Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5D19BB2
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3B042730CE
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 14:00:44 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 07C9973108
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 14:00:43 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 7/8] Add documentation for 'OnlineCheckConnectTimeout'.
Date: Sat, 11 Nov 2023 11:00:43 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <B812092F-7FFE-4001-9418-F62250092964@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation for the 'OnlineCheckConnectTimeout' =
configuration
key.
---
 doc/connman.conf.5.in | 9 +++++++++
 src/main.conf         | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 75669abc5bcd..9049d7037623 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -174,6 +174,15 @@ Please refer to the README for more detailed =
information.
 Default values are http://ipv4.connman.net/online/status.html and
 http://ipv6.connman.net/online/status.html respectively.
 .TP
+.BI OnlineCheckConnectTimeout=3D secs[.milliseconds]
+The time, in decimal seconds (for example, 12.3), to wait for a
+successful TCP connection to the host associated with
+\fBOnlineCheckIPv4URL\fR or \fBOnlineCheckIPv6URL\fR (see above). =
Connections
+that take longer than \fBOnlineCheckConnectTimeout\fR will be aborted. =
The
+default value is zero ('0') which indicates that no explicit
+connection timeout will be used, leaving the timeout to the underlying
+operating system and network stack.
+.TP
 .BI OnlineCheckInitialInterval=3D secs, OnlineCheckMaxInterval=3D secs
 Range of intervals between two online check requests.
 Please refer to the README for more detailed information.
diff --git a/src/main.conf b/src/main.conf
index ef1939cf5b6f..ddcb3564c246 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -132,6 +132,15 @@
 # OnlineCheckIPv4URL=3D http://ipv4.connman.net/online/status.html
 # OnlineCheckIPv6URL=3D http://ipv6.connman.net/online/status.html
=20
+# The time, in decimal seconds (for example, 12.3), to wait for a
+# successful TCP connection to the host associated with
+# "OnlineCheckIPv4URL" or "OnlineCheckIPv6URL". Connections that take
+# longer than "OnlineCheckConnectTimeout" will be aborted. The default
+# value is zero ('0') which indicates that no explicit connection
+# timeout will be used, leaving the timeout to the underlying operating
+# system and network stack.
+# OnlineCheckConnectTimeout=3D0
+
 # Range of intervals between two online check requests.
 # Please refer to the README for more detailed information.
 # Default values are 1 and 12 respectively.
--=20
2.42.0

