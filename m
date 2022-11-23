Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90037E
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 16:03:09 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id x5so26011771wrt.7
        for <connman@lists.linux.dev>; Wed, 23 Nov 2022 08:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxiltMLQqAMBPbIC8+PexP9TjUhQI1Z31yp+UjT+P7I=;
        b=RhyZ3uxRjbfkPTFcsuxmnMw3ZzArSrL5JfC2MLA7xjHo+1pNNxzQ3QJ4mFwvN/TJXA
         eMYqNhiwnP9KRQ0Kl8EZePQaR+dyTyDEBwzGfXsgAooJ6ljX+88jkkkM2cp6t28+rusY
         WR9QiJCNURIFGqHn/kbpskpa3z6nnWC0d+th3rUzliT66NvLk+US7F2SEWzFj0qP6hhs
         rAbY+D9zlDQpU1vAsLzq0wSnmTfW0o8HBLuQEVc2VrnJa37X90v64yAWqxXOoh5IK9N4
         j+HA5ooJla7PN16h2A/4ccT9IgzK7pG8MUc5wszPZeufrKgoHmbZtYpZaOaTKaQozZfi
         GM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IxiltMLQqAMBPbIC8+PexP9TjUhQI1Z31yp+UjT+P7I=;
        b=xAk4IpW5/CnOxxn2PP9++0Md5nYSQ6OVzmtKgQ3i4QNCUZ/PB0VKIDJKeOpSZxuZXS
         OF6OiUjxxRbff1I2iGI9royIXG+guxnr8YH4675mtdTDkilKgfVbVvrSvxTqFmqSQaJJ
         jdtPXn+R1N0rqGpb9QU4Ih5mZOxjzgOH1lEKG13PsMLzylewesmVaEoZkaXGLeDj+v03
         3hAzpYjHqk5HnUQQUSEnQKW14bLnOTop9Y8PmlL85FG84Es3KiN8f/AwQqMLhDJ094lD
         HGaolboWuLeEnhYfyGJnbXMHtIC7fX5yAWM//YACbK/OJ4vNqfkYDepBPPlE1TjulLgu
         y8qQ==
X-Gm-Message-State: ANoB5plbOSZ5bYMdaC3hswuHuox0STFVlq5R62N8761xpJfoAghyCK8P
	ZPCRr6TIO9DdKP4akqaCJC7WdElB2ZYxhESu
X-Google-Smtp-Source: AA0mqf76g7sb/Be6s9mG0Cdaj+fvJ4LhNvfV6vF5QoVKb2bQfbgimPqxqulpnWtaANk5pjAvOHXusQ==
X-Received: by 2002:a5d:4890:0:b0:22a:f91f:674a with SMTP id g16-20020a5d4890000000b0022af91f674amr6133689wrq.214.1669219387860;
        Wed, 23 Nov 2022 08:03:07 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:92:e546:b526:ab41? (ptr-gh3gmp8dtfeberb5dmp.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:92:e546:b526:ab41])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdb8c000000b002367ad808a9sm16774295wri.30.2022.11.23.08.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 08:03:07 -0800 (PST)
Message-ID: <66993511-8b3c-bf48-beaf-9ff9e6ee446b@gmail.com>
Date: Wed, 23 Nov 2022 17:03:06 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: john@metanate.com
Cc: connman@lists.linux.dev, wagi@monom.org
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Subject: Re: autoip address set/reset loop
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Subject: Re: autoip address set/reset loop

From c34b1e21adbf1376158c4140760c64bc867f9ced Mon Sep 17 00:00:00 2001
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Date: Tue, 22 Nov 2022 19:50:12 +0100
Subject: [PATCH] ipconfig: revert not adding invalid gateway routes

---
 src/ipconfig.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 74215e1d..5af6dae7 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1183,15 +1183,20 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
 
 	DBG("");
 
-	if (!ipconfig->address || !ipconfig->address->gateway)
+	if (!ipconfig->address)
 		return -EINVAL;
 
 	service = __connman_service_lookup_from_index(ipconfig->index);
 	if (!service)
 		return -EINVAL;
 
+	/*
+	 * Gateway is allowed to be NULL here, see
+	 * __connman_connection_gateway_add()
+	 */
 	DBG("type %d gw %s peer %s", ipconfig->type,
-		ipconfig->address->gateway, ipconfig->address->peer);
+		ipconfig->address->gateway ? ipconfig->address->gateway : "NULL",
+		ipconfig->address->peer ? ipconfig->address->peer : "NULL");
 
 	if (ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV6 ||
 				ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV4)

