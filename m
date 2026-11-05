Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.40.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883706;
	b=i3+Tsq80whYOIC/5f50aIf71Jtfr4ImEZGejy29gqs6rf025cFuOagC3Miroiu40hJCe
	 S+GipHtjPHJtAuyHOKMokZDPB8erODcMfTjnn8T5JCbSXVsm8bIV0pCo8U7i+sntS9i8S
	 PpEMdZ2Orf3FK5HR+MVrY0MeILSG1kwiHA/eJrYpw72Avw8drfomvi+0W8L+2BXWvqU5y
	 M4j3C5GfBK0giVIIt7EpFZnnE8EbsDyhSvajIh+1HxFLQCQRFwPogsGhUYB9d7bBB99Nj
	 7hllNfJn3Ty65gPJdc0pOOJwON9Jo8k57mScY2E+9ICXm2/0IutJbDVVFtqPjMxcfaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883706;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:x-ovh-tracer-id:X-VR-SPAMSTATE:X-VR-SPAMSCORE:
	 X-VR-SPAMCAUSE;
	bh=DzI55p4NeCymBCmRcfbqGyUVcv6GyuFyH3ONlKPmzmQ=;
	b=j4rNVkYS9bEGpwIientGNP4W0TDc94xHppFC59+/qJ4EIBA+soXWaOiB5XyRkceOrlPQ
	 xWSTNKjC7Bfd62aZI1oAZTtIBcpjIKoBTkqxwyn4UjnLiDoMRowm+F5IZXQs+s8SRqBMJ
	 OrdhWPA9KBGh3sZ7r4C1gLNP+1DpgKxv5Cvzg8uYUVbjsXmrhIT4ZYx85eNt65nCBpic3
	 MFYrRnSRi11m539tsiB1wLeG/HEEPFGKmGL63rZkUJcM8MXd6rwaNX9tllhA1LvGdRyT4
	 T5sUrB4EBI9wpiSUZQW5hXjfpdE4N61JFFqPjsUh5f/E61W4HCQYlFhCpGfYlg5/Ong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=46.105.40.13
Received: from 5.mo619.mail-out.ovh.net (5.mo619.mail-out.ovh.net [46.105.40.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19ED606A329
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A19ED606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.108.42.159])
	by mo619.mail-out.ovh.net (Postfix) with SMTP id 4jL2WP5THkzBFsh
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:37 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [PATCH 0/3] dhcpv6: Keep the DUID stable across restarts
Date: Thu, 5 Nov 2026 13:01:28 +0000
Message-ID: <20261105130131.523894-1-email@samnazarko.co.uk>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CAS1.indiv.local (172.16.1.1) To DAG16EX2.indiv.local
 (172.16.2.162)
x-ovh-tracer-id: 9093049126300274668
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFzpP9Y64MDxti/UAte3iicMEPo0I0yfZCfh1yUkzp8R9wGIxr8G7CPyaG7XHifbLd9jD0Q5/jg0oiAqhxzwAWk33vCiPGvHANBJyGJ7b8W6F4PCMyCcxK4kFQRxDuLV7LCXJaoq+UvFt8r2rMovxxz7RkvflU82O7nezToS8JGMoifI9U5B4kaX3TzJ+NLXwgEmRznCD+qiLT9PHxfWpPvIpKNpnyWroVoAnyo7ih0jf8mMU69he3Bp9fEgAS2+QDdUpGMom2xdtF4Kml+Jot8QLtJ9qrXfKu0u3lcFX0fFeB+gFLnA7nQiPzhr/lLVdfzRiwKUP0Ihn3tnPrsRSMPP3BH3Oazvc6oi0hvxM+iVEcul+GHolZcYITy/vOGBRoaa/cwaMLvlCw7j5h8xd35G5AaNw1dIGfL1uFSWHoWRJV10tkzrmZs3Yj28UZDDa2CtcjdNMDaimMvUVxrdqnpUYlucZocJJQENw1NRIUMOBmobgq/asJhoV7ODW/ihKUa6nOfW1K0TmfDlT9QM0TgOQJfIFtty2TfpV+RIuk8YlIyQIfJUm7GQ0ARCEsBy8Lsf5IefQg0Qtl21uArrtGJXB9QOvoaCrUZ+dxP4qjaZhlaqXQgzDxRVBDyxjHhuQNsWUChbNQt20DP8baLJlXPZTDXEQ/NSXC4yPd6gyJS6g

ConnMan creates a new DHCPv6 DUID-LLT after every restart or
reconnect, because the DUID it stores in the service settings is
dropped the next time the service is saved. DHCPv6 servers then hand
out a new lease each time and can run out of addresses. This was
reported by OSMC users and reproduced with dnsmasq as the DHCPv6
server: three DUIDs over two restarts before this series, one DUID and
the same lease after it.

Patch 1 keeps the DUID with the service's IPv6 configuration, so that
it is saved with the service. Patch 2 replaces a malformed stored DUID
instead of decoding it with unchecked sscanf() calls, and patch 3
keeps the DUID when IPv6.Configuration is changed.

Sam G Nazarko (3):
  dhcpv6: Keep the DUID across service saves
  dhcpv6: Replace an invalid stored DUID
  service: Keep the DUID when resetting IPv6 config

 src/connman.h  |  4 +++
 src/dhcpv6.c   | 70 ++++++++++++++++++++++++++------------------------
 src/ipconfig.c | 26 +++++++++++++++++++
 src/service.c  |  9 +++++--
 4 files changed, 74 insertions(+), 35 deletions(-)


base-commit: 9e46e4a021cd8566b942d1a72b41b14a0a58f506
--=20
2.34.1

