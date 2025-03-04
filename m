Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6624EA86
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108008; cv=none; b=B9wUjXo7JqTawEF6wbuyuHmquV3X1FnhY+W56HkxlWylaC0S6mI/wHmeWDl0Vy/L+TcikBt9CoPY9Q9OkUhIpAcoi4BXPnU2XTk1TjBQeDZeBFf1Sl/TNsj3hiCJC1zov4kjjnNakHIsP6Rlg88YZmXrOFDY4nlnIlJDw5iPLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108008; c=relaxed/simple;
	bh=uQMn/+bt0LGtnJ59ERi9iCDykIeOHd+1Efk6m0iEWpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dlgXQAPq+nyNHYiSjNMLXlOHd7g1FNZW/4g1FGcAxXZSJYFv5m8PJcSSddBpultbA9hHIRnvC1Tw5Iv1ycfxCvt0o5T8gNzNb3sw8hGrjv5dsrcZQSSxuK1Lrk1WM5pqRhZwKbo3rHm/Oxxl4CuPqweq5uziN/glGtqdYGHYiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCV5ytGm; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCV5ytGm"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7272f9b4132so3987998a34.0
        for <connman@lists.linux.dev>; Tue, 04 Mar 2025 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741108006; x=1741712806; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFLJwuv5Ze8wcg5LlZ1tHgaxBrrUUWiuClZNJ5HYoNE=;
        b=eCV5ytGmVbkWVm1KniG5d3WZMDBdrVxw6GX2dkHWYlGAvGnPb6QKcdHJTDylnp4+mP
         tgjwlqeAFs7iZby3RyyqwbZaz0LoDnBl4a0YnmnRlsq6wRdlv9wbYZ+c/kt98uokkxR/
         FL9URa5oUUFgc8UCCnJVp/kxp4ZheiRx+dXPa5+HZVUPArKV01s5dQ6WwYHwxUbzZ0wP
         Hl7mZxYMKdiAOZFjJjgVl3XcD8VPHHRZvvdsPrYp36oe/CgWX3DH9H/b+UmXPMYu7iUv
         U1D0vflFeGG0BrASI1JW1WJ5qmf9Tn9hq9gm1U69tMjfWUSXbPxbxUzH4iC279IFTzeL
         sk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108006; x=1741712806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFLJwuv5Ze8wcg5LlZ1tHgaxBrrUUWiuClZNJ5HYoNE=;
        b=w6jX4u+fg3VNyk0g9xOgCp4I533fI+P99Q7S2QDhfROV9tcaHGKhVCZ51OXThg9bvz
         KRO1ypPLJBH0ClrY0NqCKo+VtCvWuJvtWSqcbjwjBkCrq/4ECoj/JyHe1ua487n3iiyc
         A8bkDTnj0JJa0Cq9awPCIAEDIxJx8jb4gL99NO2v7FyINdc6wC4AiU9MA7wqUZm5do00
         KrY5c724FIbxjnoF9Qd9ACeC4Ygx3+aJwksJ16w4EiaM3/Ix+eOYO+PjZXW4BGu+x+Hc
         wtshSQrQ5ALw9cg//CPaevztEsU3e1GlEqsm4fKYoRU4xrxBGg3yAhGIL60oZ7m1eLJs
         m+6A==
X-Forwarded-Encrypted: i=1; AJvYcCWgAX41xs8NVqfhctOANWbPcR29AagG+/ygzZCOzE4mGfd6OByLVDeYGVrJhmFrIvT7qoonQ/jD@lists.linux.dev
X-Gm-Message-State: AOJu0YxSiJLZRvPxc0NfHahoEYmb9jL2Q/zqpMNVpI6EstxemElsevwy
	ew9G+xIxBcPQDcEitNWBW1h0GlAZxzeis0DWHEoXATwq120OZxxHlOvM8Q==
X-Gm-Gg: ASbGncsJoogBgpvwdPJC3On01eSRYFyW/wUKY1o9lfgpWJiNMlSrCZAClF42JiztEyl
	vgL5RnjDqkPf3o+TSOEDfnl3uPBi9OO0KVxQIg/gVCJmbRzXqGiXXT95nlGEYtK8ZOHCWUyRdOx
	3knA81pDyJAYDa5z3ltTUMBbr36EzHwNag5qzn0kxuF9zKfgQDXfpPQnEEZ27JO1/4/mvEC07zY
	sOasTs7k0fW9OZai5WIcZS2UV26mJx/lXLLSnyjr4YAtAXiU9HHl+kfcL8HR5xr5kja2muDLV0z
	JFG5swqo42vxrBC0izPNEifzhScv/4CxvIOq0kxhiLrZmMXbhnLvYEVSjnh1ztCshzoiM9jskg3
	NND+rH5syJQ==
X-Google-Smtp-Source: AGHT+IEJfDtXnSmpME8HcMsuW6S8kXsI9YWLiUFC9x2NSV/ypzY511jv4l1cNcsSf1jme3HpUCKcew==
X-Received: by 2002:a05:6830:2587:b0:727:1072:7dfd with SMTP id 46e09a7af769-728b8267276mr12168261a34.5.1741108005737;
        Tue, 04 Mar 2025 09:06:45 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72a170253a3sm273382a34.13.2025.03.04.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:06:45 -0800 (PST)
Message-ID: <f11d323b-a1f6-41c2-af92-bc08ee08ec49@gmail.com>
Date: Tue, 4 Mar 2025 11:06:44 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] service: Leverage 'service_set_pac' function.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <20250221155653.760046-1-gerickson@nuovations.com>
 <20250221155653.760046-4-gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250221155653.760046-4-gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/21/25 9:56 AM, Grant Erickson wrote:
> Leverage 'service_set_pac' at the three call sites the proxy
> auto-configuration (PAC) URL is currently set or cleared for a network
> service.
> 
> Frequently, a spurious, misconfigured, or otherwise incorrect PAC URL
> is the source of connectivity problems, particularly for online
> reachability checks. Consequently, being able to log all such
> mutations can be helpful in triaging such problems.
> ---
>   src/service.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/src/service.c b/src/service.c
> index c48959a7940f..da851d681bc7 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -770,8 +770,7 @@ static int service_load(struct connman_service *service)
>   	str = g_key_file_get_string(keyfile,
>   				service->identifier, "Proxy.URL", NULL);
>   	if (str) {
> -		g_free(service->pac);
> -		service->pac = str;
> +		service_set_pac(service, str, false);

Does this leak str?

Also, Kernel Coding Style prefers that braces are not used for single statement 
blocks.  Quoting:
"Do not unnecessarily use braces where a single statement will do.

if (condition)
         action();
"

See https://www.kernel.org/doc/html/latest/process/coding-style.html

>   	}
>   
>   	service->mdns_config = g_key_file_get_boolean(keyfile,

Regards,
-Denis
