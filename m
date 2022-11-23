Received: from metanate.com (dougal.metanate.com [90.155.101.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9167E
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=ZBfQ4b+5F2p4lvTygMIsnYyBmB4d72bGnET2nZO6GDQ=; b=jZox0
	zKSXSCWksCpjDc4C7BgerOfZF5l4cLeVjA2HlJZZe3HsxEm7PfKs1GxTUOxgtZC64HyhQp9roAP1d
	JWYwocQIVK5lybL2u9thXYlUW3fvBxw9ZDvQd34lby5kz18dAzRl/IsppyGXJIfy6P4k0GvR6Chxi
	/zyUGv6ON0nWWS1e4UmX6BOMQboLQuVm1GOO6bs4kXJpJw45R/ek4dJE6SrNB22IKKgTebJ5wHLgH
	VhIT5P79aC/Iff/ady8ChnW6LtiVxIq4KkDHz1BfKsAaEKnQ2MEYi3SMqVxZR+umoTkr+Gkh2+rGD
	Mg1Rw09qumT88cPkzrWwMH4/uXsqA==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
	by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <john@metanate.com>)
	id 1oxrOC-0002mg-6g;
	Wed, 23 Nov 2022 15:10:16 +0000
Date: Wed, 23 Nov 2022 15:10:15 +0000
From: John Keeping <john@metanate.com>
To: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Cc: connman@lists.linux.dev, wagi@monom.org
Subject: Re: autoip address set/reset loop
Message-ID: <Y34315YvyR6DOyWn@donbot>
References: <9af7ed7a-be9b-962a-bcfd-8b482d45a65f@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af7ed7a-be9b-962a-bcfd-8b482d45a65f@gmail.com>
X-Authenticated: YES

On Wed, Nov 23, 2022 at 03:56:42PM +0100, Geoffrey Van Landeghem wrote:
> Subject: Re: autoip address set/reset loop
> 
> Here is the patch:
> 
> From b7750b925714572cba12275e6da49b8b70cd3fbb Mon Sep 17 00:00:00 2001
> From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
> Date: Tue, 22 Nov 2022 19:50:12 +0100
> Subject: [PATCH] ipconfig: revert not adding invalid gateway routes
> 
> ---
>  src/ipconfig.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/ipconfig.c b/src/ipconfig.c
> index 74215e1d..875819a0 100644
> --- a/src/ipconfig.c
> +++ b/src/ipconfig.c
> @@ -1183,13 +1183,17 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
>  
>  	DBG("");
>  
> -	if (!ipconfig->address || !ipconfig->address->gateway)
> +	if (!ipconfig->address)
>  		return -EINVAL;
>  
>  	service = __connman_service_lookup_from_index(ipconfig->index);
>  	if (!service)
>  		return -EINVAL;
>  
> +	/*
> +	 * Gateway is allowed to be NULL here, see
> +	 * __connman_connection_gateway_add()
> +	 */
>  	DBG("type %d gw %s peer %s", ipconfig->type,
>  		ipconfig->address->gateway, ipconfig->address->peer);

If gateway can be null you need to make sure the argument to DBG() is
non-null.  While glibc handles null for %s other C libraries may crash.
