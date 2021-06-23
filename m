Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C85173
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 07:39:17 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id D685950064D;
	Wed, 23 Jun 2021 09:39:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 5F298500412;
	Wed, 23 Jun 2021 09:39:15 +0200 (CEST)
Date: Wed, 23 Jun 2021 09:39:15 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Carsten Haitzler <raster@rasterman.com>
Subject: Re: [PATCH] service: Ask for password when using native autoconnect
Message-ID: <20210623073915.2ao7xpybdhnql42d@beryllium.lan>
References: <20210623072130.29852-1-wagi@monom.org>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623072130.29852-1-wagi@monom.org>

On Wed, Jun 23, 2021 at 09:21:30AM +0200, Daniel Wagner wrote:
> When the native mode is activated we still need to ask for the
> password if it's unknown.
> 
> Fixes: 561f318003c1 ("service: Teach autoconnect algorithm native mode")

Patch applied
