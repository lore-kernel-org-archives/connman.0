Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D73FCC
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 12:26:14 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id ba1so34169572edb.4
        for <connman@lists.linux.dev>; Fri, 01 Oct 2021 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bpjOJW1jQG8fjBkxPqir9Vu7dQgB4C1TGozo64yKan0=;
        b=cpNq0/kUg/XSWnIJAtIeKfffZCB6jx55TZSY4oDfZK+zSh9m+pXKyV9r617YsUYvwP
         fH50jLRxQd2/iyMEdTfQaAUaQ3tFnUwIZtXbDL09CM4oQe28WS9D/rCsv14k4GmEsUzY
         VFdpV2K92z6BS/l79mdVVdabc7c413sprlFFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpjOJW1jQG8fjBkxPqir9Vu7dQgB4C1TGozo64yKan0=;
        b=4z6aqFHU+0tNOe3UvjcGeG2IBBjijzKNJep2hvZc6HsRs9A5wjJ8Zk3mAs11xfxml9
         ILDXlGiht+4LxdqiT8eV0dkzM62fZ3Ncjh4iVBckDWFVAIHynhnPvIetlIYK16wIptHo
         9zI9vfX/NdbL5uPS+c1zwjidL4P/jnFBjfOOQZirewe7v50OByU7KX8TNIhz9wVhg60m
         9TSl7xkgXeD0nBwkwPnWhbvl7u/PAuHjdI9hkDuYTvau1jPdM52p3DHCGJdXAEouX67M
         /1K2cWH9+Ot3zI2FGZWW5gBTv5P4NOjL+QMhWGU4/Dbvvw4m8LaYnBw2MMIvaQlOs2bt
         WQjw==
X-Gm-Message-State: AOAM533VRZWu86n6nO5umumK7YpNxt51J01gHUb1wXVnvRu1+pr6bf7H
	oCo/zG8ngWaxz7Zqeh+Q4+pP365LqRuueQ==
X-Google-Smtp-Source: ABdhPJx8Hf3F1ojEVrVFN9brm52togag6kKeReJcFrX1E4GBWKFnMSVHWKI/z+GvrdCbAuJKWjJfMA==
X-Received: by 2002:a17:906:c009:: with SMTP id e9mr5878250ejz.509.1633091171161;
        Fri, 01 Oct 2021 05:26:11 -0700 (PDT)
Received: from localhost.localdomain (mob-2-43-201-216.net.vodafone.it. [2.43.201.216])
        by smtp.gmail.com with ESMTPSA id t15sm2218366ejy.74.2021.10.01.05.26.10
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 05:26:10 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] manager: Add TetheringClientsChanged GBUS_SIGNAL
Date: Fri,  1 Oct 2021 12:26:07 +0000
Message-Id: <20211001122607.34360-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001122607.34360-1-michael@amarulasolutions.com>
References: <20211001122607.34360-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TetheringClientsChanged as dbus signal. This can be
seen using d-feet or other tool

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 src/manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/manager.c b/src/manager.c
index 3bf8f4e4..892d3a42 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -600,6 +600,9 @@ static const GDBusSignalTable manager_signals[] = {
 	{ GDBUS_SIGNAL("PeersChanged",
 			GDBUS_ARGS({ "changed", "a(oa{sv})" },
 					{ "removed", "ao" })) },
+	{ GDBUS_SIGNAL("TetheringClientsChanged",
+			GDBUS_ARGS({ "registered", "as" },
+					{ "removed", "as" })) },
 	{ },
 };
 
-- 
2.25.1

