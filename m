Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7E3FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 06:32:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCC8D5E363;
	Mon, 13 Sep 2021 08:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1631514751; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=McO0cn2M60egIgA2B8C7ECEWUaBt2AJLXtLq+h5awC8=;
	b=cf9HA084DdY8HXK5ugCJBQ/LOOh4WfMLqc4UDEI9iYdlo5ugP7C6gYDpPVmlGk+a0pKaHr
	n2GlYEv2WvtuhY+UetKLiebjt7mW+PzAAHZRgrhqHgP5C99opr6LDt4YPzHLP5qnuB6h2L
	QZEKhn/2LifiIEwbUbAps/UWrdN6zk9T0FQPD1UDqCnNT88aTgnTLaMQABKxTn4zRHwRxd
	/zJLc5uYCtLGq01obbq1KdIDxMdXREchTAMqEM7thbkhiHUuGMKzl+tcQ3svhLE0VZxhSZ
	gdiYYOxHDEtCBuPQdV+PSctJIr5gQS9PwUMQQxdx4DPdbCtN/SiY3IEFAeNJCw==
Date: Mon, 13 Sep 2021 08:32:31 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 2/5] vpn-provider: Ignore error adding when state is
 idle/unknown
Message-ID: <20210913063231.la2wfnnm5jh65hrd@beryllium.lan>
References: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
 <20210902151124.4983-3-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902151124.4983-3-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Sep 02, 2021 at 06:11:21PM +0300, Jussi Laakkonen wrote:
> Do not allow to add errors for provider that is already set into idle
> state or is in unknown state. This case may happen when networks are
> rapidly changed and VPN did not call the callback connect_cb() until the
> VPN is died and vpn.c:vpn_died() initiates cleanup in the VPN which
> eventually calls connect_cb() with an error.

I wonder if we should set the VPN state immediately when starting the
connection process to some value != unknown.

> ---
>  vpn/vpn-provider.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
> index f30ce04f..90e21e95 100644
> --- a/vpn/vpn-provider.c
> +++ b/vpn/vpn-provider.c
> @@ -2026,6 +2026,21 @@ int vpn_provider_indicate_error(struct vpn_provider *provider,
>  	DBG("provider %p id %s error %d", provider, provider->identifier,
>  									error);
>  
> +	/*
> +	 * Ignore adding of errors when the VPN is idle or not set. Calls may
> +	 * happen in a case when networks are rapidly changed and the call to
> +	 * vpn_died() is done before executing the connect_cb() from the
> +	 * plugin. Then vpn.c:vpn_died() executes the plugin specific died()
> +	 * function which may free the plugin private data, containing also
> +	 * the callback which hasn't yet been called. As a result the provider
> +	 * might already been reset to idle state when the callback is executed
> +	 * resulting in unnecessary reset of the previous successful connect
> +	 * timer and adding of an error for already disconnected VPN.
> +	 */
> +	if (provider->state == VPN_PROVIDER_STATE_IDLE ||
> +				provider->state == VPN_PROVIDER_STATE_UNKNOWN)
> +		return 0;

Checking the unknown state looks here a bit strange. The usual meaning
of unknown is it hasn't been initialized. But then this is exactly
what's happening here I assume.
