Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10943177
	for <connman@lists.linux.dev>; Thu, 24 Jun 2021 08:45:30 +0000 (UTC)
Received: by kirsty.vergenet.net (Postfix, from userid 1001)
	id F0A7E25BF95; Thu, 24 Jun 2021 18:45:28 +1000 (AEST)
Date: Thu, 24 Jun 2021 09:45:22 +0100
From: Carsten Haitzler <raster@rasterman.com>
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] service: Ask for password when using native autoconnect
Message-Id: <20210624094522.f98d8208dffd989628cbaf59@rasterman.com>
In-Reply-To: <20210623072130.29852-1-wagi@monom.org>
References: <20210623072130.29852-1-wagi@monom.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
X-Pants: on
X-Cluestick: Get jiggy with it!
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jun 2021 09:21:30 +0200 Daniel Wagner <wagi@monom.org> said:

Confirmed. It works now. Thanks! :)

> When the native mode is activated we still need to ask for the
> password if it's unknown.
> 
> Fixes: 561f318003c1 ("service: Teach autoconnect algorithm native mode")
> ---
> 
> Hi Carsten,
> 
> Sorry it took so long. There were some fallouts from recent gcc
> warnings I had to look after first. Anyway, this patch fixed the
> problem you reported for me. Please, let me know if there is still a
> problem after this patch.
> 
> Thanks,
> Daniel
> 
>  src/service.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/service.c b/src/service.c
> index 20917a8923a4..eb74a85d6e32 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -6756,7 +6756,8 @@ int __connman_service_connect(struct connman_service
> *service, service->provider)
>  			connman_provider_disconnect(service->provider);
>  
> -	if (service->connect_reason == CONNMAN_SERVICE_CONNECT_REASON_USER) {
> +	if (reason == CONNMAN_SERVICE_CONNECT_REASON_USER ||
> +			reason == CONNMAN_SERVICE_CONNECT_REASON_NATIVE) {
>  		if (err == -ENOKEY || err == -EPERM) {
>  			DBusMessage *pending = NULL;
>  			const char *dbus_sender = get_dbus_sender(service);
> -- 
> 2.32.0
> 


-- 
------------- Codito, ergo sum - "I code, therefore I am" --------------
Carsten Haitzler - raster@rasterman.com

