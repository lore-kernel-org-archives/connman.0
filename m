Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95E172BDC
	for <connman@lists.linux.dev>; Mon, 19 Aug 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078797; cv=none; b=JFfsTeaaLGVNCEq5c++9cwAFgo+UjXx/Kmnc+0eKtganJ3fvNzA1Xd2zqQYCMJsN9sCwcwMjJ06sO7UV3Xh5Oa2L2hx3HaJ30Bb9kgJcAmqV0PkXVdUHWpXFtwD7gXA4KK6+J8wjyHwJLU6v9cambItMJe/XfSXO3PnVaw2dfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078797; c=relaxed/simple;
	bh=cCRFaTOZ84Tcq3fPO9+d/AR211ylj+f6x6UNBMCw4k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lJT6aCeJBh/VSQODP/prRe59DKnxX8BqFXH3Pp+dMJkBhpwB/AQX1ARvegoQcZdSGFFmIFJRYmorJJPVfqMdf6/YUjCXhR5aa9C70VKDJIkVIh9JOoWs80dMLOZmO3NWtmTlh2QTIw4+p1AUKJJHEMohwKu1oWSIi9tva5ENb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYZYhiQC; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYZYhiQC"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260e6298635so2135918fac.1
        for <connman@lists.linux.dev>; Mon, 19 Aug 2024 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724078795; x=1724683595; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEOQjEzzn/HqBPZ18pDBIIRbvNxud9LjmvFVP17dvK4=;
        b=aYZYhiQCreehb5s6UqK3h2AjcYyI1Vekv1ljySVHpSuKwSkC7l9PdIThzyCQTkhvG7
         YuL0b89pJLLGcCQgXz6DzeSGq+unjzVoUyEz4+x7nHncz3pV3gpUTcW/0KjIsrKyhmoX
         /cfy0s1Lq7vQPgb9THTU24Y20qDT6mlaDpJ74yQuiLcByv8pWME+FP3Pyfn7sKR5NZ4f
         Ja9QXT67AWEuFQU771XnCgOWwchyr8Uq/HlT5gIvgaD56M3g40FZBITaxO/iBW/zFobP
         w6OgrzaxvcWexjHMr9WM3hHUxROfO5ExfYX8E89CqbujJ4FADAXiRyuvNtuh3dzsGPef
         GhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078795; x=1724683595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEOQjEzzn/HqBPZ18pDBIIRbvNxud9LjmvFVP17dvK4=;
        b=Y6izAMdAC3jk6ixa88iwPt2TcbRSC8ABDi8AlcxOxlrmj+DcqIdcqHnjz8Td76EvLs
         yXVvMcnEuo/cLZ0ti3PNeh7izijG1f788YFL3TS5X0FO/DBT+sQLchWaAoO3v1z+/kis
         8wyhqgdd7x4a6rGWRHPYeMSQw71uhgmx5+OYsTpMeA3e6aSAZcrmkOuAu6GKP+R3QIHz
         OUEx3BJomZ0RU9p+/Qq6xPmPo8D3xsvPmd3YWcpSS09lRxpAS5dD5QfbltukJ71c9p42
         iMlsm4q4xAIh6T3gtVUUFROn7agZevBpEPIPrz36dGXa3UaHOHUghnidmJFtL9MT4w8d
         vXIw==
X-Forwarded-Encrypted: i=1; AJvYcCVHbrAkfZUXiJT6uRrPc8y0+J6BAfQr7DZc4zSb4Ujz1LrpC3NXkCBraruReefZS4s+ufeKaHsuw84dHV+dzYgwSMGPL6lS5w==
X-Gm-Message-State: AOJu0YxCU/TEH6IkEevn2bNqd+dYxdjBtmsdjdCgXaZOeO66zaQ5Fvpc
	rXVtqw3QSbK0nkXfqfx3Lq4B+UQyobfWtGiJKfG8BfJ8zU87oB9D
X-Google-Smtp-Source: AGHT+IGzgHSBDgt2xRwoslyfBpt+JVjbRe3+M01pBBFcthM43Cf57jvAp9r3aaqab7zRSNB0m+g/dQ==
X-Received: by 2002:a05:6870:7a15:b0:25e:b7e5:6b6 with SMTP id 586e51a60fabf-26fff4c0f63mr7380404fac.12.1724078795211;
        Mon, 19 Aug 2024 07:46:35 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-270049bb2d9sm2942808fac.36.2024.08.19.07.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 07:46:34 -0700 (PDT)
Message-ID: <a0bbbf39-82fc-4f41-a60b-7631716e536f@gmail.com>
Date: Mon, 19 Aug 2024 09:46:33 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wpa3/sae authentication does not work with brcmfmac+connman
To: KeithG <ys3al35l@gmail.com>, connman@lists.linux.dev
References: <CAG17S_O7LdFxW4OUAoN+zOJ43MpmSg5V5O-jxkUg4aMmN1eXBw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_O7LdFxW4OUAoN+zOJ43MpmSg5V5O-jxkUg4aMmN1eXBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

> 
> With this update, running wpa_supplicant and nmcli, I am able to
> connect to a wpa3/sae ssid successfully. With connmanctl I am not able
> to connect at all.

That's because the firmware is broken, as I've pointed out before.

> Aug 17 18:22:53 pi5 kernel: ieee80211 phy0:
> brcmf_cfg80211_external_auth: auth_status iovar failed: ret=-52

There's that errno -52 (Invalid Exchange).  Basically the CMD_CONNECT to SAE 
fails, and ConnMan (correctly) reports the error.

Regards,
-Denis
