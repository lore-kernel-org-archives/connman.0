Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818B2C83
	for <connman@lists.linux.dev>; Thu,  7 Oct 2021 21:30:29 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id r10so23210923wra.12
        for <connman@lists.linux.dev>; Thu, 07 Oct 2021 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=StMaQR6UdIZmrRyg8fo1r97EP3xD+acM3f/67QKNpeU=;
        b=YMCGH3IniQDVmWD03nrgKjW1+B3Ya2F3juW0AWtV7LIcSy80DqbnLpppKTjW7S3Bin
         kLoieroD1jFR6wR7hj+kanUol1Lvwf0cD0awS1wwJbs2v1f+l/EKqjrpofAUiNtFhPO4
         J6q1s0d6DHu8hiToT6nWtXWZv6kAY4tfj4JQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StMaQR6UdIZmrRyg8fo1r97EP3xD+acM3f/67QKNpeU=;
        b=bUWdCMiZyK0dzyrl/wQZ+4k4aOhgQcRwaxH+PViSRV81M5JhthtTwkQAQiXYfaJkmp
         1pEyDw5yEGvIyGhwnXbGX6LxT13ReBpnUdAPr7+8H2iZaLuwSF+3y8ZZoFPnQoOHcozl
         siJ9z7ItextwNjpqOI2QCUpsVJhL9EqVJLeZCXnNYuMmM3wOYNvhCG0FSl4ENFc8Er6G
         XqCpr3WswBaAWUNGehuYLNOI3PvjxBlTDiik7xiIFKGlifoxPYzJWKzbe/J4PsOyPG0i
         oxVy35+8Q9oGnvcxj8vGeLZ2clIdk614I55Kp8FfnfSjJ1+MwIYzEFR/REKyAdMjQHdv
         M4hg==
X-Gm-Message-State: AOAM531rW6gk8aaMVd9s0BRayLw3pbSFRw+M9GkuXKmu8syS4Ub+4pa1
	QkgXDBcn46Rem/WgX89lz3HdcyOF7Nb1TP/e
X-Google-Smtp-Source: ABdhPJzky5XUVXnYQZMlTpIuK4oOuwRhKzwxtdgcRrzzC2VU3pFRm6uv7R/ftzVrVbfhSXle7TZLzg==
X-Received: by 2002:a5d:410d:: with SMTP id l13mr737224wrp.301.1633642227596;
        Thu, 07 Oct 2021 14:30:27 -0700 (PDT)
Received: from localhost.localdomain ([109.52.197.122])
        by smtp.gmail.com with ESMTPSA id a17sm497068wrx.33.2021.10.07.14.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:30:27 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH 3/4] tethering: Add TetheringFreq parameter documentation
Date: Thu,  7 Oct 2021 23:30:20 +0200
Message-Id: <20211007213021.58712-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007213021.58712-1-michael@amarulasolutions.com>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 doc/technology-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/technology-api.txt b/doc/technology-api.txt
index f22e9b29..cdf30396 100644
--- a/doc/technology-api.txt
+++ b/doc/technology-api.txt
@@ -100,3 +100,10 @@ Properties	boolean Powered [readwrite]
 			This property is only valid for the WiFi technology,
 			and is then mapped to the WPA pre-shared key clients
 			will have to use in order to establish a connection.
+
+		int TetheringFreq [readwrite]
+
+			The tethering access point frequency
+
+			This property is only valid for the WiFi technology and it's
+			optional. Default frequency is 2412 Mhz.
-- 
2.25.1

