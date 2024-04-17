Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C718C1F
	for <connman@lists.linux.dev>; Wed, 17 Apr 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385032; cv=none; b=KR7ZpkZLa32en883v0QKKJvqzit/VQaeQreQvnT9DxvYVLR0ruMtetTswxZn7PsuLKZ/f2HvDKm45Xb4ls3LtU87IczdC1xcWEW7M4pxaAX+apBIjwzPJgRPwJM/92H0QK0MnMSWmy4+Ih5/PVUpbUpDaleXejrsgZiBgFTwbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385032; c=relaxed/simple;
	bh=9DUXed4eBdv70Vyr1VKwS4TEqrkHwr3RCqgVSeKRtjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rBG9emHOWfz16VTG1u5Yt171Z3xx1BENFBpof5vk2lHjWdJPk+PHr8mljCw7nYoQouCnI4f3jS/hbq5PedRXJCMreIzGvZJRC5KR6kJQsvNDNTXbydVumXHQYDkPpQmY9ZAZ096L+pnqgCgnhYsXLTSXDOt9FvdguyprOD8qkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo+h34hl; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo+h34hl"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6eb77e56b20so41280a34.3
        for <connman@lists.linux.dev>; Wed, 17 Apr 2024 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713385030; x=1713989830; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTX9DsLxm8eJwJ4KzKerra0ZDt6uhi0RTyPy7UXzugE=;
        b=Eo+h34hlWUz+9+QXAQW8ZZAQ1t+WOSTTHDZAVFR53RpWnSmZij+A8oPy93M/ySvPeQ
         7vNmFNjfk+YxsTpYh2cybtuxlmVKd3/R0fgrP0t6e3OD/Rran0fivzN/wsNw2xmVPR3+
         5EbRBdX+XeF/TnhwpYxrzMQ8hYT9pr/o5bQ/qRzn6CWLzybIuyiLBVuTCTVdZc+PpmEq
         CfQe4ovtNJ9xVsoAHn+0jBmdJYQ3utOyU1YnUkqVqD5ei8Z6AR9OI/eQ5eIIcx/I9wse
         c1MPVlnlpxB/Qa3YErqwYOINjg+BmsC0xKMTVW8jcb/TuJqSpQMQD3beuUYfGpC6dOzk
         O7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713385030; x=1713989830;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTX9DsLxm8eJwJ4KzKerra0ZDt6uhi0RTyPy7UXzugE=;
        b=T4o8Lm97GxO/Ch4R34rRCTEhMF+8ykREr9Q1Vxrabv242Mt2LGMkMM8EorKiy9Jogz
         w4V4prkZgqkvUnr1h+WxjexB1TxMkrcyUF67R0nP8ifUyRH2Vyfeek6X+puM1/mdsiR9
         DQib0Wi9zmcOWqoCYSCWtuLZGc5cEJi239TYN9M7xyhXd9zaXw/H4/jr59HpSMk+Ldc1
         NYFrnbVtdEfkQ4dFNdfUJ9qNBQSf5a98x93qQOIqWC5rnoke+kHOGLFWYO0Pi02c2tkG
         /9na7p3Q+etlKR5LqZw84ah65uTi9gl3YGWwGwT4Tkud+EVdgFYggoRdhJ+AlZYZ0KfY
         nQXw==
X-Forwarded-Encrypted: i=1; AJvYcCUHmpInDfsYYxFs+izyge7ewxsnF5kX4QZznvbqRyA/2dq2oLp8Jl/EYjBtFXJM/n+nC4G61VCjzHriPLNjW+wzOHAsm+ecJw==
X-Gm-Message-State: AOJu0YyrnGLi8LK9PYaOcB6OGMr5j+hd1xs54ItnSyiCmqg22utWBx+K
	+6IJ71srBPotZsyRdpcI+1Ggn6QQF1Q0EAXSQVDqpk+PPbikXcEG
X-Google-Smtp-Source: AGHT+IECodiYaLce+PwTZhsiBonlnAOcc6utbn19vZKNeigY+0uYqJtojABAOFhDIRVnMXBdb5m7sg==
X-Received: by 2002:a9d:62c7:0:b0:6eb:5d80:de74 with SMTP id z7-20020a9d62c7000000b006eb5d80de74mr576054otk.33.1713385030589;
        Wed, 17 Apr 2024 13:17:10 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v26-20020a05683018da00b006ea2f7c7c60sm28507ote.23.2024.04.17.13.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 13:17:10 -0700 (PDT)
Message-ID: <573bca20-efe7-4421-9a50-eb8111fcf1ca@gmail.com>
Date: Wed, 17 Apr 2024 15:17:09 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dnsproxy: Fix cached ttl update
Content-Language: en-US
To: Brian Fukano <bfukano@gmail.com>, connman@lists.linux.dev
References: <20240408222431.94411-1-bfukano@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240408222431.94411-1-bfukano@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian,

On 4/8/24 17:24, Brian Fukano wrote:
> This bug was exposed after fixing the signedness comparison warnings
> found in dnsproxy.c update_cached_ttl() consistently comes up two
> bytes short when processing the last record.
> ---
>   src/dnsproxy.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/src/dnsproxy.c b/src/dnsproxy.c
> index d4242560..506e1b9d 100644
> --- a/src/dnsproxy.c
> +++ b/src/dnsproxy.c
> @@ -508,8 +508,7 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
>   	if (answers == 0)
>   		hdr->aa = 1;
>   	else {
> -		const int adj_len = len - 2;
> -		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
> +		update_cached_ttl((unsigned char *)hdr, len, ttl);

Looks like this should be dns_len?  Also, the { } around the else are no longer 
needed.

https://datatracker.ietf.org/doc/html/rfc1035#section-4.2.2

>   	}
>   
>   	debug("sk %d id 0x%04x answers %d ptr %p length %zd dns %zd",

Regards,
-Denis
