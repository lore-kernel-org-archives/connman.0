Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218821C8639
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302769; cv=none; b=VsryZmvuBHC2zJqX41pSSy3pFiSNjmGu8JLBJ6i+iUbKTipqIzDjmg8t9fYXo9sWQp0zTpC2ywyoezhH2gJRkmUpWoxKmZDnNcs5GzFbdQFNF2RfkCuwU/f8QG6iVCWBacaJz4aMrg0gIW0d/MDRFgTbitmVi/7+oERcMKjT/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302769; c=relaxed/simple;
	bh=f4i2vCow0NTi0zRercq4+EEKwwlPupVWiUEm545G8F8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMd5In4vbkqq9oE8hIX/zp6QnQGvoIGI2likEwp9/ndT8065NNCkca9MQ8Ap06SpgD3UfrL2Z2PvQanyJS7JsRfoTGRbmqRT8FRVuOwEXOulGzqAL3A/N+cYQvIg5/xfbv591mm2Q1Njm1o4M0WNlx6WjSOMqQT3+tn1DbFV23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ytO+v30u; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ytO+v30u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X95FivkhadLVQEV057pXq6rAssZm5VT7lvLT4Lcgies=; b=ytO+v30uNJR9Mwb6HoVu9tZtvX
	MaO9AdVvcAMWaco87reAsQZdnbVGO/ctLTEGUiFXp264kts6V7eLYv70PX+lGZIVxP0F5ZPxrLqnf
	bJHtRAkiy15J6ZROksXqMzSRgEfOwWt7Wl9wY6xQpaDkyH/rSKW0gqw7Wffi8WAHGezHzijoV7PZH
	LiJ+s0JPtcByKumpejyoRmsGokGk7wwkRHI4goRLH+2Nwds0o0Iz545pElrzTHXfqFfJFQM/3z7hP
	OCL9n2UlZ+T+YeNK4bxT2fpSXj3NF/srRibqFCDzDurZLH5k9skkg2SQTel1QlTcxkQZMoX6yma6e
	fo+7hrFw==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIp-004Gb9-0Z
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:55 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 6/8] gweb: Do not append NULL body to send buffer
Date: Thu, 10 Apr 2025 18:58:44 +0300
Message-Id: <20250410155846.252858-7-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:604d:112d:4f8c:3578
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Fix Clang analyzer warning about writing uninitialized content to the
buffer.
---
 gweb/gweb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index c17475c5..4dbbb4c8 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -920,8 +920,8 @@ static void start_request(struct web_session *session)
 {
 	GString *buf = session->send_buffer;
 	const char *version;
-	const guint8 *body;
-	gsize length;
+	const guint8 *body = NULL;
+	gsize length = 0;

 	debug(session->web, "request %s from %s",
 					session->request, session->host);
@@ -981,7 +981,7 @@ static void start_request(struct web_session *session)
 			g_string_append_printf(buf, "%zx\r\n", length);
 			g_string_append_len(buf, (char *) body, length);
 			g_string_append(buf, "\r\n");
-		} else if (session->fd == -1)
+		} else if (session->fd == -1 && body)
 			g_string_append_len(buf, (char *) body, length);
 	}
 }
--
2.39.5

