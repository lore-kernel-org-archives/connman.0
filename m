Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CB2741D8
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645332; cv=none; b=mkvGvSJHG36o/Fnhq/5ENIaKMrrNouJ+lzMk0CMBX7BnCtm5wxSTPPBGrMfUAFwLg/KDWM1ikCTxeIoKCkoVXg+j1amio14CH8a8jwMhYT0GYBivmkdp75XFpPhxqw9zlkeysr8GMAIw2sUXyLlOrulJa52q4zXvvgW20Ane2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645332; c=relaxed/simple;
	bh=Bx5DYKrEls2DO0paxLE0PgyAkdXpJoAcFXlUCOvhDpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EzZUXcWb+Ym708bZIQ1XQ/XSGwOpWeFqEc6NDVS9NtB9JG3GeJ4ZXrFBnk0LJv1GUYTZ3UEmSXszLUp/r07NS4lTGHMiYnZZOcemOwmNF57I0WoNrE444CRK1F5uZMNciId7tLBSBEDYvJ7lcXKHI8Fa+7fs67nOQqhkxj4jMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZBvVYsm; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZBvVYsm"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c3b863b8eso2839585a34.2
        for <connman@lists.linux.dev>; Mon, 14 Apr 2025 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645329; x=1745250129; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evpaFjZvqkf8PRzGiTTkMx5PnNtXvHB/WgS6S4pXCVo=;
        b=jZBvVYsmFiO5kROil/AsELNgyvLhdc8GbqCTBJze+aagITavoHsvSadCkZnyUyN0Lm
         sjctaQs9Gv7EpakbdFbYmwMEFOnjNkLa4xoyMefnulFAvSXuEpx/lhLCIRUrDYKzqN+g
         hk+sTQNIoMfVq535h/3RQo/cdy5ypeGTQ2hfQlP101350ZHJ1DDBTx5JsRjVQV0nRm2T
         dJwAOA7fzjVkdEqH7i5COMmHErkUs2ZlrjifIedCjZIumj3CgjzBc5b0dJ579TBx3+h5
         hA+N5S/BzNWcbZZXjgTjZBKz9P0tuSC4dnbBOJ9Gt17Ys0TNJwnLjuSQ4nDRcAnnCpUR
         q1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645329; x=1745250129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evpaFjZvqkf8PRzGiTTkMx5PnNtXvHB/WgS6S4pXCVo=;
        b=cYTzUQpMcebJ8McMJPKd99hX7VSmA2mA7jfCjgW0zVNuehas9Z+OwZ3yxdATXwWYAG
         cI8yPJE73ZaDPj5+ED7CxNHyioslHr6Bs9GooqPCyvy7HgFSVNedauJRXAIUChSo8z1E
         EfbnQlA6cM0cAnlgOFofAoqOZPk1t1uYR+7QRenxC4qM4vjq+hhkybteGDl28tNXMXCz
         RUxMNUgk4Ka3WSJdM+dueCmqIEDBgDkRt2EOoQRLsJo9vjp/riBU7XsvOdl0P45UvWv/
         7TdsCCAoBY9I7KWMm5yq+x3Xr+0KYw+liDixgRdfVeHGJEDZYK09/mDVoshfBrg+maV/
         s1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNP8kgJ9y/JCwa5z0wTFfwzbKsxvrYOmcwrVDfWfzOLir/HtWUxQykxdHH7ujGDn/lYLGjJnbF@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu/JjHHXCb3i2pfmvUIdmYykOZ0u6cU5lsGlwXfc6uMl/pw94O
	1qpisCWiyuId+IoSg983BspbkPUkj4pOWE7lS9Oocjk8VNilp6reRiHulw==
X-Gm-Gg: ASbGncsSNpRpvy1o4PDTsjTDAcYHzpmFhUfDZSixH35J0SizN5JmW1ujFetC0KQ9tYA
	y5T1hDRwciNT5vigbE8Z3dgsG8EM+zHh5n7axUo2AhVXTtb/Is9ZeO9h40aMKlm/zI32925TSqZ
	DDojcTAaGLyzMLkO0SLEMpe5LylBJgnpm7VZZGR2KlWBIvk8AeZ+SdUyRZqUih1lzgskNegN1fS
	r09R8Cg54Bk1s0TdwOzTrQdFjoRPdA3gDrOvcdGS8D+cZOqTlee8/FB4lydcfvfD4uPk7iATTYR
	RpEjGrBL67IgfmgYgNsgyZrYijP243j+DrTWCBRgpB7pSk3nRjrK2GoPSwRXzltNuLk48RH/sAM
	0KznjBw==
X-Google-Smtp-Source: AGHT+IG9Vdv/dX+1q9+mAZkl6P2fGqctvUnHDNTR318DC2ZJ0AvvV+4qFKmdDzECvussmj205Irt+Q==
X-Received: by 2002:a05:6830:3816:b0:72b:9fb2:2abd with SMTP id 46e09a7af769-72e863c2800mr7620745a34.20.1744645329274;
        Mon, 14 Apr 2025 08:42:09 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72e73e4e290sm2037464a34.51.2025.04.14.08.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:42:08 -0700 (PDT)
Message-ID: <321172c0-abe5-44ba-bf03-ad22a1fb1ba8@gmail.com>
Date: Mon, 14 Apr 2025 10:42:08 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] ipconfig: Fix Clang garbage value complaints
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
 <20250410155846.252858-6-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250410155846.252858-6-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 4/10/25 10:58 AM, Jussi Laakkonen wrote:
> ---
>   src/ipconfig.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/ipconfig.c b/src/ipconfig.c
> index c2d7d2bc..ce4bbc27 100644
> --- a/src/ipconfig.c
> +++ b/src/ipconfig.c
> @@ -3,6 +3,7 @@
>    *  Connection Manager
>    *
>    *  Copyright (C) 2007-2013  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2025  Jolla Mobile Ltd
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -325,8 +326,10 @@ static int read_conf_value(const char *prefix, const char *ifname,
>   	// null-terminated variable argument component list.
> 
>   	path = g_build_filename(prefix, ifname ? ifname : "all", suffix, NULL);
> -	if (!path)
> +	if (!path) {
> +		*value = -ENOMEM;
>   		return -ENOMEM;
> +	}

Looking at g_build_filename, pretty sure it also never fails.  It is customary 
to not-side effect any inout arguments if the function returns an error, so 
setting *value here is probably incorrect?

> 
>   	errno = 0; /* Avoid stale errno values with fopen */
>   	f = fopen(path, "r");
> @@ -337,7 +340,7 @@ static int read_conf_value(const char *prefix, const char *ifname,
> 
>   		err = fscanf(f, "%d", value);
>   		if (err <= 0 && errno)
> -			err = -errno;
> +			*value = err = -errno;

As above.

> 
>   		fclose(f);
>   	}
> --
> 2.39.5
> 
> 

Regards,
-Denis
