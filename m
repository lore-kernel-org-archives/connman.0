Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6302B2D7
	for <connman@lists.linux.dev>; Wed,  4 Jun 2025 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749074480; cv=none; b=U8xWAI5wMwpXhYWGkVG7vAV2vdXI5UKY3gUaJj6NOhXP5aLZReY3V/zg6GINjrMGujY9vzAyKNQPCdyokZIRJGVj/jjVMOTd9VF0/zMsrMu1YxLpVpADyORxoin+YMMdCbxuYl9agaOHm8u7Pfd2hDMdl2OEOQc78Vp9FIbLx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749074480; c=relaxed/simple;
	bh=V64i7Ww2ax+bK7DQEV5kaZVaL1MymSt1Zq2eBdrw5OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRIinci6/FF+cr3c8s32UPvCo1awFT1789lUa6zoNGim2CI6ccbPH/L4ousfh/Q5a9aca4M/IVdMlG2Jtp0akRBgGRXh6UGHYQFxUK0PIvwZSIf3iG1sHemjU2w+jhAIcrWnlbNLDjO4wY/8DjENAH3Ufs62yhahk5G0CWNi9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilgZY0LM; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilgZY0LM"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-40656384d30so274544b6e.0
        for <connman@lists.linux.dev>; Wed, 04 Jun 2025 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749074477; x=1749679277; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9seJdWg7EtPd/N10Ct40UMEohSOosNhG28/P5vFnQE=;
        b=ilgZY0LMfwrdLBD4aujuHuo46QezWxb9J1hk8H3pfWFg1NvR3PEwVGgqbnioKBYf6h
         P2eHQGYPCfzYtFNAOYtLYXAAUeFGB8Ru2s8HaR507O+IAsunRok7p6tLKTvwyirVoTm1
         S2PQFlHd4Vk7GJQ9Fp0bMOpmVQ4QddX9sYMuIRPdCpv6l/dnVNl7H/QwQ2o2QgjqcRSU
         BVmRkqQa6IWxNSjTaV8MJTvKg6Pl6abU0KbxcsztrGm2TmI6zGI1wrTnmf1j0QY4q7Gc
         +ClJou+iQlLqAYdW8gdj3JgfHjJ2xBtoaxizI5K9Njc/VrZ7jU6HW6Azjp4IJI86kBIz
         p7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749074477; x=1749679277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9seJdWg7EtPd/N10Ct40UMEohSOosNhG28/P5vFnQE=;
        b=B78fqE2NWoxOMpP+WCytfTmuPQe3+/GXLXEf8XPPDfbDm7L0eePoYfYjaTITOC9Iz8
         yM3y1n/nt6lJsZZrBv8hj3axnQR1kwQTIUCKKBZdhfH4zBExEd8ioXMqWS4C7bl7tH82
         J11ATnAM+j1wzQnh6/UzVCIi1bYtbEClwOVnGrwJ+wO+ClzNe+wdtWUAA/AmTV3cZcXH
         nBrs5UbNzmdKoHRU6pxyRktoQh5TTXxa2FMKyM83g8FcsbhAkR2CDH+IcgOsmz/SPM1l
         Nfg7wd2PRQasEhkc8UQfJMqKKfKjh8gVjOwJ6fbJ1Wy4pvDuwkkV6Ney+OQ4rug7fR15
         dJvw==
X-Forwarded-Encrypted: i=1; AJvYcCWXLhL9euODfNflaKgpiClG1fqrzmrZ12QMjjLLp7fz5TxfmAjEq/NpOghGvqWVAlzx02f61taa@lists.linux.dev
X-Gm-Message-State: AOJu0YxDPer4nqSjoG+FZP+dJrJv3f+KMHfUih/ySHijYraLRVxabBas
	luCBVnO4004UN+qHsWeawhdvgnicr7xj46t52x9OYFfu1znf8Rldr7yB
X-Gm-Gg: ASbGncs6LvudxLuHVL/hurAQlITtwDuZ9kdqFnnCVmycjqVUuO/VV32Uqyt7LnHyyi9
	9tu+aXTMR3CA62iELcl4APWYtlt+NtWy3gXY+O6wUNca7pcIiUnFD9gTZjxQ8tkqBn3JvYZmUPa
	etqIGkB5jYRSZMUvBMPVmcYSOJgWS4xgdHWKe17aqU1DGsXg5599apq7z3h9pt5HPh0H52ftOIF
	/U1h0sMays3kUWJKTL7KtjH0ahQkAAI0ZURbqpuGhkZuSGZgYDCjUnBlC0AGjNT1kP/s17jc5RI
	k1ICxe9y5cEOfYtjSsjq9zI/eCK5v8txxsfwO4dONziTU151vaiSOpjx6O8dzn685/Smoodh+cM
	0aT1dyL2PsNs5w8jMg5e1X7y0r8I=
X-Google-Smtp-Source: AGHT+IHfitfmk/TMIrOIP2w6+f1KSZ5jdLLSpkZvMnsrfL3DDbbMlD3bLEwvNusDD5Ic9cJEnjzj5Q==
X-Received: by 2002:a05:6808:4483:b0:408:e690:7e39 with SMTP id 5614622812f47-408f2bb67fcmr3117002b6e.18.1749074477496;
        Wed, 04 Jun 2025 15:01:17 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-40678ce839fsm2381240b6e.39.2025.06.04.15.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 15:01:16 -0700 (PDT)
Message-ID: <127bd971-d5cc-4354-98be-1ff9a4b271ba@gmail.com>
Date: Wed, 4 Jun 2025 17:01:15 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] timezone: Replace Localtime file copy with
 symbolic link
To: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>,
 connman@lists.linux.dev
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 jussi.laakkonen@jolla.com
References: <20250603134542.67627-1-andrea.ricchi@amarulasolutions.com>
 <20250603134542.67627-2-andrea.ricchi@amarulasolutions.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250603134542.67627-2-andrea.ricchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 6/3/25 8:45 AM, Andrea Ricchi wrote:
> Based on the `man 5 localtime` documentation the `/etc/localtime`
> file is expected to be a symbolic link, not a standalone
> regular file.
> 
> This change replaces `write_file` with `write_symlink`, avoiding
> unnecessary file I/O and memory mapping. It ensures Localtime accurately
> reflects the selected timezone without duplicating data. This also
> fixes `__connman_timezone_lookup()`, which requires Localtime to be a
> symlink to function correctly.
> 
> Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>

nit: ConnMan doesn't use this tag, so please leave it out.

> ---
> 
>   Changes v2 -> v3:
>    - Splitted commit
> 
>   Changes v1 -> v2:
>    - Change commit message
> 
>   src/timezone.c | 49 +++++++++++++------------------------------------
>   1 file changed, 13 insertions(+), 36 deletions(-)
> 
> diff --git a/src/timezone.c b/src/timezone.c
> index 89c44895..9b820477 100644
> --- a/src/timezone.c
> +++ b/src/timezone.c
> @@ -507,28 +507,20 @@ done:
>   	return zone;
>   }
>   
> -static int write_file(void *src_map, struct stat *src_st, const char *pathname)
> +static int write_symlink(const char *target, const char *link)
>   {
>   	struct stat st;
> -	int fd;
> -	ssize_t written;
>   
> -	DBG("pathname %s", pathname);
> +	DBG("pathname %s", link);
>   
> -	if (lstat(pathname, &st) == 0) {
> -		if (S_ISLNK(st.st_mode))
> -			unlink(pathname);
> +	// Remove existing file or symlink if it exists

No C++ style comments please

> +	if (lstat(link, &st) == 0) {
> +		if (S_ISLNK(st.st_mode) || S_ISREG(st.st_mode))
> +			unlink(link);
>   	}
>   
> -	fd = open(pathname, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
> -	if (fd < 0)
> -		return -EIO;
> -
> -	written = write(fd, src_map, src_st->st_size);
> -
> -	close(fd);
> -
> -	if (written < 0)
> +	// Create the symbolic link
> +	if (symlink(target, link) < 0)
>   		return -EIO;
>   
>   	return 0;
> @@ -537,33 +529,18 @@ static int write_file(void *src_map, struct stat *src_st, const char *pathname)
>   int __connman_timezone_change(const char *zone)
>   {
>   	struct stat st;
> -	char *map, pathname[PATH_MAX];
> -	int fd, err;
> +	char pathname[PATH_MAX];
> +	int err;
>   
>   	DBG("zone %s", zone);
>   
>   	snprintf(pathname, PATH_MAX, "%s/%s", USR_SHARE_ZONEINFO, zone);
>   

It is really unlikely that the use of snprintf will cause problems, but 
generally its use along with PATH_MAX is discouraged.  Given that this is off 
the hot path, I'd recommend using something like:

g_autofree char *pathname = NULL;
...
pathname = g_strdup_printf("%s/%s", USR_SHARE_ZONEINFO, zone);

> -	fd = open(pathname, O_RDONLY | O_CLOEXEC);
> -	if (fd < 0)
> +	// Just check that the file exists and is a regular file

C++ comments again :)

> +	if (stat(pathname, &st) < 0 || !S_ISREG(st.st_mode))
>   		return -EINVAL;
>   
> -	if (fstat(fd, &st) < 0) {
> -		close(fd);
> -		return -EIO;
> -	}
> -
> -	map = mmap(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
> -	if (!map || map == MAP_FAILED) {
> -		close(fd);
> -		return -EIO;
> -	}
> -
> -	err = write_file(map, &st, connman_setting_get_string("Localtime"));
> -
> -	munmap(map, st.st_size);
> -
> -	close(fd);
> +	err = write_symlink(pathname, connman_setting_get_string("Localtime"));

Might as well just use:

return write_symlink(...) and drop 'err' variable entirely.

>   
>   	return err;
>   }

Regards,
-Denis
