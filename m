Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808F2C6A3
	for <connman@lists.linux.dev>; Wed, 17 Apr 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385671; cv=none; b=L84ydvL8fnugHyzOAARZrwI8LgQuYfYM7Opz1smm0Y76xqHkTe6g2g6rEODQWNN6O/Tot9P4P3zvM+GDXw32BeKFkKBZbZ0YBabSJuWubp/I0CiREpkfUgZzoBMiqZPe/NUyaVM3b7k1VOTsVA7wCU3dWD1ghjgjv1673HY5cOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385671; c=relaxed/simple;
	bh=89mY1xnSWfICYkY+mwO+JDDAUIULySgMigm+IeqPSRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KpV4IwOlmfcVx6ead1qRw4eHhvhwankJ+7u7yPoBHWeJ+rW8UNzEKCLPUnJQipsXll5IF+ONuI89Ukx6Ppfqx/Wt2ZhZpc+fq18HzQyq5358BOI3LyDjle/fOKZHw70sa/4ClMSmbacf2AeXHiCjS70xumYtpg3wQXhG7iye6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d743rYVL; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d743rYVL"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6eb7500abe3so54204a34.2
        for <connman@lists.linux.dev>; Wed, 17 Apr 2024 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713385669; x=1713990469; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qu85AutwicBcXj7Zh9zwVr13RDONTghymsy3GiV7b0=;
        b=d743rYVLgcDouubOaBtHuzZIY9joJNm69Ve5nNdo5cSKuj2QF7JaXyr1GvBZIUjzD0
         /07kIxtJZj0SsuGT5eZkOHlG8MogfDPxzguwDFKLG13GAcQoO3eKjn9bFPgCKA5laxOK
         k4Ifj+0W+Gn+Krz5q29Kg/XtedJN5rpgQIHRoGKwpHgf5yVyR/vMdsk3Yg6WG0QxaRbT
         bOWnWJwUQMIDTHobKXVHCPh9+/W0PRkBQnnra1RxBRLzdmAeWlVx/rAT4odmE9QQ1wVo
         sEPGUtcvIm7oPgXPYiKiJoeSQHVh6LTv3MRQ15yJ8c5bN/vQ/Xy8Zkj8nnJ4fR83R1gU
         gH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713385669; x=1713990469;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qu85AutwicBcXj7Zh9zwVr13RDONTghymsy3GiV7b0=;
        b=S497FKMTxk8j5Cwctb5shJYJBeJHDXTbNSI9VPUChz1J7AmYsXCZs68x4IMh7wZxp8
         5toVFq0xC7WB6M4QlWkLCDXE4IZxUKw0A911kP9T7QWSuZIhZ1RiSymacqSvzH4vdo+0
         e/+lSo+50uibRO6m+5/eEdj1PN83rIOdD9gggF9LM04CzAmPkpQC/Nu3hZDuP6abRFS5
         HXs5kxMIthFzOH+zSN4Xnnn9/4nPDfS+aOdlNMVmscxUxHVb83c7MrC1G1l/Fe/qblVz
         rvyUlaqHlgwWM2ifUZqNG1LEI4mNXPnnMP8yTTRVQMM9IJP3FtofZ/Sp4M5NJj+TiyR7
         Rpag==
X-Forwarded-Encrypted: i=1; AJvYcCWnta7J2q219AmncRlDdS4xcizEvq3tenzynRLYqezNbSpuPep7+emxUHrKgKe9XOZgtx/Hwaeq2LFlf25KdLKr98datl0ZBQ==
X-Gm-Message-State: AOJu0YxbK5Xp7K9ndHL8mgSvgaOR8OZs81/dTnWRfaq4rSN3VcaglcuJ
	ghNw8RKlsW7QgFRflaNDv/1yaiE36KeNebVu6VZ7nykYuE/jvqBwttppmQ==
X-Google-Smtp-Source: AGHT+IH2JZj1V6oRqgq+z0VbcK5rW+y8nvBX/WaSk+/9luBymH6g7FgaP4pK4J54FIg+OJWewdwupA==
X-Received: by 2002:a05:6830:478c:b0:6ea:ab3:5c1e with SMTP id df12-20020a056830478c00b006ea0ab35c1emr595970otb.29.1713385669243;
        Wed, 17 Apr 2024 13:27:49 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l20-20020a056830155400b006eb7dc0599fsm31120otp.38.2024.04.17.13.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 13:27:48 -0700 (PDT)
Message-ID: <434da666-080e-49d6-9b29-c8fdeeba8b18@gmail.com>
Date: Wed, 17 Apr 2024 15:27:48 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dnsproxy: fix signedness warnings
Content-Language: en-US
To: Brian Fukano <bfukano@gmail.com>, connman@lists.linux.dev
References: <20240405165801.72338-1-bfukano@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240405165801.72338-1-bfukano@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian,

>   	 * The cached packet contains always the TCP offset (two bytes)
> @@ -508,7 +513,7 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
>   	if (answers == 0)
>   		hdr->aa = 1;
>   	else {
> -		const int adj_len = len - 2;
> +		const size_t adj_len = len - 2;
>   		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
>   	}
>   

I dropped this chunk when applying.

Regards,
-Denis
