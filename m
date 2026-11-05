Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.33.110.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883720;
	b=UBnvav7bDO7D+jeTs+nWeENB/zIrmuVnBtwlYjcdzfBDzytZnQfVzQLF4/CLPslSCInf
	 julQ2ApNq7KVjjOBbcY2zXycQn7kaF+iRj8mnXgEJTZTDj1Eh/M/y6463UnSz2k3TgOjH
	 W3RB33QoVsUPx5QLGc8RmycxVOvELTV/sSLqtY0rFXzWbu/92pu4btVWdkQuWUshclX1s
	 RYstVKORonQVz6U0k4JwnGlPLdOp70IWWqTIueDSnFnwsVV/tCc8/NA83ykdoDSPekFI8
	 Y7siz6DV2WLOtefU05sV7a2NW5/yCm/HFcAB1aL1SuRqEPjkh0eZ+PF+OdV4liGlHgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883720;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:x-ovh-tracer-id:X-VR-SPAMSTATE:X-VR-SPAMSCORE:
	 X-VR-SPAMCAUSE;
	bh=UdeQWGw1oC6G/OtQXanZnrB/39ZI0SgkhJq+iLaVu+4=;
	b=ecvjQyQWh0SUO5OwGIl/2n0Q33ViO8ojV6r1LEC0TvGffBZzkPidmL8cpiaymS32B1NV
	 nF6uT8k3EvXd1bwx98AZRzwURlq3Redt7gpNIumNqXqGGzqCUPNVxZ08pEOYfYXTYHUUU
	 sbWyHxNN+qABcEtzFfhqjsnUM9r6L0ShMXhZXROdMIs+kLbvEk/k9d88CProVJnzrEMzG
	 ts3KeEqO/34BTjMmP13DkfrgaTDWMw9iwiM+TvRGWKrJ710RUqKaT1ok/Ocpr1i/SoLhO
	 2RVn0HLXwKuIOiFLxIRl4/9TidvmfPUftEw5g7dBt5ZDKfE/u8T+485hHhUlQXxiUBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=178.33.110.199
Received: from 14.619.mail-out.ovh.net (14.619.mail-out.ovh.net [178.33.110.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F7606A32C
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687F7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.108.42.174])
	by mo619.mail-out.ovh.net (Postfix) with SMTP id 4jL2Wg6YhhzBFsy
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:51 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [RFC PATCH 0/6] DNS over HTTPS in the DNS proxy
Date: Thu, 5 Nov 2026 13:01:39 +0000
Message-ID: <20261105130145.523935-1-email@samnazarko.co.uk>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CAS10.indiv.local (172.16.1.10) To DAG16EX2.indiv.local
 (172.16.2.162)
x-ovh-tracer-id: 9096989776228962284
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFcgoaOaFH0jdUnASh3C3SGmLejKNrn8/DfYoURC9pUrvtpeXwmoyDj/Kv1Edpb60LcO78GB6k/1mUWa24NLptd/DIK6bqHALAiENV6ApMjzYWK1da+s1rdfObj2ESs1jTw3+b5Ycc1PE0SY+7OpFFpzOYrSlD/nIUDl+6flIia3d4hgW84COKMfWJc1NmYs0aQ3qKygP8AlsI4WDrvdbS1udSz6YsaAYm8WIgjxAwKcqNAZzz97narZKWsh9SEI3sGSb8CfTWCr5olrFu1MUO4V26H6lyAGWjCi0nhkOZTrmUQONt/FVnX9TXP5ZwJcyZ4SQ5wQZ1t2dt3fxt8oUFAqLdAyypzYrlOYLl67CZ2hqYMiMQSEjlHf3u2U1E6eUvXc3OdFt7xEHZdYmKuleuAWWVr7Y/P7AHv3Mp+uZQt85RAJbk8hbex402CJ+qmp7mMV4eLueWILpm9J3huSoiGQdbW+B5QvQGZWDizEY8AwwVrQq4r2saPMVnSGmRMoM5S3UaB3ugL7XBd/XAvHLcgJFi7Fvy4RZVtdgK0XNqPiCoiLnB+inUG+Y1svjD+bTPoKMJYoMVVGqUi/wq86S5PTijpgWvJlvOUk7u+Dk08EdbbNWWpg3yryI45wFRYKbSus8EHIZc/NIB37JJbQP3XPOVORa91xWhMgMzcFE5Jug

This series adds DNS over HTTPS (RFC 8484) to the internal DNS proxy,
without depending on systemd-resolved or another local resolver. It is
an RFC because it makes GnuTLS and nghttp2 mandatory for the internal
DNS backend: please say whether you would rather have it behind a
configure option, and whether the D-Bus and main.conf interfaces suit
you. OSMC is going to ship it with ConnMan 2.0.

The new DNSOverHTTPS setting has four modes:

  off     plain DNS only (the default)
  auto    use DoH when every DNS server in use is a public resolver
          known to serve it on the same address, so the resolver that
          answers never changes
  on      use the DNSOverHTTPSServers, plain DNS while none of them
          can be reached
  strict  like on, but fail rather than fall back

Names only the local network can resolve always go to the network's
servers in plain text. Queries share one HTTP/2 connection per server.
HTTP/2 is required, as Quad9, Mullvad, DNS4EU and CIRA refuse DoH over
HTTP/1.1. Certificates are verified against the system trust store,
including IP address SANs. Devices without a real time clock need DNS
to set their clock, so while the kernel clock is not synchronised a
certificate that is only outside its validity period is accepted,
after the chain and the name have been verified again.

The mode, the server list and the state are available on the Manager
interface and in connmanctl, and dnsproxy-standalone can use DoH for
testing.

The series applies on top of "dnsproxy: Check the question of server
replies", which keeps plain DNS replies from answering queries meant to
go over HTTPS:
https://lore.kernel.org/connman/b2a0934fd93f76fca771e2a73d6da6d9d1272f76.17=
93883047.git.email@samnazarko.co.uk/

It was tested on Debian 11 (GnuTLS 3.7.1, nghttp2 1.43) against Quad9,
Cloudflare, Google and Wikimedia's resolvers: an IP address URL, host
name bootstrap, fallback and strict mode with an unreachable server, a
certificate that does not match, truncation for UDP clients, 60
parallel queries over one connection and servers closing idle
connections, also under valgrind.

Sam G Nazarko (6):
  dnsproxy: Pass the protocol to cache_update()
  doh: Add DNS over HTTPS transport
  dnsproxy: Add DNS over HTTPS support
  manager: Add DNS over HTTPS properties
  client: Add doh command
  tools: Allow DNS over HTTPS in dnsproxy-standalone

 Makefile.am                 |    6 +-
 client/commands.c           |  137 +++
 configure.ac                |    9 +
 doc/connman.conf.5.in       |   16 +
 doc/manager-api.txt         |   60 ++
 src/connman.h               |   26 +
 src/dns-systemd-resolved.c  |   30 +
 src/dnsproxy.c              | 1031 ++++++++++++++++++-
 src/doh.c                   | 1873 +++++++++++++++++++++++++++++++++++
 src/main.c                  |   41 +
 src/main.conf               |   10 +
 src/manager.c               |   63 ++
 tools/dnsproxy-standalone.c |   20 +-
 13 files changed, 3304 insertions(+), 18 deletions(-)
 create mode 100644 src/doh.c


base-commit: 9e46e4a021cd8566b942d1a72b41b14a0a58f506
prerequisite-patch-id: b73b8f52612f48f24926028c84aba2d2b8058181
--=20
2.34.1

