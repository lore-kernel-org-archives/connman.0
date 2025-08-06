Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C37B27146E
	for <connman@lists.linux.dev>; Wed,  6 Aug 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490582; cv=none; b=uWPDEvNIN/aWc8de6DKlTZgk/be6LT/CKo3Q/ItRXuRQ/+TeS1fHYwAljOBQ0OboTj4TiT3OEVM6zi1XhEx7ecdysT62tOjeSrcZfrsKPze4ygDrr5rTmihtcUWt5FUJStMx43p9KW7ehRL3hOGjWSRV8lrDqGptY4kDEzFPF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490582; c=relaxed/simple;
	bh=7zyp1eS9aJOVwG9onJqOcmL+EToLnn3cFzIDHo0hiYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ciYqAb8MoyPd/dbpQ62Oy3ITFVkzkj8E8QxjQwEJ4mma/LaHifGYfjQ36y8cPxLd+tU1SGwjkVxQEZGpKpJFMAjU0Qg5nTBuZIBXKxh2En8ir/3hWwtrUc2j91P3RGJVhtq6x/m80S2W+zrxOMY2cwR5ZkyZWBB/eC2kttCs5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzhUUreI; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzhUUreI"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2e95ab2704fso5570529fac.3
        for <connman@lists.linux.dev>; Wed, 06 Aug 2025 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754490580; x=1755095380; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1hP/KAgmDPNceTJFmoA7Xnm+UQgZ2q0KotAPuHBdGg=;
        b=JzhUUreIXoypX26V3k6lLFEtJsyTeEzMSAbOC0zWYxbcaMNQwwSlMAUpd+aZAoOnyd
         ay2o0v85179F17wa8qBkI9BvEhRzUeUswTMTgwFOjypuxiCkOO9txov6Zr9kaEgvX6Ay
         FYWoJ+JTYMvL8EkVYUX9y1kh2lS36OZ3DlrZzdrpFa+xN0TW3NVPGBOi5NsAnh2C8Oov
         GmMwSz8xSDHjrnDKKWj+M099jj7yqwX/+8qwDCCmcyRbTbKz1lhdAvLSFm1c1b55k0Vv
         fzDKL4VpYObhWCVJgWMKKNXKboEPUpJPz4tIAJ7E0TK/gvFXduDxv19fUzI1+oVKS3zn
         OzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490580; x=1755095380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1hP/KAgmDPNceTJFmoA7Xnm+UQgZ2q0KotAPuHBdGg=;
        b=OMHPB/OWAwLnDVfVEWlZ4es9hC9uTT4WIzqPS0eMgLIdbGFtCMbqwv3rHoKdj9j7Qb
         X8TH2VGziBGP22Whwc13Wwfwcp43aQN752U0fflhv4XSm370THI7CHLq07LRfynDWFYs
         22yJo8XddsksDnaS8NL+Pwtvrw0Xi+vRA6+8CG6xvYgMo2Zx0uQeWC+2z+4F0Mbq/wLr
         NZvy1vhkzx2EEWHeOWzjpsOUH93dozajzhdAJqnsnNe/mUsJV5Uqu4FpNCZUqeyHXPfc
         s6VPa4lyb+IWjrs0EsNnUXJCf32B1Irr6+4r0knKus732kOsFzKpo/lo5HgiVied6vmy
         QHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSSs9XRKA4/vg8a5Q3GlZCtAUx0ObZXp+B0kxpuyb4pFFl8T9AfVW0Uoz0I0nFAJgDwI7naiPv@lists.linux.dev
X-Gm-Message-State: AOJu0YwQhL9aOk07kSBv9e5XtYKNtzyJMQ/N/CsZ0dOoxoV0d2CMQwAQ
	f+Z12DRZpBmI5ikLMpGwWH3yaXKvZsHIhrmr3sZwMNfK6LYrzUdYfRQDS/0HBQ==
X-Gm-Gg: ASbGncuy2wk5Qp6UGMJnEmJPVEnErrxvtQkKiFM89AHI4I/K5UliruBinJAcXF7lFa9
	N3p61STqA1X+BHgFAX2dgMK+2puIRbDm9BuwPcbVe34RgzX7+xtG/ZHpXrrvLkkpgaBJ6u/fUcn
	5GBUMQhFBIjxNDrkJPw+jjqdzZxyxpX9+oK9yEziOt+XEZSx2k7d4cYL6puiJbmUJs7/hNhOigz
	xgueP31kDK/3OCPs3eTT3JKqjPtYnKKZuYjbKUqoE8gU1M8+jNskpFAF5mI30Co8lfoe8xoIrDe
	JmNWvkiG2ckRqDo1WmDiiD2kH0b3QPsDARYA2OFO16Al4WFhMMOreRWobHqTDjqwEe+k8IKHSly
	XfO4khb/IuBIaGLhjmjXU8TL2Ih80THwFdlPl4qhIF8B1fN3Ln0KH7a8YpzaQYqLGat6qN9MYJn
	c=
X-Google-Smtp-Source: AGHT+IHXhzHHcg6R0a8br1lpDf9WYAQk/vwV8W+N0gpQlZbReb7FeRx+NHR8ukoztQGaxryKRRRzng==
X-Received: by 2002:a05:687c:143:b0:30b:6a26:5193 with SMTP id 586e51a60fabf-30be2c6ff38mr1380022fac.37.1754490579943;
        Wed, 06 Aug 2025 07:29:39 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-30bb72e77ccsm1563875fac.2.2025.08.06.07.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:29:39 -0700 (PDT)
Message-ID: <a61b634f-412f-4e45-be20-935e1a5b73c7@gmail.com>
Date: Wed, 6 Aug 2025 09:29:37 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: connman configuration for combined wlan0 + ap0 devices for
 tethering
To: Adam Pigg <adam@piggz.co.uk>, connman@lists.linux.dev
References: <27032848.1r3eYUQgxm@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <27032848.1r3eYUQgxm@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 8/5/25 5:43 AM, Adam Pigg wrote:
> Hi
> 
> In modern WMT mobile wlan devices, there are typically multiple netwrok
> interfaces for different purposes, example, wlan0, wlan1 and ap0.
> 
> wlan0/1 use for 2.5/5ghz access, and ap0 for sharing/tethering.
> 
> Is it possible to configure connman in this way, such that enabling tethering
> on the  wifi technology activates the ap0 device, and not the active wlan
> device?

I've never actually tried.  Hopefully it does?  Multiple devices of the same 
technology should definitely work just fine (e.g. multiple ethernet/cellular/wifi).

Regards,
-Denis
