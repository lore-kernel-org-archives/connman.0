Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087A3328EC
	for <connman@lists.linux.dev>; Mon, 20 Oct 2025 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982269; cv=none; b=SNdX3JDAsmdZwjCKLBY1HcM5DdNggd+HhJXfS7g3BvHZOoFg8vdiTzgo5Z78sYeb2Wbebn4wOqHPLgRk3w1zg7VnbKAfy+7lymlUV6MZiayDHrfaYEXSy1lbPAEgq+oEnWFVAQRNVH4WPnyryUzOd30hStEgZf1b65zyHwgRVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982269; c=relaxed/simple;
	bh=O9xoyC/m7Cd5rBXHbcMVAO6pXavaojs8opMwPvGj0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzP4r9Dg99Qqa4AZ9Yal8SxHHsFWDUb3r0/jEsX2MMPJ+2HWL3t2f4OF2pW9NMYry4EUQiwXZLVrtMNL/eJInpSHjlJDlon9QCrrsQd5GCvyuCQ4iBQrTZvQcbAc78qGBw5ThPHUh809iGrRGzWNdQUKL5VijajJAMjHBm8wWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cold-front.org; spf=pass smtp.mailfrom=cold-front.org; dkim=pass (2048-bit key) header.d=cold-front.org header.i=@cold-front.org header.b=pauvPyS6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZpzlCzPb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cold-front.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cold-front.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cold-front.org header.i=@cold-front.org header.b="pauvPyS6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZpzlCzPb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1945C7A0140;
	Mon, 20 Oct 2025 13:44:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 13:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1760982265; x=
	1761068665; bh=1BCt3KC0Y1e7XOycUxccP0aLjdalBu0e+M9abq8gZrY=; b=p
	auvPyS6VzGyzpMauTNzgPZi2aJdr4Z6JbW1Hy/k9Jns+6j51fEddk1DkOK9QbDoS
	3s7z8vunBYC+lnwje3XA3hpo1EY/Kdg8/JdAcljkYuCER4LtikLdM6mWoz8qp4vH
	uzf74N4WzwkbLKyfJKj/RMGxSnx04p3/lYy9ec8MQwCy9ucfWuwIvghgN631yBA7
	lqbaZi+xlva206/k/jAl1T9Pg7TpZ50oeWCLk61aEeDE3R1btlkMpazHDQqsL+Wz
	cfK3UTjY/M0spExwDOjBtka43yYseA5ZMLD4j3h8/wG30wX1BOSB8gzkSIy4Ho9B
	bj+LIKlQ41ISIOj8h0ytQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760982265; x=1761068665; bh=1BCt3KC0Y1e7XOycUxccP0aLjdalBu0e+M9
	abq8gZrY=; b=ZpzlCzPb9+3pcH7AMz4rS5mMNzh6XZxgmhJQMmV1xesuO6KBVfd
	SlAt9XCR/IuOd7GyUm6QBKaZNSZSP3GZ7RQ2dwbB1PEZ/lhKjRoW7ixJqseGYM/c
	QxMQvAuhayFH4IrLYMv1KryY0iw6ANzMVpEnU9egAfCig3YfEg7+qmoe8YMY8wY8
	2tuPuPxzgRDjVYiLspbHO6lUEZ2yHOcSYBM38n1WuEADC1qdy3EkxCIH89iIkSjz
	aIkwMH8ymJz9Yd6I8OTTNMFsr4DSRbghc2gQJengWetCpBV0wuUXKlupvceqsbwh
	K8uwJ6fVDcEWHV5sxIKZGp3og3nEzKtrhtg==
X-ME-Sender: <xms:-XT2aEihAkvYQEkfl3aUbDSh4Cwx3MR1vuf9NZDgX15dBxsGfMtq3Q>
    <xme:-XT2aNNRrp8ZUiRoAnBvOb9zZiTv7naS_G4mfh4pR-qUKB6dpp_h1IDqoqoPIqedm
    xBnPcQY7Kozflz49JJLs5r1AXfl6QY4zKpqSCQCmCxkVluu6kR1>
X-ME-Received: <xmr:-XT2aN6xGiumeVua6Fs_coM2UStMxdZ6nCfI5Vf8BQLy4NAEPsBvjJ61-f2tN47OuE5sRlbEA_baK4c757Et896b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhushhtihhn
    uceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorhhgqe
    enucggtffrrghtthgvrhhnpeduueekvdefffdvudeikeeuvdfffeejjefgfeffjeevjedu
    udfgjeeltdejveegffenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjshgsrhhonhguvghrsegtohhl
    ugdqfhhrohhnthdrohhrghdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepthhhohhmrghsrdgsrghrthhoshhikhesghhovghgrdgrthdprhgt
    phhtthhopegtohhnnhhmrghnsehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:-XT2aD2tmbyzEDk3o27fH2_xra9vjJ7XIB8d9QWTdtX5Fvef_126bA>
    <xmx:-XT2aGZ855ZbozT9VNN3BPXty8XoSlPVDo-KFXPfD38tfb04aDp8aQ>
    <xmx:-XT2aDBO8DctFSgT7O24LonzTMAiLDcgv5FAxTnuWODIoWKEtq4v1Q>
    <xmx:-XT2aA9ioh0FLGZz-Rfg1hfLGkv3KuYil45iWv6-yB3bJMVMomeuvg>
    <xmx:-XT2aKnZa19kVIrBygujClWCgBOMWu2Bk1F_xgroc6SSop0Mjvn-QksM>
Feedback-ID: iea0042cb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 13:44:25 -0400 (EDT)
Date: Mon, 20 Oct 2025 13:44:24 -0400
From: Justin Bronder <jsbronder@cold-front.org>
To: Thomas Bartosik <Thomas.Bartosik@goeg.at>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: client: set rl_prompt after saving
Message-ID: <aPZ0-GeJWF-vb3xS@ravine.members.linode.com>
References: <20251018212411.181909-1-jsbronder@cold-front.org>
 <f9379940-6eef-4887-9efb-481663d0731c@goeg.at>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9379940-6eef-4887-9efb-481663d0731c@goeg.at>

On 20/10/25 08:07 +0000, Thomas Bartosik wrote:
> ||Shouldn't rl_set_prompt("") be called first as stated in your intro
> (and the link referenced)?

As I understand it, rl_save_prompt() sets rl_prompt to NULL and we need to set it to something after that (by using rl_set_prompt()) prior to rl_redisplay() being called.

> 
> I only see __connmanctl_agent_mode setting the prompt as well, so if this
> function is not called before, there's still a save without a set before?
> 
> On 18.10.25 23:24, Justin Bronder wrote:
> > Readline 8.3 crashes when rl_save_prompt() is called without
> > rl_set_prompt() being called first [1].  This means that interactive
> > connmanctl immediately crashes upon invocation. As we're about to clear
> > the line anyways, we can just set the buffer to an empty string as well.
> >
> > Alternatively, I believe that both rl_set_prompt() and rl_replace_line()
> > could be replaced by a call to rl_message("") but I don't want to
> > expand the scope of this patch.
> >
> > 1. https://lists.gnu.org/archive/html/bug-readline/2025-07/msg00007.html
> >
> > Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
> > ---
> >   client/input.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/client/input.c b/client/input.c
> > index 78319ff8..27c281d1 100644
> > --- a/client/input.c
> > +++ b/client/input.c
> > @@ -62,6 +62,7 @@ void __connmanctl_save_rl(void)
> >   		saved_point = rl_point;
> >   		saved_line = rl_copy_text(0, rl_end);
> >   		rl_save_prompt();
> > +		rl_set_prompt("");
> >   		rl_replace_line("", 0);
> >   		rl_redisplay();
> >   	}
> 
> 

-- 
Justin Bronder
