Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9021C19E
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513962; cv=none; b=H0P9BZ4Z9SHvKsZn9xJtFfsT2yW6ET/w4xMQD04Z8r62nGyi7auf+ytKMFB40T0pZKjL5ged42K63d/8KM7DGJTeCUP8SR8iKw4qq0/yzOSLGR5SH4RVXkB7K3AVVd+W5vFcmc/cNNGoUTdaSIo5Hs+lLVWzdb7QHdw1Gb04uGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513962; c=relaxed/simple;
	bh=C7fQkQ4uquRxjWKz1wabUcvRFlwOdxWI1KrwkqADz7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2AvEGbccDBwrn97/TxDnculaqyFEH478VQFZTdHfZ/L+0HhI1dZd25sGtZuCJ5DSkbBs+7pYauveixGvtdHtUVGVM2//RRLmHS49vXAjWdE1gz6qu/48eSkiPTPhm5JB1OyeuFZYZM8v1QutO7/+PD+kxB0UoAhM06gW6mPuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=nMNGIQMj; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="nMNGIQMj"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 5723E164A4F
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:12 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0BC7A125166
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:11 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 02/18] build: Add @GIO_LIBS@ to clients of GWeb.
Date: Thu, 20 Mar 2025 16:38:53 -0700
Message-ID: <197615ff9c24862fca5bc87c29228c464c0ead7b.1742513884.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742513884.git.gerickson@nuovations.com>
References: <cover.1742513884.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=nhTKnCy/3m7l4thhmvWeX73qnAsGI6hNChZsS06GxoI=; b=nMNGIQMj1gTil6eK7UMBLtmz3zIEyHFinPdjFXY4W6lJJ4S69VMTFAO88BZRAeocOyXzzsNEhJ40FNsTzBkvUCkTVt6v14eKzwc+Q8TB7OzUiVADcH8xQ25FajfE/Z6NCSCAGEf2Jeh1xLAczlYdAOJZXXvOF4bDJU0jGkzb4T/ZkebHvSfgs7fnPA+erwseFuGQkIDq428SS/7yDZaPJXr3+wD69IM+0DUPre51bOuiHGzUHGWSZYNnQZuFKr5Cr140f3ZRyJjJ9HaSQCoxmYq0ptOigfeWAvfwsFrPkf93KgdkhGYMdFXbsbD1Ju/wOLIax3shTuprxS6Y7+eaKA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

GWeb relies on 'G_IO_ERROR' and 'g_io_error_from_errno'; consequently,
so too do its clients, including: connmand, connman-vpnd, wispr,
dnsproxy-test, and web-test.
---
 Makefile.am | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4d6425ffa28d..89662395c027 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -140,7 +140,7 @@ src_connmand_SOURCES += src/dns-systemd-resolved.c
 endif
 
 src_connmand_LDADD = gdbus/libgdbus-internal.la $(builtin_libadd) \
-			@GLIB_LIBS@ @DBUS_LIBS@ @GNUTLS_LIBS@ \
+			@GIO_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @GNUTLS_LIBS@ \
 			-lresolv -ldl -lrt
 
 src_connmand_LDFLAGS = -Wl,--export-dynamic \
@@ -184,7 +184,7 @@ vpn_connman_vpnd_SOURCES = $(builtin_vpn_sources) $(backtrace_sources) \
 			vpn/vpn-config.c vpn/vpn-settings.c vpn/vpn-util.c
 
 vpn_connman_vpnd_LDADD = gdbus/libgdbus-internal.la $(builtin_vpn_libadd) \
-				@GLIB_LIBS@ @DBUS_LIBS@ @GNUTLS_LIBS@ \
+				@GIO_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @GNUTLS_LIBS@ \
 				-lresolv -ldl
 
 vpn_connman_vpnd_LDFLAGS = -Wl,--export-dynamic \
@@ -330,7 +330,7 @@ if WISPR
 noinst_PROGRAMS += tools/wispr
 
 tools_wispr_SOURCES = $(gweb_sources) tools/wispr.c
-tools_wispr_LDADD = @GLIB_LIBS@ @GNUTLS_LIBS@ -lresolv
+tools_wispr_LDADD = @GIO_LIBS@ @GLIB_LIBS@ @GNUTLS_LIBS@ -lresolv
 endif
 
 if TOOLS
@@ -349,7 +349,7 @@ tools_supplicant_test_LDADD = gdbus/libgdbus-internal.la \
 				@GLIB_LIBS@ @DBUS_LIBS@
 
 tools_web_test_SOURCES = $(gweb_sources) tools/web-test.c
-tools_web_test_LDADD = @GLIB_LIBS@ @GNUTLS_LIBS@ -lresolv
+tools_web_test_LDADD = @GIO_LIBS@ @GLIB_LIBS@ @GNUTLS_LIBS@ -lresolv
 
 tools_resolv_test_SOURCES = gweb/gresolv.h gweb/gresolv.c tools/resolv-test.c
 tools_resolv_test_LDADD = @GLIB_LIBS@ -lresolv
@@ -411,7 +411,7 @@ unit_test_iptables_LDADD = @GLIB_LIBS@ -ldl
 endif
 
 tools_dnsproxy_test_SOURCES = tools/dnsproxy-test.c
-tools_dnsproxy_test_LDADD = @GLIB_LIBS@
+tools_dnsproxy_test_LDADD = @GIO_LIBS@ @GLIB_LIBS@
 
 endif
 
-- 
2.45.0

