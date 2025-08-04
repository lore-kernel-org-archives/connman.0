Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84520408A
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319454; cv=none; b=S7sd4TNXeiQnPpKnDwsG2orOi9B7eXRtz3jtFBa8yK+ZYbDxMj82kpH5v4C4WudS4sK3ek4ostFu4BYx/CrTdhaneK9RVi9kIHHg/eOaXdVzayl1isCkXFuZo7AniQHWTpG1Y37QJus+OQEATFPkZFc6jpW70TqlE9JN8FHuuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319454; c=relaxed/simple;
	bh=GQA4YzHDJLuBXWxWCEq/UhMNwtyH6CqLWt/4KVkIYGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PveIqDmrYcnt1IAtniAWJE9fw0jBb8ICrAeKu6oQa2zEhDmev+u7tU3c7Osa80srkY1uq4CQvTASB2mEIVw5dpAB8JyszFptdTeKk/g7aBlUt2JPtHY+lSrXEu+eUVM8RoGtZKS7Iv+4u5m1FOZF5ZfoC0jG4DLX8AByZaP9gk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS03PAnZ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS03PAnZ"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e88bc371cso1580949a34.2
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754319451; x=1754924251; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1WSn2WEw+WA3Ty3ufImnreX0UniRxEszAYDIVsLFPo=;
        b=lS03PAnZVWy0bL30LdHJHoqTlQZyFz+Go2jedyfY4BDKHwkdsT7dxABM5zYTBvTz8L
         COFMWXMrGE0SNU6ILZTLETsZuG00+7mgXky/mY5gQ7EEYp9+OJ5aiNDSmzH1jjyY8QSe
         hQnUwTDM9r+zkutXQk24kScOpNbw7ecZ+aSYQRWvK70Qk+pqi7K5ffej5pBQQhZx5ubO
         MBie8moLIIrvv72aPQOrCLbfe4giPlIxbxPrf8jk3xHrLoxV1GGJYfEsHhtw/zgNOl9J
         PQ+DNZG5TpuTO4UxlTrOjmmyZYoZsy/KLZ/39QWQzK017pRIHXTagHMXeq+acskmFq46
         vyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319451; x=1754924251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1WSn2WEw+WA3Ty3ufImnreX0UniRxEszAYDIVsLFPo=;
        b=egklBtYG/CxYIJUE17nAJtVbusLKo76qzYZfIIfMB1QwSZNSLqm1xKO24mzqaVQyGR
         dOH5yTBUzUJ/63mNr1YW5Er84VFPZVleVT49YdnzAjEl4dygQpMk1GXS5pL64cdn2/id
         A569DyZdU9GC6rHERznMnm+zphDXvO2gVcK3R4dEKMqlNCMx8zzL4FD8XQX3Fs1ySYUD
         2+f4I5WwTMN8v6VQDAl/ivJeo9nslS83hltP6tt9Z3NnL3dlFCGhDXEEIMl9xxpgN15p
         4qWjfqfT5kjieQgiUREFskh7Vi+VjedEdx+CCB0fxVvNIMQ1a/bZ+M5JEUF/z+fI4tMo
         t4gg==
X-Forwarded-Encrypted: i=1; AJvYcCXC+8uQw1ULY1AS/ZedfmE4z4lQPd0EtraaQY5jxEGiwZs18FlzAEXFs7n5qmvCm8PuWZma9pVx@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3kMhzy/9V/WmOaNZCzten6RjVfsf/tYa+Q6VUXDhjTbEPFWFc
	mfh/2XX2DOxCxnjKDtsJXMxBZkU2icXFzcQpQPWEIUlLyJnmN88pMffjDo7FGQ==
X-Gm-Gg: ASbGncvxOaE6vxJBeHzwgCdV/C4l2hFKcxulrCqxpTb7knfQ3fPrrIb1FHpCW+6JVS1
	OeluBDp9B6WHJiGJQP+g84mYdpM6s4flo0PppZYieA2ay7lkZmn4i0QWmYDEz5xSFzYRGfSxLYi
	rFoiVbdi49qLl8Exac/aJ3bsK8vbMYVbabKobiCLu3vTeGtKeVico9hZiiIjSNVLkKv4ZQtGjKW
	xr9hBJf1Q8gnBzYyNIAGuSGTvlrSG7uLMuUOOaENnaFpktc/sU/8v6y4paNZz4dKycuqO5/hcQJ
	orjeKa1HEVLKOQRmRk8CQJv8fPyBigYGGI6fJ/Jo6IQ0tiPEvwRrpO20kGqmc7DKKCkRKcON9nJ
	NH3XkklqoH1EPbXB6ukIU/5JX/uZFP5pu8fYeLD3bIF05BVQLKJgO9FCOncx8QTGL4YHu8mC3CY
	s=
X-Google-Smtp-Source: AGHT+IHomNd0CtXwFYm4yTWMbMPHxJytR1hxla5BVoP7OEiE0fF6ZrDqD2+16Zr62hAQ/9BXXTMBeQ==
X-Received: by 2002:a05:6830:d12:b0:741:21b8:b245 with SMTP id 46e09a7af769-7419d284f37mr4992115a34.16.1754319450896;
        Mon, 04 Aug 2025 07:57:30 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7425127e203sm205387a34.45.2025.08.04.07.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:57:30 -0700 (PDT)
Message-ID: <a32467d4-d902-4cd4-b5ad-3ec3c4b3cec7@gmail.com>
Date: Mon, 4 Aug 2025 09:57:29 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/45] inet: Expose __connman_inet_is_any_addr() for
 plugins to use
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-29-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-29-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
> ---
>   include/inet.h | 1 +
>   src/inet.c     | 5 +++++
>   2 files changed, 6 insertions(+)
> 

<snip>

>   
> +bool connman_inet_is_any_addr(const char *address, int family)
> +{
> +	return __connman_inet_is_any_addr(address, family);

Might as well just rename __connman_inet_is_any_addr and fixup any users to use 
__connman_inet_is_any_addr() directly.

> +}
> +
>   struct in6_ifreq {
>   	struct in6_addr ifr6_addr;
>   	__u32 ifr6_prefixlen;

Regards,
-Denis
