Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4226E6E2
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714450; cv=none; b=pYCRHXm32MvwfVcSLSF6en+6KudQXmI9SqjkQGXlyuQ5NprQpI7/Lqw2gUYW6gfklLlHN48NS50LlbfTIbnmLip84598wulWXOFBgi2jnpaT3qGj71EkzTkM0at6avYQVihzWHQ5CbFVeyl5PYM5n4QL7tXpVtYSdngcbUyHazM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714450; c=relaxed/simple;
	bh=hzkvLarV5YwDrSlhHbFYf/KTHqYg0NnTO3uzODdFkjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lo3pwnyeH4WpGltmJ1tgxLn7f9AKWvZsARrRtAjZhS76VW9jub2DC/L8iQa6VLUrCkcDAOnFZYzgmDu5igX/kHdnWG9617YDEbipZ3i3qJLQdk8RWj+yBSYJ5uJYjpdLqAx8X5NdavplVKQ0uLlHCwKHzNr3Z1fxlaJGmND6FvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ0mrebj; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ0mrebj"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e810dc22dso2542047a34.3
        for <connman@lists.linux.dev>; Mon, 28 Jul 2025 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714448; x=1754319248; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OXzB0eZBeBslmnCRDBjgGOnY0mmGud08L8JzucYzf4A=;
        b=BZ0mrebj6Bowc1yXP/VmcndNZr6ouTWrvd6+JJdOfIuxEAQQYevO0g8XWlKcTnyJUa
         3ckP0NQgqzIidMeic14j0oktuwRYbwWz4BgezftG8x+78p9NkpKiss43aPxDK3L54uW9
         A6mg1K46qtB/ua/9NzXLjwbaEoVErHCs1tlGlzE1rTK5b3n348YWbflunymLUoVUDzRb
         e135DiC6OXptDeK5uGij3z6UiVTiFchNTJFu/ID210tyRpQfV+VjFBxyWTZw42ufEohm
         QNePIZRMwPOyG4CLm2BSMjJLxGfUogBrGc6WrQq2/bgDf2WVl2hdiyDgJ9GeRZ0tL9vb
         3H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714448; x=1754319248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXzB0eZBeBslmnCRDBjgGOnY0mmGud08L8JzucYzf4A=;
        b=eLRp9Ggt9gNwQR3mIUSCPeS09701/dcvPGPZJWHn/dpv5RFRPLH/PVqlw+3ml0ltx3
         XAFSDuy7lMciuC9KR/f6iNFwzrVCzPtrz6xVgmDslygIH7yriRGGZQbL9P5gBFy8tJly
         DSCgAkE+2dRpiYlMzSCR7YT4s04+JGIht+bWbqd4/26j/upd0tcHG8WxxAKUOCzQxUqo
         RHpqFXTbRSiNtnT0hg/gylgPkY0UTCQ9Tg4KQKrP8GDJjFId04DlMQl10o4K2YUsffwj
         SE/a2h924KbDxZ0OOfhv/XMfVCzNCZOBkzWTGHI8hAiwHzv0t/8fqavyvnV0zUMs+VcN
         3xIw==
X-Forwarded-Encrypted: i=1; AJvYcCUHilXMbYjnSdKY04h++BBudct0oNMK+w7hAL/Z47UdS6z0+0x6PJTbEFFLv8qYpLXH/JRXBWDt@lists.linux.dev
X-Gm-Message-State: AOJu0YyvIyKDDYj7cKDayU7I2WmoQu7daBgcTeQBfP/2tTMTNhkeg30T
	J6dk0y+89NR4oqJqePHy8LbwwhE/AMeaSyefUwpHgkKdKcJyBormjrMV
X-Gm-Gg: ASbGncvN87lGmDNw/SBvHkpNPLN1QYJ6Qiuqvc8QfmF4rDCC69Zvr+B1U1C5AE+B2xE
	EJ0oaCJmy65G1QgTv9ODPtvY2tWpt+gvYZY+Wt9nLclXFtDu426xfugoL2TEKeVAW3yADFHtTpM
	FyVd7ep8T7QUvgcTElyq6PcDlKk1pcZa55uavMo94/geIKbtWoykBA0DVR2aIInBMvcm/7deNQU
	QWOwuKhOdfGGAx4iyTrKYL/V7a0eOw0c/WrsmP/fQi1AEUmHeNfI8TyoaUgvAZt1Xl966cbdLb+
	suDb8KRHPuKrQtFKEWzu+v/ds0IPG1VUEsKr012jDM+pbPF3HD0MwiYs8sRa7qikdxEBzSjMJo0
	dR28xQWFA5ixejSb6/emeQnGsw0EpafNzCzOpNdS5Ff9wY+cfbohCFGplnyoA5+BM2NuRobJm2c
	4=
X-Google-Smtp-Source: AGHT+IGwwtY7eRVEhGbzlL9YRW0yIz+90R5/fSxA7xnjmeAUvRAOAYm0xIHG1Nwe1nqdv205X5mxew==
X-Received: by 2002:a05:6808:4fd1:b0:41f:79f9:1b6b with SMTP id 5614622812f47-42bbacc3e6amr6383463b6e.34.1753714448139;
        Mon, 28 Jul 2025 07:54:08 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-42c7d3c2ea7sm1090640b6e.23.2025.07.28.07.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 07:54:07 -0700 (PDT)
Message-ID: <bdfd4f28-e5ef-4949-a032-a4f838c40779@gmail.com>
Date: Mon, 28 Jul 2025 09:54:06 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] VPN association state, dual IP support and WG fixes
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:26 AM, Jussi Laakkonen wrote:
> This patch set (1) adds the association state also for the VPNs, (2) implements
> dual IP support for VPNs and (3) contains fixes for Wireguard address,
> especially for FQDN handling. This is a combination of all three improvements
> for the sake of testing them together.
> 

Now that connman 1.45 is out, I'll start reviewing these.  It'll take a bit 
since I have limited time these days FYI.  Most likely I will cherry pick what I 
can on the first round and then request additional changes.

Regards,
-Denis
