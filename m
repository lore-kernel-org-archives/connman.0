Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14A348477
	for <connman@lists.linux.dev>; Sat,  9 May 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334516; cv=none; b=qFiR7mw7IYB8LHZgnMCPexXWGPW20oRELqWafo7vi3bHI300YqT8AK6z7q/dVNb7DjFiUxwfPZKok4yvjblgglFfvOFdUvrgVTCp7OaaaIgBlCQQzJb8D5GPe0Mjpafxg30lO/mo9frkkCbVEiZufL8U2Lr/3vp/hr7DiRIzSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334516; c=relaxed/simple;
	bh=nu+YxrJ/2VEPWUzskqkHoz0NuikQPpRlUCnk2K9Rk5k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqxjaQfxWpMjn/MXuNVr5ODeqJC3kQ3Ac0wkZnE5FZRXN5ee3QFB9tFc95V+BeMiOfaWNhmKtiiYI3P4pDFfazK9eQDN9qbff8kTxWs+xdn8w7+gDtiDu0BKzJh0mpBEOROAjT+7Tq10y+WMwHHNxR5HcUIoOCs3g+JWHMrPRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=pIHk1jJK; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="pIHk1jJK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=A2lzzlyS0jPq7BSvJ56WZdZe0om3jo6uzcP0YdNpwgg=; b=pIHk1jJK+yZ+l0F0S/0Hwzu5Is
	YEqnBtgl6Tnk0oGjSZne1kYsL2OPo2Xk/T84aJgQUP+AsbCpuFZHewMxamdEZZRy+pHxd4IxEPXZO
	y1uO+HEN0paEZgjElvVC3tI6NZr46OyPfMEtWYYxPySdtq+9+e2DqcoAiKE4+i+uowQQdGdLyPhwf
	+qjj/+kNfn/S+eR4D7a+YPAw9bNupzl2hALHkAHVc1UM4/qzkXKY1hdwoLBwx5cqXyklQS69k15ku
	W4SRdRD8IM6Z4QR+7mRbQ5WQQw2dxGu8LxHQqyBUmvyWjULDVKrn/p31TawpNBn6cn0TqDBqZ/efk
	H/RAS+hA==;
Received: from [2a10:a5c0:37:6500:41d2:24bc:9d82:eda4] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLi2h-00H1Hp-1y
	for connman@lists.linux.dev;
	Sat, 09 May 2026 16:48:31 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 2/5] build: Define DNS server addresses in Makefile.
Date: Sat,  9 May 2026 16:47:35 +0300
Message-ID: <20260509134822.343265-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509134822.343265-1-jussi.laakkonen@jolla.com>
References: <20260509134822.343265-1-jussi.laakkonen@jolla.com>
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
 Message-ID: 20260509134822.343265-3-jussi.laakkonen@jolla.com

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

