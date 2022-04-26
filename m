Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F97E
	for <connman@lists.linux.dev>; Tue, 26 Apr 2022 14:19:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: adalessandro)
	with ESMTPSA id BC0641F43D12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1650982772;
	bh=OQ6BCBwYhPChwx8csgEmQYUPvpoHot+21Ok5ZgY9unw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=W+mBOA5sKla3Cf7jjNNEgsgV8Gn3/Sp0sGvOEi4U6kPy8zXZKKts7V09hBN6G/JnU
	 Hgi47/XVXfA2t5YNC7bCZSyfjh960ssUjU3pkJxjJR22rkowKA4G068QDLs4+fTq8q
	 ze7AbDIX3TpQFegEeApW0g2zkevX5rBDGZKU4gLYV0TKbs4JSodY2jzlWCucZZAx09
	 S6wpq1vnW9XiVeFSxysymY/uQreMK306uCNtDF7PFLE1BFvYeExNFG38rDgKHPGPPR
	 36DeAPe5eAbzv31M9n4Hs7H8ISYhxZ061Fu0nreK+jYFnn1EQz6srJy7IJeLR8dxFu
	 rI5wHdJO0xQmw==
Message-ID: <4deec7b0-a2e5-0d91-a81c-dc4bb79c1594@collabora.com>
Date: Tue, 26 Apr 2022 11:19:26 -0300
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Content-Language: en-US
To: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <20220425150837.89194-1-sven.dembianny@bshg.com>
 <20220425150837.89194-2-sven.dembianny@bshg.com>
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20220425150837.89194-2-sven.dembianny@bshg.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sven,

On 4/25/22 12:08, Dembianny, Sven (GDE-EDSO) wrote:
> Previous MFP support was restricted to WPA3, however it is also possible
> to set MFP to mandatory on APs with WPA2.
> 
> wpa_supplicant config:
> 
> * WPA2-Personal: key_mgmt="WPA-PSK-SHA256" ; iee80211w=1
> 
> Signed-off-by: Sven Dembianny <sven.dembianny@bshg.com>
> ---
>  gsupplicant/supplicant.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> index 1b92ec44..e9152632 100644
> --- a/gsupplicant/supplicant.c
> +++ b/gsupplicant/supplicant.c
> @@ -4969,6 +4969,10 @@ static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
>  				ieee80211w = G_SUPPLICANT_MFP_REQUIRED;
>  			}
>  			add_network_ieee80211w(dict, ssid, ieee80211w);
> +		} else if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK_256) {
> +			key_mgmt = "WPA-PSK-SHA256";
> +			ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
> +			add_network_ieee80211w(dict, ssid, ieee80211w);
>  		} else {
>  			key_mgmt = "WPA-PSK";

Shall we also consider the "WPA-PSK" case in the same way?

>  		}

Thanks,
Ariel
