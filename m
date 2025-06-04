Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DA1A42C4
	for <connman@lists.linux.dev>; Wed,  4 Jun 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072608; cv=none; b=ludkAFlHxq05KVe4f5ki0seep1Ns2L/b2sLBRm+3lezLhfDICyf7tsS1NnofTWyQJZgMBrcm6lNLWQe4iNj++zNBEaecvVhnOYsxLmO2c7t7Ry4W2JmdhA9gTjOLO8Bz3p6yx0JvKz9cPCWUXdF2T2fHaOylVD8JFdDJcB+m168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072608; c=relaxed/simple;
	bh=naIPo9CzBbRMgOAnBgnIiMVCjveCpLNcT7j7wS0/fVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmvJ9vo6j3M1I/VyRZsDzKztoXxPHbsnDQbT2vu2AEnqPE4or3e5d+77MKPI8IpQT8DZaSY8Rwurfo3rpvtlkjmEkv4FHRaIuG4/+TNGOjCoKxpU//EcZ8Gik6Vi99QUucSkhKPy3WFUgSyn9haLnWA47dWnNyMoY85hMTiRF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqT3yenl; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqT3yenl"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60402c94319so165515eaf.1
        for <connman@lists.linux.dev>; Wed, 04 Jun 2025 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749072606; x=1749677406; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jd7kVb+fAIyHnSrhzPwD8nkoyk/kXE1VBG6SJ4INPmk=;
        b=XqT3yenlXpaf9KDCLEK7H3XcLSlxMOYUp5we8CZyHAeSkHV530OlbPPXeeSNbOPyQQ
         f1OU8OUhwcrGC6H048RKEBFJO2ApMwjOlgGTrsq8OQq00YZSNHYPLRPGbniKm1Fz05lU
         8k3NaHjGKy7Cu1XKOzYAZ0mmnskaDdyPw2Uh76JFAcdEt12xdM7Ds1Gfo3IIzXsh9nwp
         M90gOlPXsSQlU24IzaTWlIgIjlntscjO8GCJ2w5jWWZNgIcRG5HK8z4cuYETS9p/kLkk
         9EqolLQ7+2uW31ytIk+0lZL1WvO3h6Pj0n4W0liZeeN2ekgWNZBnNg8vf02elHhCiOoH
         1cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072606; x=1749677406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd7kVb+fAIyHnSrhzPwD8nkoyk/kXE1VBG6SJ4INPmk=;
        b=EZkDlrupUwKkizTkIfsswdGyKsGdmRDeesoHIaAIJMMNHjDIx4ciMUM225XPSq8OcJ
         4a3FF8zYHX1Jgc6YARNR1hLsDpQOE9chwxRhJ7yZP8nN1P+cDVf60Hsup8DQ22zT3/Z/
         EKZkwH1tStAFPor6C8tkY+hYbxTfcsvYUx8wekkKDRFAZiaGN1ggw7TAl3aFITivSSRG
         maAolcsIjQxucZuCNVchzu4BF96QqAuNGbBPIRBvL6Grbjm2PYEji3zv6bRhBgWWlY5d
         K/5/cxuSoLc7XcNlc+OtYcZ7lLJNa24Ml3W5eWqheLVHq28eTKPv/8g26ier4Bw7TDzW
         QkLg==
X-Forwarded-Encrypted: i=1; AJvYcCWjlGxVLWrRN4O1DQEZKcSl7+82lpz9xufxCkeY/wGxlRMBTTt+oun6N8z8X6HhNatBnklZnYL/@lists.linux.dev
X-Gm-Message-State: AOJu0YzWYzc4IRtTxO7lUYg2GmnKpAU3/KlWdMI4J2Ijk72QJMUzsIDP
	eVBhNrziL94jxDZvYE+DpGaCHBXENDa8h+HZlRAec0dD9cYNp64+RQpxei9q5w==
X-Gm-Gg: ASbGncvxLq0Nk98e2LS4+XENp059fXFOh5v+5WnRdPQfZyJDBWI/YljVR0fwcYKL+N2
	79T5Anh8Ypt97fnOLVn6EdKMhiE33tlLu/EaD3L7L+HPJunrOd0/LGu+d0rn//uYXAqDeXHe2L6
	KLSXYsAtBpvHy1vRpxkAbdfzKwibv6FC0b2Q8L4iKzpYXlIh2ycbn7FdmIpMsnJYz8KlWjPHuVj
	XKDlcmiKgRIsr0lz1KeibaM8L+NTN+/J/fO6UX2h72XPinXK4IhnsKTfjfqP940nQ1GhSUJHcjh
	GdPc0gV2n5sEgsypZ+86vGM+UdT7afDcGKOdwyXtNRNSN7KTlAx3gTcyp7GQRnRG4veAOj8WsVT
	mwznQxjBbEDYKcgbkRfhRX6A5los=
X-Google-Smtp-Source: AGHT+IEHo4FT/p0geqCtctDUAfSoWmwhySV/JVKFW4toTDddgB3ApwRlUm8a/J6ZAxuYQvLASMUHNw==
X-Received: by 2002:a05:6820:4b8a:b0:60b:cd81:9079 with SMTP id 006d021491bc7-60f0c9a66a4mr2713517eaf.5.1749072605671;
        Wed, 04 Jun 2025 14:30:05 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60c14c427e8sm2364668eaf.3.2025.06.04.14.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 14:30:05 -0700 (PDT)
Message-ID: <92771f8d-12a4-44fa-b9d0-a473e15b5e7b@gmail.com>
Date: Wed, 4 Jun 2025 16:30:04 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] connman : Add null check in prepare_target to avoid SIG=6
To: Shailesh Rathod/LGSI GPOS Dev <shailesh.rathod@lge.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Cc: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
References: <SE1P216MB264701D18124CD7147BCAF1AF062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <SE1P216MB264701D18124CD7147BCAF1AF062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shailesh,

On 6/2/25 1:49 AM, Shailesh Rathod/LGSI GPOS Dev wrote:
> From: Shailesh Rathod <shailesh.rathod@lge.com>
> Date: Wed, 23 Apr 2025 17:48:14 +0900
> 
> Add null check in prepare_target to avoid SIG=6
> 
> When Ethernet is connected and an attempt is made to enable the SoftAP,
> a SIGSEGV (signal 6) is observed.To prevent this, add a null check to

Can you please provide the relevant backtrace in v2?  It is hard to see what 
this patch is fixing without some more context.

> avoid the segmentation fault.

Same whitespace corruption with this patch as well:

[denkenz@archdev connman]$ git am 
~/Downloads/connman-Add-null-check-in-prepare_target-to-avoid-SIG-6.patch
Applying: connman : Add null check in prepare_target to avoid SIG=6
error: corrupt patch at line 11

> 
> Signed-off-by: Shailesh Rathod<shailesh.rathod@lge.com>
> ---
>   src/iptables.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/src/iptables.c b/src/iptables.c
> index a81a077..54e04d3 100644
> --- a/src/iptables.c
> +++ b/src/iptables.c
> @@ -2746,20 +2746,21 @@ static struct xtables_target *prepare_target(struct connman_iptables *table,
> 
>      switch (table->type) {
>      case AF_INET:
> -       if (xt_t->x6_options)
> +       if (xt_t->x6_options && xt_t->option_offset){
>              iptables_globals.opts =
>                  xtables_options_xfrm(
>                      iptables_globals.orig_opts,
>                      iptables_globals.opts,
>                      xt_t->x6_options,
>                      &xt_t->option_offset);
> -       else
> +       }else if(xt_t->extra_opts && xt_t->option_offset){

Please refer to:
https://www.kernel.org/doc/html/latest/process/coding-style.html
Section 3

>              iptables_globals.opts =
>                  xtables_merge_options(
>                      iptables_globals.orig_opts,
>                      iptables_globals.opts,
>                      xt_t->extra_opts,
>                      &xt_t->option_offset);
> +       }
> 
>          if (!iptables_globals.opts) {
>              g_free(xt_t->t);
> @@ -2768,21 +2769,21 @@ static struct xtables_target *prepare_target(struct connman_iptables *table,
> 
>          break;
>      case AF_INET6:
> -       if (xt_t->x6_options)
> +       if (xt_t->x6_options && xt_t->option_offset){
>              ip6tables_globals.opts =
>                  xtables_options_xfrm(
>                      ip6tables_globals.orig_opts,
>                      ip6tables_globals.opts,
>                      xt_t->x6_options,
>                      &xt_t->option_offset);
> -       else
> +       }else if(xt_t->extra_opts && xt_t->option_offset){
>              ip6tables_globals.opts =
>                  xtables_merge_options(
>                      ip6tables_globals.orig_opts,
>                      ip6tables_globals.opts,
>                      xt_t->extra_opts,
>                      &xt_t->option_offset);
> -
> +       }
>          if (!ip6tables_globals.opts) {
>              g_free(xt_t->t);
>              xt_t = NULL;
> 

Regards,
-Denis

