Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AFCA64
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlmbLbic"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so6544160a12.2
        for <connman@lists.linux.dev>; Tue, 05 Dec 2023 21:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701839855; x=1702444655; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5p4aVEvr2YkTImOU3JFSagbhV64CtnTT4dcXzj5+Ks=;
        b=JlmbLbic4Ap7cOlnKd5prLjWn7m9xXfWQNiOWtpqnNzdaP8u3CHffIOvEv3Nic8Joc
         Xf8DBVqD3/Lz+0mcWYlpg2/O3wI1sQvZbKkrkgvgtAVkEwpVcAC609aDAYmbm9WLlKpd
         qEIqFawm/mOT9ypWotsmB20ZNAg4LFFks8CxX4sZMLCo4g7jP9aqTox4qKorbsvvN1Q9
         ep97WU01UqVkLabvWEPDBODLv0Jd1rvq+PbTe1JgP6K+CTXpdOdtyTdioFzuOsei4z2r
         ICdzLGnhUk7t5SJ4mdHRLzQ9lIdRbGJ9gC6ekAow8v53uyQ3x84b9vzsuwrkqkeLv7jU
         rANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701839855; x=1702444655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5p4aVEvr2YkTImOU3JFSagbhV64CtnTT4dcXzj5+Ks=;
        b=b/7rDS0fxWGe6tJAdUaFMhsaoZzRd3iyESqUpGFLr7u8bF8BHtrEl7tuPs/IAdfsZp
         4Uvfw66DJnsmAsRwGB2Xg4VFo86HqFZPCmy72d1LOJ3l01CwaViiMznOU1js4o5PLwMj
         448DtK9sXD2MnCks5Ts39YJt6pqH1USZqdnZxhLBiAcgQ3ugpI+opayazqFdF48p+VmE
         gL1aGgXcSI07ZPaTm+XiZS2RHTVq3tU+/ZY2qzi8FgAmQMCKM+XBFsjbgagtV4QZeHaf
         Y81zqDsGngCQcASyqSM/y9k92x2KkMe9kZAlKsrqWPVHvRRrBGxqustI5+CAsOFgyVM4
         3otQ==
X-Gm-Message-State: AOJu0Yx5exePFam580L3x6/zt5v864uk5BMXuTM7ADSDXlYU7AqBtzQZ
	iUZinUMECDIyAUQ2yGmc+2w=
X-Google-Smtp-Source: AGHT+IGAzL5jg2BQIv3z6hlnNc7Ov3IuH2aZ2RP/CHfF8yLaBk4jIp8cBHaxOnV30B1Jbv34i5xtEQ==
X-Received: by 2002:a17:906:289:b0:a0c:46b4:a705 with SMTP id 9-20020a170906028900b00a0c46b4a705mr161852ejf.56.1701839855300;
        Tue, 05 Dec 2023 21:17:35 -0800 (PST)
Received: from [192.168.2.2] (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id sa12-20020a1709076d0c00b009fd585a2155sm7654687ejc.0.2023.12.05.21.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 21:17:35 -0800 (PST)
Message-ID: <82dd9807-2b83-4c1a-a697-f2cb92b1e1b7@gmail.com>
Date: Wed, 6 Dec 2023 06:17:34 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Regression_caused_by_=22Don=27t_add_route_for_inval?=
 =?UTF-8?Q?id_dst_and_gateway_address_combinations=E2=80=9D?=
To: Grant Erickson <gerickson@nuovations.com>,
 Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <A9CCB4B1-2A45-4C97-95E4-FBEDFAA8CD13@gmail.com>
 <83d7e315-a25c-4c2c-9ddc-9abde56ebeff@gmail.com>
 <73D64378-2195-4669-8B60-39F808190977@nuovations.com>
Content-Language: en-US
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <73D64378-2195-4669-8B60-39F808190977@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

2023. 12. 05. 17:57 keltezéssel, Grant Erickson írta:
> On Nov 22, 2023, at 8:07 AM, Böszörményi Zoltán <zboszor@gmail.com> wrote:
>> Someone with a bigger hammer should look into this.
>>
>> I guess there is a difference between
>> * intentional default gw with all-zero network and netmask bits for VPN
>> * dhcp not responding on an interface and then adding a route with all-zero gateway and netmask values
>>
>> 2023. 11. 22. 15:53 keltezéssel, Christian Hewitt írta:
>>> […]
>>>
>>> And “all-traffic” is routing through the tunnel again.
>>>
>>> I don’t code so can’t figure out how to fix this myself. I’ll happily test any patches you share though, and can provide remote access to test devices if needed.
>
> Zoltán and/or Christian,
>
> Are either of you running this down or working on a patch to revert the prior one until a more comprehensive solution can be found?

I wasn't. I can send a revert, if you really need it.

> Christian, based on your “don’t code” comment, I suspect you are not. :-)
>
> I have some patches that should be flowing shortly that add low-priority default routes for non-default service network interfaces. Those may allow the infrastructure to better address this but could also confound and complicate this by introducing potentially additional VPN breakage since that’s not a use case I currently have a DUT configuration for.
>
> Best,
>
> Grant
>

