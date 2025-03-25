Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDC20E30F
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921613; cv=none; b=UISvFz0f0Yy3NjkJFKQXBArFOgv/bUrpZ5iTZtqS/vUOQQi6BjAF+xButck834vydE15DDpI6Bl03+LKkQ9mrN8JB9PbILoZ4Jcg3TYbDRCusAANmslJLgtEA7Sn0Nfw8zsnnj0eyDYMQ+YZGj5EcabCOLBm0CHwwVRXTBlmr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921613; c=relaxed/simple;
	bh=eafoiSD1yr/41f9vfH10XdFWqRWK0B2bGFVZnLA7Eas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLOayH1t4LlpyKqCdYQYeGsQhdUd4oG7z2QXYpeJvnIQgBP8FAnPKrM+SUOxFtrFGLX6HDkvnx0vufYEmu+FDKM8QOY3pg3GxDyOVjS4n93Pp3RMym/ouqoqtT41usKJBtZFrA3x214FVwUibSYWA4R1rzpYFaoPoFYU0tk8uis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiZOw098; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiZOw098"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c14235af3so2443267a34.3
        for <connman@lists.linux.dev>; Tue, 25 Mar 2025 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742921611; x=1743526411; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ajktf1IUDkGrNZCIrKlL6lLBjQ1PEzgM5op70HCqom8=;
        b=AiZOw098fuhmEYipPiKgsXZRQOiRkVWNYIJl6o6AsHdas47ufPzKLh/q0W8a7/7oVX
         PMuiSSo29VCA91wM83rHYGy5AIlCVvcRuHcoxHw3fOREWgAckmHMkQkBcZAs5/uM1I5Y
         pOUZ8XKOypYtWmbi61i64d+b12q803Xdh6U6tU+AKBFLhlvndcY8CdjgYU+we69XAwFT
         AVsTa8XdX/SQlxGLL5oY5Lr44ZGunpAiGByg3d/65mrC/2rp57JzS3JExHNowASPoTmG
         oLG+H8FBS7NFdXqedbHhfktUrW3hvtKbjI5+LhjDfmF/YxZwnOjDO/oMEuAKgD/mjDpf
         IySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921611; x=1743526411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajktf1IUDkGrNZCIrKlL6lLBjQ1PEzgM5op70HCqom8=;
        b=QKWCAPdAnit2ofLEqW3tXt7MkG0gbrWRVhg/gIGB4eIJaL1vlNZmgzqdmEkJbjNxWM
         kY6MJEpJMZVQykdFhdEtS8LM0jR5d/YUJXd0EVpKTbvFXdXA4PN3WWcJJDqzrNmEZGFu
         Ug5BQmGiNSWmUREQy8b5YcfxAX/JmRdkzMEzA5A9ZzINz08rh6P4M33/o212DU1HYGOH
         IfccALaf5c4hrJZxOqquqIvQnCQXn5bLTE7516NEmqZq1VdTIEpBPQR69d33mRcMuMxe
         UYKFaGG9EvZOrWl9ZviW4hw1E0S3htumsVkZHWce4NAHNdBoDFTuz8tOtRgpANKrc7Pq
         PPcw==
X-Gm-Message-State: AOJu0Yw91OB5+R6OttFCqKVBxWJpwB1Ay+Q6vSiKtwFc/wNPSgo+KlVC
	XosR9EaoIfBjUCuApuj0u6Yrw4o9yF7IYuFz9QyK0NyNAQIji4Hi8EU8Lg==
X-Gm-Gg: ASbGncvtD1wHYTBQuBFwYZwUO8nNiNQCuNseHOoHRstMQKl1eJbrS0544v9cDWQcHRW
	9mtbV4g6BtGzh1xEvbs8hmbkhOvqMg7+lDNo8w/391IAD/IYl0UQKlq2A7MSBkax9y/Ta686hvK
	UP3gBWeIUM22lacvPe20+Fv1pMJ9v021fbbIiyVnXiETozTvbSp+6T00shMrB9fuRuEdERe/oYm
	GJY7/QT185Lf6YJJxVbk5sPb+/rQmLzBF3aAIV/1PC+4n5Iz2na/B3lGCx0yakguY6/8Vj+QoT1
	2ObSxbfGZrBP0pVI3tce6upXHIyIN4+VaU2r05MxkXOvG7GwOnDLkfFsXptNIE1Ns3rklyLk9TB
	2nI9DKf0A8g==
X-Google-Smtp-Source: AGHT+IE0k7nu07gpDxZdjWIdNlBS4+7HB1aAyC4y5b6hKB6ZMkfYUZFFk4pdO7hbHVNt1Am8rvnOCA==
X-Received: by 2002:a05:6830:3686:b0:72b:823c:8f66 with SMTP id 46e09a7af769-72c0ae6a3b3mr12675042a34.9.1742921610878;
        Tue, 25 Mar 2025 09:53:30 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72c0abb941esm1986182a34.16.2025.03.25.09.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 09:53:30 -0700 (PDT)
Message-ID: <a4619dde-3046-4ee7-b707-755a21f2fffa@gmail.com>
Date: Tue, 25 Mar 2025 11:53:29 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] wispr: Refactor 'wispr_portal_web_result' to
 leverage 'GError'.
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
References: <cover.1742878567.git.gerickson@nuovations.com>
 <90cf71d0585440245fc9f788fbbb460a0c210f56.1742878567.git.gerickson@nuovations.com>
 <287e3eb1-a5bc-4976-b670-491fd7a7eafc@gmail.com>
 <73E10B6A-822A-4950-A698-F545E93BB1DB@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <73E10B6A-822A-4950-A698-F545E93BB1DB@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

 >>
>> But now you have a simple return at the end of the function.  Which by the way is discouraged and should have been picked up by the compiler or static analysis.
> 
> I tried to keep the original block of logic as-is.
> 
> Personally, I’m a fan of single points of exit—so much easier to audit. But, happy to keep 

Kernel often prefers the 'exit-early' approach, but this is situational.

whatever style is preferred. It sounds like the preference is to replace the 
prior ‘goto done’ with ‘return’, correct?

Rule of thumb is not to have return at the end of a void function.  Static 
analysis will for sure flag that and I'll kick off a coverity run once I get the 
rest of your patches merged.

The question really is: Is the now-empty-done label hiding a bug?

> 
>>> + g_web_parser_end_data(wp_context->wispr_parser);
>>> +
>>> + DBG("wp_context->wispr_msg.message_type %d", wp_context->wispr_msg.message_type);
>>
>> We still use 80 character lines, so please break up accordingly.
> 
> Surprisingly, checkpatch.pl did not squawk about this. Fixed, regardless.
> 

The default is now 100 for the kernel.  We're sticking to 80 for now.  Maybe:

   --max-line-length=n        set the maximum line length, (default 100)
                              if exceeded, warn on patches
                              requires --strict for use with --file

works?

Regards,
-Denis
