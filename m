Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305773FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:43:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D38760A44;
	Mon,  4 Oct 2021 08:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633329819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ka322dslKjNWHU0wJ5ISC9EWdulHGJoArhjYb7lTCdI=;
	b=NhYW1expl0j7spw3JOU1dmx0f0vj+8lY0tMksUQlJXksO2sYWE6alJqSp7ofah+Qh8bIyP
	LLYX8icFuRRxzchS7fDNEwe6N+xeMqRVvR9waqzToGhlqSvcbibFsiG/HYuBidgJ/hJaLK
	m1QSus8v6U6h4ekqZdG0xMSgXL+eJ1bmB0jUqdTfs3NGdky6mEObPts91FRTxhPOH+ZKNi
	ItY1gQsx+ftcsGXaFM0pt6IZxdaFR+2MQZo5lei9K4SLEsqYmmh5+zn2NUaImbsJjfDvNd
	ANRPRpDz2oqBSrNnxVshrv+DupK95wDA2VpWt57JWcDAhXe8Sue/bybCKTCjbg==
Date: Mon, 4 Oct 2021 08:43:38 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH 1/3] iwd: Scan hidden networks
Message-ID: <20211004064338.wcqkjiw5u2ywkbrb@beryllium.lan>
References: <MRZP264MB154441C6059B4972B76730FF93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154441C6059B4972B76730FF93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

Thanks for the feature. The patch looks pretty good. Just a minor nitpick for
this and the other 2 patches.

On Fri, Oct 01, 2021 at 03:26:03PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Only visible networks were retrieved by a scan, via GetOrderedNetworks()
> iwd function. A call to GetHiddenAccessPoints() is necessary to
> retrieve the hidden ones.
> +static void create_hidden_network(struct iwd_hidden_ap *iwdh)
> +{
> +	struct iwd_network *iwdn;
> +
> +	iwdn = g_try_new0(struct iwd_network, 1);
> +	if (!iwdn) {
> +		connman_error("Out of memory creating IWD network");
> +		return;
> +	}

Just use g_new0(). There is no use to try to work around small memory
allocation failures. First they are very likely never to be observed and
if they do our failure path is not tested. Even more...


> +
> +	iwdn->proxy = NULL;
> +	iwdn->path = g_strdup(iwdh->path);

If g_strdup() can't allocate memory it will call abort() anyway.

Thanks,
Daniel
