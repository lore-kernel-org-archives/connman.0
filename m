Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB918AF3
	for <connman@lists.linux.dev>; Mon, 12 Jun 2023 13:46:06 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9745d99cfccso768452966b.1
        for <connman@lists.linux.dev>; Mon, 12 Jun 2023 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686577564; x=1689169564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47dTSOVaOCIstfJ9L4EuJdYRHKDMyNOyEmfFYhEP2Us=;
        b=QLEGz+RtZOWxcAZT1MjfCrKtoaNyl9WYHZqPNGwJ2iyoDz0TRL0KNHHoKCSY1+AJa1
         Goe1pvVbIGFTCHVvxdc8CsVkTLtxY/8J0/chlRyPf+aMUzZFafDFkETYMtGduvr/BUAA
         7Qzv0c6P3rpPZtfhvoXw95fi1ANbNxZFMmhec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577564; x=1689169564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47dTSOVaOCIstfJ9L4EuJdYRHKDMyNOyEmfFYhEP2Us=;
        b=JCcBqVYagfeDvpudA4Mgo+40JvVKRVGfa9kx6mISJ3XaSJ/Ux4KzXrHOYSowg3K1Ub
         tHD9vpUiflwwP68U61FA2DyXww9+BtHchh9IGwOpLeX4pBdlSr/sxpXdFKBWzrZHDz+r
         ktfcFUjklk34O13cZG5FtHslcxXTdCJdtweIVx1ItSNgLtfQDvSYc51XI90NbB7pnz5C
         VBrP99t2Lxs6MidWjimOmskb1EmFeJcJQciFLd0wq8ledn/+7LL073Wfce0RX+PJXded
         bRGn1cWP7Kne2iY+uNLWqsGicZbaTN+jQKSvJ2u9nmT47+xqOzBWNQFXgbt5DkTdFReS
         DNPQ==
X-Gm-Message-State: AC+VfDzhBqponYVluHzUz0ppyN1wvtyTRsKmlGXnKYwMLwoeE12Nb+LG
	lqs/FGIypJ0MzBaoB6KQOVGMabR3KEKCY3Jnh6TvpVqlafyeoMA7
X-Google-Smtp-Source: ACHHUZ6HBme6Nl2dJTtmExFPlIVKamFT++RDJ/3kYOYeeDrQhiF2yp9/0BWyQbNusg06EloENA7OF10JZ+yC/zhIY+s=
X-Received: by 2002:a17:907:3e9f:b0:971:2ead:e161 with SMTP id
 hs31-20020a1709073e9f00b009712eade161mr12766352ejc.6.1686577564140; Mon, 12
 Jun 2023 06:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MR1P264MB1540A3B3D6777C951E8910789354A@MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MR1P264MB1540A3B3D6777C951E8910789354A@MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 12 Jun 2023 15:45:52 +0200
Message-ID: <CAOf5uw=TcgdSf272WWnZ=ySTSUrx5En_+SjDGv8taGB2ad1yiQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] wifi: Fix connect-failed error on user reconnection
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 12, 2023 at 3:19=E2=80=AFPM VAUTRIN Emmanuel (Canal Plus
Prestataire) <Emmanuel.VAUTRIN@cpexterne.org> wrote:
>
> Connecting to a WiFi network under disconnection leads to a
> connect-failed error, when the disconnected status is updated to soon
> by the driver. In this case, interface_state() resets the disconnecting
> status, letting network_connect() try to directly connect, instead of
> setting pending_network variable and waiting disconnect_callback() to
> start the connection.
> ---
>  plugins/wifi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 865fe0ef1e55..e141f8dd73c1 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -2667,7 +2667,6 @@ static void interface_state(GSupplicantInterface *i=
nterface)
>                         connman_network_set_connected(network, false);
>                         connman_network_set_associating(network, false);
>                 }
> -               wifi->disconnecting =3D false;
>
>                 start_autoscan(device);
>

Can you please add a trace of connman or short trace of it in commit messag=
e?

Michael
> --
> 2.34.1
>
> Hello,
>
> Please find the right formatted patch in attachment.
>
>
> Emmanuel



--=20
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
