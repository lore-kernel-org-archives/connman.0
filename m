Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC871747
	for <connman@lists.linux.dev>; Fri, 25 Apr 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590043; cv=none; b=GjJbBPrbsZ9iv56r0Qi6gEpeddsklZ6ik/XmcCLytYjojatAq9P0fzSmyvuUs6nLXPBr9Msjud1KjUUhoiat3/+qivxRVJJ5tbINV91kP40iTX5BlIMU9WObp3ET/AdrqN6LMIFq9QiXP5hZ3r0QhjqutDzJEvIj1BbbqSy5kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590043; c=relaxed/simple;
	bh=W6w7XU3/nq+7UlBs6XBNd6SmKYpzLlvLQW8HlvuPJw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gGWohNAKxGXkdn8skPYHFLDr5o3ZLmDzBjrmSMUcv37n8iRvNrRnQkd1ufjdMdEJNME7jVKmV+qqOWDhD85Gn0eGyK2xJXOQ/xwk0Fc0tyWAjJkzMrJeSOtz8qoQZQsS5WEMYhcsIEyYiy9eWkZy+NmiBU5MiDP60byOx8qSYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0boS9uc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0boS9uc"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72b7a53ceb6so1474918a34.0
        for <connman@lists.linux.dev>; Fri, 25 Apr 2025 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745590041; x=1746194841; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTh8Z/xT3HMeK7MRW8oiswNeFC4+bTydF14XYl3QKpY=;
        b=A0boS9ucUs7OtO73TMIzOZtnOGwTUJvdPxmaL5s09Lo1K6JJkNCJLqMH3h6DXU4xcp
         M55elhjJpAskdFlaUUJbaBaa1AyAO6C/VWZ9Jur6oI3pRgh1RNoC9fdlR0ZmBPdFDoQx
         iqr2hTRX2JaVbdXoB2BzeY4bJRSrcnwM4J8X9tToVDksU1qNFTmg9iCQA91MtNTjMDeh
         kXYHWOmieCi5XiaJyt7IKTT/npcOl/8Z+rbaLLS4XzNyPK4/qjfmQMap9PS7hFyGBHYV
         NhG9PyBaHoPEB8O54JlBenZqZX+fsRP7GVeHPhQY0xdppvnCwCpdNfhff7dswwBaT22P
         HBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745590041; x=1746194841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTh8Z/xT3HMeK7MRW8oiswNeFC4+bTydF14XYl3QKpY=;
        b=I5vfN0gggcRkoNuf8jOkw++EF4yg5i1CRefW2tPXsMnpR+U2v94wUJzoc+yeNq4qya
         aUw/PVMwHS5dWrBF332WVBbZTWRWWGNvZiGpZ1YqlbXh/tuITj+BCz8j4vX/MTl6FzxD
         JHtsKqB1lUWL4+xPp/5Qy1Csn9v+ANkdEkrBicRfqsmzZjcD/6VMeJJw0pJT6WLqE1lh
         9BWhKJTiSroKOU+5dwDyrPipDmfP3ldVkbizxjts78136QGehpksnm9SOMiPUHnyajfP
         5gZV8uRA8YABuydkk5DxE3HoVMqK8ib3+L9mgdjvRCjxIJJ0BldA3pbG6sYpBIifGCxd
         QqBg==
X-Forwarded-Encrypted: i=1; AJvYcCWH/YwvgU3XRSwq9AmQBmkoe/zn41fJzrCZomMdGtiWyqtPuBHEAXjxI3Ma7eXmxB9vKmPctdnK@lists.linux.dev
X-Gm-Message-State: AOJu0YyrDGgYZ0X5sybJ7AqsQbm3OYIJX3plea3hbzyTpMI3C03sJNcO
	BwJ0A8Z3WR/PIxyfK1l96ZvGSWZyu/7SKxXN8+6XzLE2u/3tj25W
X-Gm-Gg: ASbGncu+64UWGqHUYYc3nv+4wh1f4jaPTU2yOvpZklVnLNrS0BH82Zc+SPUHBl+qdBd
	8T9MQxsjkki6DNM7axiNhholCdxEg25PbKKpWzZE5JkDjGB4i74GcpRgcUc0aiU/haRsrT0hgT8
	dpUAIHIXR841A/a8i/3QZotNjge0k9mXqZxatHCUM+ljOvO/AfYPRoK6Q4ZuScFEevyJ3UezO+B
	RRaOfp5bjUnGTFluHLxJnQEm4FnfWBOyXebX+Bfdnq6kHCu8Tl3ljqa0m6+2GeNnG1YvJsAuGyY
	moN6vxQHYYlIdcZA8360l9lJakTBQd4TGtFiaAfSDrhPIaybcJqpn88XCPuNXX/drOKgjN4x2I7
	VINe7lw==
X-Google-Smtp-Source: AGHT+IFo7N9sdrJMBuAUxryOH40giOiXiR6pTDO2SwZ+Gxb/eMpNnyUnBTMwGSi92MLfchWQ5JLnHA==
X-Received: by 2002:a05:6830:3910:b0:72b:9140:f6d9 with SMTP id 46e09a7af769-7305d0107f9mr1403708a34.4.1745590041073;
        Fri, 25 Apr 2025 07:07:21 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7304f2aef9bsm699366a34.34.2025.04.25.07.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 07:07:20 -0700 (PDT)
Message-ID: <e985bdf8-7abf-4d54-83b1-b52c22069e67@gmail.com>
Date: Fri, 25 Apr 2025 09:07:19 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dnsproxy: Fix for CVE-2025-32366 in ConnMan dnsproxy.c
To: =?UTF-8?B?7Iug7Jyk7KCcKO2Vmeu2gOyDnS3shoztlITtirjsm6jslrTsoITqs7Up?=
 <ioerts@kookmin.ac.kr>, connman@lists.linux.dev
References: <CADiHxDFvu+0uOKuMQrvuz69DwW9aH3ECYg326dfMy7pewj-6dQ@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADiHxDFvu+0uOKuMQrvuz69DwW9aH3ECYg326dfMy7pewj-6dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yunje,

On 4/10/25 4:11 PM, 신윤제(학부생-소프트웨어전공) wrote:
> Hello,
> 
> In ConnMan through 1.44, parse_rr in dnsproxy.c has a memcpy length
> that depends on an RR RDLENGTH value (i.e., *rdlen=ntohs(rr->rdlen)
> and memcpy(response+offset,*end,*rdlen)). Here, rdlen may be larger
> than the amount of remaining packet data in the current state of
> parsing. As a result, values of stack memory locations may be sent
> over the network in a response.
> 
> This patch adds a check to ensure that (*end + *rdlen) does not exceed
> the valid range. If the condition is violated, the function returns
> -EINVAL.
> 
> Patch diff snippet:
> 
> @@ -997,6 +997,9 @@
> 
>    if ((offset + *rdlen) > *response_size)
>    return -ENOBUFS;
> +
> + if ((*end + *rdlen) > max)
> +         return -EINVAL;
> 
>    memcpy(response + offset, *end, *rdlen);
> 
> Please review this patch and consider applying it to address the
> CVE-2025-32366 vulnerability.
> 
> Best regards,
> Yunje Shin
> Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
> 

Any chance you could send this as a proper patch using git send-email?

Regards,
-Denis
