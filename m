Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CD3B71A7
	for <connman@lists.linux.dev>; Sat, 17 Oct 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260393; cv=none; b=UWjIhL5yJ6myE2yq3TqcTeV31wBK9CQxssjT2SELivxTpjgoCkGZyvi3oFufRaDbaVBvJFQZzE2zFrn7SYNOdBqG3Ja7LAcLyOm/9XoobBnUZBmrvIm3SnV/+hw5kfJ8wrj7bvnF/3kKPfQWVGT2tdloq0tfsosiaxEMTinwEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260393; c=relaxed/simple;
	bh=G5Fh5U0oC+pzVWptpJXYUt3rczeh3eav2i5ojQ2q5eg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B1c2ByhsyZbH1Nucp1HBPDvuq8SuKso7StbB1ahsGj8a/c6SyECFMru/LCvIcQW2pu0KITwMsX/9IkP+LTHdtHtm9ALVWt7WkLXAhlZbBWCWhlk24wEdNx6qYCPwZZdAcvBHCB0lJUhhIU2nTjz1sMFMrwwcpWusIJjbHmS5MS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=dzYXlLHq; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="dzYXlLHq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=95inmTXRe13UuFgg7Oymu37sl5xQcUbqgbCuKEIouIM=; b=dzYXlLHqesqtVyPa4IHqXzZKrW
	+rJidwOCBPF4fY/Xv//dLEPeTN8MIjkTgZ66No/7dpDcG87/OOP/2U3XeNqr1d0S4t8LFARw5tNfL
	WTgkejEwO3e6+54f4LZ1xr91Stw77iuPRe3SA8RxgmKf7BS+LaHZSyF/uhq+fJMsuuQ5bqfe3uDim
	zMWzugxzMUejwBOtxistbiGTJuV46jqzhQDCNEHlGQyOL+fyKfQ1hf2gwUxwkd9929mEGPM9ItjBi
	ZwVIvJf+rhh4Qr+AYxksStv+5NOoHtWf/ZQ3sH86G+vP2yes6IHSr2VLcRrR6au6BqRUmQ9EMKI2F
	5Vbh1FwQ==;
Received: from [2a10:a5c0:37:6500:692b:4032:511f:1a05] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1xI7NL-00GTaE-2L
	for connman@lists.linux.dev;
	Sat, 17 Oct 2026 19:35:19 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] Change inotify to single instance mode and add cb data
Date: Sat, 17 Oct 2026 19:34:33 +0300
Message-ID: <20261017163501.480955-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20261017163501.480955-1-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

This patch set includes old changes to inotify.c from Sailfish OS ConnMan fork.
It includes change to use only one inotify instance, adding refcount use for
inotify and improving the callback support for inotify. These changes have been
included in Sailfish OS since 2015. The changes included are acting as a basis
for the next NLnet project patch set containing large changes to storage.c in
which inotify is being used more than currently.

The first patch adds user_data to be used in inotify callbacks. This is due
to the requirement of having to handle different events from multiple locations
in the same callback.

In the second patch inotify is changed into a single instance as the amount of
the instances is limited per user. Also, this patch makes it sure that the
struct is not free'd unnecessarily when callbacks are unregisterd by adding
struct reference counting.

These changes are also available at my connman_ng repository located at:
https://github.com/LaakkonenJussi/connman_ng/pull/8 - I will keep adding these
NLnet project works on top of next branch, and sync from upstream when there
are changes pulled in.

The work for making these patches available for ConnMan upstream has been
funded by NLnet foundation grant NGI0 Commons Fund:
https://nlnet.nl/commonsfund.

The NLnet project website is available at:
https://nlnet.nl/project/ConnMan/.

Hannu Mallat (2):
  inotify: Add user_data pointer to inotify callback
  inotify: Use only one instance and refcount struct accordingly

 include/inotify.h              |  10 ++-
 plugins/session_policy_local.c |   9 +-
 src/config.c                   |   7 +-
 src/inotify.c                  | 158 +++++++++++++++++++++++----------
 vpn/vpn-config.c               |   7 +-
 5 files changed, 132 insertions(+), 59 deletions(-)

-- 
2.47.3

