Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A30736BCDA
	for <connman@lists.linux.dev>; Fri, 10 Apr 2026 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818624; cv=none; b=DJelhAsK/0e99WWC6zY4vfglX6jNY3VpWOiNWy22ON3T4LF5YIPliY7Il6KW51caqKRWxm4QirAq3d2Ths/YG2N15BWVFFdkDyAIUFzHTevpgRyGDJj9soEHseAdttGxMi8+H+8Jfp16yMmsq5564amXEakNCWwAnyS0N7QgmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818624; c=relaxed/simple;
	bh=YIho7ZBZSVJs3woUTig5jf8m1z0Rk1npFGhDw3CMI7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ojm0Gr6ozdugPney19BROoJKKhJN0yNgsy7l7GLn3PAmXYBIQ/XxJDw6HzVaUR7tXJJCrUNO6RfzUXVj/t9hhbjoT/8xGS1OhZBrnUmqj+TN9opWJloSsOFiOzQ1yGLeoDTuL3K61FtKUQS75SceIZaC7rS72RrGROpgcWEM0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=iZWf8GWS; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="iZWf8GWS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ptuByUjnZ4UlMKZAyX8da0wvfmpSLp5rKCXVej1yks4=; b=iZWf8GWSWsYRVFHjWdwBLogZ5A
	D1VJL22w/gNzhVN0L7rNoIHAUuh9w+cCAx41j61E+YUL80Re+bBufTiFbf0CiSZVjqfv6aHcKDr1Y
	ph9Gi69T6c2edUTL1593FDwbJv3HFfP8PdRpbtHOc4FAbqh9CKwLqnxVulpI16J+812KDSTjMYqge
	Lt7SFUkZrCL6lRKrfMbwXGHT8Bu9lLT/3W1l4Kf5OAZDDokU4QjXTZ37HsdjpVIP/rp/7I7ukr1Tj
	swvvs3UTdRRyd9B/9eeEM8yDnopEfUCS9+dSYnl4LyGsQcYcwv3TMs1z6XArkNk3BgXrcEF9DcRNb
	r0vcIxOQ==;
Received: from [2a10:a5c0:37:6500:bc58:5597:ebe9:bd51] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wB9Xm-00FWHv-0a
	for connman@lists.linux.dev;
	Fri, 10 Apr 2026 13:56:58 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH] iptables: Allocate the struct option for iptables 1.8.11 and above
Date: Fri, 10 Apr 2026 13:56:33 +0300
Message-ID: <20260410105648.1521565-1-jussi.laakkonen@jolla.com>
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
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260410105648.1521565-1-jussi.laakkonen@jolla.com

In iptables 1.8.11 (XTABLES_VERSION_CODE 12) the memory leaks were fixed
by always freeing and allocating a new option struct. This changes the
default behavior when using iptables via libxtables to requiring that
the opts need to be allocated before passing it to
xtables_merge_options() (xtables_options_xfrm() calls this).

This adds version checks for the XTABLES_VERSION_CODE to allocate and
accordingly free the struct option passed as opts to libxtables only
with versions 1.8.11 and above.
---
 src/iptables.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/src/iptables.c b/src/iptables.c
index a81a0779..964bbbf9 100644
--- a/src/iptables.c
+++ b/src/iptables.c
@@ -1951,7 +1951,7 @@ static void dump_target(struct connman_iptables_entry *entry)
 	}
 
 	if (xt_t == xt_t->next)
-		free(xt_t);
+		g_free(xt_t);
 }
 
 static void dump_match(struct connman_iptables_entry *entry)
@@ -2005,7 +2005,7 @@ static void dump_match(struct connman_iptables_entry *entry)
 		return;
 	}
 	if (xt_m == xt_m->next)
-		free(xt_m);
+		g_free(xt_m);
 
 out:
 	DBG("\tmatch %s", match->u.user.name);
@@ -2587,6 +2587,38 @@ static struct option iptables_opts[] = {
 	{NULL},
 };
 
+#if XTABLES_VERSION_CODE > 11
+static struct option *iptables_option_alloc(struct option *orig)
+{
+	struct option *copy;
+	size_t count = 0;
+	size_t i;
+
+	if (!orig)
+		return NULL;
+
+	/* Count entries (including terminating zero entry) */
+	while (orig[count].name)
+		count++;
+
+	/* Include the terminating NULL entry */
+	count++;
+
+	copy = g_malloc0(count * sizeof(struct option));
+	if (!copy)
+		return NULL;
+
+	for (i = 0; i < count; i++) {
+		copy[i] = orig[i];
+		copy[i].name = orig[i].name;
+		copy[i].has_arg = orig[i].has_arg;
+		copy[i].val = orig[i].val;
+	}
+
+	return copy;
+}
+#endif
+
 void iptables_exit(enum xtables_exittype status, const char *msg, ...)
 			__attribute__((noreturn, format(printf,2,3)));
 
@@ -2862,7 +2894,7 @@ static struct xtables_match *prepare_matches(struct connman_iptables *table,
 			g_free(xt_m->m);
 
 			if (xt_m == xt_m->next)
-				free(xt_m);
+				g_free(xt_m);
 
 			xt_m = NULL;
 		}
@@ -2888,7 +2920,7 @@ static struct xtables_match *prepare_matches(struct connman_iptables *table,
 			g_free(xt_m->m);
 
 			if (xt_m == xt_m->next)
-				free(xt_m);
+				g_free(xt_m);
 
 			xt_m = NULL;
 		}
@@ -3569,7 +3601,11 @@ static void reset_xtables(void)
 	 */
 	if (xt_params->opts != xt_params->orig_opts) {
 		g_free(xt_params->opts);
+#if XTABLES_VERSION_CODE > 11
+		xt_params->opts = iptables_option_alloc(xt_params->orig_opts);
+#else
 		xt_params->opts = xt_params->orig_opts;
+#endif
 	}
 	xt_params->option_offset = 0;
 }
@@ -4061,6 +4097,11 @@ int __connman_iptables_init(void)
 	table_hash_ipv6 = g_hash_table_new_full(g_str_hash, g_str_equal,
 						NULL, remove_table);
 
+#if XTABLES_VERSION_CODE > 11
+	iptables_globals.opts = iptables_option_alloc(iptables_opts);
+	ip6tables_globals.opts = iptables_option_alloc(iptables_opts);
+#endif
+
 	return 0;
 }
 
@@ -4068,6 +4109,11 @@ void __connman_iptables_cleanup(void)
 {
 	DBG("");
 
+#if XTABLES_VERSION_CODE > 11
+	g_free(iptables_globals.opts);
+	g_free(ip6tables_globals.opts);
+#endif
+
 	g_hash_table_destroy(table_hash);
 	g_hash_table_destroy(table_hash_ipv6);
 }
-- 
2.47.3

