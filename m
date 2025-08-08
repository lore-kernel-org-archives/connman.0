Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC3280CC9
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667556; cv=none; b=Hm/axwzDyaWPc2qRbzhaKcA/zspdJ9hC2frL8RJxp5zYROnbWTGoZCHDvCncME/V3xKxYuNfWUxpwO0J8DjNnkyDfPyiB8gG68M4ZrjpJRoaDZ+GWk0cOIzczd11Ym3gLXLwnfpqLMpUnkLpE5ckobBrBZ5pTQKgmpohep5lRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667556; c=relaxed/simple;
	bh=bZiDyw1BaoZqpBUznK2IxtQpASP4UJTvoUOi6goqk/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qA/jbjE5T32CxsMV/ovo6e+zrTqkzvAnrNJRHdFeOL0EPk+WyF6wTOtS7iYUmveYmeouZJfm41eqIJEZztYO5D2cq0BgaoRw3Bv4AC0rk5Wa4NpmrQfT+nnQqzatI8oW34gjZBRiL/hx81xYgUSDBSFIsWX1auOl4FNVPdvKAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGMdqTKi; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGMdqTKi"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-306ab1b63fdso1328456fac.1
        for <connman@lists.linux.dev>; Fri, 08 Aug 2025 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754667554; x=1755272354; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1kjuazqOUDOSMHb0F/O63OZexLQyyUy5grtKKAZ864=;
        b=jGMdqTKioo/esR1LlHPyMDgEdYBJ70/HPlGd0reMUGquw9KQg4RdCoD6HPUWDHJUpS
         uuTld77pqlTdWI0wmPRkjUO5ctLy2076zRU/v+UxFVK9pTYCqlWsNwx2C7RbDrNdieaX
         sXZ/MAeTD1ybRvVVqxckI04mEJ1cUCwKXoEv77yw7KlSMGP6PFjbEXeHvO/sDXBMCpkt
         lwr1jJerb8tNFXuSFMl33TaFit7yNOYnhQiad1HPSijs/Z0pFtga/fYKPbf18r/pao3N
         KaGTUK9IClKv8mFFpKqmn66QXd547FhP5Fv1D3ZpxSyTUDRACcDLgrCNUvJ3uxz9SCMS
         82Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754667554; x=1755272354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1kjuazqOUDOSMHb0F/O63OZexLQyyUy5grtKKAZ864=;
        b=L8tfbrslt60RLpm76hHGrvjCQxeaKs4mDOVDsPhFl98D09r72sTs5UpkZawQtsBJ8Q
         RaizBqtFD/Fo3XgczCw6Ls3SAvAm7wTok9pgOicS6Fw6/Zqxqk2+fZSM3w2C+/yv55If
         FSrKvlEHggFqBbeH7VUUUdEuP2bAzOlRhanjyB4zI8VwrEtFxtBCjtYP2oAL1JrFvWzT
         zHEf9/HbvceaxIjVZHuHOwzdtXBloo/vR8LYnN541+PyOHNkOPJaW0XxEwE+pB9o3yyO
         B4ADZwBCUdCPDSihLFxshWP9Q3syAIACBNpkCEiqU67xiIx5F+1p+jzCmZpBw+g2glZi
         YZBg==
X-Forwarded-Encrypted: i=1; AJvYcCWspa3Xkvr6Kp1yezzGqy4BLXTOeUD7tECHWwMmcNzfHUjmwDUlSI6ofTWFnZu/3wMO1CGaZOo7@lists.linux.dev
X-Gm-Message-State: AOJu0YyrubZVFIvNBRcAxssrVCeB+4SPFkhyY2mUDedQe85l28BphDcN
	jHPI9a44bIeqalgcpz2tqBKbn6XArqAv3z7DoH0YgfiKy7lWnTNSwQDJ
X-Gm-Gg: ASbGnctBh6m/lUiYSQpdmgw9WpykHuqQgZ9SgMYWSTzZ/y/UgpfONE72rCaBLJacLBC
	rJUb9fcwbNX/5YR+9+nnDRTUHxdFsSevNOSwAWRDtBiubFySaE04NkQIDo5I1qKo6Wkr9WWZVIr
	u/RIOYoo/7pa5d3w0FVDCoLGV0vCUrZXSMngL9jurmbsd5H7NfKfj+wy+nKjJ5FX5amQIX0se9G
	ABViBeyH8oOpJVfo9KvKhaG1JC09T8pVG4AF4qLwe55MWUFFtdE76F5CE0Jgvv6VPwCLha7+5Mu
	R4j88DxtHVYUWJ7UHUTOIlNVORWsMpRKRedBEDZNy3d6fFn/1dYBBdwGEaCxB1DuCcAC+4Q1xda
	fFZBB7j+fh1D3HxaWwxD26g5ehwBzbFr29+BhUthEdy3q9KY/6NiMU3A8wH4wJT0kXoct835NQP
	I=
X-Google-Smtp-Source: AGHT+IHkPKrcN5Ru/kEy7AOLrtKDf3iNUMcPT7e4uJcRHI+adxOa2ZV0qoe1IQhDjhxEnpov3B/4ZA==
X-Received: by 2002:a05:6870:41d2:b0:30b:dc26:41c5 with SMTP id 586e51a60fabf-30c211ee27fmr2075288fac.41.1754667553694;
        Fri, 08 Aug 2025 08:39:13 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-30ba8228a79sm3384390fac.35.2025.08.08.08.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 08:39:13 -0700 (PDT)
Message-ID: <aa8fc0b1-e386-4afb-9f2f-d9907f9864d3@gmail.com>
Date: Fri, 8 Aug 2025 10:39:12 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/45] vpn-util: Add wrappers for GResolv hostname lookup
 use
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-18-jussi.laakkonen@jolla.com>
 <c4b5a272-a47e-4644-8bc4-7647f6ed5d40@gmail.com>
 <5be890a9-66d0-4475-b2a2-b881859f9aa7@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5be890a9-66d0-4475-b2a2-b881859f9aa7@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jussi,

On 8/8/25 7:36 AM, Jussi Laakkonen wrote:
> Hi Denis,
> 
> On 8/4/25 17:39, Denis Kenzior wrote:
>> Hi Jussi,
>>
>> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>>> To avoid linking GResolv with every VPN plugin that uses it, add wrappers
>>> for the required calls in VPN utils.
>>
>> This may need a bit more explanation?  You're still using GResolv types in 
>> these functions?  Why can't g_resolv_ be used instead?
> 
> I can amend the commit message on this. The issue is that VPN plugins can be 
> either builtin, external (or out of code tree plugins), so making this wrapper 
> is a bit more straightforward by linking vpnd only with gresolv and having the 
> plugins not to care about it?

 From a maintenance stand point this is not preferable.  Why would we maintain 
extra wrappers for a library that is in-tree and we control in the first place? 
The plugins should link against GResolv and any issues should be solved at the 
build system level.

Regards,
-Denis
