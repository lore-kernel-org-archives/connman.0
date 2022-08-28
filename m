Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86E3214
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 14:19:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2941D5DE97
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 16:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661696362; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d+NjNsqJQRs05kpuW8qfPVZyaDqc+f9Zk1bWNiRxv6w=;
	b=KUVzzsFwssvgQVHmPvIlVS03nWP0liizuqGq98N9vHIG+4ogfMy/BQl5d2m1y6o/G6T3ra
	aq+jM2OxyuNrQWdDY5utMe31g/yWjfgBjHhX1rWEgQHjRyUY6KFOfG0bIPASPsnCWPOAEV
	7pTFaiMHcmE38EsGVRGTQpJ+eMdRNJUfOH3jAQHOH9a9BwkRvQrtZlRYvT0RfhEuFkF4Ub
	Vmaz/RxM3TRE319d6zOU4qhlw4Aum2H+g6UveleAXHbSHOwBIP04jCVKJpYujNvyyxsrvx
	5THfwOeCGVmt2xD0NMn3ChnBnYwvPWM13ZdQoLTu+FgvgyZS6QihVLDqK8sWcg==
Date: Sun, 28 Aug 2022 16:19:21 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: Removing credentials for unavailable services
Message-ID: <20220828141921.zhtha3rxnjqoic3c@beryllium.lan>
References: <YrHdHggQSI2xH5fB@smrz.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrHdHggQSI2xH5fB@smrz.lan>
X-Last-TLS-Session-Version: TLSv1.3

Hi Roman,

On Tue, Jun 21, 2022 at 05:00:46PM +0200, Roman Smrž wrote:
> Hi,
> 
> we have a setup where we need a way to remove WiFi credentials stored by
> connman. This is possible using the net.connman.Service.Remove method,
> but that's available only for currently visible services and I don't see
> other way to do this that would work for any stored service.
> 
> To solve this, my colleague created a couple of patches adding new
> methods to net.connman.Manager interface to list and remove known
> (stored) services. Does this approach make sense to you for submission
> here, or would you suggest something different?

There were several attempts to address this and a few patches were even
posted but after my feedback, they were never updated.

https://lore.kernel.org/connman/DM6PR04MB700338BA0F2EBF84D07EF5759FAE9@DM6PR04MB7003.namprd04.prod.outlook.com/#r

Maybe look at those and integrate the feedback into your
patches.

Daniel
