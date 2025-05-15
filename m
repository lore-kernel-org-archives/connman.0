Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAC1F0E4B
	for <connman@lists.linux.dev>; Thu, 15 May 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331513; cv=none; b=X1bWg2dEGbFYNy65CbwfIpo9GChTY8v4jTYTwtDuf+FbB+rTC6kIp39soy5IfiUmK7Sd+moVmo3oeu1bCYubPQ+QnvHb9jui2cwRRGxzCM2W5oyzZ5yiDkBSFTk+pC3DLe44NHcGlJpbifAYCQQYZYvpfet/3LSF80l4qft2Tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331513; c=relaxed/simple;
	bh=MoCd+GG/uDNEP5daILgw9Eh1C6GOTJ93keBQMt83n2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/ud8oQcMRRnhtIt9s8yk9NIHYZPcULtd1n7hX5Ands6PXBZPdDBF4QFFCzOcamv8JZOZbTYqGOxfKpA6T/b0TB0g5t7Nq+QGRIsnJa9LH/3x63cxsmATwZMO7gIwZ19YiXwcEzAUcxgCNLgi38DipG15GxremjJ/KZZYwKdd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD5SC9NM; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD5SC9NM"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-731e277a6b0so1446928a34.1
        for <connman@lists.linux.dev>; Thu, 15 May 2025 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331511; x=1747936311; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qc9hRh/amdeW+ukbqfhh57DZY3rHl54GhfNWQe+jvAw=;
        b=bD5SC9NMmM+UWzfNHiI+8TRHvUgKK8sX0j12Ggj8qMMAOV7HCm6LIBco0LkJo+6+KY
         tPbNHeEDPfzqH4PoS6YzLb9N75Z3W7Ov157eJ9w/dG5ZBqUt9XObS+zreVjO9PY6wB9J
         Qn+Ktd8UD2loDmZOl2csC4GKyeagGxncFVovLcg4pn1Zbvhd9QpuSY0Yg96UCLZ/EXnp
         AHWr0iIWUE6kshwphw8X22KPaE38pAejW2SUMvuJ1LNXNXsWTJV7dMv40p6WlXHi3BYi
         3eUfazrd8A1S07ZoGe+/Y83tI+haf4uFpnIEVadr9MYxBd5QUYHFlygQwKNcVz5Kw8Id
         K/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331511; x=1747936311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qc9hRh/amdeW+ukbqfhh57DZY3rHl54GhfNWQe+jvAw=;
        b=hFzAc21raXV40UkE6Wm6CwoHmZwR5NmNy8Q7A4WXzFT/c9qtABjQ3EOTdjHNEmuzSH
         SpM8v+OCqP+WCAc5uTd5g6E6i3WQEuiw4hwep8UwmlBpwZUom/J+44PJnIary6eTjcL/
         LqNU7M4RT0EOhhOAESFduGMLg6/cT3zbC5yADMaPNEalpBQEPwyF7WqoJMrPRCg7f2K5
         BG4ljp6r2hCss7eRy3ecPpDWScCbvdmE5kz/tF+Vm5Tky/zUOuNLT5QuELEe5YRGg7Do
         yCHw8SJJge/Q4PZw6qhX0aAW9792He/v8mrj39U6crzPSxatRkND/AD7UiDm6b2FlhZR
         sNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT9Uw11e5j601J6DgYPLoH2lV3hJHqcSDBX0PffRFliusDNMpeNaZ5X+QAK4H2E09miZJi7mnP@lists.linux.dev
X-Gm-Message-State: AOJu0YzQy0iQ9OYpcCetmFZcuNO6doGetHD+VRlYslhM/702Gtt4292t
	lH51V0ePFnLa62tqQS33ZNjwR4VSoogzbMWUPhwzPJuwT9pFZVi2WGYy
X-Gm-Gg: ASbGncs54lZMtknFwbQgiwvEz6rBX0Nlfm0rLkjGq7h/P/BfSGv76OlP3Zs3773flf3
	/x1x3byxDhQtnLZ4zlN8bSQ3xYuy0PrI/NwAGtDZ1JG5VYLDBheA5ttrC92Dk4OeRiFI6klO786
	A01/T+yjDH9pugku6nbVRvSZPgFFjRU5httmgJBrKXwhFd+TxHFGh57bOi6CbpfSaIsFCUk2Bmk
	Lke90uVsFpJi6P8Rg37OOpRh+yhneMJ05YA8w4e25SfzGu2JcEyBuzH1RalhcVBXY81/p8MHL8W
	341QCi7Is/Zgk5+SUT6dlBAHvRBwIHBS3dQh1BuAswJjSpLlMW/uckktKOr2uO9bmjqxaccImkW
	3Nsvx7e7Zdj3pbiD+
X-Google-Smtp-Source: AGHT+IFX6+V+MSviBZX/E7SmBH8BXUJzzCRhNos4sHN1x4KB4SXsmaV4HH36bWpsephaKKMKD+WH1A==
X-Received: by 2002:a05:6830:6989:b0:72b:a712:4b72 with SMTP id 46e09a7af769-734f6ae9421mr472888a34.9.1747331510964;
        Thu, 15 May 2025 10:51:50 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-734f6a81ca2sm39882a34.21.2025.05.15.10.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 10:51:50 -0700 (PDT)
Message-ID: <8d84f23a-56f9-4345-9b25-38fb9760c0cc@gmail.com>
Date: Thu, 15 May 2025 12:51:48 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] timezone: Fix compare_file comparison in timezone
 checking
To: Michael Trimarchi <michael@amarulasolutions.com>, connman@lists.linux.dev
Cc: linux-amarula@amarulasolutions.com,
 Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
References: <20250515114409.1456854-1-michael@amarulasolutions.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250515114409.1456854-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 5/15/25 6:44 AM, Michael Trimarchi wrote:
> The original condition incorrectly returned -1 when the real path and the
> provided pathname matched, due to a flawed use of `g_strcmp0`. This patch
> corrects the logic to return 0 (success) when the paths match, ensuring
> proper file comparison behavior.
> 
> Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

No Signed-off-by used by ConnMan, I dropped these.

> ---
> V1->V2: Improve commit message
> ---
>   src/timezone.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Regards,
-Denis
