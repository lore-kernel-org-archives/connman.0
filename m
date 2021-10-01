Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F53FCA
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 13:28:38 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so7210932pjb.1
        for <connman@lists.linux.dev>; Fri, 01 Oct 2021 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMEQny5kylztZs8UBwXLifKXFbSUOWCDyptSD4F+qpk=;
        b=ifFZfpWMIW0WruLAKazvGw+JnZ8OvQ1TaYeexSBd2T8c/bQX0roFE2V7SFC4aZ6FVg
         S6KlWKScaTnpPIY7SIWhQqcj/NygJ3UvAAedD9gco4IBAC+eGjrCWsYoegiS0vp0vaC5
         zSqMUX3XWgzongZEGJCqdTtd1MMGqQESWcKBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMEQny5kylztZs8UBwXLifKXFbSUOWCDyptSD4F+qpk=;
        b=GY+HCJg3xDeda9mcI961UEdDH1rg32kAgAfWI3l5RxcSebMiU94tCKEsW57lIexkwr
         bNrJclOj/iMCMda5yX0G5hQGUUc2+R0n3sY0+JKHwiDEkW8Njwkvco6YZTNz273FmTLI
         FjaYlfZhj5by/nGpEPE41aAIB+QbZbt/+QQoxNlUCjDRbKSA/U7JLk+oS6P2jbpney1L
         mglVGhNBhzELEGRA/2QVn83yArcjV27AN8gu6ZujyBQXcwv7HRoY9B+oCfFfOXGgiRYa
         efmrglO0pNq8ys8TK3MWQIFHzifLfrH1YZ7l3kY4HP8/zERIVEmLxZmzXtcVZDwu1Fj8
         7BUA==
X-Gm-Message-State: AOAM531EFycGQbzmO4HA/uxmeaoNomjw7jMkuXSa+T23Lw7LmtbGKwvl
	s5+xyJYuWo1Wm0rR3uZosQVTDCLtDAJ4ImuvJBNLfA==
X-Google-Smtp-Source: ABdhPJzLJy0ZbnPod+YPLnPR7MZ23pU1CxSf9BI2DyzKo/3FnVOQ0BOF+4bQKxK+j5+XiM0J+ZP+Q0HNGAiHsq4X7es=
X-Received: by 2002:a17:902:b286:b0:13e:1a30:ebc6 with SMTP id
 u6-20020a170902b28600b0013e1a30ebc6mr9746280plr.72.1633094918264; Fri, 01 Oct
 2021 06:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 1 Oct 2021 15:28:24 +0200
Message-ID: <CAOf5uwnCvrffN6go_BwM0oOMGM+OZ=EucuV_OnifnmGQ+XE3kQ@mail.gmail.com>
Subject: Re: [PATCH] iwd: Fix missing Ethernet attributes
To: Emmanuel.VAUTRIN@cpexterne.org
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Emmanuel

On Fri, Oct 1, 2021 at 2:13 PM VAUTRIN Emmanuel (Canal Plus
Prestataire) <Emmanuel.VAUTRIN@cpexterne.org> wrote:
>
> The Interface, Address and MTU attributes of Ethernet Service property
> were not retrieved because the interface index was specified to late
> (at network connection instead of creation), preventing the access
> to the corresponding ipconfig.
> ---
>  plugins/iwd.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index 14a442a7b67c..9f2114f47311 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -209,18 +209,13 @@ static int cm_network_probe(struct connman_network *network)
>  static void update_network_connected(struct iwd_network *iwdn)
>  {
>         struct iwd_device *iwdd;
> -       int index;
>
>         iwdd = g_hash_table_lookup(devices, iwdn->device);
>         if (!iwdd)
>                 return;
>
> -       index = connman_inet_ifindex(iwdd->name);
> -       if (index < 0)
> -               return;
> -
> -       DBG("interface name %s index %d", iwdd->name, index);
> -       connman_network_set_index(iwdn->network, index);
> +       DBG("interface name %s index %d", iwdd->name,
> +               connman_network_get_index(iwdn->network));
>         connman_network_set_connected(iwdn->network, true);
>  }
>

I have sent a similar patch 6 minutes after you. Anyway nice we get
the same conclusion.

Tested-by: Michael Trimarchi <michael@amarulasolutions.com>

Michae
> @@ -912,6 +907,7 @@ static void add_network(const char *path, struct iwd_network *iwdn)
>  {
>         struct iwd_device *iwdd;
>         char *identifier;
> +       int index;
>
>         iwdd = g_hash_table_lookup(devices, iwdn->device);
>         if (!iwdd)
> @@ -920,6 +916,11 @@ static void add_network(const char *path, struct iwd_network *iwdn)
>         identifier = create_identifier(path, iwdn->type);
>         iwdn->network = connman_network_create(identifier,
>                                         CONNMAN_NETWORK_TYPE_WIFI);
> +
> +       index = connman_inet_ifindex(iwdd->name);
> +       if (index >= 0)
> +               connman_network_set_index(iwdn->network, index);
> +
>         connman_network_set_data(iwdn->network, iwdn);
>
>         connman_network_set_name(iwdn->network, iwdn->name);
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
