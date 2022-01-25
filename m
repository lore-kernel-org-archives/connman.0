Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78B29CA
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 16:25:04 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id x193so32097428oix.0
        for <connman@lists.linux.dev>; Tue, 25 Jan 2022 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JVCOj0rqg3e8p0pTdK1yvJ9xAWISmmMqGvOZ6dYCtYo=;
        b=S8V61kdZqt/l/9sJ7ZzzZZoe37sTSEXt5wZ00v0EyZxWz0EoDU/YmCd17LAJDNNXeW
         CVUEvsG3oYQ1139hSsPiDopYKkWjSb3+m3FpwTVMYVksow2hUxUeL8keXZakgq2vwZay
         CkDm3BY8VZUfk3rMDABgQXm+muB859nyNKDupEIZYW86oRmHo1gxpS1OnzPjAQs6phv7
         M1cXfMJNDhApG4YQ5sgGBFQPuVQwy8OoIvzmhthaVQKeElQJSybQJW+NjFnhXAXDhFDW
         Y1Nt3IvDMO8Hhp6ofPXhimia0BqTr7t7chK98ZPig896GSRcFjHCO3M6omANMemNuHyH
         eCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JVCOj0rqg3e8p0pTdK1yvJ9xAWISmmMqGvOZ6dYCtYo=;
        b=UXCVnbeCOBhmtFN7zpv5hb4plSj/7n5wob5AJ3UQ6jCOdHt0wrMIRxCV5lowBcKfkq
         lsUp6Srt5A1gva4QTKVOJk/huK/P81gS8u2flO5glzXyjAa3sRPDgYl1D9w9amcWfTZg
         SXgV75oXPE31ZlhUGJ/WiyCDMKG0NyOQPT7htZxR5BN8HbbBxfTRWIVz9PMTDX8JpZ77
         v8nhNFRubUjCGV16sLeVMv5bKkByA1v+QZ6xWlZXrZ6Emd5whH4wIkL+3VLxK9Z5TVTU
         l3cql5AdmM023ZtjjMbbOtp54NcsLyQJVjxrnODBexCXkqis6iFi8kf7sO8+WXWNjMdQ
         TU3Q==
X-Gm-Message-State: AOAM5312/ZY4a09N42yH4xKGApgixA5yqiY2qrxHlnxiVyBVA3DvJAGm
	nFWaPH0Q4wwWMFtUB3g9zNQ=
X-Google-Smtp-Source: ABdhPJy0cHFvJ8/lSP62ZCGfuCEXLuUl32zwM2FgGlM5DnG7FFyo1C0ic2hnhryUVAUXJdpwrmNjuQ==
X-Received: by 2002:a05:6808:249:: with SMTP id m9mr1137574oie.96.1643127903686;
        Tue, 25 Jan 2022 08:25:03 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p4sm1112539oia.24.2022.01.25.08.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 08:25:03 -0800 (PST)
Message-ID: <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
Date: Tue, 25 Jan 2022 10:25:02 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Content-Language: en-US
To: Daniel Wagner <wagi@monom.org>,
 "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>, iwd@lists.01.org
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

> For the iwd developers: Currently ConnMan's iwd plugin doesn't track any
> networks state. It just forwards the connect/disconnect requests from
> the core. Do we need to filter/serialize those?

So in theory iwd should gracefully handle such scenarios.  For example:
- Connect comes while already connected (network switch)
- Disconnect comes when connecting (aborts the connect attempt)
- Connect while connecting (aborts original attempt, starts new one)

There may be situations where the timing between requests is so small that we 
simply have to return an -EBUSY (net.connman.iwd.Busy).

Is there a particular scenario which isn't working?

Regards,
-Denis
