Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEA7E
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 14:56:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5so13240075wmo.1
        for <connman@lists.linux.dev>; Wed, 23 Nov 2022 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwY6f+zfYk/M+Sc9iNqm6sEnqsFRVmglioN96MyQw+g=;
        b=pPPVdkLyvx4VUCPRc+xQu3X2MtfWo5hsKp3SgeTduNilwlDyIieHkurLvCqzwAyAVS
         GhFyrU5Y6h6z8sCoeXBHqr8SAXtGeAd6U5pgbPajUCUDLndALqt3uL5GgDNEHN21c+zT
         LhOyBjuZCSX7jN1Kty/al0RSBY6YrEd5VEY/1b7YF1/3gPfD9aBJqqpxgOSBNGsm+PJK
         IZuwvYOrB/WBo6n0t5G+VVK12WHisY3ntcK55HWfx8DsEw4Vxhg1kFfn5fSfolFzrzMR
         6v03mT/2098/oBfRB2naPDlk6z5Yif7BScKv4ywoOw/O429KHiyEitt3HYEh9ygSZq3t
         1hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QwY6f+zfYk/M+Sc9iNqm6sEnqsFRVmglioN96MyQw+g=;
        b=PVCUlLXcu++B5fQLTfDEzuB/TFG95iTsC55/yEi4Ganz0rq1E6PScMoB/jKo2H/JW3
         teRjGLIlB5hwWudSObaqmmJAyx4eqSVPUXKd0wkZXu4P+hsZejAmP7H9RSywhHU3X05S
         2ksRbgn71aiA0x65bo69jHNG33TNe+n17MzOESHhbY4LopZ/4QEaVhQzCKaJvx8yJAzu
         lsbfqAlz0uM8G6Ec/9OHUEC+QCSnSom2UySUGtdPZFjRBfTSyr0ilG0lvNmwQMUEeZuE
         URb+1PFKs+inBsr+f7WFmCEUdtycVKQvZ/LBJ0iSUxjGub4sElnlvgCTf1ICPdZIVMtq
         gafw==
X-Gm-Message-State: ANoB5pmrJjoH1lL5G0KNbf7oV9IxDMTxxnO/bO80hCjA09p4+A9EAoL8
	NB+lSzPaxzKasFuVdV81PRLT+uBS4cPQ3DiO
X-Google-Smtp-Source: AA0mqf65Ghqp4xQhojz3LHGFuT/aAGqL9LPvJlFR74vEITgJGOl8FZI0QYYsB454T/UmFloLpMwYVg==
X-Received: by 2002:a05:600c:4151:b0:3cf:6fd1:d94e with SMTP id h17-20020a05600c415100b003cf6fd1d94emr19862083wmm.61.1669215404502;
        Wed, 23 Nov 2022 06:56:44 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:d266:9a1f:8f14:dfe7? (ptr-gh3gmpbkotaupr9i21z.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:d266:9a1f:8f14:dfe7])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b003cf878c4468sm2846148wms.5.2022.11.23.06.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:56:43 -0800 (PST)
Message-ID: <9af7ed7a-be9b-962a-bcfd-8b482d45a65f@gmail.com>
Date: Wed, 23 Nov 2022 15:56:42 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: geoffrey.vl@gmail.com
Cc: connman@lists.linux.dev, wagi@monom.org
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Subject: autoip address set/reset loop
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Subject: Re: autoip address set/reset loop

Here is the patch:

From b7750b925714572cba12275e6da49b8b70cd3fbb Mon Sep 17 00:00:00 2001
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Date: Tue, 22 Nov 2022 19:50:12 +0100
Subject: [PATCH] ipconfig: revert not adding invalid gateway routes

---
 src/ipconfig.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 74215e1d..875819a0 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1183,13 +1183,17 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
 
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
 		ipconfig->address->gateway, ipconfig->address->peer);
 

