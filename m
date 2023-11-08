Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4413067F
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3J21nWH"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso1301fac.0
        for <connman@lists.linux.dev>; Wed, 08 Nov 2023 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699465525; x=1700070325; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuXTTlwOYVKTpLFEO+j9EJ+1SLhc82cVl+euGvNc4SQ=;
        b=d3J21nWHmV510a1c5DHmKs8tAVwmvOHslLNrxfjeJSfMmQlfDpKVsAMTpDEAFpyrc5
         GYTiBKX5NRqt0wU1WMEZrEfUOv5Z86MKS83lSjvwsrdcMl0e5pZHzgxoIya5Pus4dlWb
         sbQW4iETmIf/7o1Oqr/k9LpTOqWp9fDtENZQfQiE9vNNUpI2kv2T/Ug7pUYcCT765s4C
         vYF0AIV81yJML6PILhDkK/YBb6O3xY4ROcIJYVCEqkFmNLBJMqQTd9iDdr3eLMeeMlVV
         +skB2QOoTePciuYwTb2E6j7K5yBHnWpro6MEOt3hcgwvAKr9OO4ISzf5muKE11WtyzD1
         MBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699465525; x=1700070325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuXTTlwOYVKTpLFEO+j9EJ+1SLhc82cVl+euGvNc4SQ=;
        b=Ise/0smIS/49lOL8zKqYrErxX8LWbGGdatptnLHhnwYY1UHmQi4RRYaTlKROyidoFD
         9sZf5rY7EKS9F6hdfdJXbBy6WgO/O9Y1ZyYOc0DZXEEX/o8CqMw1NHcheePptuQ8Qign
         F8orUkuKn1MUZD3bEtUU0iL3Zviu7NczGKcgx2Z7PNLyuRe5EzjD8tRR7cGdJFGe3uzp
         g5KgTzPc5xuOylGYf7lrZZiZxmBmqHE1ebZjVp+s0EujraejkbLQ+2bdV1TEou7Ujzor
         5I1dyeFfJplZhxD4P/y2qjhiKKxUcLPPR5sHkboR1OwyH/VgxK8tTpAVZ6+BWuuT/Ahm
         jJ8g==
X-Gm-Message-State: AOJu0YwsYfQ0fse8IdLBt0fJNtcAc9ji3aAWEu4ZpEFDEDYCDZDoIHs0
	grE4W2KZ7FPlMcWTsahtLVM3mqNHLRQ=
X-Google-Smtp-Source: AGHT+IHle9CzfUB9pAFHbSpnSLbPli9/iQ16/vUVosvqE4RfQt0eNDKq9BDQFUMPHnyBKMUWWHRXLg==
X-Received: by 2002:a05:6870:2887:b0:1dc:dcf9:18d8 with SMTP id gy7-20020a056870288700b001dcdcf918d8mr4064381oab.24.1699465525054;
        Wed, 08 Nov 2023 09:45:25 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w10-20020a056830144a00b006cd33d6fd5csm1955977otp.11.2023.11.08.09.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 09:45:24 -0800 (PST)
Message-ID: <a4e95ca1-61e0-40ee-a1dc-7d170075bc1a@gmail.com>
Date: Wed, 8 Nov 2023 11:45:23 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v3] gweb: Refactor 'parse_request_and_proxy_urls'.
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev, Marcel Holtmann <marcel@holtmann.org>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <538FAB81-E180-4D6D-B405-150F8553F843@nuovations.com>
 <6cb6beb7-73f1-4743-bff6-f822ae282786@gmail.com>
 <FBB34102-662F-49AC-A11F-7E92A455C5D9@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <FBB34102-662F-49AC-A11F-7E92A455C5D9@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

>> So I'm really trying to understand why this default_scheme is useful and self-documenting, but failing so far.  All I see is a single call site for parse_url_scheme_with_default() which always passes a NULL as the default_scheme.  So this branch is always dead as far as my brain is concerned. Why is this useful? Help?
> 
> In the original embodiment of the implementation, ‘parse_request_and_proxy_urls’ directly invoked ‘parse_url_scheme_with_default’, ‘parse_url_host’, ‘parse_url_port’, and ‘parse_url_path’. In particular, it called ‘parse_url_scheme_with_default’ since it had the logic to deal with the case where “http://” was not in the URL and passed “http” as the default.
> 
> Later, I refactored it again to add ‘parse_url_components’ and have ‘parse_request_and_proxy_urls’ (now just ‘parse_request_url’) invoke that. In that refactor, I just kept ‘parse_url_scheme_with_default’ as-is and wrapped it with ‘parse_url_scheme’ with a ’NULL’ default scheme.
> 
> At this point, I could either just eliminate ‘parse_url_scheme_with_default’ or modify ‘parse_url_components’ to pass the default scheme all the way through. I’ve no strong opinions one way or another.

What I'm nitpicking here is the current state where you are invoking a function 
with an argument that is always NULL and there seems to be no current or future 
plan to use that argument for anything.

I have no real preference between the two approaches you outlined.  Just pick 
one of the above approaches and go with it :)

>>> +
>>> +		if (host_length && host)
>>> +			*host = g_strndup(opening_bracket + 1, host_length);
>>
>> Should host_length of 0 be treated as an error right away instead of advancing the cursor first?
> 
> An early exit could be done; although I could also see an argument for:
> 
>      if (!host_length)
>          err = -EINVAL;
>      else
>          *cursor += host_length
> 
>      return err;
> 
> at the end to consolidate such a check / cursor advance in a single place, shortening the blocks / cases above.

Yep, sounds good.

>>> +		if (*end != '\0')
>>> +			port_length = remaining_length;
>>
>> Why does it matter whether *end is the end of the string or not?
> 
> I believe this was preserving a vestige of some of the original port parsing logic. I wasn’t sure why the original author handled that case uniquely, so I preserved it. I believe the else case handles things generally.

Just rip it out.  Lets simplify whenever we can.

>>> +	result = memchr(*cursor, path_delimiter, remaining_length);
>>> +	if (result) {
>>> +		path_length = url_length - (size_t)(result + path_delimiter_length - url);
>>> +
>>> +		if (path)
>>> +			*path = g_strndup(result + path_delimiter_length, path_length);
>>
>> Looks like you're running over > 80 chars here.
> 
> checkpatch.pl warns at 100 though the coding style docs mention 80. Which takes precedence?

I think the Linux kernel changed to 100 lines by default some time in the last 
two years.  Don't remember exactly.  We are still using 80 by inertia.

I'm fine switching to > 80 lines, but lets have a separate discussion about this.

Regards,
-Denis
