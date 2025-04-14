Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C24274674
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645070; cv=none; b=Ay/qoCYI8Vc+haMEREKbfUmgd8a5KtVjGLfMhXPiJ08ai846UPAFHzqCXPcQ+0omZvfTaz5zZNhimRnh8YeUuEdSSGq/nS3TrmJHCOutj3PsQigG4kPxgjoOp1r6/M0lvigVCljcISEl7i22tx6Wo/SYUg0cnrTrIXGnfDQWxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645070; c=relaxed/simple;
	bh=WuebOznF6ZrK/GvJWG8KQJTTB+aQebuCd2TeqNdpPok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BQkwaGFY1LvGnjnPcPJS+Lj0Grb/Nr2f0Z9lEzZ+/EB4WfNxfGT0awJlMxOtQuaaFr4TIeujjcPIhNfxq3hMgrwWw5sFDX5/Uycch8861rBz7w6v9ju+Y6IXvb318Fo7xlCE1ySggW9qnLYZiZhrq2h9vHsM3s37zYJYoc7BI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmu/V8+Z; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmu/V8+Z"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2d0a742df27so2382363fac.1
        for <connman@lists.linux.dev>; Mon, 14 Apr 2025 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645067; x=1745249867; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4D/jaB/hvDNI8UypdKLinKjya35hVbxvvpgtoofTJdY=;
        b=fmu/V8+ZsI724DCqNn50Th34BenViLDIh+/ofr31Sv5I3BKgI8EKzTL8nA5bBsxAzA
         9DIUmYevFK9c4R9/v0sd2JoEd5GnD/qKNtDs15quL/F8vNTm2zx3M3oWpNfzApLlTcyI
         7VNuDerWfvXvUW1zZCLxowlVLCOdxjq7e99/8bn4cEaqYNQ2zSj05X3GoY159TM/2w0n
         4Qj6ELubm5gtytNMWpd11XiLShlvyEbxEBAJ+2aIVNnQTWWNh1c7sk8Y3jlNjnuFKRhY
         I/gGyGuvIK7RgqqxssTZPYhuGAvwpfxjP1MgRusJn8lwT7P7bdPdbOQ7ETMeDu0jQs8/
         q/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645067; x=1745249867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4D/jaB/hvDNI8UypdKLinKjya35hVbxvvpgtoofTJdY=;
        b=BQhQ99c6MF+F8RY6Wk25x659SalSEu64CUcsFvOggq9Ka0ne2jlVS4+/sgHgS+kcsX
         sLqFd3IBiftPmXjQdtB1A7XSw0NxWfGd4bIt3eY4tdHe21k65fKmh6lH4X0FBfkcYVKg
         yKOj2I5RY351fIxOQ1YYinEUbY0Ctwobye/3m1lOcdAaNhVSUWcwpSxD3ttfLWkWkPf8
         u8MzffCUiLxfSV4QB03BlVPDorifEx6Q2TXjrhxUwlF7EWGvokoW+iwUyI031fdLCE5w
         mK6unCcraAUHgGVNRCIKBqf4jAsI1bJxlnMu8bztV3UrN+pjaamqKocH3nOPUOZ3/Wzu
         M5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhMQhOfT1S+tm/+v43J5Dtx6dIB+1NNURhxMt8IQV/fStrMhbMRIwGTDHEUdCwGT1AbCfylDZO@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw7WLlmfb07O06TmQ4x+QyvG4nSw/AAmKAwS0egFjS3YJXrPm3
	W5iv3zuZTzgyL/6MDSO9G8dOFtO2YTYU7lxN150yS/kQnNwDQpoI6b0dQQ==
X-Gm-Gg: ASbGncvv5P+WqleOWjtasQmuPg+iz4MfdHq+zzmKnO7t/J1Vx9F4dRWxJ8qrt4GGZ+Q
	upDvVlY6Oqmr1ZvLzaSELof6X7GtnWdL1AKdSbNddQ2VbSPUtfObdVqaArVi8dYMeKEN8P2Tu1+
	eR5KhRlIsm2UANJ+PFs4PvQKQK7IxoHAiXCKHLw1PxZIj08l3MhgddTsqeLx8nojc6Wb4zyjdpF
	lpL1hH+Xw/WzFZVmF/d45fwGyJuZj3/B8kitOGc8WqWGLq1nW1/xlaBBvXk16GkCgkq2W58Xk6j
	stDOVj5sx0E4AoNmiYY6e9RtspXA1BX205qr+TxJNZqkQPK2T0nbKomFrgOLBs2PaGse2Shp+Mo
	ex4ixnA==
X-Google-Smtp-Source: AGHT+IFrA2vpbo7QuJokdJFq06xRXVD9a+10ET3oe4MgD5MFJt1lLa3lUQ2UYo0vLBVDpIYYgtvEhg==
X-Received: by 2002:a05:6870:1647:b0:2c2:2b79:f7f6 with SMTP id 586e51a60fabf-2d0b323bb8dmr10613570fac.9.1744645067461;
        Mon, 14 Apr 2025 08:37:47 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72e73d7140esm2001623a34.22.2025.04.14.08.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:37:46 -0700 (PDT)
Message-ID: <fb741df0-6f1b-4287-b494-60bb0d8e618b@gmail.com>
Date: Mon, 14 Apr 2025 10:37:45 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] vpn: Avoid using uninitialized prefix_len
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
 <20250410155846.252858-4-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250410155846.252858-4-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 4/10/25 10:58 AM, Jussi Laakkonen wrote:
> Clang complains about the prefix_len being possibly uninitialized. Set
> the max for IPv6 prefix len as the value.
> ---
>   plugins/vpn.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/vpn.c b/plugins/vpn.c
> index 42396d2a..9664c82f 100644
> --- a/plugins/vpn.c
> +++ b/plugins/vpn.c
> @@ -4,6 +4,7 @@
>    *
>    *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
>    *  Copyright (C) 2019-2021  Jolla Ltd. All rights reserved.
> + *  Copyright (C) 2025  Jolla Mobile Ltd
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -388,7 +389,7 @@ static int extract_ip(DBusMessageIter *array, int family,
>   {
>   	DBusMessageIter dict;
>   	char *address = NULL, *gateway = NULL, *netmask = NULL, *peer = NULL;
> -	unsigned char prefix_len;
> +	unsigned char prefix_len = 128;

How does this help?  You may want to share the actual error verbatim. 
'prefix_len' is set from 'atoi(netmask)'.

The use of atoi seems to be pretty dangerous here though.

> 
>   	if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_ARRAY)
>   		return -EINVAL;
> --
> 2.39.5
> 
> 

Regards,
-Denis
