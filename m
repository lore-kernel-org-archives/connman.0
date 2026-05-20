Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD83EAC9B
	for <connman@lists.linux.dev>; Wed, 20 May 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291335; cv=none; b=laISlgQ5gy7YwTchGYbDcU4CjKks9brNlZDmzhXY2hxG+yzQmDhUZbjTPzIVamgNENkbUea6cvDoflRyCi+uKH4PNVTf63Gt3nddqZ51ussV4jjOp+F6B7Vd+b7R7sztBH5ZVnJqXsQ7Ve4PLWkZiX7RySmNfVJzhEzB0+iaAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291335; c=relaxed/simple;
	bh=7o9Z9JnTAENfPEVYXxR85zNe4/MubjF7FES5lca9lgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeiciCG5RwHXm1ECvZ8fogmOrtBOh+LlJMpuIMlP0yc0yn4pKnOlsmPbecd+FzKukctFeT7f7Q+Yg6nTO0CBtILCpDjg2SlVqM4JPFDK6VZOmBZ7B26qvfyhmIhcNwpnMTA2lBFM6lWw+qGGW5Vrv91kQZ8JAbEWT2xAyO5aVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=FQQz7Hpm; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="FQQz7Hpm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cz3A+5VIqOugR5AiZVPHjKthN7EFGpwF4j9n3AYWeq4=; b=FQQz7Hpm0LkovvA4jQgazazMzk
	jsQUqzaQPTEcQ9JF7MgkoYtXyRDyKFmzP9So+uvZ8IptA0UgMKzWKZneqbBIRGxwbDKM/yeO5OgmY
	aXXc9moUhVEWu9KdBkqL9fCLgzsY+qZ/vbs7JaFCVmDCKh+VnGdGL23vjvUKugI0uxY/XK4bhBDF7
	s+TMGa6CBMG1PAOyYsm49+ZHhHCUdrhyKQIas6On9zUIsP3XCgS9eA6Q+VnubniSCaFYuhHCBXUFD
	f5LsWJLpOncex0Iyqx9pvgZh7UWXN1tRyKXebznAII5i3/P3RVou5tx12CGyG8DUyKsm3iS501qCL
	UlDUPVWg==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGk-002WBi-2l
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:30 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 9/9] doc: Document conf.d support
Date: Wed, 20 May 2026 16:47:13 +0300
Message-ID: <20260520134720.981315-10-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
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
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.961]
 X-Symbol: BAYES_HAM(-2.99); Message probably ham, probability:  [99.99%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-10-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

---
 doc/connman.conf.5.in | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index ab0ae5c2..455f5e87 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -14,6 +14,13 @@ is a configuration file for ConnMan. The configuration file is
 optional but it can be used to set up various aspects of ConnMan's
 behavior. The location of the file may be changed through use of
 the \fB\-\-config= \fRargument for \fBconnman\fP(8).
+.P
+.B main.conf.d
+is for configuration files that can be used to add and replace main.conf key
+values. The format is identical to main.conf, suffix has to be .conf for the
+file to be read and the files are processed in alphabetical order. The last
+key value pair in a config file will be used if any earlier key existed in the
+other files.
 .SH "FILE FORMAT"
 .P
 The configuration file consists of sections (groups) of key-value pairs.
-- 
2.47.3

