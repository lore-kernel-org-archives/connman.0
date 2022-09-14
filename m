Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B1441F
	for <connman@lists.linux.dev>; Wed, 14 Sep 2022 18:57:16 +0000 (UTC)
Received: from [192.168.132.180] (unknown [186.12.61.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: adalessandro)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id DF9936601F8A;
	Wed, 14 Sep 2022 19:57:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1663181835;
	bh=GUWyqrIrZY5NczBjk/Wsl4rExMW+Rol/Tpws+Do2MsY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=YcoRQGVBq2XSNPH6aq81HEr584otXXZxm2tbyYTeokQ/0A/CKCCEi42RZYQ6+z6Dn
	 TprYBdsEOTEPKG69hkafBjpjlUz4dt/LTE3ObTrRxOc31S/h8THoRroub3I+0H125R
	 EuVf6RfF1h5Jjrqe8FiU/opJKXPWsjvaVOM62OKM2jXd4d43dP3kPuemc/DpSIXR50
	 KoLMkyr2xkhs+nMv9ktXWiso62YZPs2NRf28xMHPNGC2XVAPC4/Q8EbAOeL9AiODDi
	 3a+0VKUhvzy3nrP/6ulvKE1hOsLjO3+E4a1sYIA01ErE6K9zvEsyVAUEAF3xjkDt2L
	 IRMF2UdQX9TuA==
Message-ID: <20defbe5-b144-ff2b-8bfb-1621368be5d9@collabora.com>
Date: Wed, 14 Sep 2022 15:57:08 -0300
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] wifi: Handle invalid-key case on WPA-SAE authentication
 failure
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: connman@lists.linux.dev
Cc: john@metanate.com
References: <20220914184610.258763-1-ariel.dalessandro@collabora.com>
Content-Language: en-US
In-Reply-To: <20220914184610.258763-1-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all, John,

This patch is a follow up of my question e-mail with subject "No
password prompt after wrong entry".

There's currently a difference on the state transitions between WPA2-PSK
and WPA3-SAE, which makes the latter not to prompt for a new password
after an invalid key has been sent and rejected. Note that on the former
case (WPA2-PSK) that works as expected and the client agent asks for a
new password if the key was invalid.

The issue comes from the state transitions on each case.

For the WPA2-PSK wrong-key case, connman goes through states:
* G_SUPPLICANT_STATE_AUTHENTICATING
* G_SUPPLICANT_STATE_4WAY_HANDSHAKE
* G_SUPPLICANT_STATE_DISCONNECTED

So, the invalid-key error is handled and reported here:

https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/wifi.c#n2526

However, for the WPA3-SAE wrong-key case, connman goes through states:
* G_SUPPLICANT_STATE_AUTHENTICATING
* G_SUPPLICANT_STATE_DISCONNECTED

So, the invalid-key error never gets reported. Instead, connect-failed
is reported by connman, which makes the client agent never prompt for a
new password.

Any feedback is welcome, specially if the proposed solution should be
implemented in a different way

Thanks in advance :-)
Ariel D'Alessandro
--
Collabora Ltd.
https://www.collabora.com/

On 9/14/22 15:46, Ariel D'Alessandro wrote:
> On WPA3-SAE authentication, wpa_supplicant goes directly from
> authenticating to disconnected state if the key was invalid.
> 
> The above is currently not handled and the `connect-failed` error is
> reported on such cases. In order to make the client agent prompt for a
> new password, we need to handle this transition and report the
> `invalid-key` error.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  plugins/wifi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 2a933708..ed7437f5 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -2528,6 +2528,25 @@ static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
>  	return false;
>  }
>  
> +static bool handle_sae_authentication_failure(struct connman_network *network,
> +					      struct wifi_data *wifi)
> +{
> +	struct wifi_network *network_data = connman_network_get_data(network);
> +
> +	if (!(network_data->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
> +		return false;
> +
> +	if (wifi->state != G_SUPPLICANT_STATE_AUTHENTICATING)
> +		return false;
> +
> +	if (wifi->connected)
> +		return false;
> +
> +	connman_network_set_error(network, CONNMAN_NETWORK_ERROR_INVALID_KEY);
> +
> +	return true;
> +}
> +
>  static void interface_state(GSupplicantInterface *interface)
>  {
>  	struct connman_network *network;
> @@ -2625,6 +2644,13 @@ static void interface_state(GSupplicantInterface *interface)
>  						network, wifi))
>  			break;
>  
> +		/*
> +		 * On WPA3-SAE authentication, wpa_supplicant goes directly from
> +		 * authenticating to disconnected state if the key was invalid.
> +		 */
> +		if (handle_sae_authentication_failure(network, wifi))
> +			break;
> +
>  		/* See table 8-36 Reason codes in IEEE Std 802.11 */
>  		switch (wifi->disconnect_code) {
>  		case 6: /* Class 2 frame received from nonauthenticated STA */
