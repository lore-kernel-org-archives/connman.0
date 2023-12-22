Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D982C186
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8N5JTNO"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ba8c218fe1so97868839f.3
        for <connman@lists.linux.dev>; Fri, 22 Dec 2023 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703269127; x=1703873927; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJ/ZK3p7lTDs/uHxBV6qpAlKQpzxmbUwbmwdtFSss0o=;
        b=N8N5JTNOn2Iu4lcBdrCZfVLawr2mxjh19jVeNrl4JRwdR5a0W+QyOd8rcws5CZHAvH
         FpDYASsq0WVFc2cz6XCLWLieBB9tj2ti/Qw7BVe4JuAWIz6J8SolwMnImHP8DAaqlAt3
         0pREGgvUHN74Y9k4TN53R0oohTT+Q9tGsJ7AmsqTJLhF8YecFy/xbdJ/VJe+3R+tn+58
         dY5rCJlRdwYZGlAsqGNSgH6bt6on3cdchxNCx2tu6M0nqfbtAFAM7VYEj4VVmb7ORg96
         ZruZdGnQym9OTfufT5P3hbJlUVyWdV1+lcTYr0Azim5n8yDRPW4gGNvAy+HRM7vyXr06
         pLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703269127; x=1703873927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ/ZK3p7lTDs/uHxBV6qpAlKQpzxmbUwbmwdtFSss0o=;
        b=du47qKy5F1i7DcbG455nykSQEREkgHX8qpQ4CFPED5SW8MXM7s1dA/c9G+w524KDdX
         /x9juPcY2cVCOq2VaKuykpMZlCeP/ycQaezl4xL+LIm8NhayLaMuC6jrLXJr4I8HBJHO
         IJBsFuI3549ksFRxPuj9I7X6tztYoBhKhAauuRF+ENTQA9GxLft35gDfMgdCK3VWiGYK
         cD07mGqGbV0auMzUX+D0cectVmg3yXXd3Gk4sgUd83DCRyj4LuSOLzcQC7Jjl5Z5j/t2
         /yXvxTW/7uyshOTaKTOZiQutFNE3viQM0j82Z5uJLQTxQIAjeXqEJjXuY4lKw4X/8rZL
         ksAA==
X-Gm-Message-State: AOJu0YyAh/MqWbkPa55A9NyRSjEsJ/fumNwcaSC3UBG75kIWBd5eEpxJ
	usHlQMNHgvZkTU4Ej67Djt3hokZ4GAY=
X-Google-Smtp-Source: AGHT+IF/fGlVtZX93lvm9ds4Z3h/waHqGtqNyqB8cbNdCIKNVbtLFnfRRcIbHRhfhggAyZXA0Ifb2A==
X-Received: by 2002:a5e:8d15:0:b0:7b7:aab7:1406 with SMTP id m21-20020a5e8d15000000b007b7aab71406mr1781926ioj.40.1703269127406;
        Fri, 22 Dec 2023 10:18:47 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id ci7-20020a0566383d8700b0046ce69fc447sm1107021jab.8.2023.12.22.10.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 10:18:47 -0800 (PST)
Message-ID: <e18f7683-5cf0-41bf-9a10-930d7a76b848@gmail.com>
Date: Fri, 22 Dec 2023 12:18:46 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] main: Use static global rather than 'General' string
 literal.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <20231221070523.2354507-1-gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231221070523.2354507-1-gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

>   
> +/*
> + * This is declared as 'const char *const' to effect an immutable
> + * pointer to an immutable null-terminated character string such that
> + * it ends up in .text, not .data (which would otherwise be the case
> + * for a 'const char *' declaration), and with the 'static'
> + * storage/scope qualifier, the compiler can optimize its use within
> + * this file as it sees fit.
> + */

I think you already had a similar comment in src/gateway.c.  Since this is 
something that makes sense to make into the accepted (and encouraged) pattern, 
would it make sense to document this in doc/coding-style.txt and avoid 
replicating this verbiage across the project?

> +static const char *const general_group_name = "General";

Given doc/coding-style.txt, item M3, should this be 'static const char * const'?

Also, since you're using this somewhat like a #defined constant, should this be 
capitalized for clarity?

Regards,
-Denis
