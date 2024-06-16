Received: from mail-108-mta2.mxroute.com (mail-108-mta2.mxroute.com [136.175.108.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C2ECF
	for <connman@lists.linux.dev>; Sun, 16 Jun 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718553181; cv=none; b=Y9fOJXLjRl0ZRGnzSYthezjBVLihoCrceLIJmZca29oDTP/32+LJ8LDTwytzUY3kt5Eixa71+kisTYCg1tnRPQXjYCbYMeg9NCeRs0DmRUjQXqNrSLBNlnhGAwi9sVtWa4KhSeZajWUXd09BW/XEosAqD8sU07WbRXwrWUULc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718553181; c=relaxed/simple;
	bh=j1MO2Rmg39w5tkmSLIPGoPRxQMz5AQnL6MhOjCMTOcQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gOL3zcBCX8YRlzllXwhUjg0gDCdVTSk3r4oRO4nifBFTBcSVQgwWh43gTPpZw5Hf2/0Vmf7pmKd8YEbTmQ/mGkVzaWPRCycjUm8dST72aL57KPS7ONOLzuHHEulxZ3v4Vw2vdTkaLJos4XCdY0xiQrQMhiMo0QdEDJ9mNNFtNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freakingpenguin.com; spf=pass smtp.mailfrom=freakingpenguin.com; dkim=temperror (0-bit key) header.d=freakingpenguin.com header.i=@freakingpenguin.com header.b=hFW9RHh8; arc=none smtp.client-ip=136.175.108.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freakingpenguin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freakingpenguin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=freakingpenguin.com header.i=@freakingpenguin.com header.b="hFW9RHh8"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta2.mxroute.com (ZoneMTA) with ESMTPSA id 19021bba4d200017a3.001
 for <connman@lists.linux.dev>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 16 Jun 2024 15:47:43 +0000
X-Zone-Loop: 490e2730a78cc5b7cff1bc35c0cde7d58f35f52bd82c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=freakingpenguin.com; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dfmU/cMKYJ9qRF1zpzcNVawmMg8yfrta6yyAd3OM8pc=; b=hFW9RHh8XzgusagSy1yN3jeMvm
	XZDwCZN332FiPVPvgEdeBRccO8kl6bgWTnsG8qVkCvt4snUloH9pwyX4Rxii1Tw1jtQ+onsFRKnoo
	5YZZxC8i8In5tYLsPUVWYdTqTR5O9nGujL4Njc+5wgzbxwL050QuPQOKoBJXLqRsqqFl00KsQy1FN
	0oVABeZEVO80XbN68d2yFRv1b/TgSiEnNmPnP90CAwjjKHtno52snS3hHeATDqFAIYA0wsUrpOeqU
	CZcOobN97x4R1+dANUEEVm12qJvBMiy3/hmAoNfXFSBlm5KGECTYPL1oQrc2jVLJRsqo809bQ3TPW
	tUDLYxZQ==;
From: Richard Sent <richard@freakingpenguin.com>
To: connman@lists.linux.dev
Subject: Global nameservers or alternative to / change in FallbackNameservers
Date: Sun, 16 Jun 2024 11:47:32 -0400
Message-ID: <87o780anzf.fsf@freakingpenguin.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Id: richard@freakingpenguin.com

Hi all,

I'm using Connman with --nodnsproxy on a virtual private server where
the DNS servers discovered via DHCP have inconsistent availability. I
thought I could resolve this by setting FallbackNameservers. However,
this setting is only used when DHCP does not provide DNS at all, as
opposed to my initial thinking of using it as a fallback in case the
DHCP discovered DNS servers fail.

> # List of fallback nameservers separated by "," used if no
> # nameservers are otherwise provided by the service. The
> # nameserver entries must be in numeric format, host
> # names are ignored.
> # FallbackNameservers =

This results in a resolv.conf containing only the nonfunctional DHCP
discovered DNS servers and not my fallback DNS. I could configure
nameservers on a per-connection basis, but this is frustrating to have
to do on a system that could be deployed to different hosters that may
enumerate the network interfaces differently.

There does seem to be some demand for a way to set global nameservers,
as opposed to per-connection [1]. This case is even worse to do manually
because it discusses a laptop which roams between connections
constantly.

If breaking backwards compatibility with the old FallbackNameservers
behavior is considered unacceptable, I propose a GlobalNameservers
setting in connman.conf.

I do see a line in service-api.txt that implies global nameservers are
in fact already a thing, but can't find any other references to them.
This comment was added back in 2010, before FallbackNameservers was
added.

> Global nameservers are automatically added to this
> list. The array represents a sorted list of the
> current nameservers. The first one has the highest
> priority and is used by default.

Thanks

[1]: https://www.antixforum.com/forums/topic/set-default-dns-for-all-users-ethernet-wifi-connections/

-- 
Take it easy,
Richard Sent
Making my computer weirder one commit at a time.
