Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3234EF04
	for <connman@lists.linux.dev>; Wed, 14 Jan 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384311; cv=none; b=g9CgoW5WMb8c7d+tvbk/bzBK1cTr20fXsnl3XYXQTKcvV9F8FmqyX2I260+ZpMMNVG38y4zV3FUVlkPu5Y5u3gu0T2dKolMWL7EuupWRXrZR+l3zwovjmouHI+gHUsZt1W51wfMR/oHD/GQ/06DdbE0gZOF4PITV+PaD1yp5ytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384311; c=relaxed/simple;
	bh=MreIJxnYnA9mWaaJyP5QVeSeD7Y3qlDeiOASvJntQeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVGM2In76C2aWngYLhqQAAXae3kndhtCGB1ndmVqn3fcPbpfvL65Kkqc14vZXuPAdUmbaD2NSGM8ZnUvS0q920kIVyKS9p5KPSb9L8rs//Qoncdjne5yiIw/R/uB57lqgJYPSqsBa/8q0Y9rItQPJQSREISLG+hvJdHfcjsgLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=V71486fv; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V71486fv"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12336f33098so378554c88.0
        for <connman@lists.linux.dev>; Wed, 14 Jan 2026 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1768384308; x=1768989108; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQofkZYwYiGstx8psLcVUT5WVLcCQiad88gz5dmJwAY=;
        b=V71486fvV6g0qAcA0AjZN9sRI7ZuqN5AwSNFmCqIPTiRajWKz+Ba6Fv4feZw8QAHnd
         fQ0h69L0iFFHpcrm18ScB4Bbm1ebvR5yQGvswfU2j4WoO3iqO3Xhp4RxbPO5zlUb8Yqm
         k9r/+zdQDfIKnvj3dpzsz7636+ceIhJr5utq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384308; x=1768989108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQofkZYwYiGstx8psLcVUT5WVLcCQiad88gz5dmJwAY=;
        b=eMVIjlOPZYGfyp41E81Z35vEORz4ziGST/pi+eVWKMkfenVlXbUxnNNPqflBKv+KpX
         4FDpn4Li8XngwiYyDDaSRJBbdZ/imMz0nXXq54hEsR1t9JFOQn8wUjrkCDlhbvkWzygV
         UgTMOaGB72UEI0bJ05yVyrgoGLI+UtRoP4MxGwdC46WhUCzSZPt97j4p8H2Vac3t2O08
         1IemRljrTQP0VzqRJ3y4zffeWrM8xs5RgnsukhxjfzgsLzC1zciieFYJvb4e1PmzFEiS
         qSjyAN0c0Jy7kulscI3VdOJ5bHv3Svz4U/UmQMHtcDUWlfTAxfV1P4FIS4jACaQ+ywoh
         T8bg==
X-Gm-Message-State: AOJu0YxSmYwH2wd6HVJ8vhDxZsrlZK8TcIb+8ku5QqFN548II0YVX2U4
	8HN/vkmIiGtcHzB29nfZTdKD45hU5tfwoufmwllnWOmyxJVi0IH5ro5AIrguPfwGJOIuYR9M6lD
	9Sm3DeKYy+ZYGxhppI00CA/y9oP5L7UEbwMDjYLixPA==
X-Gm-Gg: AY/fxX7xn/pqlipUFfAXL/DpJumwP31PC3sekAAkdWqOEBSO+J+IbaAQwHyMrVETLj5
	PHS8syI4ksOEGjfBh5iC6/BcWUtesG5lZzQyYUTjpWEKZAy6Gg7MsP0Gz02jxkff0gVlMz7Qg9e
	EGg6e4V8ZJ8MkCoWuTeHS8P6bLx24kojt4+tR9sOfdsrDXroMCCy4X5nCbe/Zl869nuYfLTn8bJ
	fxdRK+7vxr1Nhwa8hsKZRKGx8CmbN77ydJs4ADscF4x87H1YH6sNbDNK942MyaNJGMqw/+2sK7Z
	rCZoyRACHfpS5n6qu+HFjPGEX9FYibd6LDAwxryIF7MOrf6YVkbYk+VWqWLkom+2AWKST28=
X-Received: by 2002:a05:7300:4791:b0:2b0:4ae1:b4ae with SMTP id
 5a478bee46e88-2b48706f17cmr3012122eec.24.1768384308052; Wed, 14 Jan 2026
 01:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114094722.10158-1-yaming.chen@bshg.com>
In-Reply-To: <20260114094722.10158-1-yaming.chen@bshg.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 14 Jan 2026 10:51:36 +0100
X-Gm-Features: AZwV_Qg0QcRjiBRFIIlHoCw_83klgH5iPLSeHtRegusZwyKcjHhMhpRe5q9-W-4
Message-ID: <CAOf5uwn7EefUAb8WsCisCLEah8+ZT9yU=L1VKBPH_k9_Sx3vWg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi:Remove passive scan on new active scan
To: "yaming.chen" <yaming.chen@bshg.com>
Cc: connman@lists.linux.dev, gerickson@nuovations.com, sven.dembianny@bshg.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jan 14, 2026 at 10:48=E2=80=AFAM yaming.chen <yaming.chen@bshg.com>=
 wrote:
>
> If BackgroundScanning is enable, the old passive scanning task
> needs to be removed when the new active scanning is triggered.
> It can prevent the old passive scan timeout handler function
> from accessing the dangling pointer after restarting the
> wpa_supplicant and wifi driver.
>
> Changes since v1:
> - Shorten the patch subject and inline code comments
>

This should not be included in the commit message, the should be under ---
---
Changes in v1:
- Shorten the patch subject and inline code comments
- Fix compatible string in socfpga_agilex_socdk_emmc.dts
- Rephase commit messages for clarity
---
plugins/wifi.c | 17 +++++++++++++----

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
