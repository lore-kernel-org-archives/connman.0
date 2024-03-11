Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6518C01
	for <connman@lists.linux.dev>; Mon, 11 Mar 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155369; cv=none; b=ETjF1h1nrR7uayw2eE0oIl26KcXotqqpLVfA0BaVTFZj/q8WiI6vrbLZEpG4hIeHmLRpZHesY0lg9c5LQdUeWNZS6GMUqTZjfVe2nxad6sjk8iVEafAJ8gXDoygaGIJEr5H3FXBMhQfnERnAQ6E0CzpdPMojqIt9aFONhCthz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155369; c=relaxed/simple;
	bh=DR4mZ4vLiMy8MaLfzcWeSViyPI3WTceHYvJcuRKHYVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=noECci9SukQaBc7a0NNZM5tznhYYSULYs5CSuKr6oPZpsFQzQs9pWaxfPOHNPJjFurwJy9svUNXiECO2EdakC/QhuBb8t+JWtu+PRJJDnVXFfgx2plb37Pjvje2RYf+ZQhM7tEO4uAQnQYHTCWc+gDalqDdd8gtMP8Ip925Wuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ycEsuCqp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OV7mO5kN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycEsuCqp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OV7mO5kN"
From: Alexander Kanavin <alex@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710155364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=igXyuK7ashuYPgQ7EgdEhtLhxd5zMw1tQO6yJUAKI9M=;
	b=ycEsuCqpAAdqZvLlHyW3FgiTHtxPBlbjMLx0WniWNnmomwW7AsuOblPtvDlzmrR7Fs7pqN
	1uBVhk1uiaV29EZ7DRDLdtVW35pqPNn78xkEJYK1zTs6hc7o9eKo+kxqD7n1AFVIo5j13V
	3OCtsS1H1kM7RF8h3LvxqxPmTWK5/D8mNJekZUpt8wowJGWyGAOtQ1aH7Rb/ejZOxzbez2
	Qy+gNCBcb2j0esz6Qag2Oyo/rZtBOhLGhrCmyKR6EeJylqB51/QYLJaLpGLmxN3bohYasQ
	l/RCZr8PDkw1pkdbq3CaskHHr5h1PwLD9TepM9JzTUVb7mnrFIwdpQSNuuEnsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710155364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=igXyuK7ashuYPgQ7EgdEhtLhxd5zMw1tQO6yJUAKI9M=;
	b=OV7mO5kNBCShY5K1kB2+mgbCjox9g3ALrXNOHOMsfFX8o7kEj8SvtFgnE8RtOwukOcov4Q
	JbHRCcD6DNGpJACA==
To: connman@lists.linux.dev,
	marcel@holtmann.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] gweb/gresolv.c: make use of res_ninit optional and subject to __RES
Date: Mon, 11 Mar 2024 12:09:18 +0100
Message-Id: <20240311110918.1399173-1-alex@linutronix.de>
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
 gweb/gresolv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 8101d718..9f1477c3 100644
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
@@ -1024,6 +1028,7 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 	debug(resolv, "hostname %s", hostname);
 
 	if (!resolv->nameserver_list) {
+#if (__RES >= 19991006)
 		int i;
 
 		for (i = 0; i < resolv->res.nscount; i++) {
@@ -1043,6 +1048,22 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 			if (inet_ntop(family, sa_addr, buf, sizeof(buf)))
 				g_resolv_add_nameserver(resolv, buf, 53, 0);
 		}
+#else
+                FILE *f = fopen("/etc/resolv.conf", "r");
+                if (f) {
+                        char line[256], *s;
+                        int i;
+                        while (fgets(line, sizeof(line), f)) {
+                                if (strncmp(line, "nameserver", 10) || !isspace(line[10]))
+                                        continue;
+                                for (s = &line[11]; isspace(s[0]); s++);
+                                for (i = 0; s[i] && !isspace(s[i]); i++);
+                                s[i] = 0;
+                                g_resolv_add_nameserver(resolv, s, 53, 0);
+                        }
+                        fclose(f);
+                }
+#endif
 
 		if (!resolv->nameserver_list)
 			g_resolv_add_nameserver(resolv, "127.0.0.1", 53, 0);
-- 
2.39.2

