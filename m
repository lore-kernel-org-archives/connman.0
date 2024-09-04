Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1521CF28F
	for <connman@lists.linux.dev>; Wed,  4 Sep 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452631; cv=none; b=m99vUvW5pEoIoD8r77sjbhC6dT2bYLQbMrtOGcQ//yI6Mz/VWrrsuy+hr9OXfOosR52aEhyfOB8brD8+xnKZ697lp7ogkLSD2kJdUnb6bh/+pYpzoaRHRGh581iF28P77lFlqjY+Pcd2vhgkc+kdSX/uE9Tt1kopvpIgz+dM9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452631; c=relaxed/simple;
	bh=Pu5qqAcQsjy2QbgcupcKs/9uToiTAROnkjVTLipGmQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+ItxLPKS8UkA95aUJshZq0SCiimanf4nYasRaHQ2Nt98BBR2EuBhMe7Ad2MfJYl/KmpH2NLKcHN6FEIoFcDSegn4dAe8kTO8cVK8mraaZWWWwuBZbKF8KWBAidE8GpfYDRkBLutWK9Vs0EGUdyUGvTCKr86hb1kset5qv/MQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XYbT6FHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwtTCX7a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XYbT6FHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwtTCX7a"
From: Alexander Kanavin <alex@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725452628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xrZQu12oe4rjOmy1Lih2sOQsbTLkXG4gcI77ElooeXw=;
	b=XYbT6FHlJvFvEtvJth+oxNAuE8E/w1Qo9rTFvBCuYV+cuDqbuJzoenHsjGL9JIwKng6GF+
	2gWbwhOO4pZhS6c674UP9mctYxcrOaBuefLunvIeI24qnQNP8mOj8r+O9HN9R1sv101/ss
	KOkyv5xxHo1wMTZCMz6uJKfPAx5aTNMvPrTZJwlBZLiIYdKum7ukgcuuaiN9TiNw4Iptrz
	TqmOKnE1KbODrQZiW+ixfpXLE/++zgjvAZYFl0RrGePcutNMs8Jogvw5L91Sv65e+LYsax
	c7F/V/rTsXSwjJm0XqLjzbFZ0Gr+VcADDrLTGQwkrTwiDpM9Ndw86Vl7qAB+Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725452628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xrZQu12oe4rjOmy1Lih2sOQsbTLkXG4gcI77ElooeXw=;
	b=JwtTCX7aagAA0GjaiGY/ux4qbig5l+GwYQ+69oJ0tzGPL4PYffVTimrlmCGxcxinWLyXEh
	r2qnCnSp+OkfsmAQ==
To: marcel@holtmann.org,
	connman@lists.linux.dev
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2] gweb/gresolv.c: make use of res_ninit optional and subject to __RES
Date: Wed,  4 Sep 2024 14:23:13 +0200
Message-ID: <20240904122336.963194-1-alex@linutronix.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khem Raj <raj.khem@gmail.com>

Not all libc implementation have those functions, and the way to determine
if they do is to check __RES which is explained in resolv.h thusly:

/*
 * Revision information.  This is the release date in YYYYMMDD format.
 * It can change every day so the right thing to do with it is use it
 * in preprocessor commands such as "#if (__RES > 19931104)".  Do not
 * compare for equality; rather, use it to determine whether your resolver
 * is new enough to contain a certain feature.
 */

Indeed, it needs to be at least 19991006.

The portion of the patch that implements a fallback is ported from
Alpine Linux:
http://git.alpinelinux.org/cgit/aports/plain/testing/connman/libresolv.patch
---
 gweb/gresolv.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 8101d718..136b31f6 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -879,7 +879,9 @@ GResolv *g_resolv_new(int index)
 	resolv->index = index;
 	resolv->nameserver_list = NULL;
 
+#if (__RES >= 19991006)
 	res_ninit(&resolv->res);
+#endif
 
 	return resolv;
 }
@@ -920,7 +922,9 @@ void g_resolv_unref(GResolv *resolv)
 
 	flush_nameservers(resolv);
 
+#if (__RES >= 19991006)
 	res_nclose(&resolv->res);
+#endif
 
 	g_free(resolv);
 }
@@ -1013,6 +1017,26 @@ static gint add_query(struct resolv_lookup *lookup, const char *hostname, int ty
 	return 0;
 }
 
+#if (__RES < 19991006)
+static void read_nameservers_directly(GResolv *resolv)
+{
+	FILE *f = fopen("/etc/resolv.conf", "r");
+	if (f) {
+		char line[256], *s;
+		int i;
+		while (fgets(line, sizeof(line), f)) {
+			if (strncmp(line, "nameserver", 10) || !isspace(line[10]))
+				continue;
+			for (s = &line[11]; isspace(s[0]); s++);
+			for (i = 0; s[i] && !isspace(s[i]); i++);
+			s[i] = 0;
+			g_resolv_add_nameserver(resolv, s, 53, 0);
+		}
+		fclose(f);
+	}
+}
+#endif
+
 guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 				GResolvResultFunc func, gpointer user_data)
 {
@@ -1024,6 +1048,7 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 	debug(resolv, "hostname %s", hostname);
 
 	if (!resolv->nameserver_list) {
+#if (__RES >= 19991006)
 		int i;
 
 		for (i = 0; i < resolv->res.nscount; i++) {
@@ -1043,6 +1068,9 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 			if (inet_ntop(family, sa_addr, buf, sizeof(buf)))
 				g_resolv_add_nameserver(resolv, buf, 53, 0);
 		}
+#else
+		read_nameservers_directly(resolv);
+#endif
 
 		if (!resolv->nameserver_list)
 			g_resolv_add_nameserver(resolv, "127.0.0.1", 53, 0);
-- 
2.43.0

