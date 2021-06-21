Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9271
	for <connman@lists.linux.dev>; Mon, 21 Jun 2021 07:04:20 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 86F06500653;
	Mon, 21 Jun 2021 09:04:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 527EC500650;
	Mon, 21 Jun 2021 09:04:18 +0200 (CEST)
Date: Mon, 21 Jun 2021 09:04:17 +0200
From: Daniel Wagner <wagi@monom.org>
To: Carsten Haitzler <raster@rasterman.com>
Cc: connman@lists.linux.dev
Subject: Re: Bug - 1.40 stops wifi password popup for agent
Message-ID: <20210621070417.trmfbzrrsjoieuny@beryllium.lan>
References: <20210619200329.20a38c0960c156a956cbeb21@rasterman.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619200329.20a38c0960c156a956cbeb21@rasterman.com>

Hi Carsten,

On Sat, Jun 19, 2021 at 08:03:29PM +0100, Carsten Haitzler wrote:
> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=561f318003c14fff56720309b6c9dfdbceb8dd87
> 
> This broke that. Using iwd instead of wpa_supplicant. wpa_supplicant
> works fine.

Thanks for the bisection. Will look into it.

Daniel
