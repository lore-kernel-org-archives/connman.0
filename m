Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E02676FB
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548982; cv=none; b=At8N0HyUCVE3pwM2Jhb2Dw2tkwSWEDJfKi8vck+qNsSxWQy43J0uy8NdgQbUsgNxdSuiXZ4qazXu3oYRIz2MzAxkXfx4j5ptKmCkl15FqG2XrT+qB67rePLPHnSEynPqV9oSP8Ht7e3zWUYSPOC1tAPj86HQPw2guH6cwrrN0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548982; c=relaxed/simple;
	bh=M3eyVPgxVcrWFhnQoZV6rvXFRkCvI8GjYim9/6LsMP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cv8ggxuWaS/dRtIj/wjzUIGeALGA1D8yXWdcQaOn5nH5Bh95lOk0Htb31YTpJQRjIjw3AHKIkgYIo/8MSVbWMpcUd6Bnf9GwJnHbNyu2+Vps8itHmG2QnjuadJsVG2FyUqGc824PWNF1vgeXkkkx5oUwQh8UjpJese+VfbQfCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeFKROV+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeFKROV+"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso2477799fac.2
        for <connman@lists.linux.dev>; Fri, 14 Feb 2025 08:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739548980; x=1740153780; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P35/ctZpqy/DvBEfj1h1V5PWeAgw45oL8qTsxrqqs/Y=;
        b=LeFKROV+MxNwWEdVxJXSoC3dAmfvd559iygNA10rsokqSrdOV5A4Om/AklR5PchUKs
         +Ww3XPr64AVmLFUcqUrxLq+SHPLUo/3K/uE69MSi3VnctXZfsNjV4jdSA7kWIChNbDZX
         wp+RW4ZgJjWK7Wek7Gh36S6B2loBP4sO0f2woMu0Y5SiHTCxBi7gkxQQgc4M3cZ3TyII
         L60B5jDPXxe5itYsLVc2HNX5+o0oI9WGiN4BEu2cju0n6wD2bHUulIWlzIfmVahjeRTB
         4RWo+JkWNZ2Hfu0Z7jnctXw4+pCmtg1Y+k+JxXkRrb5UGxneU3hLFH69Zfa9alSvL0xv
         pmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548980; x=1740153780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P35/ctZpqy/DvBEfj1h1V5PWeAgw45oL8qTsxrqqs/Y=;
        b=Aia8XwCaOXs3rlnfkGn8TofKjn6hN/A3r3x9l3NWY3NLk9igReuhRy6+8/tk73Y7KJ
         QC8ZbOHXWSDgkIDEeXl/NIsi8yEUIZTe8U+l7NP0LDdWHUbAqHBmjQwFCzgjfonL2mNY
         CeuH/vSw3XbLY8+fxWc+uhBD72E39cJ599Izb+2gEQJrEq8tX0WSqoQcaEdYi5QBBlJQ
         cDi7f+EzB6cyTE5dNL7/xVLghaq1vSabtDgvumcxmwPOXJN5HfHDWTy1wXxotnlgUkB/
         5VoqTZNHgzDW89cxVK+0mpCPpJJWvLonUWVPPC3ocn3d/rgN9hm9Vq0cHGuKvBLV618j
         /6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWPuVjg1R6ctnKF6ZuJx4sEkSCp4lXqeCKKPi9ZOFVgDrdwKxbX7tbWjT/MWCqATcfA/JwSQP2a@lists.linux.dev
X-Gm-Message-State: AOJu0YxR1rcyBGIvorqPWN59dc0ZO6vkiZ0L6KU1EVz5l5FL+2Zb+6mA
	lXcVXmT8fyaR2vZGyQODg37FrLGv0wtJxzug/+Q/+aNqmG4ShI/T1g9tHg==
X-Gm-Gg: ASbGncvYRxPU4Tcq1APtTXCjj8deTkj/vMcaaOZDPfPe4iZu0sZJ/+0dxmiHTN6CYsq
	JfhOT8yguaKgoZWsevfhdydSnvVsoRENj3NvuWJRJpKJhoDfguR06W5JVT3vWkScJVkE4M3IlD9
	qK/p1ibh0ca2KcCIEPcUNYyxm8/uXId1R5uyA1TSDKgcq3FCf3avway4v6x75LBo86u2CPWpchA
	wnGyoEditaLe0lJo22d8dI5gycUgnF68trx5bgKQ5Xo2BmsXIWwi0S4JmIK32pKEpEhu4oJbtA3
	DXL9yP5z/infS9zoQRX7m0gEqMLBVPFUwfJmURg08aNMeUn4CAGwi02Q
X-Google-Smtp-Source: AGHT+IHfUugtug9tENiGnvwvAxH8yMmsRJT/7A1VCKUHqU0YsP2yhvHBQ95EE/4rkqz7zwJxRbRR2w==
X-Received: by 2002:a05:6870:bb1b:b0:29f:df6d:999b with SMTP id 586e51a60fabf-2b8f9061062mr4547754fac.39.1739548979914;
        Fri, 14 Feb 2025 08:02:59 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-727001dd0e3sm1372914a34.27.2025.02.14.08.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:02:59 -0800 (PST)
Message-ID: <37feab56-a21b-4c51-b826-6f3690b9ea81@gmail.com>
Date: Fri, 14 Feb 2025 10:02:58 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gateway: fix calculation of is_vpn6
To: Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/23/25 5:38 AM, Gabriel Sanches wrote:
> Fix is_vpn6 to use ipv6 variables not ipv4 variables. This stops
> the WireGuard plugin from faulting on startup.
> 
> Fixes: commit 823d5a2a8cc4 ("connection: Refactor ‘__connman_connection_gateway_add’”)”
> 
> Signed-of-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> 
> ---
>   src/gateway.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

This patch does not apply cleanly to upstream.  Anyone care to re-send?

Regards,
-Denis
