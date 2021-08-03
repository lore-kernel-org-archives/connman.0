Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827A70
	for <connman@lists.linux.dev>; Tue,  3 Aug 2021 07:41:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7398A5E361;
	Tue,  3 Aug 2021 09:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1627976469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8C8vIp1JEne03aNF4c4JOXucwu1hI7hXzPtgnO0Liqg=;
	b=MosZ+OBaVp/WGbaKbua1WPCEIlX+G8OoqB3bmDz5dGKIpvSkDzHBL/sgGEF9ZaEGjt6Pin
	Z0dkjkTv8zwxDplWZcHAwaA6zjHrLQ5w2BKWDKqL/w0iDIV5TU2GvJWrwUifdzUaaR6SlW
	GDt8RviL68ZcROg1lHw0tOXFOs7/r1srmvF7eR6k+G2Gi7mMs9gbNJtP7kvULHAqKTEI7Y
	8QM53l8gkDM9TaSE09sH26WCaBYVX2ZXYu4DxMapHA8R6LBahiYIzd6LKnUJRlkK88MWiL
	paSGGnGn1O5CCPialbxTRgzCH9yppqNI9fHhd08JKw0yrYsKDiuOgTyOomZrrA==
Date: Tue, 3 Aug 2021 09:41:04 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com,
	marcel@holtmann.org
Subject: Re: [connman v1] wifi: Set ieee80211w as required for
 WPA3-Personal-only mode
Message-ID: <20210803074104.dawii3v3bknovg2e@beryllium.lan>
References: <20210802151006.28183-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802151006.28183-1-ariel.dalessandro@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ariel,

Thanks for tracking this! Just a stupid question:

On Mon, Aug 02, 2021 at 12:10:06PM -0300, Ariel D'Alessandro wrote:
> From wpa_supplicant docs [0] section "ieee80211w":
> 
>   "WPA3-Personal-only mode: ieee80211w=2 and key_mgmt=SAE".
> 
> This means that the parameter ieee80211w has to be set to 2 (required)
> if SAE is used. Fix it.
> 
> [0] https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
> ---
>  plugins/wifi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 578b4be7..02603e85 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -2174,7 +2174,12 @@ static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
>  	security = connman_network_get_string(network, "WiFi.Security");
>  	ssid->security = network_security(security);
>  	ssid->keymgmt = network_data->keymgmt;
> -	ssid->ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
> +	/*
> +	 * From wpa_supplicant docs:
> +	 * "WPA3-Personal-only mode: ieee80211w=2 and key_mgmt=SAE".
> +	 * Set ieee80211w as required, which is sent if SAE key is used.
> +	 */
> +	ssid->ieee80211w = G_SUPPLICANT_MFP_REQUIRED;

Should we check the keymgmt is SAE and only then set the ieee80211w
value?

Thanks,
Daniel
