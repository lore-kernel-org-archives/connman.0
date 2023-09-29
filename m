Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CA4418
	for <connman@lists.linux.dev>; Fri, 29 Sep 2023 03:34:28 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77575233633so255604885a.0
        for <connman@lists.linux.dev>; Thu, 28 Sep 2023 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695958467; x=1696563267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQHvj8UL7YzmzVxLqNfcPjgzgjzYUzjJ0EAqDmoFlXY=;
        b=MTX6q1Xf2Lt7yr9pUqjOHYFyw/cOyU7UedQmRu0F0uImlg+XvZ3Jl1nOuuddU9WRMT
         T5b7T0ZmwqvnnVLkekuN156zAsIV9gjYGUBqcu+KD/FLW3G96ogbC+PIDJdNI6XCjPbw
         bKX3o7MAyWmUNbfDpF84megxPbQ/Mso2ucWCc0gYaSjaGKdF880Q/3B3KF9coQ+GrTi/
         yBP/8dIz+yR15UqbIiqwNO3Fbc6wzxoyPfCu37CmTXfqTYqG1aZqacvigwQwpX9E4F2j
         lH8Jd9UHBfvJjOnG+0DHTsHrlPlq9EJvvhzwGU3vFTZwsVo87Tb9s5rzNr2BSmRAit5+
         YEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695958467; x=1696563267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQHvj8UL7YzmzVxLqNfcPjgzgjzYUzjJ0EAqDmoFlXY=;
        b=LJRpR89jpDvXPz9EwZ8PreIlmRXRJJMa27GtpC+JzzlboRg72rVVnqYAmSuOxhDbx6
         EtsoATO0T0/QslxfAPklTnvGwQHkb1VfPmeYcokS1lhLIa/IZQ/YjX7h9tIPtT7wCzig
         8C9u3SaPqVTTZIkxvx+xemMRp1ZvoqhkcW3aKmptW2xKqbMf6ZN1I5oH6uJllBdgqs31
         JVpYxZUVVkRDe93hsbpmaIbFpDUAV02bsY5jDlamZ5tWW6J2slm/pvWgV48SrheWL/3t
         C4+JlRiMvSj3SdvYcKx5lTma3RA3gGFpzbURNi7OgAXIXB03fOjBY2+lBgVxwqTHv5eK
         ivTg==
X-Gm-Message-State: AOJu0Yz4xdrkXF3tLl6f00nuNi10SGIFQ38BvjDl+sp0MbJEl65LXP1N
	uS1Jt83wtiIXvQr6SXPqfOX0uJT1eW1+Wg==
X-Google-Smtp-Source: AGHT+IFkJ1+BjXCpUmB9r4HDBR6ZWpyfk3NdVhv5f+wBaxjEnnnyT1EfL8Ku/4sW21M6reRt1aqPgA==
X-Received: by 2002:a05:620a:4111:b0:773:d284:cd2f with SMTP id j17-20020a05620a411100b00773d284cd2fmr4216979qko.49.1695958467053;
        Thu, 28 Sep 2023 20:34:27 -0700 (PDT)
Received: from nicSlaptop.localdomain (modemcable069.200-80-70.mc.videotron.ca. [70.80.200.69])
        by smtp.gmail.com with ESMTPSA id z20-20020ae9c114000000b0077589913a8bsm479250qki.132.2023.09.28.20.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:34:26 -0700 (PDT)
From: Nicolas Gariepy <ngariepy1999@gmail.com>
To: connman@lists.linux.dev
Cc: Nicolas Gariepy <ngariepy1999@gmail.com>
Subject: [PATCH] resolver: FIX path to resolv.conf config option
Date: Fri, 29 Sep 2023 03:34:08 +0000
Message-Id: <20230929033408.80874-1-ngariepy1999@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two problems with how the "ResolvConf" option was implemented.

1. The "ResolvConf" is used in src/resolver.c using the function connman_setting_get_string(const char *key) but the connman_settings.resolv_conf option could only be accessed using the connman_setting_get_bool(const char *key) function at the moment.
2. The Gerror is not cleared before trying to read the "ResolvConf" parameter of the config.

This patch fixes the two issues above.
---
 src/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index ae4a450d..61881442 100644
--- a/src/main.c
+++ b/src/main.c
@@ -599,6 +599,8 @@ static void parse_config(GKeyFile *config)
 	if (!error)
 		connman_settings.regdom_follows_timezone = boolean;
 
+	g_clear_error(&error);
+
 	string = __connman_config_get_string(config, "General",
 				CONF_RESOLV_CONF, &error);
 	if (!error)
@@ -801,6 +803,9 @@ char *connman_setting_get_string(const char *key)
 		return connman_settings.localtime ?
 			connman_settings.localtime : DEFAULT_LOCALTIME;
 
+	if (g_str_equal(key, CONF_RESOLV_CONF))
+		return connman_settings.resolv_conf;
+
 	return NULL;
 }
 
@@ -842,9 +847,6 @@ bool connman_setting_get_bool(const char *key)
 	if (g_str_equal(key, CONF_REGDOM_FOLLOWS_TIMEZONE))
 		return connman_settings.regdom_follows_timezone;
 
-	if (g_str_equal(key, CONF_RESOLV_CONF))
-		return connman_settings.resolv_conf;
-
 	return false;
 }
 
-- 
2.40.1

