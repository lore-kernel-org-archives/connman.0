Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457555;
	b=YIdLp8JcNcNtQoPrdVwafIpdE8SjiHlmlwCtVjZgXkwp9xkFHIzsA7r2BPmMi0bDrUPe
	 qDYWjG4uzF49TZOrSbIV9s3sNui7gRQPj+fHbwbsBOvPC+lU1VlzjZpe9T8Ijw3A43aJr
	 YeNi1WzamsM3qPN/hXP5crjef0hVh5XZeFXBgopKESylF94bEMvG+jOYQi8Z5wnCAhLKY
	 nBO5VLpwNdClgyFvXhBu6igz9PhpiHiuj2ucdWIyVJI1Xnn3g6qE5Q960JBSPXkG62M61
	 Gh+K/gn8KTcYBX2aQcGtIgDZwPFOqrrF2WdWLxUiO2Qh0yz40xBGGBUN0PrqyXIAHsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457555;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=Ql1L6IafBkv3lOLxf77NWVf5Q2/pedP5/M88cWYubUE=;
	b=FwbCuWINikR5YuwQd4GFNyJ+vp8Q/veG/IHqQ9NkD1cFN6nrFU/K5YQ8CSnnTh2YZzhg
	 3kH1KHMgRNPsbS6UvnwmpH8VdANAS57IIKHGvdvk7c08DExHBUmpB65mSSHzyW9cPpBkL
	 Sa4JXqrB+K6riVbn5ephq2d1DKyxAmFCc5T3rEpMuMtBGqVs5PSmSNNN7PvUcinlpokIV
	 Qw49CtYaI+xssQ+fM9nlrBJV8PY92IRJyoJWhOYZW/Zm45PKp6FwdFp0TGhn+MLI5ILiZ
	 QFan2L6nwUN7fG+dkwo54lpZ1/m5x/u/muGsTolYBjocw/9CBCggAajX63vnWZ/ZSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=hl3Dinfn;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240C606A31C
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 04:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E240C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=hl3Dinfn
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id D1C7D1601FB;
	Wed, 11 Nov 2026 23:25:52 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 5E584124BF7;
	Wed, 11 Nov 2026 23:25:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: giuseppe.eletto98@gmail.com
Subject: [PATCH 0/5] wispr: Complete Every Online Check, So Continuous Mode Never Stalls
Date: Wed, 11 Nov 2026 20:25:46 -0800
Message-ID: <20261112042551.1613107-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Ql1L6IafBkv3lOLxf77NWVf5Q2/pedP5/M88cWYubUE=; b=hl3Dinfneq6ZXPuVgB+YCNqnZ/qdclNVghOUC3wYfjvvJ+j7uPMedjOMRPEAJRcyQ6biBKYzWgppC1SAQm3ehe9dZItexr5Pzkz2htqAzsYijDw8R3GWLzg39xA3lTerXYUYyY+GrDwbHVSizjR03u1z+zYtc+l06GLngwdwPXtJEVZfpJ38pjE2a3oxzdKmnBnOXcJSs7DBwJQUM7CYcNpUtrYatO9fOD1uzwZ3P+3iZxX2hlg4+i6en9Miwu5FBj4mYnJ5Pa1+GlGVF01bpioLzDUU102DspjxrJR3WFu6xbfbK/C6QRCTfFQxH6Vp+97XLjlrNOs4nC2S3k1/HQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Online checks passes only on HTTP 200 with an 'X-ConnMan-Status'
(see related https://patchwork.kernel.org/series/1122950/)
header. Many other outcomes never complete the check at all:

- A status the code doesn't name (204, 403, 5xx, 511)
- A 200 without the 'X-ConnMan-Status' header
- A redirect
- A 505
- A response that stops part way

The check stays active and incomplete, with no log line. Later starts
return '-EALREADY', so nothing re-checks until the default service,
the link, or an address changes. In the wild, systems stay 'ready'
after a router outage or pause or stay 'online' behind a router that
starts blocking them.

Each failure is logged once, with its reason, and then retried with the configured backoff:

    Interface wlan0 [ wifi ] IPv4 online check to http://…/api/v2/status failed: unexpected HTTP status 403

After 'OnlineCheckFailuresThreshold' failures, the service fails over
as designed. No configuration settings change.

Grant Erickson (5):
  gweb: Report transport creation errors accurately
  wispr: Fail checks ending in an unhandled response
  wispr: Fail checks before requesting a browser
  gweb: Add a receive inactivity timeout
  wispr: Bound online check response gaps

 doc/connman.conf.5.in |  16 ++-
 gweb/gweb.c           | 240 +++++++++++++++++++++++++++++++++++++++---
 gweb/gweb.h           |   3 +
 src/main.conf         |  16 ++-
 src/wispr.c           | 169 ++++++++++++++++++++++++++---
 5 files changed, 401 insertions(+), 43 deletions(-)

-- 
2.52.0

