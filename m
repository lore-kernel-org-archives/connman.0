Received: from mail.oscloud.info (unknown [178.254.20.203])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DF7E2
	for <connman@lists.linux.dev>; Tue, 21 Feb 2023 00:30:03 +0000 (UTC)
From: "Oskar Roesler (bionade24)" <o.roesler@oscloud.info>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oscloud.info;
	s=2023; t=1676938925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IMVHjekYDo8V6z9TAY9l5fsdwbaHKJu7JwoKDTc7g0o=;
	b=JzZ95H5ZdJhlBmsMtavbjoCt0NVU6//OK2bLaBVcCzC2u+XjLfpKB7Kv7Dw+NTFsBJKq+h
	JQECJIj4hu5cvdCoJjfKePOLgCmruGrZLP6XeWyKobTzLNyWEgS0TmCA7kv2YH0Qn47T/B
	YAQCjz38k7Xi5QLLgD1EwvLluB/My54kH+Hwwvuy4ncKhlRmImOomdenq5z8/HBrrm1WJQ
	BwATu7RsW/M5VRGkb1MHw4huWvxEwih0XLkIlqpMSqOV6xV1giR5Dryl8QXGEQcLbEeJ/o
	DfTDL9JKPdYODRRnkMTefZWzFLkeLxnuCEJvrXIcZrFmiQ99lunf1y0H+ZHocg==
To: connman@lists.linux.dev
Cc: "Oskar Roesler" <o.roesler@oscloud.info>
Subject: [PATCH] doc: Update connman(8) manpage on the --nodnsproxy option.
Date: Tue, 21 Feb 2023 01:20:10 +0100
Message-Id: <20230221002009.253059-1-o.roesler@oscloud.info>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=oskar@oscloud.info smtp.mailfrom=o.roesler@oscloud.info
X-Spam: Yes

From: "Oskar Roesler" <o.roesler@oscloud.info>

The --nodnsproxy option documentation left out that ConnMan will fall
back to creating a resolv.conf on startup. This gets fixed by this.
---
 doc/connman.8.in | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/connman.8.in b/doc/connman.8.in
index 85e7c5e0..868196c3 100644
--- a/doc/connman.8.in
+++ b/doc/connman.8.in
@@ -94,9 +94,11 @@ to itself by setting nameserver to 127.0.0.1 in \fBresolv.conf\fP(5)
 file or leave DNS management to an external entity, such as
 systemd-resolved. If this is not desired and you want that all programs
 call directly some DNS server, then you can use the \fB--nodnsproxy\fP
-option. If this option is used, then ConnMan is not able to cache the
-DNS queries because the DNS traffic is not going through ConnMan and that
-can cause some extra network traffic.
+option. ConnMan then figures out the DNS server and search domain
+on startup and sets them in \fBresolv.conf\fP(5). If this option is
+used, then ConnMan is not able to cache the DNS queries because the DNS
+traffic is not going through ConnMan and that can cause some extra
+network traffic.
 .SH SEE ALSO
 .BR connmanctl (1), \ connman.conf (5), \ connman-service.config (5), \c
 .BR \ connman-vpn (8)
-- 
2.39.1

