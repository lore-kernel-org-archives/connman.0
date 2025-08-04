Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE11B4F2C
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333654; cv=none; b=Zex2OpjfH7t/wDmMmt7Bj5s+Xkt7zrGtAW9DRLj59L5hliXVpBqY4iZIoN6ozdjOaXUt8fjXMI4j7qQUZLXzl8seL+n9lNCKjcQwKkb0UJuRWw6Y072gxYhFO53+CG6lO84G1Lr3w2H2sodBc5v5lbJJe6M/NOq/SiaosTkW/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333654; c=relaxed/simple;
	bh=W6ZzIKa88e+XYaP5coq/aVS9sCHgiRlNUWPU30j0oiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyUx1Kgd3nhdwNerOYXZXzElbZP7HpePlbr7pc9nr4dBlWa/buywgrhFi1UV9zJJarrUqmSBER1BhvG0KJ5iQwT4fzZAI3MZR3XtVcD2IOwZyjLdfMR85UfvvVIy6Qu9CyPE8wFNbx0ILp/WSTXwv/KnmZ0gijjD9mt4/fPUN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/q0pVIG; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/q0pVIG"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7419f3428c9so769630a34.2
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754333652; x=1754938452; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AE0+0WvL54dD5b+KCXnVYpSwx4aAGAz5Ya9P09lLsaA=;
        b=i/q0pVIG+mVvgiiVQikuCCGqa6qFb0gZaWVy6iteUzY+SUWmxslNHMxrlkuf9P8/+p
         3d+cggMCC82BIM4/ldef7IR274wvUywDZ4jYE3LcmYdg6cHqQAzqnmKdqdkpcZnkOCaV
         jWAzwY5JF5vxl/wte9ZrmH/RyJKcRc2558WnD6JBqbLhR80+K9Rzj+S3k5FMB1lU3rHh
         4+Yvm2uS6kHMgPE9OM/XxLJ4v/0tfKxAQ1pq6rNGTraBmBDzZwElQMBIcHNaxB3/+BH6
         /awjvclTmiqmEZkm6EmICBk2YRG+XM84FS0j/AXuIeh3FQHf/kVCvi+P6bzQw1U/Bchk
         It2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754333652; x=1754938452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE0+0WvL54dD5b+KCXnVYpSwx4aAGAz5Ya9P09lLsaA=;
        b=CMtuYCYrlxz2KxCtxXElLSBT+ycYlNJgdSY0ZGYYTkKErmFOZkLBU8dOSdoQ6yBv+t
         i0ehUajVTbVHoydGSfaGdE6KQXHwi62AeG0F3da9zNHxrO4xIezp7luZ72BOqt6hSDOt
         G3VFei3H+UE3tF0oi4suKkI4VM/iQhKTOmz3qH/IOg8FsKW41ZeAXqZxmxUm4yr2iHiw
         xV+vPRcRy69aMSK5I10wt7knouPoP1Z8QLoFullTWGQrBUE/ELGnMFZN75yz8PdDCUKc
         igl4/N2ZPUHpRvBc1rtyER/RTd36Gir7vZBpXE9EjzN+Yju5R5ENuyAuDEGIjJBOlpqE
         KshA==
X-Gm-Message-State: AOJu0YxwA8Ej1dhh8siqJ2aCnrVgHylxJHUVpNdsAcqnsl9+ef+C3m8b
	c7IzbJvtU4iJgHnGoIsfM8zgq0jEFQf0PQpbH0UQTiqxUwV4/iNwwR4vl64kxA==
X-Gm-Gg: ASbGncutRz0mlf0JtxdxaP+3HyGIiZEnq98+uWwqBIRZ1OWBE23i7SNmd6fbAKliRot
	s8TkXNh8ZWx7nKJwbYyYgIl+vZorboIQChaJwHON3IOTh5QKq3NwiPTKiXLKxBogcanduNLxM7c
	aiG6iFJ8v3UnDQkaLAAePI00sC85pqR8MVCczqoCmLOOSt3QPxKRQcpPWK8ONu/coNVmMRYXvCu
	X9atl1HR4JA2tZX5Ro2FYcnSGPvlyPW6azFI9km6ogK2IXBCBADLGCmzQ8yeYc7ZyY2QZRZvaX9
	qP8CZvlt7ZPmqgTxpJYFGCatErsFj5fA79zkrnOPC4NeD5lQRFj+B7vr21vVfqQwcZEbNG9+B06
	/Usn2hqOBqbgnvh9oJ1IG5pCda9FTTfAUVj+YXsmCtqHBz0gzzwxWjK4t2Cbw0StR/ynA475z++
	cEAU4sdRT4Jd+aFcOLTyds
X-Google-Smtp-Source: AGHT+IHJyVmSRtxFjvkbmZsNUc6jsTGaMKz4hNvZwukI3pnKp6DVRdaFGNX66dXqVPPq+1vW5eCa1Q==
X-Received: by 2002:a05:6808:302c:b0:433:cf8d:4890 with SMTP id 5614622812f47-433f0242483mr5912976b6e.12.1754333652365;
        Mon, 04 Aug 2025 11:54:12 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-74186cc4e0csm2349774a34.20.2025.08.04.11.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:54:12 -0700 (PDT)
Message-ID: <360f4003-196f-4d50-b08f-dd22c40caf3d@gmail.com>
Date: Mon, 4 Aug 2025 13:54:11 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] technology: Leverage 'DefaultEnabledTechnologies'
 setting.
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
References: <20250728223217.3991877-1-gerickson@nuovations.com>
 <20250728223217.3991877-3-gerickson@nuovations.com>
 <34d2345c-58a0-4e1c-9943-549863b7b060@gmail.com>
 <509FC512-C600-4AD7-9640-B8C1FE7AEB0B@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <509FC512-C600-4AD7-9640-B8C1FE7AEB0B@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

 >
>> Perhaps instead of duplicating these strings everywhere, the CONF_* defines should move somewhere as public API?
> 
> Fully agreed. Do you have any preferences on where?
> 

ConnMan uses a single header file (src/connman.h), so that's as good a place as 
any for now.  Maybe in the future we start modularizing the code a bit more, but 
that is a battle for another day.

Regards,
-Denis
