Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0215168
	for <connman@lists.linux.dev>; Tue, 20 Jul 2021 12:14:31 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 453FB500653;
	Tue, 20 Jul 2021 14:14:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.96.3])
	by mail.monom.org (Postfix) with ESMTPSA id BC161500650;
	Tue, 20 Jul 2021 14:14:28 +0200 (CEST)
Date: Tue, 20 Jul 2021 14:14:28 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: service_update_preferred_order cleanup
Message-ID: <20210720121428.p3t54ne3emuxz3bl@beryllium.lan>
References: <MRZP264MB1544B944E70E53B4B1A9287693E19@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544B944E70E53B4B1A9287693E19@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>

Hi Emmanuel,

On Mon, Jul 19, 2021 at 09:01:49AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> For uniformity reasons, the service_update_preferred_order shall rely
> on service_compare_preferred generic function, instead of processing
> itself the preferred service comparison.
> ---
>  src/service.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/src/service.c b/src/service.c
> index 149b66ecfbe0..182a1905c32d 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -5917,27 +5917,15 @@ static int service_update_preferred_order(struct connman_service *default_servic
>  		struct connman_service *new_service,
>  		enum connman_service_state new_state)
>  {
> -	unsigned int *tech_array;
> -	int i;
> -
>  	if (!default_service || default_service == new_service ||
>  			default_service->state != new_state)
>  		return 0;
>  
> -	tech_array = connman_setting_get_uint_list("PreferredTechnologies");
> -	if (tech_array) {
> -
> -		for (i = 0; tech_array[i] != 0; i += 1) {
> -			if (default_service->type == tech_array[i])
> -				return -EALREADY;
> -
> -			if (new_service->type == tech_array[i]) {
> -				switch_default_service(default_service,
> -						new_service);
> -				__connman_connection_update_gateway();
> -				return 0;
> -			}
> -		}
> +	if (service_compare_preferred(default_service, new_service) > 0) {
> +		switch_default_service(default_service,
> +				new_service);
> +		__connman_connection_update_gateway();
> +		return 0;

This is not just a pure refactoring change. Because

> -			if (default_service->type == tech_array[i])
> -				return -EALREADY;

is missing. This is only relevant for service_indicate_state() when we
would ignore the new service. Hmm, not totally sure what it means. Did
you figure out why this is not needed anymore?

Thanks,
Daniel
