Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559F10A2A
	for <connman@lists.linux.dev>; Tue, 28 May 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911161; cv=none; b=I8VIy1gvHEZaNZf//Gb/ZupUCb3n5gTmAwByR/TcFTIBv13Jz/aRkhxTAE+26c2W7Ax4hgHrM02j8BJPTJ31FTPWtL+DS5Jd/TsZPe9rfv52UlSy8aLIx5v8jCw8SUzlIZte57JMu9JnDUl+MY6iElBrQHVmBwz/IxiFJdN+JHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911161; c=relaxed/simple;
	bh=5+XX0S0NofdkVuNU7jLnLBPAsBymLt77K/vj2yd5yig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9ZUbOt5AdJqQiflIJYF1tcWhtH1ekHzyWjsin9tghOMdiw/075ZJuLsJ00kcrnKC2ySM4JK1cSWXoL9EOad7AiJjgpfifBCDMheQoQ5A6FjgK8xAnNgjkBHU1WR5Oc4Y0FYGpN0AG+24RdQtD82j0Q2uVXBD224nBFM/8fYc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F199Z1gM; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F199Z1gM"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8d0a215deso1946331a34.0
        for <connman@lists.linux.dev>; Tue, 28 May 2024 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716911159; x=1717515959; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfcZmywtvQYsg0gE4ARRuFs9A9G1/WvUs1ZYkENeaVA=;
        b=F199Z1gMoYk6u+MSWbGQBa1muLT6dk3DWGRq3HQ/TJKyvfikKb0R3aaJ4Zj9CGnZfq
         Y68I+QqcheFkjFU51IZSOKOhbfnpUOPtSdU8776Onm2GSnWEsbEJsHjCRWFmyeLJVheN
         G3nPXy2zKWJ9W9iCfRa69bzxjNjk0exQCtBCM86c/LdsoLFsf6ofNzkdCdlNz8zABMLf
         MIJjRQ8RVeVLlN1TTFVBVOI90S2EhcpXsonadappCDI3QcO51yr9QKPLyxuriee3PScK
         7Pkk2vGg3W75Kmsaj0fkxDZEZDIcvdE1g6CknIpUIZygef0Y9+Qp0Wnh0ltzt+LwUC7f
         +7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911159; x=1717515959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfcZmywtvQYsg0gE4ARRuFs9A9G1/WvUs1ZYkENeaVA=;
        b=Zt0ZX0p2U1Q8iK+0a5MkYE7t+bVM6LACK2Aad+hRTMAAqxlKLPNWN04bQ59Yjs+LBP
         OjALpvamAOp6m5Zjpc0wAkyHxoEM1oWBFpNTi/wCD27XmHiLNtZaJT1+gaSMI3xAHk9D
         NT6K55b1FXlXaQT0yAZyjH+r5+SI/VuzC19AmICp/PDjdqssQdr3PJaE1+DYSPT1bp6v
         BAR3sCCSDJ+3GToUP/EmIfo3+mau3gfWk1y6ncOPEUjKGtTAEFvew47r1fEsnyXhw5j8
         MJ7CVxfpkHryXuMesogQzqWJmvSRTnAWztojPSpnpdJ9QbUOpfuwaEuhn1kALRzxCBOm
         O1qw==
X-Gm-Message-State: AOJu0YycJqzf2zrMysAULOnjRv7s/baFKxhICvvMncTtwR8vX4xwHjI8
	2+4En8EtNfNvw8XkAZUHOiywoVBITqYULD9gOMuEC61h7EZS/QU9/z8+9A==
X-Google-Smtp-Source: AGHT+IHYYsmV5xUTphqODPSn1UeCa73iVgASHVda7Qhwl2LzVgVHFiA0hTAJUTu23BgYPT0ek8O6AQ==
X-Received: by 2002:a9d:77ca:0:b0:6f1:222c:2302 with SMTP id 46e09a7af769-6f7d4144a1bmr6542941a34.2.1716911159176;
        Tue, 28 May 2024 08:45:59 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-6f8d0e84211sm1955091a34.78.2024.05.28.08.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 08:45:58 -0700 (PDT)
Message-ID: <e9262f10-35b5-44ba-96c0-cc76490ae453@gmail.com>
Date: Tue, 28 May 2024 10:45:57 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Prevent a short allocation by checking upper_length
To: Colin Wee <cwee@tesla.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
 <20240510235325.3625167-1-cwee@tesla.com>
 <20240510235325.3625167-2-cwee@tesla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240510235325.3625167-2-cwee@tesla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Craig,

On 5/10/24 6:53 PM, Colin Wee wrote:
> From: Craig Young <cryoung@tesla.com>
> 
> ---
>   gdhcp/client.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

I added a gdhcp: prefix to the commit subject.  Applied, thanks.

If you have other fixes, feel free to send these in.

Regards,
-Denis


