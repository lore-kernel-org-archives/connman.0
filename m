Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447C35504E
	for <connman@lists.linux.dev>; Wed, 14 Jan 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386160; cv=none; b=TIKIz2zfqUTcz6rE/DGCth+pJA4x4DyG5lmjiTWGdzWM3S9x52jz0HhEOJZmlxAK1LG5ssIPi+0m1dEoZQOJx23gW5MYtqgPwP85PDhASJYIndUzbg2MNuhql5GQq4O6DLEKAL5UCUsg5oB6e2adDN1JrpgJ1qXdmS2xUqA3EgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386160; c=relaxed/simple;
	bh=MOkV11Z2lMyuamSt2ljZJJo5Al1Lc0aA7dUHqPEassQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW9MXp27YuP5b2GOgggJ8vxMS3edR+5emEOVGZJSlC156x4MFlWmuQMbbt8AUvUV3vDCrU9pGz8aZluJDQS24sVK9408D9dbaJvMifaNLpkQ/JaAAeja2Vu6JS8/m4VXKivhDQryXn1ob3voYGYCRGzSgdNyY7gF/t0KsbTbeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=eunocGde; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eunocGde"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12339e2e2c1so127787c88.1
        for <connman@lists.linux.dev>; Wed, 14 Jan 2026 02:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1768386150; x=1768990950; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvBJsAM+i0lacXKNwF3FIjfOmyqDK+5XsyQ8GXxiEBw=;
        b=eunocGdeTx6hu+/5zvZCDgufxbiTXmqeaJByXzR42JyU6VgpPcMpFdXYscw58eL67A
         MCiRKbWDN946fGQHXJFRpWwiwHzNJ1ch/PBT7kMA29QVSm1BYxckSi/is4M8CoDoqjnR
         p/TD0e0jyHpBCW6WnjAHzNWXxsJ1ahW4viAo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768386150; x=1768990950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VvBJsAM+i0lacXKNwF3FIjfOmyqDK+5XsyQ8GXxiEBw=;
        b=m76knn7lG2G/9UpuQejtU+jOVrdd4dgU6sCHdiRX7XeEm5ROwTntn/RBJxcraNPqEC
         jzh6bFyFAXc5hdl0gmxwA15G8AccpVQkgu2QxaTwzSf6lqklBkKtg5wFyaGnJWT72Ao4
         y1+HeUbG6/Z5PYYo7QF5sQZTYhciscPbCaGbtCPbIWt0BFP3ej4xXLC5wQLXYpsXIMiM
         kftNNCquYCZy+heIRTJ9gJfN7S/uaUsfZprBAV4E1+y2wwQctyarFK0ubpvQE6fHSAKd
         O7Wnx+nuPCDPzy1+XMjDKTCQX8acOtxu55swLm6sWDEMh7ylRCYFc0cYLVNpcuAotzc/
         PKeA==
X-Gm-Message-State: AOJu0YyrsSMonzE79IwRto8fi/AfeCxQcesYbPBA+lp7NgZhcULtHHNl
	9msL5indDd5/dxZtdYUOLcbHlQAqOBRR2lmuA8ZUqLhMB5uZx7oUJrLQOjsXF9g1bnV0vIb3931
	EPwDUb4FVhMsKUYsIL2vQSE0+xaaSruohUZceA1ZxXw==
X-Gm-Gg: AY/fxX70zEFUNzSfTbQ/AwKeG+2P782I6Umisyu/SWlYe1TSv40gExdvQLGNHVxYHys
	krzj0CYPNyaSbaO/c+74t018VfR+Q0TLYKiwsjwrHvfk7Yk3MDy0FpEfhcD8SBKQFDZ71SDlj8/
	QbYlhU0PNeqha5eAFB6ErpnEPELrR164Uf0ZqISOCH9lUq/1MgA0Xw1e6EY7XhfqMI6XoL30wCE
	3JFLMTVIok5OvWU2RWwRx5EFNwgc8SQKEzEFKaVg2Vx1yBHkOKIht0XFpd5Ck3GpcOkn3fUEZKZ
	Tf4RMLw+z4nfEAYEAXRRyhlWcGq3drKd7GV/yEGDlEWjyDbWk26i1htmcoOB
X-Received: by 2002:a05:7022:b87:b0:11b:3eb7:f9d7 with SMTP id
 a92af1059eb24-1232b61efd0mr7217842c88.14.1768386149948; Wed, 14 Jan 2026
 02:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114101736.11023-1-yaming.chen@bshg.com>
In-Reply-To: <20260114101736.11023-1-yaming.chen@bshg.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 14 Jan 2026 11:22:16 +0100
X-Gm-Features: AZwV_QgrGow9q4ASO9RPrfpuM4qJv0ixmgYZCcYjroV7wbja13Wy7ZoKcqI2O_k
Message-ID: <CAOf5uwn=jZD0Qumatcvb-3a-oRf+c-4G77uLr2a+OJVTXVgjww@mail.gmail.com>
Subject: Re: [PATCH v3] wifi:Remove passive scan on new active scan
To: "yaming.chen" <yaming.chen@bshg.com>
Cc: connman@lists.linux.dev, gerickson@nuovations.com, sven.dembianny@bshg.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jan 14, 2026 at 11:19=E2=80=AFAM yaming.chen <yaming.chen@bshg.com>=
 wrote:
>
> If BackgroundScanning is enable, the old passive scanning task
> needs to be removed when the new active scanning is triggered.
> It can prevent the old passive scan timeout handler function
> from accessing the dangling pointer after restarting the
> wpa_supplicant and wifi driver.
>
> ---
> Changes since v2:
> - Remove the change log of the patch file from subject
>

Thank you for your cooperation ;)

Michael

> ---
>  plugins/wifi.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 12389fa6..96c0c127 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -1999,13 +1999,22 @@ static int wifi_scan(struct connman_device *devic=
e,
>                 }
>         }
>
> +       /*
> +        * If BackgroundScanning is enable, the old passive scanning task
> +        * needs to be removed when the new active scanning is triggered.
> +        * It can prevent the old passive scan timeout handler function
> +        * from accessing the dangling pointer after restarting the
> +        * wpa_supplicant and wifi driver.
> +        */
> +       if (connman_setting_get_bool("BackgroundScanning") ||
> +                       wifi->scanning_type !=3D WIFI_SCANNING_PASSIVE) {
> +               connman_device_ref(device);
> +               reset_autoscan(device);
> +       }
> +
>         /* Distinguish between devices performing passive and active scan=
ning */
>         wifi_update_scanner_type(wifi, WIFI_SCANNING_ACTIVE);
>
> -       connman_device_ref(device);
> -
> -       reset_autoscan(device);
> -
>         ret =3D g_supplicant_interface_scan(wifi->interface, scan_params,
>                                                 scan_callback, device);
>         if (ret =3D=3D 0) {
> --
> 2.34.1
>


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
