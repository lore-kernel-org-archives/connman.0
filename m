Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3961A6811
	for <connman@lists.linux.dev>; Wed, 25 Mar 2026 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400279; cv=none; b=MZhZSpc/DmZE8bU0TCxNWggbiYUKJdvV6C2J+pxbRQmrpcUAsA9m49ub+XcqJn7vbOzxzbge3qJrlx9KtjVSTiyYaN+uM3D5uEnCs9MqBlG3xKrHgN+R0ISisgvkhfTUho8G107IchO8TrHL2OJCTEl07Ld2FQEFQuqcHWZd3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400279; c=relaxed/simple;
	bh=FNyixndDxADTw0JP/tC38iQVFIQ68/oC2Eqwk904umA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFOtN0SQspu5cBin5j5bYptrnAt8zo0IAP/sUU6xd75y1HL0RIFpO6nPVdhFdXZMC5/CGAaeTK+q0Zs2z8CWhTNKbXhx16X+f3NE0PzwbsAh0GGD1A3gkt7OQmQtCb4qPRbqWbPZ7M/GDdB7Vrcj2KRCoYB+79tJHCprk2MGJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cold-front.org; spf=pass smtp.mailfrom=cold-front.org; dkim=pass (2048-bit key) header.d=cold-front.org header.i=@cold-front.org header.b=CYChQLhF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kb9nTrPb; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cold-front.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cold-front.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cold-front.org header.i=@cold-front.org header.b="CYChQLhF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kb9nTrPb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0E491400074
	for <connman@lists.linux.dev>; Tue, 24 Mar 2026 20:57:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 20:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774400276; x=1774486676; bh=++BGWUrfLd
	0FQnagsWFo+5Bol+waTXInrd3Bv4vkVH8=; b=CYChQLhF5Gog0dRGcSD67YcuwY
	907HogCY40igcRQZQRZwbb3m30NBwkt1gckgryNKfvVmbORejeYttcaKzcTK8FxS
	Z5R0zOGRcWgI+oqfVTs+w12xMNbITthSNqCrQd11BH8dq0/2JBdXUVabM9MMJHzq
	wqLPREaEmxxcE8WstpbR2x8FxO1OOwwX1bxOJiQvoGw/Su8JosRWlRSg1Trdn5bQ
	JY1uEiSVj014XVn9xKCt1zmk5xRz6U1RIwaXAVzvXcqgFfhL9oR4g0sWJJlkgolH
	8CSG+p2W5wopTPK3zjBcRWlKsF92rpQe38v69oekD8NQxEcOcvZuex3ve++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774400276; x=1774486676; bh=++BGWUrfLd0FQnagsWFo+5Bol+waTXInrd3
	Bv4vkVH8=; b=Kb9nTrPb8ft2+P6kevhDUlr+zuEOEJMG0ih5watbQmWUSsPc+yn
	+UU9A38U04XyzU4ONScmrh7QeExWw09bX82U+mAKMcNc198s9Ti3xC3OlP3H7O70
	ZGjNc2nVXU398ozO2uQsoFAhDQSDSoj/2FirHnffjusNaY5N3p1bAamyoe8XUZG1
	syQKXS32v5jMYg2es5T+v0YhEFaFDqWXbuwP8KyQVxHfKbtERhqrCtGTJSnXexFr
	1WZggfudWWLrbJOXtKOH2NFzlP4wXrPqmh6H31s8agLpCXEF2w8s0lFgAmdj4ijd
	PBeOgI+Uwmr2Z3Q8lGQVk41dx37M+CenTxA==
X-ME-Sender: <xms:FDPDaW6N1AANFPjHIWW1Lp-hBMWpHHQWi4K67UpxCVe5Ip7t4isQTA>
    <xme:FDPDaW0gmb1OcxY-8ud3HaCZynjLMnNbF6QezJcPg0T11tdjMhnAHIicVfZ7T19EA
    ge-ENyTYW_UaaPu77EU1BTau_vRCrhq44jCI_a51wRwasga53Tr0g>
X-ME-Received: <xmr:FDPDabEn8zPPuiC5GCOf1gZHFg9_IZkiSLDjR-nMokvNFlKC5WBI0t2KqHICj8FuWme7lnGZx6cWXS_7wXX4foSe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheplfhushhtihhnuceurhhonhguvghruceojhhssghrohhnuggvrhes
    tgholhguqdhfrhhonhhtrdhorhhgqeenucggtffrrghtthgvrhhnpeegfeegffethfegtd
    fhhfduiedtgfffjedtffduvdfhgfefgfegkeehieduffegudenucffohhmrghinhepghhn
    uhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnthdrohhrghdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhhnmhgrnheslhhish
    htshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:FDPDaYRt0hEhDxVr8ISoaDASeEVI2bLFvIec89o4fuFZdGWwie3ghA>
    <xmx:FDPDaaAu0rP6nB0y8spNCWUvz6kphbP7nufn1kBG0TYI_dF30ro40Q>
    <xmx:FDPDaQ2HjOOXXS3yxiElGuNNulkuJD_jQ3B-i512sKbo_YEDtM377w>
    <xmx:FDPDaQU4JvkTkXGg6mYvLBTpUPWoK-Pw-McRAn_RB8AuEhLw0ITFFA>
    <xmx:FDPDafYlDa2_P--trenAjWMnfLNXGFSInBefyOE_6GQyErbjCvpexnpq>
Feedback-ID: iea0042cb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <connman@lists.linux.dev>; Tue, 24 Mar 2026 20:57:56 -0400 (EDT)
Date: Tue, 24 Mar 2026 20:57:56 -0400
From: Justin Bronder <jsbronder@cold-front.org>
To: connman@lists.linux.dev
Subject: Re: client: set rl_prompt after saving
Message-ID: <acMzFAxE0MEtgW2p@ravine.members.linode.com>
References: <20251018212411.181909-1-jsbronder@cold-front.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018212411.181909-1-jsbronder@cold-front.org>

On 18/10/25 17:24 -0400, Justin Bronder wrote:
> Readline 8.3 crashes when rl_save_prompt() is called without
> rl_set_prompt() being called first [1].  This means that interactive
> connmanctl immediately crashes upon invocation. As we're about to clear
> the line anyways, we can just set the buffer to an empty string as well.
> 
> Alternatively, I believe that both rl_set_prompt() and rl_replace_line()
> could be replaced by a call to rl_message("") but I don't want to
> expand the scope of this patch.
> 
> 1. https://lists.gnu.org/archive/html/bug-readline/2025-07/msg00007.html

Hi,

Just checking in on if this patch is appropriate for merging or if outside contributions are not accepted?  I assumed that connmanctl immediately segfaulting with readline 8.3 would be something that would be fixed on a bit shorter of a timeline.

I'm sitting on changes that I'd like to push up to openSUSE, but if this project isn't supported there, I can just drop them.

Best,

-- 
Justin Bronder
