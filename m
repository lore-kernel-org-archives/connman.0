Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1A1FA0
	for <connman@lists.linux.dev>; Sat,  5 Aug 2023 18:03:00 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9646F32007F0;
	Sat,  5 Aug 2023 14:02:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 05 Aug 2023 14:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1691258579; x=1691344979; bh=k4ufZasxIJXte3MxR9K6+9Dr+
	+4DeE8F/l22bXPGt9c=; b=k1YT6tYBeYdn12Mzu8r95vC7j4Z1i4N/H0F4+UwXT
	vwhw2/jLffkLjze/cmtQ662Hfr+XoNU6qUZrBmljihkdPERQJtfEx5R9/EYtRvOa
	nHAimmh+3kKLYbFAdQNztIcWK90Ontg7OP6q67PiPS2GfDLDO0yWo8/g63ixclND
	2PNP9LLP6WBR8AbZjPzdT426dp+LNc7wFdvX3pCGOabNprdyGSlo3CixlGClgPYc
	/KvnSJ1F5EwsT63/YysYjbjEjnwhebsPLSQ6XY+//11fUc6hQ4d4xF+mSFxP9vuK
	zARjHggG+c9A+Hu81u9N1WUBdoNwOUNyGw1ZnErmc+Lcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1691258579; x=1691344979; bh=k4ufZasxIJXte3MxR9K6+9Dr++4DeE8F/l2
	2bXPGt9c=; b=DZsIfYdRZzqR4VmRq+QJvGdU6WAnJrrtlbKlxOKKgJpiVvU0C41
	XVD4xunB0c8vdfkTLRBKEAAl0dUIXMu6i6tfWUNCr6TYPncrKBBm3SZoQ4mM3tLH
	D0GYSCBzoRv3FXxQSKmZoNdSSFkiytfHzayE58hcz9ZzUyzH+j4zciQuZTozJAgB
	fdgqQ0vAuchIJDX8REjpF2xwozdqb2866tdk3sg9/HUStnk0e2T7SPYi8H8pPqpM
	UM6Wd7YKmxOXuWf17KVUlJDYhJ8Y5r5NE/ECBJYUs/tXhZd/F/4p4H41NQsrRVXs
	I0thoXWE8MQloPWsYuML1+zSOpInr9KZppQ==
X-ME-Sender: <xms:0o7OZBStLv-kKlWECFx8HVuYFC8nreFaDHUa8c-IGj_ZMIOi3OrF9w>
    <xme:0o7OZKzFxcS4CqDhXC1d7UXpPP-4NnR6Ua4mtGljYKCdXZgsmx64LP2jmqeEsr-xW
    rZl91ZuRkYCr67oOA>
X-ME-Received: <xmr:0o7OZG0KvtHoc8EMG0TYtUvoo38mkrrRm_mgL2FeFdlvs5AU87T1ci5vJILpyxBQ3XQeT73F14LKZxsDqgXhDrVdhDB->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdfstd
    dtreejnecuhfhrohhmpeflrghnucfrrghluhhsuceojhhprghluhhssehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnhepjeeiudeuieefteekgeeuudfgtddttdekud
    dthfejtdefhfffgedvtdejhfekjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhhprghluhhssehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:0o7OZJDKp3ISxJADUubUrdm40gO4G0pKeeeOtRXXXKKOeDKzXTXVUg>
    <xmx:0o7OZKhjcmqwVmhwhOouQ4KYSXxO_q1J4loogkz4LYhevL4XfUa7lw>
    <xmx:0o7OZNr6AyhelTUmWvNFE3OWojAX5kLT_47lUDBiuFCYdQBnuDI4Vg>
    <xmx:047OZAeC5Ah-WA4018o9P8dm0oANHoC9JQF_ziqVNev7Z0meux-FuQ>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <connman@lists.linux.dev>; Sat, 5 Aug 2023 14:02:58 -0400 (EDT)
Date: Sat, 5 Aug 2023 20:02:56 +0200
From: Jan Palus <jpalus@fastmail.com>
To: connman@lists.linux.dev
Subject: connman 1.42 build failure due to missing header
Message-ID: <56htxwyywekx6sjsq2akitcj6xmqmggkv4uo6wnhmlxmxyzo23@5crxfr5suvpk>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20230517

It appears that connman 1.42 dist tarball is missing
scripts/libppp-compat.h header resulting in compilation failure of
scripts/libppp-plugin.c.
