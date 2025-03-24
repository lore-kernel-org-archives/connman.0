Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3EC18DB3D
	for <connman@lists.linux.dev>; Mon, 24 Mar 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854549; cv=none; b=NytzU/s0FgD07e2pW2xHI6sx261mJHZgFqofZ8Cs2dDly/D2V83iDvRWkRBbTsjP0XN5hJvHjlrt6iA2EnIYcMcOx+Vwq0chIMnEkTyjNmFgwEv3+TA9YbTEsTASAOkgjlbg2WEiLR2AUQ9RzxClh9Qa0JosCNiavM1gl98qsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854549; c=relaxed/simple;
	bh=0dTupZ2NwZt0Jqng2Iv+GDDKIr9jzrGkABWyd8Hw13U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QhU1drL7/fxYBKRjtxu1A8XlJMcJIpBw4RldN2kwYG3poJspUJrKgQQY90D/UEb5zPdCxxTVqxzm9HnIfmQYnqfgYO2nSk2Jnpa29qv7BbMZEJBNvlqHlCHRaGAWuvP+OldC9DEbh3XJoW5449aJfzTD7DPk4QsFyNgjEJcEgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P326uHPf; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P326uHPf"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6025007e9a0so194430eaf.1
        for <connman@lists.linux.dev>; Mon, 24 Mar 2025 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742854547; x=1743459347; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glNrzEDRtcgcb74mTFTlXjaR4yNS3SVGBg/2fPVjqxs=;
        b=P326uHPfe4aEIE1jpTkaRE6+3Heu31xgNSFCN63lqkAt9AQ31HqumReFJ+Ztnol8lH
         y8Ya+lQEz6Rf2NX5VgxBEID+H24XZQqRizjLQqH28xhbdYzFddIm++2HWpBFdt3z04kC
         h2nm3nw82BS3a7KwGb7B5c7ER2XewGEkJzbtiTtZu95Lxp6MG/P2nKDT2sXxTHmnwtv3
         ZWgo/myv0xPEGpNhZwXZr58zvUw3ne8b5mhimXZPuq6duK3Gn8bvZ1akqdUEiEfKW0CJ
         WEr6r565S8igD2vcg+KdyVCeDm55vGTbvrYECH+ieZG0NImpTviumyXE7GTseF3TGl9M
         Lojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854547; x=1743459347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glNrzEDRtcgcb74mTFTlXjaR4yNS3SVGBg/2fPVjqxs=;
        b=FWSRFKQEED1N27Wz1jqAzEJVtIfpti6ndBNlyEnE2+PxWvFkv9F39r/k1vtW0lXMls
         nhOPqW6IhBY8zdXwjbzyStBMQ+M4+Drplv7b7k43Mow30fwx7o7gp16IMLKcifHN/lBG
         44MX6/GbmvM224LXHvyOm3eOU08eYQh5rE8/zO2N6W3ju4izbnv9SqRZRfNFm/q4QQIT
         0mPi4Fs4B7DFb7Nkx03Y1XcwpbN6Gr2ufF3RyXvPFnSNGSRb8CxmsgGKh2XjGctnow95
         JQj8ZDGJ6IZP0R0YNcLHG/nYHOswsyzAP3DjwWdqudNzqLDOZOu9BktAj3rrcnPgfXHe
         6GCw==
X-Forwarded-Encrypted: i=1; AJvYcCXMvEWnhNPVEVVCcszJn+QZb51RFPVtamA88K7hxODgByb/2MRHTjwO5LW1FItleDXEE+kgva6Q@lists.linux.dev
X-Gm-Message-State: AOJu0YwTyuyHe0ZNPd+GQu2+VJh1tBQil+2gWq46ILDuXswQqMoICGVB
	dtJWKqvCMgq80QaG6DvVbNdRinLm4IN6rF50MUz3ISxIu79oZAkP
X-Gm-Gg: ASbGnctOGw9LB8rlBkjwTRhYL409gk1K8eVUAvSO9Qi1BrQqjP68yfquEQy5e9zyqWH
	Q3qSmxeGqI6GXj3X2ALIvXVu2vSIFcFL+q/JkBM2wdq5sJieXIfTEOr2wZNW/sAIBL+lIymBoE1
	+5jmyuIqdWZBN7hpcH/kRjMvFtA3ZTM0OHnj9P5Pf/Z8fiLbj+MHlSLhvnflO62y38BXV09xFmE
	BNiqvs+rzcfr2B9rxO+w1LW+zuIIBUIKlcXSR0nUkXJfNcQdHWhjStOse/rYwgAVwTNiF5mAv4o
	UjUwO9KpF4W3GlvybwcKd6YhCsM8uOIdkPvr2GcWo4TujQLZmutnpplVD0p9uhSYuDzf0PTwYPU
	UdR0CvUf0Mg==
X-Google-Smtp-Source: AGHT+IFUpz4vuWQfrUqZcLwDkdGCWmRfnxzF+SidEY4xUBXS93zV0X8a+l+ySMnZ9RuZANAFqI4oGw==
X-Received: by 2002:a05:6870:7a0d:b0:2c2:5270:f182 with SMTP id 586e51a60fabf-2c78056f79dmr9040034fac.39.1742854546632;
        Mon, 24 Mar 2025 15:15:46 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c77f0f4105sm2218740fac.47.2025.03.24.15.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:15:46 -0700 (PDT)
Message-ID: <99b428ef-30b7-4ae4-ae18-53e11822bccc@gmail.com>
Date: Mon, 24 Mar 2025 17:15:44 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] build: Require gio >= 2.40.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <cover.1742513884.git.gerickson@nuovations.com>
 <9aa482d85c931c18f59e11f1f62f543dd486aeae.1742513884.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <9aa482d85c931c18f59e11f1f62f543dd486aeae.1742513884.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 3/20/25 6:38 PM, Grant Erickson wrote:
> Required for 'G_IO_ERROR' and 'g_io_error_from_errno' used by GWeb.
> ---
>   configure.ac | 5 +++++
>   1 file changed, 5 insertions(+)

Note that g_autofree requires GLib 2.44.  I've added a commit for that prior to 
this commit and amended this commit to require GIO 2.44 for consistency.

Regards,
-Denis
