Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD628EF
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:28:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D9B2DE361;
	Tue, 11 Apr 2023 09:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681198089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QFmMvavFWTWEhhU0QD7weKFwBOSmxmjgopYMNRNZAUM=;
	b=WDQkGRf+zQf0E40k/pIsU2g+A72fYzeMirE6WbaCHRor7LLx5smwfA09lhRLlmSyRxq+d9
	gd1IoEWOe2MNIk0A0Mk76fsgZj8ZoyWLmoue30PDiuRqH2qV5egWHslxCRK4T+3WTm2E/h
	0ghH8Dj/1XDergZ9q1xwXLK815fQbh5fD+J6pEeHHqA+xkr5NIX6iR429yGKh+1+wIKPwD
	CdAx0HCM1VCdlLOZDYMNQebN0PM9s1aaKEJK0vscdk+cuznYx1i5X3K4R6BF7CB9c3wsgk
	dlStFASP2Y8EAcw00wLgTc6Y62DGyuLck18VZ1G8SXdAJnrDy/eAKecusqddaw==
Date: Tue, 11 Apr 2023 09:28:08 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Fix hidden service with wrong passphrase
Message-ID: <20230411072808.nkxk6iprmgp6jlnz@beryllium.lan>
References: <MRZP264MB154400DDFBFE8E6BE89E250193AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154400DDFBFE8E6BE89E250193AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Feb 27, 2023 at 05:19:37PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Two cases need to be fixed during the connection to a hidden service
> with a wrong passphrase:
> * the invalid key error shall be reported to the user,
> * another attempt to connect to this hidden service shall be possible,
> and succeed with the right passphrase
> ---
>  src/service.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/src/service.c b/src/service.c
> index 6f31adb33d6a..06d02322f437 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -3241,6 +3241,9 @@ int __connman_service_check_passphrase(enum connman_service_security security,
>  	return 0;
>  }
>  
> +static void set_error(struct connman_service *service,
> +					enum connman_service_error error);
> +
>  int __connman_service_set_passphrase(struct connman_service *service,
>  					const char *passphrase)
>  {
> @@ -3265,6 +3268,10 @@ int __connman_service_set_passphrase(struct connman_service *service,
>  		connman_network_set_string(service->network, "WiFi.Passphrase",
>  				service->passphrase);
>  
> +	if (service->hidden_service &&
> +			service->error == CONNMAN_SERVICE_ERROR_INVALID_KEY)
> +		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
> +

This should be handled by the caller of the set function. We are already doing
this, so please move this part also there.

Thanks,
Daniel
