Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BA4F1FC
	for <connman@lists.linux.dev>; Thu, 18 Apr 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457905; cv=none; b=tkAPC0BAbQ+bB855xrwVs1PH/t0PzlP+HVmeEEzz+zd5AcSj1uDyfnUN8qql9C7bL4lBTTJ3n/TN66K/uj/y7V82G+gtr6PPPe484AiYhsjEequeV7YF6cvAti6fFcudjmAVJ3g3CHIxqcB/97tH/S6kFXizoL5IfukHsh96EkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457905; c=relaxed/simple;
	bh=h23pfmGf8CIMkMxA+VKPrLpOuU8o4yCHrF5HLE/miiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VUDESuv6z4ZDCbrJ5W2D56yBK/i5A0Ppv7TOUhB5xxOAc06p3xA/I315Gnd+9Xr7McmfvMgy7E+qGlCPYnG0iAq51KAb160iuIz6VsisH4xsuPNZrYZoOu55GUCpB6Dxcz9cToKzehKbdwA0hZhO+1epYHLzo3l45ZBCuzWH8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQm3Ih7X; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQm3Ih7X"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c6f785208dso392017b6e.1
        for <connman@lists.linux.dev>; Thu, 18 Apr 2024 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713457903; x=1714062703; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WI0sw0XtFmFPeFTADzWASFwp/olkWSG4xEEmjPDT3lY=;
        b=NQm3Ih7X9wMfXJaHHKmHfW0hJHwq7pPr0+mhj1AD1vCqgTy2jFEnifcp8CFt8GLKAB
         8aMI46jGmJveYuOOZew+35smPk7VHMWjXB3beKqSlMYGgd/ICsEyX69Ht4jtjUEvdQPa
         9Io31ARD662lrPh6sjWLItSLLk8GwQYiCQChG0Dml0zadlo5ypS3KQr6+tCC9D8RPKSQ
         FSJAai3fhm3JnP77ANmhN+HkHzUBiRB8tLK7T9vUP09fqdHL1YnfnKSYdMSAimDtSZZC
         I/Lj+RV9dE83OKorjRVOsfFIZZuC3sPSLAAIxJDd0j1SO4vFgUWZtIp9izrY+7nwECF9
         u7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457903; x=1714062703;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WI0sw0XtFmFPeFTADzWASFwp/olkWSG4xEEmjPDT3lY=;
        b=QRprzCVFL5XQQigSLDsnH+ovq2SfENLu67ofHeOkJ5QD7Cf/GvpSTCAV7ZvOtGqILe
         t0Yvl8l5ngvLcYRpgaGPE0NS7pglpXb927ZOjXKJF2dRy6AVKrR9uM0aR9sDIxHRsegQ
         pz7gG/21eUOHqr7TtWsmJPZRpxvH0Ssz1Dj99dHAnDAO5HRv3rv/44OtVpBoKjUuMtfd
         N9Y+Hm0Q1AV4WBfPso/qYe4ULHe3K5JU1VtlmuoLwMqrfpxxTiftX+oQ6j/NPF0jxtSb
         ZLttSCZGoV05eeqA9H2LzaOEmpAzgp3fB0VyOAl1m87x4XwPLtjpnF2rUzD3Rw8gHMAo
         F/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYNxh2CHlpkS6s3f2fJaDS+NQ4jA+5wsOB9YNfE2d3+Mt9IatTXNQqT6OAW3vcoXjzwK0NsayPWhZkauIGMo33PkS3/biZ7Q==
X-Gm-Message-State: AOJu0YwSUw2HCrT2uWG+XAwMOTlqCs557y/cajy1QKmINa8RbnqPbRF9
	JGKu9WkX0sVBVvnkjmLml95JMamRGxAEBEEkU5b6WUlJgZqf+0z4JUZbOA==
X-Google-Smtp-Source: AGHT+IHnGwMiPDkbQTqEKXQPhNvN9xzOb6+CHF8H2V79rrWIl7Iwe/mIDtsO9eTbIuYLBjUBNXbHxA==
X-Received: by 2002:a05:6808:2381:b0:3c5:fcfa:c268 with SMTP id bp1-20020a056808238100b003c5fcfac268mr4308651oib.29.1713457901603;
        Thu, 18 Apr 2024 09:31:41 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o17-20020a544791000000b003c5f54d014dsm310832oic.51.2024.04.18.09.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 09:31:41 -0700 (PDT)
Message-ID: <0caf957f-e046-4453-a8ae-fd6c994ac95d@gmail.com>
Date: Thu, 18 Apr 2024 11:31:40 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Use a log identity always valid while logging
Content-Language: en-US
To: Christian Meusel <christian.meusel@posteo.de>, connman@lists.linux.dev
References: <20240222232326.1677146-1-christian.meusel@posteo.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240222232326.1677146-1-christian.meusel@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2/22/24 17:23, Christian Meusel wrote:
> I encountered garbled and changing log identifiers from connmand 1.42
> running on Yocto Kirkstone.
> 
>      Feb 09 02:40:18 foo time[590]: Connection Manager version 1.42
>      Feb 09 02:40:18 foo time[590]: ../connman-1.42/src/dbus.c:__connman_dbus_init()
>      Feb 09 02:40:18 foo time[590]: ../connman-1.42/src/main.c:parse_config() parsing main.conf
>      Feb 09 02:40:18 foo time[590]: Online check disabled by main config.
>      Feb 09 02:40:19 foo U[590]: ../connman-1.42/src/inotify.c:__connman_inotify_init()
>      Feb 09 02:40:19 foo U[590]: ../connman-1.42/src/technology.c:__connman_technology_init()
> 
> This variant is slightly patched (see
> https://git.yoctoproject.org/poky/tree/meta/recipes-connectivity/connman/connman/0001-src-log.c-Include-libgen.h-for-basename-API.patch)

Ugh.  I think the Yocto folks didn't read the basename manpage carefully enough 
:)  See [1] for an explanation.

> which creates a use-after-free situation. But nevertheless there is no
> lifetime requirement communicated for the 'program' argument passed to
> '__connman_log_init' and on the other hand 'basename' might as well
> return a pointer to an internal buffer.
> 
> In either case, a locally allocated log identity string will prevent
> potential issues.

argv[0] is being passed in as 'program'.  So getting rid of basename use and 
running strrchr should be sufficient.

Regards,
-Denis

[1] 
https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=ba5a6df2d170fce96354f0c9ba281fe049d2f0a3

