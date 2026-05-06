Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02053F0ABC
	for <connman@lists.linux.dev>; Wed,  6 May 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089020; cv=none; b=VvY3E/b8zCRMBv70S23k+HRz87k4KcuC73D1FdE2qNX8muybTEPAtL4BlQZyEbtcmiaGkplxhZSA00BoYyeb48c4jyCpWmPQ3ixB2hpl4bBzuAjr14FvvofgX7BPEcub/B5HaWFsJiLFi5mguGWqA9i/3BntdRAj4rWrP+6mj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089020; c=relaxed/simple;
	bh=P2RvYJyibbJYbvrvf3KktOt8ITlgOUV13bsU2kkznLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A14D21002axNrpuxrygpgAj7nJnOtL5vqZnzhPCjUuuBaQ5JxU9WjFBtD6Xy8EYHSV3gO7UsyWkRtN++2jGY7YYMNModyJ7H1vKc+RtKbBn551L1sye0GCQgcO4wNFtZ9FGxxPuUCfhKaCVComAijZ8Po/Nvu/GjuR3YbQ7LDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=kkdgXQxP; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="kkdgXQxP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v8iFW9WFIlQY0Ca/ccvWQaZ95jb0oACntMeWgbMcwAY=; b=kkdgXQxP5s+W/mzDj52FVbAz+9
	uRFmeK3OHk94+3IYJPMwZjIFsTbqHKh3nD/uvobSRObuK6cIkekQI4RsL6Cl4i2+fLi0WH/mf7IMJ
	dt+GGCG0ev/g7cqZuHx//y+1FXjUjBaolo8pvzU5aD7Y6uZEiTQSUh7uY95TV7qjyJxM06w0U7+zW
	m90CBVwowry5WBTfWiEZEJB2UPdPYUH+XTW1URhBHdwfX7MkGf4bH7MxJjFfRzAPDjRv3Y/rBGhLN
	WXrb+AVf+2WGR6T6KrdWEtyBDC4+2NhP80sDzlxixcHbhDInT9aCg/VB746fgcdzSwLfmezmwsIau
	XBdvGUeQ==;
Received: from [2a10:a5c0:37:6500:e838:5b8f:da27:a067] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wKf9R-002AWY-0E
	for connman@lists.linux.dev;
	Wed, 06 May 2026 19:31:09 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH] unit: Fix iptables test to work with iptables 1.8.11 changes.
Date: Wed,  6 May 2026 19:30:19 +0300
Message-ID: <20260506163102.93792-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410105648.1521565-1-jussi.laakkonen@jolla.com>
References: <20260410105648.1521565-1-jussi.laakkonen@jolla.com>
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
 Message-ID: 20260506163102.93792-1-jussi.laakkonen@jolla.com

Fix the unit test to work with the changes made to code to work with
iptables 1.8.11 and above.
---
 unit/test-iptables.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/unit/test-iptables.c b/unit/test-iptables.c
index a96d8679..101d873c 100644
--- a/unit/test-iptables.c
+++ b/unit/test-iptables.c
@@ -272,8 +272,12 @@ struct option *xtables_options_xfrm(struct option *opt1, struct option *opt2,
 {
 	if (test_config_type & TEST_CONFIG_OPTIONS_XFRM_FAIL)
 		call_error("xtables_options_xfrm");
-
+#if XTABLES_VERSION_CODE > 11
+	g_free(opt2);
+	return g_malloc0(sizeof(opt1));
+#else
 	return opt1;
+#endif
 }
 
 struct option *xtables_merge_options(struct option *orig_opts,
@@ -283,7 +287,12 @@ struct option *xtables_merge_options(struct option *orig_opts,
 	if (test_config_type & TEST_CONFIG_MERGE_OPTIONS_FAIL)
 		call_error("xtables_merge_options");
 
+#if XTABLES_VERSION_CODE > 11
+	g_free(oldopts);
+	return g_malloc0(sizeof(orig_opts));
+#else
 	return orig_opts;
+#endif
 }
 
 /* End of xtables dummies */
-- 
2.47.3

