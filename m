Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69025DDCD
	for <connman@lists.linux.dev>; Sat,  9 May 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334515; cv=none; b=WLYsH0KO3ni0AxxEIqv1k7UWQGcI5l+gKuUEaAb+f32oNu6AXNR5WtVdmCZec63t8xrAJc9ccCI+V8XLdGjSr4KD0jREGYX9+dz+vwL3p88Jg5fYQxdzToCt0Lq9mRakkd5bP/gpITpZwiosTh9Y86SbvLYMQ50mIfaxGQL+fsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334515; c=relaxed/simple;
	bh=ftWop9heLjSEouzdSGacrJ0geJsBnXWIrRoxqKR7dKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZjtvQyH23hKvwojOJFaHjtrSQ1wFeHwzGUKFYKaD7J78tR6ZmsRspk2H+o5VmZLjixhtNc7UGQVhvtWIu604mcYlmdONISuBCsGoiAUOG3LT8gDHjqbThR5ihfUYWkXQU5IARUvGQiAaq06WqaZpjc60t2x+zMz2yPqfZFekMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=SJt/BS1m; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="SJt/BS1m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=drTBPI4b/fQM4neWtX3v5aVsxVyXmdbHJOjGaVTRdxs=; b=SJt/BS1mj0V/Bn0oGdPr/TCfPU
	YODDLchrDt+mMhFkWakFMxeirMgw3LB5RI/Hei7nVSg5jiC6EktlOy7WZGdhduZQsjy1dZHxv1OrD
	vZa26CYMopDX2vK+x8gibfi1T6+E+GJfS3kM6XrMTc9A3AoUmT983qbABiuLpmpWAsn6pzIKy8fgD
	gGt478LH+4f1xCzr1qkdYqJT3yPS+hTUczqGONjAfkFbTzSV6X44VJ6ohNg8b/BYuYAqJeZ2woy1m
	4oAoBfU9+3PN+++Q4Pgpv3uJxoUJwtxH8S/KdSoYXJxSbbV0NXOdRyE73HYMVOc5m3mfnFIe30dte
	I8XCEiAw==;
Received: from [2a10:a5c0:37:6500:41d2:24bc:9d82:eda4] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLi2i-00H1Hp-03
	for connman@lists.linux.dev;
	Sat, 09 May 2026 16:48:32 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 4/5] gresolv: Use compile time defined DNS with lookup + UDP connect
Date: Sat,  9 May 2026 16:47:37 +0300
Message-ID: <20260509134822.343265-5-jussi.laakkonen@jolla.com>
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
 Symbol: BAYES_HAM(-2.99)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260509134822.343265-5-jussi.laakkonen@jolla.com

Drop use of hardcoded DNS servers and use the ones defined in compile
time. This makes systemd-resolved use to work better.
---
 gweb/gresolv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 8101d718..7bfb4ad8 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -809,7 +809,7 @@ static int connect_udp_channel(struct resolv_nameserver *nameserver)
 	 * bind the socket on any interface.
 	 */
 	if (nameserver->resolv->index > 0 &&
-			strncmp(nameserver->address, "127.0.0.1", 9) != 0) {
+			strncmp(nameserver->address, DNS_BACKEND_V4, 9) != 0) {
 		char interface[IF_NAMESIZE];
 
 		memset(interface, 0, IF_NAMESIZE);
@@ -1044,8 +1044,13 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 				g_resolv_add_nameserver(resolv, buf, 53, 0);
 		}
 
-		if (!resolv->nameserver_list)
-			g_resolv_add_nameserver(resolv, "127.0.0.1", 53, 0);
+		if (!resolv->nameserver_list) {
+			g_resolv_add_nameserver(resolv, DNS_BACKEND_V4, 53, 0);
+/* systemd-resolved listens only in one address, use IPv6 with internal DNS */
+#ifndef SYSTEMD_RESOLVED_DNS_BACKEND
+			g_resolv_add_nameserver(resolv, DNS_BACKEND_V6, 53, 0);
+#endif
+		}
 	}
 
 	lookup = g_try_new0(struct resolv_lookup, 1);
-- 
2.47.3

