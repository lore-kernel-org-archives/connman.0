Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300F659
	for <connman@lists.linux.dev>; Mon, 24 Oct 2022 07:40:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 516FC618F7;
	Mon, 24 Oct 2022 09:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1666597202; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bJAit3TFJ/Y7XCWcWwuCOzuUPU5DwUdV/5g2CwC9PIY=;
	b=BH1hjcvmq4bpBhum3coPPrpnAussq7DY2tvXvXEOk5QP46NRtIGwRY8zARtQch7MILuUhC
	MyRQfFbXub/rSfGP0SMl3rHbLtobo5KJs4izAXWmp1lD2eJVl/ag/CR3BzraZpwB4ljVX6
	ttTzmsNoLlr//7E05xacz4KS+lEEC4DjYDnnlBVPUj3b5QRrVL6cNWa5y/PDQDavVtVsQC
	je4QiNFS7IyhjxDt3PkAmnKWqFibRiIg2/7oGbW7Dh2pinVe3pQk85YC4KL/PPmebPbR/H
	Ib/1AkpBu43mBLkXd5CIVEcF26CygtX0Vpt8MQy5t1NZ6tC95Zhr6BpLrbuCWA==
Date: Mon, 24 Oct 2022 09:40:01 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: dnsproxy: first round of refactoring, TCP bugfix
Message-ID: <20221024074001.ud4w46xewtdnzdtm@beryllium.lan>
References: <20221018084746.21959-1-matthias.gerstner@suse.de>
 <Y05p9FJvQGPuuEL4@kasco.suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y05p9FJvQGPuuEL4@kasco.suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Matthias,

[Sorry that the last time the review took so long. So this time I'll
give it high priority :)]

On Tue, Oct 18, 2022 at 10:55:15AM +0200, Matthias Gerstner wrote:
> On Tue, Oct 18, 2022 at 10:47:30AM +0200, Matthias Gerstner wrote:
> > From Matthias Gerstner <matthias.gerstner@suse.de> # This line is ignored.
> > From: Matthias Gerstner <matthias.gerstner@suse.de>
> > Reply-To: 
> > Subject: dnsproxy: first round of refactoring, TCP bugfix
> > In-Reply-To: 
> 
> Sorry, it seems I've messed up the summary.

No worries, it is a steep learning curve :)

> This is the same patch series with the minor changes you requested in
> patch 03/16.

So I've tried to apply all the patches. But as noted, not all build
without a warning or error. I've tried to fix it up but there so many
'unsigned char * p' -> 'char * p' followed with a 'fn((unsigned
char*)p)' makes me nervous that my changes are actually introducing
regressions. Anyway, every single time a cast is used, it shows there is
something (slightly?) off.

Again, I am against moving the declarations down into the body and
mixing them with instructions. I am sure this is encouraged in other
code bases (I suppose C++?). But no projects I am aware of which follow
the Linux coding style has this style.

As the rest of the ConnMan code base is not using this I am not keen to
change it now. For me it's actually harder to read as my brain is
trained to look for the declaration at the beginning of a block. So
please don't do it.

Thanks,
Daniel
