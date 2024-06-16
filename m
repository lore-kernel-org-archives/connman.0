Received: from mail-108-mta106.mxroute.com (mail-108-mta106.mxroute.com [136.175.108.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789611773A
	for <connman@lists.linux.dev>; Sun, 16 Jun 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558351; cv=none; b=I7SFYmlr6P4eTpinhlHkIj+EexeCfckrsL1yn24c953YWGIMoGkxmD83efaWF3vWeijUXiXSIi7SstzMvhiRUxcwt1c0HU2CMED98zIV1+bJsnoofSHacNJ7in+u4PpLPJnHrinCASE5AYNjAKvIe7NIOYZbtTEaHvi3JoJCN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558351; c=relaxed/simple;
	bh=ujAffFUL6JnD5y28Imi6thlikVC6Ep8k33l2dm6FeyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpCXoTcOaWlnD9BxDbmGQEW4gk+031UrXJn2dLVolkA7Oy0FLz03nwxcCsy+mQErq/q4F8+q/OEV4EzIUAqfwCGqrOQsiuAL5yu5duMygWcRNYMcvrUAL4udbgUtUq626W0dJ7wg0TIw0hn+3EnhJHyYbj9gUA4cWIhvBDr3hJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freakingpenguin.com; spf=pass smtp.mailfrom=freakingpenguin.com; dkim=temperror (0-bit key) header.d=freakingpenguin.com header.i=@freakingpenguin.com header.b=jz7KYgcR; arc=none smtp.client-ip=136.175.108.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freakingpenguin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freakingpenguin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=freakingpenguin.com header.i=@freakingpenguin.com header.b="jz7KYgcR"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta106.mxroute.com (ZoneMTA) with ESMTPSA id 190220a8d6100017a3.002
 for <connman@lists.linux.dev>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 16 Jun 2024 17:13:55 +0000
X-Zone-Loop: 18dcdbffd1381907bd357685dd53205cd3475478a15b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=freakingpenguin.com; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OBk3XBEdqiUWePe8zYAd7y2cq65q43t1U1I+qaPCXt4=; b=jz7KYgcRCazgTm/vyUks4jDxZU
	Swgpyq7/rUUjzdiRIfL41BVI+RcP10w8IkQOIZczCkA50MSed3XmI1WijfG8RzRGaU8XELl4pHZed
	tnQR1ky8ie4DwD/4J/9m5tbRNjYk7rPLzVhIKDb95iEwotSUD6yxOSA0tjVcv+Q28eIIHgREzDlup
	YxF4ReYxbz1xR9hsdP4BONXw0gothcT1oAJ6NnLRlgyU+8OksIQh2uISB9BnkmtSKuMsDbs53vL1j
	QiZZ7a6QVKOv2f4MPEDLESQOVl1DpT3UPRoH94YPtL/ZrSsjUrnDTODHdrni4ih+hlYxwSAQdsF7e
	GhqdOHgQ==;
From: Richard Sent <richard@freakingpenguin.com>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Global nameservers or alternative to / change in
 FallbackNameservers
In-Reply-To: <CAG17S_MDPgomPHz0WGvc656fHobod=jwqT_t_xNqbTMw2K-Wcg@mail.gmail.com>
	(KeithG's message of "Sun, 16 Jun 2024 10:59:00 -0500")
References: <87o780anzf.fsf@freakingpenguin.com>
	<CAG17S_MDPgomPHz0WGvc656fHobod=jwqT_t_xNqbTMw2K-Wcg@mail.gmail.com>
Date: Sun, 16 Jun 2024 13:13:47 -0400
Message-ID: <87bk40olo4.fsf@freakingpenguin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Id: richard@freakingpenguin.com

Hi Keith,

KeithG <ys3al35l@gmail.com> writes:

> Might this be where we recompile to use systemd-resolved? This is what
> I do so that I have control over DNS. It's in the docs. It would be
> nice, though if this were a runtime setting instead of a compile time
> flag.

Thanks for the suggestion! In my case I'm both on a non-systemd distro
(Guix System) and using --nodnsproxy so that's not an option, but it's
good to know it exists.

systemd-resolved support was added in 2018 (972e16af), while the comment
mentioning the mysterious seemingly-unimplemented global nameservers was
2010 (1cdd39b9). I think needing to change the entire DNS backend to use
a global nameserver instead of DHCP-discovered ones is a bit much to
ask, so a runtime setting would be lovely. :)

-- 
Take it easy,
Richard Sent
Making my computer weirder one commit at a time.
