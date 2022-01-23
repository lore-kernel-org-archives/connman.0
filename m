Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644132C82
	for <connman@lists.linux.dev>; Sun, 23 Jan 2022 13:18:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8203A5CF3B;
	Sun, 23 Jan 2022 14:18:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642943888; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ec48OB2Cd2OttiIViRE0si9BlzE7d1PsxXilnMjkKzc=;
	b=bbmV+QMgoF11fz66I5thyxwX5R/CNq7pWR2eLKm2xvmVJ05RZPwh0Bcw8SpeOUQOkKCRGd
	6dUe6jpiUM6yb0d8UEl/TqxSW8jYBdWgRawXHOleesEWizQxMJ1SiWkRzxXudLDpHR6m8Y
	yvVm1/FddRprzwTYrMzinJmFfAa6Ct1Sd/vA5DlVZBwr8lgDzb8EGM5t5+6lEG4jB06wyn
	8CMp3KgHaD7eigksTjS0sMMh9KlgdHQ1M7nMfvBPmOX6qt2oxUEFDqEMfyRhyKdG13Qx9w
	NIuqgxfDnC2OivgTwVRziLcIGTop7Nb86TYUNWBI0U/kvsGOmhqdJaK9iWXNzQ==
Date: Sun, 23 Jan 2022 14:18:08 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Always disconnect connection completely
Message-ID: <20220123131808.x7vvxmkhbu3jieiz@beryllium.lan>
References: <20220119133927.1245607-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15449D2CB5CB2656550C629A93599@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220121074740.axzlpaj55xtzeg5s@beryllium.lan>
 <MRZP264MB154465E0619D397C2859ABA6935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB154465E0619D397C2859ABA6935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

You forgot a static. BTW, please check your formatting:

$ git am ~/0001-iwd-Always-disconnect-connection-completely.patch
Applying: iwd: Always disconnect connection completely
 *** .git/hooks/pre-applypatch: Testing for mode changes...
 *** .git/hooks/pre-applypatch: Testing that this is buildable...
  GEN      src/builtin.h
make --no-print-directory all-am
  CC       plugins/src_connmand-iwd.o
  CC       src/connmand-plugin.o
plugins/iwd.c:254:6: error: no previous declaration for ‘abort_pending_network’ [-Werror=missing-declarations]
  254 | void abort_pending_network(struct iwd_device *iwdd,
      |      ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:3405: plugins/src_connmand-iwd.o] Error 1
make: *** [Makefile:1871: all] Error 2
 *** .git/hooks/pre-applypatch: Didn't pass buildable test


--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -251,8 +251,9 @@ static void cm_network_connect_cb(DBusMessage *message, void *user_data)
        update_network_connected(iwdn);
 }
 
-void abort_pending_network(struct iwd_device *iwdd,
-                               enum connman_network_error error) {
+static void abort_pending_network(struct iwd_device *iwdd,
+                                       enum connman_network_error error)
+{
        struct iwd_network *iwdn;
 
        if (!iwdd->pending_network)
╭─wagi@beryllium ~/cm/connman-upstream ‹master*› 
╰─$ make
  GEN      src/builtin.h
make --no-print-directory all-am
  CC       plugins/src_connmand-iwd.o
  CC       src/connmand-plugin.o
  CCLD     src/connmand
