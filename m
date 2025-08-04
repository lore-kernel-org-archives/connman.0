Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C6271A9A
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318380; cv=none; b=oCSmb3OFBp6tCpMU8edCwfqgJaDQl3XHYeWT8tE9N+FWMxjujzYAUav4RaZiBOOTBH9gCGx6469CBt4JgiYLF9CWdqqWQ3HWsG0pDsktLHRdf6PHgto9t4gzngpt8cZr/v1QZ7zU+WdBJFsx6t6pA/Cu4XdIq3HZbjpbJFx99vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318380; c=relaxed/simple;
	bh=ZRhQjfmhIs24eDYC3Yd9Qp+QI2jvRjP4r02YE1ocz3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RHeRb02lkjrXi0DCR/2pWmp0VrPMU4gFg7gJSAoDQ7vll7pKsBe7jdZ37d85K9tmjQjQxNkFKIl2ouQfgMtekhB8mAJ4Y0N4J7LLAn+UOwExuZz7BWfck4mgOuntRH4DQom8qq6T5si6aS4U41LZ+ZL6gSOvHDpZf0G5EhxJP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG3Ef28v; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG3Ef28v"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-433f984817dso1215255b6e.0
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318378; x=1754923178; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06CMIMAe+24FX1nCn5mU3te0YjE1le2tzaI0zZbez80=;
        b=bG3Ef28v62+Y5xxH1AWazE/W8XDZ8i+88dagscZQwLkaRoH1lCoOjwYR0hNiaagfcX
         ySFvlKuF39MFTwF09EGb+CMOY1ybA3TKuDlSOjS5Yr+HxBkyS8XojU4ycDjamtzZao84
         hN4mtc/wpDqo5HFu6XJ5lte799G5bwJfUKnzwa4HdUkiOFUM5bZNHTVi6mheJE/TKod+
         Dxlo2tqhcHCqG+5RsOHRMpLEl8hqfVlXqAYhDu9uV3Tel+PuGtRwxM/JO+ef1wkVFfzt
         IcY3YACUcRiSDOQ0GoFaEFCYpmvtuWT+E82EmbLVXq4MtgJ6SddYQ1+gkRa80TSgHdMW
         KAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318378; x=1754923178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06CMIMAe+24FX1nCn5mU3te0YjE1le2tzaI0zZbez80=;
        b=ayi4ODJudbiLcIHhxkGXnk3qRsymmwNbKVgC+7k3h4oXF3vdY0BZIOCyMZ9LzYhsbY
         nimzplnFCxM6Zq7qL0BMjgpw2k00j8wVh2onS+m/5pXyPYT6Clfme0XGXcL6f2NgGgUo
         q7pHMeh1NVpiuiQFrV0TxKyXMILDEJNh7/9bVehrux7SkOeXHsR9fmUYcZVudgV6SZf0
         sS9kuGSbo4YuL+4jqOsOT5Lxt2dNM8SOO8pBoF76cdq8c+Wq4OFHU6MaOBLqRzwabra7
         Wz4MVE23WWo/NRq9+Sgil1nfPjIU1fecJEQi5p8a9iqulRYo7668/MeNiaXZ9nderLT5
         uEyg==
X-Forwarded-Encrypted: i=1; AJvYcCVLO4cSgAcMFOKatDKmJUkHttQpObv82nWkAmFzOcWKUODDoPq00S0t4Dwot77um4p4y6tbLYyb@lists.linux.dev
X-Gm-Message-State: AOJu0YxeywiUhAKuQLKkHyRhXmwfhRWUkdHf50Phf6nbylLD3lhlsxjg
	4pxGEzvi1OruStoueqDmF5NBVYUW7Hpk0GcfroNKVWV5SymEhpW+xNcL4fuTKw==
X-Gm-Gg: ASbGnctI25l9KL996M16cOFDOvKw+VAiPV3iRqvikvSOKo3CWXnsklN13xgsWF08CGv
	xZrs3ojdw9LPT1MKkDJDZiJsfERRMb6V4Kjq09833e+1+JlFSDXNU/lSREOJOc1XZOFRmauOMWL
	6WMBF/LXOzX0W/bFg+qE7UZ6nQ5tuTapCDfHeVMxv6RHQsYSRuPB7q+UJqR824R15ZGzPoPm/1B
	wYPuicO9TyOGkxovNWCmBeRlx7omevd7LObkXjRUvifg/J63I6JxfOxbm5mdwijkqmcCkP5dIKd
	iuGn68skS8EFkWqvzUTyhLr2jIYXqDak9yb98qjJVxNXYs67oDK4Hwg6nLEfmILm5aAQS6Ps9q8
	vQDvatZ1jGmn5EXhrY+ecexHoOMGfOKPhld2F9wj5YG28ZLnzp6X+oEvEvxqLea3VJUmzH4rBY5
	o=
X-Google-Smtp-Source: AGHT+IEDoCq6pk7P4ZkHL3EnFLh9n2F1PgoR9eBUL5p+axIIO2haSNK8Naj0OlNm+wJZU7lAyAATCA==
X-Received: by 2002:a05:6808:181a:b0:41f:4f52:2498 with SMTP id 5614622812f47-433f0351dd5mr6061360b6e.31.1754318378463;
        Mon, 04 Aug 2025 07:39:38 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-61986ef9086sm1282129eaf.27.2025.08.04.07.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:39:37 -0700 (PDT)
Message-ID: <c4b5a272-a47e-4644-8bc4-7647f6ed5d40@gmail.com>
Date: Mon, 4 Aug 2025 09:39:36 -0500
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
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-18-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
> To avoid linking GResolv with every VPN plugin that uses it, add wrappers
> for the required calls in VPN utils.

This may need a bit more explanation?  You're still using GResolv types in these 
functions?  Why can't g_resolv_ be used instead?

> ---
>   vpn/vpn-util.c | 30 ++++++++++++++++++++++++++++++
>   vpn/vpn.h      | 10 ++++++++++
>   2 files changed, 40 insertions(+)
> 

Regards,
-Denis
