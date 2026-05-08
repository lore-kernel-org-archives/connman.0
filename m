Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9D3D47C6
	for <connman@lists.linux.dev>; Fri,  8 May 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256399; cv=none; b=dKlk3slXNZHqAUPs8bbOzQbUokDed6nKVdCan1j7fJj0llXaIisgYvYLqq8zU/vCJOayBDbqcLGrEs9HyeryyWYXFG33NASHV7ONDmxwicldnH5/rA9HrXA2mK/PX5+Z2pg8ZM940eLxYn2khIeOa7rp6jW9gystvYH+XzUNWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256399; c=relaxed/simple;
	bh=nu+YxrJ/2VEPWUzskqkHoz0NuikQPpRlUCnk2K9Rk5k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkwcaDETUMG+gOK4OwTyEatUD3BXzpt+lH/A95s55/yafWqIcsAyAwwNDoehM/7Kgo4S6z7aCjssfGp1+9kSE0l9cbLKjaGgWJFauNQmmZywu//TVQoXvkV3+rL5uEYVKIMnTrMpKcUW9GQv5M6FuQ5U0bJcECvXpae85+G6y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=B5o1vRzV; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="B5o1vRzV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=A2lzzlyS0jPq7BSvJ56WZdZe0om3jo6uzcP0YdNpwgg=; b=B5o1vRzVeLvfB8EwXIM1DIZVe5
	3lMY+pax5iDh1mK+u4DT9pSgBLL0J+NvBUmyafnOOxzkNDl4gc0jLLsK6W3/1JtCLcDYmaHpYtTB9
	EIp6KUu73Y9VuHv31yMDGo3WmS1idExBJK7W7r2yOh25IPSC7f+LMAjuNesyKhN0/8cQhPm4kQG2w
	Rzq2p34tumtdmsnWDjpqpN2NvX+UBttaJNAhJXaWRKxTampgsotFUpGKqinT1D+6Igu53wXFBeYBu
	ZpeHhDH13U9LWCBwQkKUWfxBACFD72/eit4rW2wXTACH55LUXtelLwmcwM0RGhsaiQ5AXnENPDAJ4
	QOP/z4Gg==;
Received: from [2a10:a5c0:37:6500:11f6:3d14:7c4:afac] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLNie-00CcPv-2a
	for connman@lists.linux.dev;
	Fri, 08 May 2026 19:06:28 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/5] build: Define DNS server addresses in Makefile.
Date: Fri,  8 May 2026 19:05:37 +0300
Message-ID: <20260508160620.214218-4-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508160620.214218-1-jussi.laakkonen@jolla.com>
References: <20260508160620.214218-1-jussi.laakkonen@jolla.com>
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
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260508160620.214218-4-jussi.laakkonen@jolla.com

Add DNS servers for IPv4 and v6 in Makefile. Use only one for
systemd-resolved.
---
 Makefile.am | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index fd636d5b..88100968 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -246,6 +246,12 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				-DRUNSTATEDIR=\""$(runstatedir)"\" \
 				-DCONFIGDIR=\""$(configdir)\""
 
+if SYSTEMD_RESOLVED_DNS_BACKEND
+AM_CFLAGS += -DSYSTEMD_RESOLVED_DNS_BACKEND -DDNS_BACKEND_V4=\""127.0.0.53"\"
+else
+AM_CFLAGS += -DDNS_BACKEND_V4=\""127.0.0.1"\" -DDNS_BACKEND_V6=\""::1"\"
+endif
+
 if VPN
 AM_CPPFLAGS = -I$(builddir)/include -I$(srcdir)/gdbus
 else
@@ -263,6 +269,14 @@ src_connmand_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				-DCONFIGDIR=\""$(configdir)\"" \
 				-I$(builddir)/src
 
+if SYSTEMD_RESOLVED_DNS_BACKEND
+src_connmand_CFLAGS += -DSYSTEMD_RESOLVED_DNS_BACKEND \
+				-DDNS_BACKEND_V4=\""127.0.0.53"\"
+else
+src_connmand_CFLAGS += -DDNS_BACKEND_V4=\""127.0.0.1"\" \
+				-DDNS_BACKEND_V6=\""::1"\"
+endif
+
 EXTRA_DIST = src/genbuiltin src/connman-dbus.conf src/connman-polkit.conf \
 				plugins/connman-nmcompat.conf \
 				$(service_files_sources) scripts/connman.in
@@ -280,6 +294,14 @@ vpn_connman_vpnd_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				-DCONFIGDIR=\""$(configdir)\"" \
 				-I$(builddir)/vpn
 
+if SYSTEMD_RESOLVED_DNS_BACKEND
+vpn_connman_vpnd_CFLAGS += -DSYSTEMD_RESOLVED_DNS_BACKEND \
+				-DDNS_BACKEND_V4=\""127.0.0.53"\"
+else
+vpn_connman_vpnd_CFLAGS += -DDNS_BACKEND_V4=\""127.0.0.1"\" \
+				-DDNS_BACKEND_V6=\""::1"\"
+endif
+
 endif
 
 if XTABLES
-- 
2.47.3

