Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6F15746F
	for <connman@lists.linux.dev>; Thu,  5 Jun 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135484; cv=none; b=X6Ns+iYiONBeyRVgnbqdsPjtRQMggHeLE2BRdyDuzdSXY/Tv6nFAUBpl+9AlbQNaXq7HtchD4UQUCEY2Uj56BKTQshSKS4HCm2fehoiKOpDeDRqt/+/GdrVk5a3j7i/VECMuxodQm9KH3Q49ouCugDPguO/b2Y7KFaa1rOxyRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135484; c=relaxed/simple;
	bh=Hg+TeSLVnU4uJq0yzlmX8u6JQ2c8zkRvgCOAo50Oq4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rslwA8STLlNN6isGjx/H4GNkJKxOaKe1bWFXRyMS7xn6Xs7XKHm8H9SKsHPOoQgnos8gZlGoMzAkb8muJVT1L6NLH/8OOJoJCQrVJEqXp4nBDX7zcWPHPiRjsvlFdLR4fTsujWUKE7cPZNJds4riT6+ePOPVuku+GSzm4rCLNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO3yMb8X; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO3yMb8X"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40791b6969bso729063b6e.3
        for <connman@lists.linux.dev>; Thu, 05 Jun 2025 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749135482; x=1749740282; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Deexf4z3d5ZI6MphFkvpuYQTqQpKAodoCEwJ41Kl5OE=;
        b=PO3yMb8Xcd+RgQVvZMY4fndyLXgdXu+lV4PYv0s8nF5qN+nfsqHmE/t8wfCBBiM9vq
         OK/sCOWfW4zp1wm4o0Chf7cJUxQwOGMZam9rT6uP9oX1Cyb3n/gwIjHZVyy2/CJ7aACk
         uY/DNU+0rJgHCBINw076L7AFMAkBeUkVfexYsz1pFLpDGJZGtL1Dr/a0Umk3DgJKgIgZ
         GHjR8CwjG7EUd8Ewbap83kYTh346HtaL7o1PCV1WsGp5Y25BVgIg08lbctOWlOvCrJaq
         mMAJidqztVtGHSLIhSHfs1C6/N6+dWSla3AfYZ9vbnV7xZIl3ubiqeI1XlGlHptgdbJI
         LiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135482; x=1749740282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Deexf4z3d5ZI6MphFkvpuYQTqQpKAodoCEwJ41Kl5OE=;
        b=BR2EakNGxCeZbINYq79Gy1LANfKZ0yMfWmKGNt4HLEatPAN6RuNGCqQdofkMXSKY4Q
         wzOEuIvYskFHhkeNvy1AgSY7pDiHC2FonJca4hx5Ny7C2ePxhOEUnfIzWFrR+H0aApxF
         u4hewPkf4PkQB+NjhLmpn3PcbQiDE9XQCmLu+li+hfCfp5Wxs4jAaximRJzCDwNlq6TL
         FXw9Wp3aQFFZ+N0ZjCE3pk/GcVChcYmUrmTokLPXpwIY4MyWVRwWGoGax5olkaVJznA7
         EjFYCn5YbmbH5F51IVPGxJZ5usA712vzuowk6jIsSyI6xd1wS7j28DgH+tjzcu8/Ec7K
         zLtg==
X-Forwarded-Encrypted: i=1; AJvYcCXmIh8zVXd+xXZS8t46GbDQqNXEedXZe+tTRnyefcv6+PupG2lRnDaqlTjwwfFosAcBm+S1fyp7@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1t4eh9OisX/e40YPwwmLdUJi+y6rZMHF14nHzxHJhIMzyKZqk
	qtg5itdzJ/bODbfgALCw8xUC78YHTCBP7anz+hNBU7QX+qYnl7xRBKeRtQhexA==
X-Gm-Gg: ASbGncsFNBx9LjmIwuIkk7IG+PtqXD89UtFNYILaEVX6Mg7nqeR8HlKUfDKqsqlrrge
	qT8+9GWxdOUfG4Saua8wG2XZXOq2ypi8kdhQy0765eCw6yx5Cjxp5LAitGLlhgebjYcmncYUOq4
	nBfvUiqdou4qrstN9iSI4KlqCzx5ECEn/7jzlwwJ2fIGNMha1IOR9itmJVksrVR0D8yHo84Bh7u
	luUitpkIu8R9B9lPTqfIdaGPEP6k6jtnS6yHw4xhfW49SleBuHj7YHUJsvT1lZI4o2eLKijorIe
	j46uJytOPwyyLXEIRyABDD8rEQ8hCPwDoSZ2GrMvPccQW9lyI6kwJR8qtCejZr6MbSyM9xkaY/O
	yRA6RdxU91w8YpLpj/M0LwQG0WJg=
X-Google-Smtp-Source: AGHT+IHxBSqZnAAI4CIitKI1HoBM0hTCWK6VAPz8edTXaAmhcA09LFgQLXxTAxV1ER5xBR4lyravgw==
X-Received: by 2002:a05:6808:6a84:b0:404:ed12:453 with SMTP id 5614622812f47-409050d312cmr28085b6e.19.1749135482378;
        Thu, 05 Jun 2025 07:58:02 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-40678c1dbefsm2588447b6e.16.2025.06.05.07.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 07:58:02 -0700 (PDT)
Message-ID: <8e4ab5c6-7d9d-4357-9be3-d457b443518f@gmail.com>
Date: Thu, 5 Jun 2025 09:58:00 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] timezone: Replace Localtime file copy with
 symbolic link
To: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>,
 connman@lists.linux.dev
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 jussi.laakkonen@jolla.com
References: <20250605080336.21824-1-andrea.ricchi@amarulasolutions.com>
 <20250605080336.21824-2-andrea.ricchi@amarulasolutions.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250605080336.21824-2-andrea.ricchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrea,

On 6/5/25 3:03 AM, Andrea Ricchi wrote:
> Based on the `man 5 localtime` documentation the `/etc/localtime`
> file is expected to be a symbolic link, not a standalone
> regular file.
> 
> This change replaces `write_file` with `write_symlink`, avoiding
> unnecessary file I/O and memory mapping. It ensures Localtime accurately
> reflects the selected timezone without duplicating data. This also
> fixes `__connman_timezone_lookup()`, which requires Localtime to be a
> symlink to function correctly.
> ---
>   src/timezone.c | 50 +++++++++++---------------------------------------
>   1 file changed, 11 insertions(+), 39 deletions(-)
> 

<snip>

> @@ -537,35 +527,17 @@ static int write_file(void *src_map, struct stat *src_st, const char *pathname)
>   int __connman_timezone_change(const char *zone)
>   {
>   	struct stat st;
> -	char *map, pathname[PATH_MAX];
> -	int fd, err;
> +	g_autofree char *pathname = NULL;
> +	int err;

Amended this commit to remove 'err' variable in order to fix the warning this 
patch introduced:

[denkenz@archdev connman]$ make
make --no-print-directory all-am
   CC       src/tools_dnsproxy_standalone-timezone.o
src/timezone.c: In function ‘__connman_timezone_change’:
src/timezone.c:531:13: error: unused variable ‘err’ [-Werror=unused-variable]
   531 |         int err;
       |             ^~~
cc1: all warnings being treated as errors


>   
>   	DBG("zone %s", zone);
>   
> -	snprintf(pathname, PATH_MAX, "%s/%s", USR_SHARE_ZONEINFO, zone);
> +	pathname = g_strdup_printf("%s/%s", USR_SHARE_ZONEINFO, zone);
>   
> -	fd = open(pathname, O_RDONLY | O_CLOEXEC);
> -	if (fd < 0)
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
> -
> -	return err;
> +	return write_symlink(pathname, connman_setting_get_string("Localtime"));
>   }
>   
>   static guint inotify_watch = 0;

Applied, thanks.

Regards,
-Denis
