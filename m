Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A34699
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 17:12:47 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id bs21so30398483wrb.4
        for <connman@lists.linux.dev>; Wed, 23 Nov 2022 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZiWUXYXIrddi+NXmePUOV0r4KPJDf8VbJctGbINfqM=;
        b=g1i7kfh1nN8vCopkyv74O+40Rtn3pPeoMat/nNmzsSc8VvcBoJZ51KPe01bfX2h158
         EFDSKQB38PPp/vHJ4pokfoau2YWRnI0EsHsoE/p6NtL58fxFlDn4ERCLtiRUcb1OZQNi
         Cl4jEL6uPknF7KvKGtpT0dhO0pIfx5OtUxXbPa45PLBZcCiBnXHzOz2MfceDM1DNMlCc
         dF6//Y7S9IbS4rtSfEWJIMrKldee9SKwyEE3Ze44PFO/Gd0zmTAD+uQX5rDMp5DQ3/1u
         BrjvXUSQ6EK1YUXyjytwsLgYMULlTEqQVGFcNRtyFcQRpTOadaAto1hkgzC9lTIx18M1
         Atrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ZiWUXYXIrddi+NXmePUOV0r4KPJDf8VbJctGbINfqM=;
        b=dbO5k2pEfLJ+1DZa7E9oToN7dCl4LKlefruQ4Gw1N0yaCr+5/2LxCJBpG5zEobAb0z
         MT9ukGUlGGetRBpeaNgItVLR5lQs0vSpLZnMk+8Eh8yU49RUUMLVw1J5yfOQi8m5Hqhj
         CrnKMueCcpT55s66ScbmmcfTY2re/gVuBo/7yK2Y0QIwFcdIAjDg7QgnI44tOvfXnvzX
         pkBLyi3jxjBjk5+bDCKx5OeAlgVpJxxnEKXY4Y4/WkTLFFlFNbKJstwSAootPPVDFHVr
         1MR5cC/8yheKwvUjP9xkzjbMj8COqYeL091AaBXRhxke1XshD3xinXWlRKlM/psAZSDY
         UHfw==
X-Gm-Message-State: ANoB5pnhmc1ecYoXB5m3tV4zqooAUlGC5SgCIJWaQatWNK54AfcBD5on
	RPj+ljPr3DZ8Fsw3mcXzNMc=
X-Google-Smtp-Source: AA0mqf4cBUcopSlbeIS0HD6OO6gLO/H8Zs5FG9QQ7NAetLj6eInWXt38/7YrIS6dpm9SUj/mcbJw1w==
X-Received: by 2002:a5d:4a52:0:b0:236:debd:bd65 with SMTP id v18-20020a5d4a52000000b00236debdbd65mr17147858wrs.527.1669223565834;
        Wed, 23 Nov 2022 09:12:45 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:8386:59a3:6a97:5842? (ptr-gh3gmpadia5ywuu5a2q.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:8386:59a3:6a97:5842])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b00241cbb7f15csm12498793wrb.106.2022.11.23.09.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 09:12:45 -0800 (PST)
Message-ID: <152f062c-7c16-c6cb-c8e8-c6f82902e40b@gmail.com>
Date: Wed, 23 Nov 2022 18:12:44 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: wagi@monom.org
Cc: connman@lists.linux.dev, john@metanate.com
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Subject: Re: autoip address set/reset loop
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Subject: Re: autoip address set/reset loop


Hi Daniel,


Well, as said it autoip (APIPA) was not working because of this because it seems to not have assigned any gateway at this stage. This get's assigned in the __connman_connection_gateway_add() function which is called after this DBG(...):

if (!ipconfig->address)
        return -EINVAL;

    service = __connman_service_lookup_from_index(ipconfig->index);
    if (!service)
        return -EINVAL;

    /*
     * Gateway is allowed to be NULL here, see
     * __connman_connection_gateway_add()
     */
    DBG("type %d gw %s peer %s", ipconfig->type,
        ipconfig->address->gateway ? ipconfig->address->gateway : "NULL",
        ipconfig->address->peer ? ipconfig->address->peer : "NULL");

    if (ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV6 ||
                ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV4)
        return __connman_connection_gateway_add(service,
                        ipconfig->address->gateway,
                        ipconfig->type,
                        ipconfig->address->peer);

In that __connman_connection_gateway_add() function the null gateway is assigned 0.0.0.0, so your commit was effectively blocking that.

