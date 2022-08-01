Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AC17E3
	for <connman@lists.linux.dev>; Mon,  1 Aug 2022 08:07:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A17E05DF33;
	Mon,  1 Aug 2022 10:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1659340849; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bX6tKF8PPx5kj3cXGPt+RUFv6nyfoSWJo1mNe9oghZs=;
	b=NxJeyokkKs9zsW9bXq7OplvD78HR1AMiqHU0TKXeX/vREOIoB6DhQ/uyXqhKhWoSCTsZT3
	Wcul+N5Wab/oaevLhS8vrsVAevw/MHOnHKkyLaWhbOnDVDFtep03z7ikQbFwlLkRQ2CL7S
	//h0igk31/js5e0uhn/+yQy27mPVaY9cBkJIRnENNJmP8ZBvA31KTKJDpEs4V0mlpfpMXf
	+7i93s7zPwVMuLzjappOqur1IP34XAZdho92OStLDqh62d6et0bLQNj/NnMdt5o6v7Qc9T
	x9LcqHrxdObGVAGprt9eMhnWkSJ+ICQu6ZCWkPyztp8TjwLDziMQVdoAwGwmhw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Nathan Crandall <ncrandall@tesla.com>
Subject: [PATCH 5/6] gweb: Fix OOB write in received_data()
Date: Mon,  1 Aug 2022 10:00:42 +0200
Message-Id: <20220801080043.4861-5-wagi@monom.org>
In-Reply-To: <20220801080043.4861-1-wagi@monom.org>
References: <20220801080043.4861-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Nathan Crandall <ncrandall@tesla.com>

There is a mismatch of handling binary vs. C-string data with memchr
and strlen, resulting in pos, count, and bytes_read to become out of
sync and result in a heap overflow.  Instead, do not treat the buffer
as an ASCII C-string. We calculate the count based on the return value
of memchr, instead of strlen.

Fixes: CVE-2022-32292
---
 gweb/gweb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 12fcb1d8ab32..13c6c5f25102 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -918,7 +918,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		}
 
 		*pos = '\0';
-		count = strlen((char *) ptr);
+		count = pos - ptr;
 		if (count > 0 && ptr[count - 1] == '\r') {
 			ptr[--count] = '\0';
 			bytes_read--;
-- 
2.37.1

