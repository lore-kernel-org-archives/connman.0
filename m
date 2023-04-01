Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF82CA5
	for <connman@lists.linux.dev>; Sun,  2 Apr 2023 00:00:05 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id u10so24844454plz.7
        for <connman@lists.linux.dev>; Sat, 01 Apr 2023 17:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680393604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4fQzhtLTNMW1h4aGAmlkoMVxdV1f+pAYnb4ZPXFhqo=;
        b=bs2S1lWJlC/iMOUeWA8IUUnv+QQd6YmAUYUMcVu/r/VarGF4gHiQtjLm7SbsRGGabf
         BewoHClZMES7PcllFamKBXSz3JtyN80N1oAuPDmJI0sXmPXcfO2wYieaFx055Q/b6TFv
         xE5xpw3fWU5RtEjPsS9Zi6ri2WKQ8qRKu2jjlwlP536nCDwt0gnCS4XBCoUZGbGND12j
         mM8chE9xwhAOfNAIkzX4HfHa/3H8Hm5jENL/SqH4ahTNhopU2WZSDNNzSV8Y+sjlPCvB
         L4VAf4pMBFUbUb1fhruGuJl6LsUnHj3SbfdD9zHEZHg+t4JrUdrCUEeX5xxejGlLN8CB
         nEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680393604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4fQzhtLTNMW1h4aGAmlkoMVxdV1f+pAYnb4ZPXFhqo=;
        b=ex2bVHf4USXwIbbHUTYiFPm5jZycAyxvCgZThNXxh/YhG4NS0vM4LopW7voVvbwaWe
         rAkjFS7h9bnHCrElTl80lC0swHaoQZN58sdDv4ltexgcuBkLePLaDMC7zwFfMZFbcr+x
         4c4Qh7CtBUrOsdVdEDhMJ5uhxeoxWGjhmB3404Zvk9K9Vv+vUj2TfaHtutOy30PzzHvK
         tqtDLwYxN96XsM7MW1i80c9vWghIa0rUyza0LP1FTJkHO0r52BFHP3N4CXlHGHYXfPFC
         8nLseD4lW8OEFHl1DQdZTJ8PcdPnY/smhFIgnoUmSNNMzQOaPZo8MJOazTFVKHEDYKq0
         6GHg==
X-Gm-Message-State: AAQBX9c3uqcuGFXxnmzpHpOgPUZmA08JKbPO9IsPB5XbZMaexG7032Vq
	YQdeWjlBrIzZ5Vtw7xNC8WM=
X-Google-Smtp-Source: AKy350bEq4afOiqPhgPGEO9MPnF1+jIUrbAcJCh8DLFO62P4bFLyoml6vIZq52yUNXLlj3k5JaVXOg==
X-Received: by 2002:a17:90a:b88e:b0:23e:cea5:d37e with SMTP id o14-20020a17090ab88e00b0023ecea5d37emr33754412pjr.46.1680393604361;
        Sat, 01 Apr 2023 17:00:04 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b001a1ccb37847sm3881864pln.146.2023.04.01.17.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 17:00:03 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: connman@lists.linux.dev
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] rtnl: Ignore adding/removing interface to/from bridge
Date: Sun,  2 Apr 2023 09:59:19 +1000
Message-Id: <20230401235919.111754-1-net147@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids wifi interface being removed and added again when tethering is
disabled.
---
 src/rtnl.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/rtnl.c b/src/rtnl.c
index a87296ff..e8a8325e 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -886,7 +886,7 @@ static inline void print_attr(struct rtattr *attr, const char *name)
 		print("  attr %d (len %d)\n", attr->rta_type, len);
 }
 
-static void rtnl_link(struct nlmsghdr *hdr)
+static void rtnl_link(struct nlmsghdr *hdr, bool *has_master)
 {
 	struct ifinfomsg *msg;
 	struct rtattr *attr;
@@ -928,6 +928,7 @@ static void rtnl_link(struct nlmsghdr *hdr)
 			print_attr(attr, "priority");
 			break;
 		case IFLA_MASTER:
+			*has_master = true;
 			print_attr(attr, "master");
 			break;
 		case IFLA_WIRELESS:
@@ -960,22 +961,32 @@ static void rtnl_link(struct nlmsghdr *hdr)
 
 static void rtnl_newlink(struct nlmsghdr *hdr)
 {
+	bool has_master = false;
 	struct ifinfomsg *msg = (struct ifinfomsg *) NLMSG_DATA(hdr);
 
-	rtnl_link(hdr);
+	rtnl_link(hdr, &has_master);
 
 	if (hdr->nlmsg_type == IFLA_WIRELESS)
 		connman_warn_once("Obsolete WEXT WiFi driver detected");
 
+	/* ignore RTM_NEWLINK when adding interface to bridge */
+	if (has_master)
+		return;
+
 	process_newlink(msg->ifi_type, msg->ifi_index, msg->ifi_flags,
 				msg->ifi_change, msg, IFA_PAYLOAD(hdr));
 }
 
 static void rtnl_dellink(struct nlmsghdr *hdr)
 {
+	bool has_master = false;
 	struct ifinfomsg *msg = (struct ifinfomsg *) NLMSG_DATA(hdr);
 
-	rtnl_link(hdr);
+	rtnl_link(hdr, &has_master);
+
+	/* ignore RTM_DELLINK when removing interface from bridge */
+	if (has_master)
+		return;
 
 	process_dellink(msg->ifi_type, msg->ifi_index, msg->ifi_flags,
 				msg->ifi_change, msg, IFA_PAYLOAD(hdr));
-- 
2.40.0

