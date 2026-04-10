Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FD3002B9
	for <connman@lists.linux.dev>; Fri, 10 Apr 2026 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818732; cv=none; b=h5LcwSZKjL0oxhyeI4CguxQo4iDnUdyubo/3hM72Oxl3hNgGmdfk/iL05nJwunwoTEE8mQZk5XfC/eX3VXZhMaBAdynrAJ6zOQ7z5n70lc0SqzLk4U5Qh+ecpnCfGoGU+tjfc8vrac3pregb/pewqPHV+UIHw8X9GR3gyWSsumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818732; c=relaxed/simple;
	bh=Z4OKVHcLh8kPDUnRh+sUA3JI6/0TcjPqpePC7nr5USg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jl25SgtPwLS288XWfFpSC7O5HeArHaYlrR4Kn09JCh0JszPPazMCgWzhlrwkZD8R2bFDBhWXm4ru9xAJf8bSEFoTyGLc5BszIySR015dAZJ8RAYRKvhDbZmhXi0vonLxcv1eJQywxsdnFZVtaV5X4z7ftrDN6YjlUsIo7jZSo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=W8Hjx1KB; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="W8Hjx1KB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OL6cjemXOIeSChAAC/NtkQz1orAWUsi6+KfhOOAhC0g=; b=W8Hjx1KBtOFWqp3WsBbJhq+icr
	3B+LKUX6IBESEWAYYPOTnkvhRRme6K3Vntha3bdxO08f1zzd9muuWfviw/hi2XaimN7g1wDZWkSyU
	4+X2hwg5op3mN9M6xdY4H3+hnR1172Z32juBmTy/n1mq5OWrN0OeKAqBdWdcAcUYMjiceQR8RccUz
	oQUFId4R/gbQM8thRrFfrggskaW+qJSwOqXQzypy3i5dE5fZkHt4jlmNT0lXejHSnqjdI3sQCjx+B
	2qS46iSLxCD9cESvQfzRJNDWTrOwRaANJDFGdPnInJao4Fv7c5kVQ4q9HB4GH0zNTybODmWWu2VFq
	Drg6/6Aw==;
Received: from [2a10:a5c0:37:6500:bc58:5597:ebe9:bd51] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wB9ZX-00FWab-1z
	for connman@lists.linux.dev;
	Fri, 10 Apr 2026 13:58:48 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH] vpn-provider: Compare using lowercase of type value in set_string()
Date: Fri, 10 Apr 2026 13:58:29 +0300
Message-ID: <20260410105840.1521646-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
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
 Message-ID: 20260410105840.1521646-1-jussi.laakkonen@jolla.com

The VPN type value is always converted to lowercase. When the type is
set via set_string() the comparison must be done also with lowercase.
The issue was introduced in commit 3aa13afdf706dee92f657bf6799d6bd97b81da4d

Reported by Frank Liepert <f.liepert@meteocontrol.com>
---
 vpn/vpn-provider.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index dafdaffa..2833d249 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -2754,11 +2754,14 @@ static int set_string(struct vpn_provider *provider,
 		hide_value ? "<not printed>" : value);
 
 	if (g_str_equal(key, "Type")) {
-		if (!g_strcmp0(provider->type, value))
+		char *type = g_ascii_strdown(value, -1);
+		if (!g_strcmp0(provider->type, type)) {
+			g_free(type);
 			return -EALREADY;
+		}
 
 		g_free(provider->type);
-		provider->type = g_ascii_strdown(value, -1);
+		provider->type = type;
 		send_value(provider->path, "Type", provider->type);
 	} else if (g_str_equal(key, "Name")) {
 		if (!g_strcmp0(provider->name, value))
-- 
2.47.3

