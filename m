Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E419343B
	for <connman@lists.linux.dev>; Tue,  5 Aug 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408370; cv=none; b=WSjbCNeQTfZJINOtDPQahc1GQbXOa6jLJw4fA+HRmRFr4wLvwD6d27i38LNP5qFCKB36ah1WJ2ZRomnpE4VxiuJx5Eoyb/ylKw+3C7djQMr2didMx3aeYuvIUDKo0+N9BwvsevCar4WKS3zRAtGAc3okZX74W/nGwVPdnI3CGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408370; c=relaxed/simple;
	bh=FjuGTjYpn0uJzDmM47e9bCzzp93W1IW7+m3Aku115D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cg2pObpTHbSdaksjFw0kOaQ+iy3Y1tfaxiGwRBnJtqs+DJtdOThmChoK+CYQ3JH6xwndKQQ8Ku9/8BZ7lkJiplZlw8t0hBc2U7BjJRJO7W/p0RKcLzwBI5R7Ngcb0X+7DwEgUp/FZx26KiZiKgFs190iWTzpxRkGRilAihs7O0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFo6l16S; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFo6l16S"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-433f681be75so1670194b6e.1
        for <connman@lists.linux.dev>; Tue, 05 Aug 2025 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754408367; x=1755013167; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEDr9t1lNoU6WFaW6F1L0pj6E/5nuBfgAYeMY7f9vFw=;
        b=VFo6l16Ste201PD6O0A/a/aslW/Ujj+OjLJo3YMCPIBQthArQCl+AditUm9CfgbyPy
         nln/0hkVktZI8MJ3Ed2kdasJ+yjpkd8jXcrpwTMtaSi5DRduItgEikOadwvqKCZ0OTwD
         xB2WJ1XvtnDoXMQEH7TnsB5mDfwlvYG93BxkO8pktbvnGEmR6V61uA5PQRWNpR+/mRrQ
         2cWQrGFJ0HADllSeo1nzf9JdC4iwLs9kjQxlmHjvt71DWuNwh9GkCRAkPHQ9RpraT9mL
         9VdECiCEKSB/uscYGoyV6kkRErOxVXKRmEliy0tFNU7gqu3D6ZaDGFUaL/cwUJqMVIcf
         7oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408367; x=1755013167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEDr9t1lNoU6WFaW6F1L0pj6E/5nuBfgAYeMY7f9vFw=;
        b=kQXTtY651MJSBDFJAiQUEMFrndtjqWe+ObP7NZIMw5GwHQ0TG04VHwQeQ8AWscQ/+z
         m76yC9FEmhXhialWZygOsIM9r/2hTkU48OfFDxcVyPDX5gE898kIe+LPnj1ttkBo85A4
         2/0UAtFztcX9bUWL7Rl4hItYdRA2FSHlbcdJy2qxfHjn+tgH5mzhEXBr3wB/Q7lnpYAy
         zZhIuPOO3Mc9Ue1O+/J+1bXNlbD62LluwgxGZs80wMC8FbtGOe4VzS9Auy/BizbHDPM2
         5W+t8kWlizRMjcSemNsLfZudniqlqYnSsw/mxfnFFMZKtiscRFGpXLK/C4hxWlrRqb7a
         V9ag==
X-Forwarded-Encrypted: i=1; AJvYcCXsosnxb6tTsJQ/F0z9Jw7xpRjjq9V5ZVPPujduGGV0yy3mLWNhiA/7t8gj5ajdhn4UJQyhy+C9@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6Fix8Sfvubh8pkUYNy8i77pxxsmCzpcsr+z2jBsFLgaduGmBV
	2xlhYyHrqj4pP4Cv1roSbSL+9w9zYlwm9drQ/caM80EopqTs6dTrWy7o
X-Gm-Gg: ASbGncsdGRjnS/m9YLKVbykFxAALzQKZfyCh/gZ3PKRp9z1kk6jWIrMP1Cn/p5u0CZc
	iVWOoeBWyYoUSVxicTAxARO1WvuOdTxxhRVlU1xcfmJth7fc4vxiFTRxFTDfSJaHobsksFPeB+V
	yj37WISazxhHIwbHee7USYHsn0Yg4JLM/dZHf01tQlKW316ZyLKZeE7BXJfdfe3K2Zmnw+fF04C
	xDwDG9z0aDA+nOo+elctmqZbI1cxr/xHWJhnRvag7PMBu/tQVMKvcFthyaNxxULzNAQ8SXH/c2E
	LCYs0h0SjYAjMd3Zupoy+SX9KE1stPEmLe/jKOgMmT1vWVTzJrsiPgwlP98RdynOWZTc2Sc9fR1
	PopNi68keM/1bM3o3hf+UIQ6o+JvBJSdDbrKTxYfGMdW0AJdYbyxaV+5nNnXkAWg3Nj+81GO4z/
	w=
X-Google-Smtp-Source: AGHT+IFfmVlp3R+nXa23e8mT6PZLnRDlh3NcK5QYaKC89ennn3sIH7e/8UPL5AXq/QpREbIuercgzA==
X-Received: by 2002:a05:6808:1b28:b0:435:6c1a:f3b with SMTP id 5614622812f47-4356c1a1b65mr1918607b6e.14.1754408367162;
        Tue, 05 Aug 2025 08:39:27 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-43358891df0sm2631591b6e.23.2025.08.05.08.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:39:26 -0700 (PDT)
Message-ID: <89108c70-fccd-45ce-8754-87aa5c0ab93b@gmail.com>
Date: Tue, 5 Aug 2025 10:39:25 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Connman : Allow connmanctl to trigger Wi-Fi scan
To: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Cc: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
References: <SE1P216MB264730620165FFEBF76CD1B9F04BA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <SE1P216MB264730620165FFEBF76CD1B9F04BA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shailesh,

On 7/11/25 4:31 AM, Shailesh Rathod/LGSI Connectivity Team wrote:
>  From 7a587f647db2d86404bd1a578ee90447b5e2ce26 Mon Sep 17 00:00:00 2001
> From: shailesh <shailesh.rathod@lge.com>
> Date: Thu, 10 Jul 2025 04:32:13 +0000
> Subject: [PATCH] Allow connmanctl to trigger Wi-Fi scan
> 
> Due to P2P Scan feature connmanctl couldn't do Wi-Fi Scan.
> This patch enables the use of connmanctl to
> manually trigger a Wi-Fi scan.
> ---
>   src/device.c     | 14 +++++++-------
>   src/technology.c | 19 +++++++------------
>   2 files changed, 14 insertions(+), 19 deletions(-)
> 

Looks like all your patches are not coming through correctly and are corrupted 
somehow.  Perhaps your local mail server is not configured correctly?  Outlook 
is known to not play nicely with open source mailing lists.

You can see for yourself here:
https://patchwork.kernel.org/project/connman/patch/SE1P216MB264701522C92F2327FD04590F04FA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM/

Try downloading the 'mbox' or diff format and note how the whitespace is badly 
mangled.

Please resubmit, thanks.

Regards,
-Denis
