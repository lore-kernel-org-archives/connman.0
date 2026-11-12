Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527673;
	b=zMLS92kKFuj224s1PgeslrDQetr/Cnlq5127RN2YHIzhKdQsApqv1GLHr3DnGtPihckg
	 yOaR1IhKVQc905peRI36TvUWjhXwlvJrvvC2zGTdpVRm+3v1Ka1zmEHkCDuw2xUEchnEj
	 fBegwQ4SfsNnnZpak0USwPVoSG/b33BwuJvMyO6FrFwy32R5VSKZEKEoW/kA1vKgBLPcm
	 AFuYFKqtH8x8DoH91hvPC4+1vIv+fWOYYh6xlQWh+23tWQkKD0OpifQL+mTGl4RePiwkA
	 eegoVLUq7e6L+TkrK4kkJGBK6MNGxJlGMBCHxolPL/a9/PH19aqtaURW/LX6BamtWVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527673;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=aw2tqvD9jqpTl0cbdJvw9cQgL+ZC+914EpdNnHAQmk8=;
	b=jvnFBtiBQTQ1IuNPvn4AYPsMoU5QCG0K8sAy8e98nBv4nC9T30HQts58AJqXADraBC8H
	 l+1uPIB/srSXCXCP5dVAQr7qXiM/pj9eK7QBW/ckbPNUz8K2gvu1bs9Her15zf8WAdH6Q
	 /Yk8lH2Xa+MJam9KMWtDediVxXKTJEIrTUgORopwJRn3X2eJczpoN5Tm8Jpr/Zc93vGbR
	 9LHekgKol1ViRu1hH+myhP8dI78xDc5dJd8NO5PQVC3CKwVrtV0oH2UG0y4yZ4Foj2PDt
	 7LRGwKmE6IBbWDUpNSVT6E9p+j9uzyM0lBSN0MmLRK044XsjZuBiJT0SU/yChmUtm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=S50Oovc8;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF6606A321
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 23:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87CF6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=S50Oovc8
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B629E16025A
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:54:31 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 687E4124C6A
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:54:31 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] scripts: Fix issue with const return value from strchr
Date: Thu, 12 Nov 2026 15:54:30 -0800
Message-ID: <20261112235430.1627131-1-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=aw2tqvD9jqpTl0cbdJvw9cQgL+ZC+914EpdNnHAQmk8=; b=S50Oovc81xFDpWD1Xl+o7E6V1rhFJr0vEQVc/6Hgsu/Ng3uA322syP9Gbb0M/r7ChImcmcn5QURea8Qv/xWY2T34W6kFCmEyAEoOajV0ma8T/0vnugGtpeTNxxQl/6NV06sRJ/9/U5VPXIzk7iFEcp/Dn+tDKDbSOsGYAaN3pH9ssiY5Gum6Po7FdMqH3xSiEoVnv9sWr7IEuTO3BBQ32iqUt7biSzAFIHojImNbhppELJQZDq/yIk3OW9xBYOLudtFtHSimdzng51g4iYNjSzaXdLLaZKoShKPGoGeqZG0un8ro0VU/eckwfSzud9Cvsh6H2Xo8XRYUWB2EjsbbeQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When compiling with recent GCC or clang/LLVM and glibc 2.43 or later,
such as on Ubuntu 26.04 ('Resolute'), the -Wdiscarded-qualifiers
(GCC) or -Wincompatible-pointer-types-discards-qualifiers (clang/LLVM)
warning occurs, and is an error when --enable-maintainer-mode is
asserted, because with ISO C23, the function strchr, which returns a
pointer into its input array, is now defined as a macro that returns
a pointer to a const-qualified type when the input argument is a
pointer to a const-qualified type:

    scripts/openvpn-script.c:52:15: error: assignment discards 'const'
        qualifier from pointer target type [-Werror=discarded-qualifiers]
    scripts/vpn-script.c:51:15: error: assignment discards 'const'
        qualifier from pointer target type [-Werror=discarded-qualifiers]

In both scripts, 'append' writes a null terminator through the
pointer returned by strchr, splitting each 'environ' entry in place
into a key and value. So, rather than casting the qualifier away,
'append' is made to say what it does and takes a non-const 'pattern'.
Its only callers pass 'environ' entries, which are 'char *'.
---
 scripts/openvpn-script.c | 2 +-
 scripts/vpn-script.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/openvpn-script.c b/scripts/openvpn-script.c
index 6ba0d292b28d..d949556428d4 100644
--- a/scripts/openvpn-script.c
+++ b/scripts/openvpn-script.c
@@ -43,7 +43,7 @@ static void print(const char *format, ...)
 	va_end(ap);
 }
 
-static void append(DBusMessageIter *dict, const char *pattern)
+static void append(DBusMessageIter *dict, char *pattern)
 {
 	DBusMessageIter entry;
 	const char *key, *value;
diff --git a/scripts/vpn-script.c b/scripts/vpn-script.c
index 6e020e92147c..6d5a3acf7874 100644
--- a/scripts/vpn-script.c
+++ b/scripts/vpn-script.c
@@ -42,7 +42,7 @@ static void print(const char *format, ...)
 	va_end(ap);
 }
 
-static void append(DBusMessageIter *dict, const char *pattern)
+static void append(DBusMessageIter *dict, char *pattern)
 {
 	DBusMessageIter entry;
 	const char *key, *value;
-- 
2.52.0

