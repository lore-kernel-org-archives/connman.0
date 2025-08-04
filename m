Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2722B8BD
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333713; cv=none; b=jKLFY5n+i5Xftpl4Ly+KVjQSENlZEXqWfytW9ptF2H3XknZPb9aEBMawLzxgTpBCIOEBtFzUC+nzJ4dHyiF4YORo0CTNQAbKTH9STzrH+Smibn/33PhbAadauopf1nLZdJH3WgO7BrOAwo/JHedKsEq2xtJXJYsoz8jd5HfI+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333713; c=relaxed/simple;
	bh=6Hta3BZMZ3RR5izRIyYcNk3fdYv1Sm2+VIeFLWaigMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhXGsdloAPs8vdER3nGllnT4rpHO1Wihyx00Y7RWB4Na95Vg4al/VbyuAxbwpWwRuXUmL7JqYJad/QVzlfU0RSx8a6QWVzauYNjaAascW58rxnSsaTHGIMk2YYoQSUr3ZuflpxfsnjfErRn6+6DSVelr/Lgzf1wio7hKQYgwiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHXO2fAQ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHXO2fAQ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30b7448b777so1620346fac.0
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754333711; x=1754938511; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNP/a3pjzA5hEP9ShT/5S1HXmTaoOVGCU9/UgEMsYUY=;
        b=iHXO2fAQ5TNOKezgPOgAV2RgvpWDzAx8n90XsLrZQtioyHTcP8RmJrqjF+bjptheFp
         Gh2k/8naIqud6LLy8NNv18Kk0TOCiyEBGC7Gg4KTb5WwQewRhj+14yMQRJ1BHR2LHTxG
         HaFbpRisBalewiXJjSk+Z8/TZkisxJt/Egu4oecfASof0vdzk7VkT/Z2ftJhLPwziFor
         HVde6YQpQdtydOSuciIayLO6FKprq2uRHnE9jVPGmaHsgvlq1AmxjhMfyyt0haAa1Ix7
         hAeYpXKQS1IO7makF3+NbJmIg53yDphIOcC5KsETLSZtO4DA61UBeSiXlgW1PfKGNrhh
         qGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754333711; x=1754938511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNP/a3pjzA5hEP9ShT/5S1HXmTaoOVGCU9/UgEMsYUY=;
        b=P0/qUu5XF4OXm56Dwlq9bH0AQEY/sYyMbYQejw7bv+K31KsTS05B+1WnlwOBs73jY2
         LF9ghCbqUYUkWOLUHiZzp+OL9kGQuCucMalBOvLkjnl6kVsSzjvMPy3HVSw6DMGQtQB6
         BPJwE/UOwM6p8WiP6UNoccquBrqcJZ+LKmvDnAXfWs5C5xTxF391mQ4ODumZXyUy0ZWv
         tr6i1+rMvRpgNocCMN0qS//UrtQLSHuIBoKGzNOOhEMIbNwcEoyjWy4H5/PrzX8LD4Po
         kY1G4/EfQTGk+y76Op6pap43B/K6p+7pGGyRAWufEH0Jsv/CBiRIy4I/3Fzo8eOXx9v+
         6ULg==
X-Forwarded-Encrypted: i=1; AJvYcCUJsNnFNTO4M1DN5GQXKAgNAWg6lpLrXApO85MjCYyPm0Xcx/nBaIgB8nCXk9L0K25vou3U5iff@lists.linux.dev
X-Gm-Message-State: AOJu0YzGWuvgRFW1pTw+0iotkXQToFZqcTUBNy7dCWRybsj853yLMwil
	aD6x8IJPu0Ts7V+YbwA46QJrRKkfLodd4H4rpKzUG2OyIV0/55DVLtJ3Mi9NgQ==
X-Gm-Gg: ASbGncuFNR3ua5Ym5lk+E5aQYTxlSlKvmIVxog99TlHXacTUA+Ui+V3Zw+7BlXPijSZ
	sph46U8ujSiOtk5AoLabVbdwbaThatRs6c8GMdAbArw5pilrNuo0nfCRzLppteFTvrYCjSo0OzN
	VFvwHGSBGynRHfFXjNDzShnvOf/7UGgwVRhWKL9wtnRO0pVREVNdyH8D+BOEQ6fsmJknu5zz+cb
	DxDUOJOdEZjryHw7mK9GicTQE8A0t69siD5KlLcT67Mj0IpD3oSqiIG+hDIDL2Ulh+KT7YS2OPo
	y8oo8HEAr9tg62XPRHVKljW6ZqrZ0xaOLwroK1VsvP2IIoIUAqCbKzwPP4YCt8SCpFzOB0jdte6
	VfuukYhDLprgheb3dcyl5yeNodEAPirWu+XUJK3vfxemxPzkkRJw83AEuD4xhkZ182JDg9r7luu
	Q=
X-Google-Smtp-Source: AGHT+IG2qgqRZiS0j1X4QF+tLh/bNHTp9qXMfNd45RNKnRL/gH/MRjOnwvLTUdsOu+4bn1HkXLAtNw==
X-Received: by 2002:a05:6871:5317:b0:29e:1cd8:4a0f with SMTP id 586e51a60fabf-30b67717343mr6497911fac.17.1754333711090;
        Mon, 04 Aug 2025 11:55:11 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-307ae88a303sm2695431fac.5.2025.08.04.11.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:55:10 -0700 (PDT)
Message-ID: <c37267a7-df36-4354-a63e-f86c194fa0dc@gmail.com>
Date: Mon, 4 Aug 2025 13:55:09 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Adjust printf(3) formats for 32-bit platforms
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 connman@lists.linux.dev
Cc: m.szyprowski@samsung.com, k.lewandowsk@samsung.com
References: <CGME20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a@eucas1p2.samsung.com>
 <20250721141712.796989-1-l.stelmach@samsung.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250721141712.796989-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

On 7/21/25 9:17 AM, Łukasz Stelmach wrote:
> On 32-bit platforms time_t may be defined as long long int to make it
> 64-bit wide and y2038 compatible. On 64-bit platform with LP64 data model
> ABI long long is also 64-bit, so it is convenient and safe to always
> cast time_t to long long and use %lld/%llu format on all platforms.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

No Signed-off-by used by ConnMan.

> ---
>   src/device.c  |  8 +++++---
>   src/dhcpv6.c  | 10 ++++++----
>   src/log.c     |  2 +-
>   src/ntp.c     |  5 +++--
>   src/service.c |  9 +++++----
>   5 files changed, 20 insertions(+), 14 deletions(-)
> 
> These adjustments were made in response to gcc complaints about improper
> arguments for printf-like calls. I haven't checked manually all the
> calls in the code and haven't changed those which were not compiled due
> to #if-s and #ifdef-s.

Makes sense, but the patch doesn't apply.  Perhaps you're using some special 
sauce on top of upstream ConnMan?

[denkenz@archdev connman]$ git am ~/merge/\[PATCH]\ Adjust\ printf\(3\)\ 
formats\ for\ 32-bit\ platforms\ -\ Łukasz\ Stelmach\ 
\<l.stelmach\@samsung.com\>\ -\ 2025-07-21\ 0917.eml
Applying: Adjust printf(3) formats for 32-bit platforms
warning: src/device.c has type 100644, expected 100755
error: patch failed: src/device.c:896
error: src/device.c: patch does not apply
warning: src/dhcpv6.c has type 100644, expected 100755
warning: src/log.c has type 100644, expected 100755
error: patch failed: src/log.c:149
error: src/log.c: patch does not apply
warning: src/ntp.c has type 100644, expected 100755
error: patch failed: src/ntp.c:406
error: src/ntp.c: patch does not apply
warning: src/service.c has type 100644, expected 100755
error: patch failed: src/service.c:844
error: src/service.c: patch does not apply
Patch failed at 0001 Adjust printf(3) formats for 32-bit platforms
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Regards,
-Denis
