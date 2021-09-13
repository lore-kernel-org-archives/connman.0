Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A93FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 07:27:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E94F60A44;
	Mon, 13 Sep 2021 09:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1631518040; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=B23K1/V0sz0TAAMkAwnf8Zzy+QulbO0BsZwuy+0CFGU=;
	b=o0XC5Wl/h/Oj21Ml4J+illmYyra5wK5FC9BzAFf+Y+odaTTDz2yQItx3jfYy8s4GAdtoDc
	hYIDB1B2AkmI4xZEGuY+KvYe39JENKHzJIQIOI5oCZRL0+WkaIwxeIetzKO8xzbjVUY1+w
	TOcglArMIceAstUcF9Jdly3vRiSpLBs9+4vWOdb3hY2ZwxvkymVmOyd3dR2UP3JJ2VHREw
	BNo4wGDulpQOWY0WQRPBHZXLI1/4Aso2OBJ/6/l4KkEuTCOsDCAoXP0ZfPGZ7EqRa66QFF
	nSF4fxpZpN9cZ1kmUahns2saZQaTtlNBOgEv4bINnWYpmhvSFMBshOiUFvIncA==
Date: Mon, 13 Sep 2021 09:27:19 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] build: Fix compiler maybe-uninitialized warnings
Message-ID: <20210913072719.3qlnsqjzplntm265@beryllium.lan>
References: <MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Sep 13, 2021 at 07:17:13AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> 
> ---
>  src/config.c           | 6 ++----
>  src/dnsproxy.c         | 2 +-
>  tools/ip6tables-test.c | 2 +-
>  tools/iptables-test.c  | 2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/src/config.c b/src/config.c
> index 62023b1072da..33fdc7375c15 100644
> --- a/src/config.c
> +++ b/src/config.c
> @@ -1106,8 +1106,7 @@ static char *config_pem_fsid(const char *pem_file)
>  
>  static void provision_service_wifi(struct connman_config_service *config,
>  				struct connman_service *service,
> -				struct connman_network *network,
> -				const void *ssid, unsigned int ssid_len)
> +				struct connman_network *network)
>  {
>  	if (config->eap)
>  		__connman_service_set_string(service, "EAP", config->eap);
> @@ -1418,8 +1417,7 @@ static int try_provision_service(struct connman_config_service *config,
>  						config->timeservers);
>  
>  	if (type == CONNMAN_SERVICE_TYPE_WIFI) {
> -		provision_service_wifi(config, service, network,
> -							ssid, ssid_len);
> +		provision_service_wifi(config, service, network);
>  	}
>  

Could you split this into cleanup patch with a commit message?

>  	__connman_service_mark_dirty();
> diff --git a/src/dnsproxy.c b/src/dnsproxy.c
> index 4b65b3790bb9..fbbee0413f8f 100644
> --- a/src/dnsproxy.c
> +++ b/src/dnsproxy.c
> @@ -2707,7 +2707,7 @@ static void update_domain(int index, const char *domain, bool append)
>  	for (list = server_list; list; list = list->next) {
>  		struct server_data *data = list->data;
>  		GList *dom_list;
> -		char *dom;
> +		char *dom = NULL;
>  		bool dom_found = false;
>  
>  		if (data->index < 0)


Same here (maybe including the compiler warning).

> diff --git a/tools/ip6tables-test.c b/tools/ip6tables-test.c
> index 41e842dd64af..a52f4af04edf 100644
> --- a/tools/ip6tables-test.c
> +++ b/tools/ip6tables-test.c
> @@ -45,7 +45,7 @@ int main(int argc, char *argv[])
>  {
>  	enum iptables_command cmd = IPTABLES_COMMAND_UNKNOWN;
>  	char *table = NULL, *chain = NULL, *rule = NULL, *tmp;
> -	int err, c, i;
> +	int err = -EINVAL, c, i;
>  
>  	opterr = 0;
>  
> diff --git a/tools/iptables-test.c b/tools/iptables-test.c
> index e9b7cb224d7a..f9d091eb9490 100644
> --- a/tools/iptables-test.c
> +++ b/tools/iptables-test.c
> @@ -44,7 +44,7 @@ int main(int argc, char *argv[])
>  {
>  	enum iptables_command cmd = IPTABLES_COMMAND_UNKNOWN;
>  	char *table = NULL, *chain = NULL, *rule = NULL, *tmp;
> -	int err, c, i;
> +	int err = -EINVAL, c, i;
>  
>  	opterr = 0;
>  
> -- 
> 2.25.1

For the tools/* fixes this is okay. Not really important stuff :)

Daniel
