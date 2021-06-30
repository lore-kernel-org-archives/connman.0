Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371C70
	for <connman@lists.linux.dev>; Wed, 30 Jun 2021 07:35:27 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id A533350051C;
	Wed, 30 Jun 2021 09:35:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 6E6255001FD;
	Wed, 30 Jun 2021 09:35:19 +0200 (CEST)
Date: Wed, 30 Jun 2021 09:35:19 +0200
From: Daniel Wagner <wagi@monom.org>
To: John Keeping <john@metanate.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] agent: Always inform upper layer via callback
Message-ID: <20210630073519.r6zvbhs6cbbzs2an@beryllium.lan>
References: <20210629073326.22689-1-wagi@monom.org>
 <20210629114842.2d8a486d.john@metanate.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629114842.2d8a486d.john@metanate.com>

Hi John,

On Tue, Jun 29, 2021 at 11:48:42AM +0100, John Keeping wrote:
> On Tue, 29 Jun 2021 09:33:26 +0200
> Daniel Wagner <wagi@monom.org> wrote:
> 
> > The upper state machine expects to be called in all cases. Do not
> > silenty eat up the callback.
> > 
> > Fixes: 8ea2d67a6e89 ("service: Complete only after user connection retries")
> > Reported by John Keeping
> 
> Tested-by: John Keeping <john@metanate.com>
> 
> I've run through a few tests with this patch and it looks good!
> 
> Thanks for tracking down the issue here.

Thanks for testing. Patch applied.
Daniel
