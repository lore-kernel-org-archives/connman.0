Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832CE36A01F
	for <connman@lists.linux.dev>; Wed, 14 Jan 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378285; cv=none; b=IojvrXq7njs/0rzoLIdeCxKw5RiqtjfDKLgsPkeNhyFgjYPHWQG/TU8u7uqQaRAP/l7+0Xy/U7cr/VmN/8PgHsJrrO5ZO7IE/GKL3nxl5cT/P8CaM5E5Qmui6fZ0movAQbKtvO+JDssIOyLlEWovKI2kb6xDpcq6XVMgPQQ40Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378285; c=relaxed/simple;
	bh=5WP0JvyTWZf8LJPn9V+TtBtWQ3uWtF13ck2BWFeXQ4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJZLFC2rzW2sUCOMWmn2hHTWFaW46SQ+ixjQZLuISJxLmxjktpSSuQRgP7MaMICKKbQRvBIPCG0OfHgdqg68E4r/ztv7ldYFX9/eC1KV1ybnB+camwFudZGXmu+fy4pqRf1CUVr3wWbgxVoY174pBUfilYHWv8XrDrYV65c8dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=LchRXIQO; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LchRXIQO"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11f36012fb2so11316694c88.1
        for <connman@lists.linux.dev>; Wed, 14 Jan 2026 00:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1768378281; x=1768983081; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNGtzogpRJd4eboT/LjEUAODAFEDrf/yrBfgb8RIPqw=;
        b=LchRXIQOYBVr7qJ08s5orLkZZD6+usDh22KFNFsntvPsKdnunJ3vPTU5iyty9msohD
         qytzFO1OPMH0IHq5YSa4kBvLlCRWpyFgVeVp9JqaXmHIwrGF2Ie4Nz/rBxcZg9PN2gY7
         GuikTCSaOl961pmBNVZiafm3d9uXF3WQgzbPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378281; x=1768983081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SNGtzogpRJd4eboT/LjEUAODAFEDrf/yrBfgb8RIPqw=;
        b=bXjWiekGz/juqFbksHKgcm7JjxjcquY7m7p+g2VuNemCN5IQcJBCei8O4uAJXiKmGn
         Myf0LSfvuca84vjY5iYJF6eg2ccxYfUs60jWPa1GxZZg7Lw7DYQlu/9beugfEZSuawYI
         HupqEOVJvHndgAheRUXZNVtpe8DLC0Om2/HVM+5Z17B1M1BygyCiNE7eq6y5qM7OrAFC
         pLRaqu2vNm519V8pJGBCOcpRl5BvhaB5YqNbzmlO9Aichkxskp+F9wGqldRij2iEv+kH
         +O0BG1/nFpWQbCqJVMxGgefWp/yoBFcjZRXTninGv2BYIErpBFPEOLLo7cygH1OUqBUp
         AUaw==
X-Gm-Message-State: AOJu0YzrjFDA8jDwUL2gJsTouO96zxAnO9OCHycNPUzxqvR3pYNdIy0q
	4bk68U+Rgb1hT2H5drDsZ+zmEXJsveMBdWZGbFeNHfOU9zgvz0kW/lPADuEP3NxmoUpv1IvMuKj
	jfnnTSBq2wd420xG3eowsHq0Ma75a6HrgB/TtLySiqA==
X-Gm-Gg: AY/fxX5xyBZ6IBeAvJndVz5e4jv+Hm/0o4vE780ksZyI8jfIYGqHz+eH+QQIyAO73L+
	zXLJmPzF7QM4lmjnWL4lcFLCqkv6f3BzOlYZUZlGvNSaJT/SeZKA0y1f0CM1Vjb0HmYu94y6bOR
	Vgvqy+8Qyo5mmACja7O+ivnLqAHKYaiNm/ZupXq9vvqbuv7tWKecR9p5TMSTT302fZefPWxLEP0
	5gOfVAqsIVbeNbm989K7rTHzWBYxGrhExo7K32ZZCg04Pjre0I0huhD+iLv8ZcG+yjsTK9w51DI
	y/xscVgP6P1oEvSNgK0l0RvLwDTika4dF7KW+kN7rmEbIU5idfGPKYcURmyn3+lNHw5QGug=
X-Received: by 2002:a05:7300:a98b:b0:2a4:3593:ddf2 with SMTP id
 5a478bee46e88-2b4870b4cafmr2294737eec.31.1768378280582; Wed, 14 Jan 2026
 00:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114080641.8184-1-yaming.chen@bshg.com>
In-Reply-To: <20260114080641.8184-1-yaming.chen@bshg.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 14 Jan 2026 09:11:08 +0100
X-Gm-Features: AZwV_QgAUadmVUTkW82yA1kdnxmed_OaGHvbG4TSMIuX9tHQdAnRDrIqJ1S4rLM
Message-ID: <CAOf5uwkx6cneRS6Ujo6HtrpXgRmBZdBanr+XOJxGHbO2cbYn0w@mail.gmail.com>
Subject: Re: [PATCH] wifi:Fix the crash issue when restarting the
 wpa_supplicant or wifi driver while BackgroundScanning is enable
To: "yaming.chen" <yaming.chen@bshg.com>
Cc: connman@lists.linux.dev, gerickson@nuovations.com, sven.dembianny@bshg.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Some nit, try to reduce the subject of the patch to < 80 chars, for
rendering problem

On Wed, Jan 14, 2026 at 9:07=E2=80=AFAM yaming.chen <yaming.chen@bshg.com> =
wrote:
>
> If BackgroundScanning is enable, passive auto scanning timeout work need =
to
> be removed when a new active scanning is triggered.Because wifi->autoscan
> and auto scanning timeout work will be receated for new active scanning, =
but
> old passive auto scanning timeout work is still running, if wifi firmware=
 or
> wpa_supplicant is restarted at some time in the future, old wifi and auto=
scan
> objects pointers will be freed, so wifi and wifi->autoscan objects pointe=
rs will
> be dangling pointers when the timeout handler function of old passive sca=
nning
> work will obtain wifi and wifi->autoscan objects, it will trigger a crash=
 of connman.
> ---
>  plugins/wifi.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 12389fa6..191c4fa0 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -1999,13 +1999,25 @@ static int wifi_scan(struct connman_device *devic=
e,
>                 }
>         }
>
> +       /*
> +        * If BackgroundScanning is enable, passive auto scanning timeout=
 work need to
> +        * be removed when a new active scanning is triggered.Because wif=
i->autoscan
> +        * and auto scanning timeout work will be receated for new active=
 scanning, but
> +        * old passive auto scanning timeout work is still running, if wi=
fi firmware or
> +        * wpa_supplicant is restarted at some time in the future, old wi=
fi and autoscan
> +        * objects pointers will be freed, so wifi and wifi->autoscan obj=
ects pointers will
> +        * be dangling pointers when the timeout handler function of old =
passive scanning
> +        * work will obtain wifi and wifi->autoscan objects, it will trig=
ger a crash of connman.
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
