Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E870
	for <connman@lists.linux.dev>; Thu,  5 Aug 2021 06:07:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7728160E32;
	Thu,  5 Aug 2021 08:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1628143670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ei/x+NCqmrIIE51roJcjtIJx0r9uAVV4AIPYhskHxcc=;
	b=kl+SSSqlKKTAVmvE8Nh1H0GVkVeYsU6LbZ4Bob46D188zZh6zg/S89vmQhviCOGThtUNm6
	NN3N/wT9DbzGh0OkDMi6DtU5wmst0Li+AhQTzK+n6VY/3fkOypEtNReRxGzd71YLksNVQq
	1oCbCsoJTlMRbvFk33aV7AHqFjJTeaoYcOYmnETl8q2tJuOzC3pHjPDoF1Kn/6it8LmTkU
	HPjEcpTTN+LmBOmi7+NFFUfYbDcjaR1dHb/cIo5h5nAHhXidOdXc1onNad86SV0hwehhQ2
	7N3OyQ01pOtnBLFBf5liO3Xzz733p0zu6OkBNPLjE6SDV2W0mRjuio5p17PPxA==
Date: Thu, 5 Aug 2021 08:07:50 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com,
	marcel@holtmann.org
Subject: Re: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
 transition mode
Message-ID: <20210805060750.kbrvx5uouuq37egk@beryllium.lan>
References: <20210804212315.265376-1-ariel.dalessandro@collabora.com>
 <20210804212315.265376-2-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804212315.265376-2-ariel.dalessandro@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

[adding the new mailing list]

On Wed, Aug 04, 2021 at 06:23:15PM -0300, Ariel D'Alessandro wrote:
> This commit adds support for WPA3-Personal transition mode, which
> supports both WPA2-Personal (PSK) and WPA3-Personal (SAE).
> 
> Based on the AP accepted key management protocols, connman configures
> wpa_supplicant as follows:
> 
> * WPA3-Personal-only mode: key_mgmt="SAE" ; ieee80211w=2
> * WPA3-Personal transition mode: key_mgmt="SAE WPA-PSK" ; ieee80211w=1
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  gsupplicant/supplicant.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> index 58c78fd1..8316f48a 100644
> --- a/gsupplicant/supplicant.c
> +++ b/gsupplicant/supplicant.c
> @@ -4903,17 +4903,16 @@ static void add_network_security_proto(DBusMessageIter *dict,
>  	g_free(proto);
>  }
>  
> -static void add_network_ieee80211w(DBusMessageIter *dict, GSupplicantSSID *ssid)
> +static void add_network_ieee80211w(DBusMessageIter *dict, GSupplicantSSID *ssid,
> +				   GSupplicantMfpOptions ieee80211w)
>  {
> -	if (!(ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
> -		return;
> -
>  	supplicant_dbus_dict_append_basic(dict, "ieee80211w", DBUS_TYPE_UINT32,
> -					  &ssid->ieee80211w);
> +					  &ieee80211w);
>  }
>  
>  static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
>  {
> +	GSupplicantMfpOptions ieee80211w;
>  	char *key_mgmt;
>  
>  	switch (ssid->security) {
> @@ -4929,10 +4928,22 @@ static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
>  		add_network_security_ciphers(dict, ssid);
>  		break;
>  	case G_SUPPLICANT_SECURITY_PSK:
> -		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE)
> -			key_mgmt = "SAE";
> -		else
> +		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE) {
> +			if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK) {
> +				/*
> +				 * WPA3-Personal transition mode: supports both
> +				 * WPA2-Personal (PSK) and WPA3-Personal (SAE)
> +				 */
> +				key_mgmt = "SAE WPA-PSK";
> +				ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
> +			} else {
> +				key_mgmt = "SAE";
> +				ieee80211w = G_SUPPLICANT_MFP_REQUIRED;
> +			}
> +			add_network_ieee80211w(dict, ssid, ieee80211w);
> +		} else {
>  			key_mgmt = "WPA-PSK";
> +		}
>  		add_network_security_psk(dict, ssid);
>  		add_network_security_ciphers(dict, ssid);
>  		add_network_security_proto(dict, ssid);
> @@ -4994,8 +5005,6 @@ static void interface_add_network_params(DBusMessageIter *iter, void *user_data)
>  
>  	add_network_security(&dict, ssid);
>  
> -	add_network_ieee80211w(&dict, ssid);
> -
>  	supplicant_dbus_dict_append_fixed_array(&dict, "ssid",
>  					DBUS_TYPE_BYTE, &ssid->ssid,
>  						ssid->ssid_len);
> -- 
> 2.30.2
> 
