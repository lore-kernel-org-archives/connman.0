Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3373FCA
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 13:29:19 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id oj16so3259431pjb.1
        for <connman@lists.linux.dev>; Fri, 01 Oct 2021 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8gu6NMqPk/ejldB6GE52W8/saRjOq/Wrwsn91E39RM=;
        b=L68HTDGE7NS2uNlUWGdKFwZfuoSu/sXWwMk/3x2M0xDwowoJsj+MkJNHoXeR++KZlw
         AWeIzdIxApqrnKnuDo5mIcZXdnX5yLOpbAJ61KOne0ZJttQkmYRZQwTxomp/uM14rD5D
         ufkYBMGDPQtnbvGVeaBPS7HMyR3/iEZ735asw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8gu6NMqPk/ejldB6GE52W8/saRjOq/Wrwsn91E39RM=;
        b=eUtdQJZCmuOeYu65RK/aUFAJ2SFiu7o4AnBrlWodYLG7+oDn2Mo7ppyS9Pch4+JB5D
         V+OMraE9u6jV9hb5vslIJHCHD80SBKmXcyaDzmufpgpOYMHTtsq7VDVBHNVXqh9Mh+x2
         FunOLz4KL9L5FdfcvJXgB0yA7eaKwzWCxUl6NYVAmoKGFvNmiSbExdPEb8E4z7Q10qUr
         5gSTk4r8bnuOl6aAdq/ZDmZoSY/YFNpqZSP9FDd8sEoj0Qtrpe2CgoVGu6UdPFQbC0Tb
         KD4egBdzA0Xh5XRDn4gYprVr5T86sOlnXE3xliozTKBHjaHFLoED6/Ykf1XdR4b84VMh
         Wjjw==
X-Gm-Message-State: AOAM5319i8b05UjfTDfLzweTa2mbnkyEVv/rvCGZ2Bpi2ukr5P50UfHh
	hOf/a1hOHW4SMRXVgAp9Jhcgj6vufkWgH2V4bQixfvmHAhDS1g==
X-Google-Smtp-Source: ABdhPJwISVBvTYHCjBsqL90aQ/UxOAsfx4JeDcy9IeZasIUCj6qgRl7gJe5vtaOKm0upUgB5hff0aF+56UXwMHwI9G4=
X-Received: by 2002:a17:90a:2e0e:: with SMTP id q14mr13383131pjd.171.1633094958950;
 Fri, 01 Oct 2021 06:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MRZP264MB1544D8BAECCC6E7436D85D4F93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB1544D8BAECCC6E7436D85D4F93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 1 Oct 2021 15:29:07 +0200
Message-ID: <CAOf5uwnD30ADMg4_EraiZodqk8cP2wH9Hc2a0QHPCJeY5__evg@mail.gmail.com>
Subject: Re: [PATCH] iwd: Fix timeout error on new connection
To: Emmanuel.VAUTRIN@cpexterne.org
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 1, 2021 at 2:18 PM VAUTRIN Emmanuel (Canal Plus
Prestataire) <Emmanuel.VAUTRIN@cpexterne.org> wrote:
>
> Before connecting to a new network, the currenty connected one shall be
> disconnected, what always failed with "Operation timeout" error, as
> the disconnection seemed not completed, cm_network_disconnect
> returning -EINPROGRESS on success.
> ---
>  plugins/iwd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index c1c273ef4b3a..ec9a4574cf2d 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -317,7 +317,7 @@ static int cm_network_disconnect(struct connman_network *network)
>                         NULL, cm_network_disconnect_cb, g_strdup(iwdn->path), g_free))
>                 return -EIO;
>
> -       return -EINPROGRESS;
> +       return 0;
>  }
>

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>

Michael
>  struct auto_connect_cb_data {
> --
> 2.25.1
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
