Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD77261D
	for <connman@lists.linux.dev>; Fri, 12 Dec 2025 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524709; cv=none; b=nYTv7Vzm+XtIw4BTiUUq+cOTJIlkXn+Q8UYB7Ku+aTGILoHa9zWvtkkECAc/ILFbkNZPIf7PjM46sw/5O1dFvRbzul1qU/twJULs0AKAzTKkWs6aIlsQQYVY2wKClScwx74ZS/MEZXtU1NZXTBfYUh9Y6Julgw4x+h8W13aXVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524709; c=relaxed/simple;
	bh=z5I35LvE00eVoOQduPZtsVYFK+n0PFI5yUr5+BE7WIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTRBpUR8luwljh1d5JmkL+UENLG1fwDrMrVrszoBHciwtAihr7dUuRINg1QamwjdBvf88GnZtz8nmAymPlHs8q34zzMfmAtYzQKr6lrCAYrvgrnppITrIoCVIUkQEMby/6yWeotpE3GM1vBqkC+KE0JPoheA6xn6QS9p2FX/hys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=MJTOtL9e; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MJTOtL9e"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2a45877bd5eso1245118eec.0
        for <connman@lists.linux.dev>; Thu, 11 Dec 2025 23:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1765524707; x=1766129507; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7hf7XxnXYng7rF2EEGXrmwWuWKniVtGROQLCtpZIJg=;
        b=MJTOtL9eyORQ58+oRhziq8HGrcCa5/9Aj13kLxJR9zPmXC+L4bp36DVvPjKchEh68H
         V01VsV+lSApJhDNsgJb5CzS2rJrrh4jfZXiVVrUkQeiy890v+D5hj5INrSASFSEhnTIY
         oQIHHmv50sIRwDw36EU42VZ9qisnzu3JB3iQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765524707; x=1766129507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7hf7XxnXYng7rF2EEGXrmwWuWKniVtGROQLCtpZIJg=;
        b=KpZfT4idhWD0aqB21q7cbo2uIB7FsNcaBV7jbQ8Q8uYbSOm5jqRJLesC4JKX1mJRNB
         OCuRyLusNUkBp1CdLnw6gw6gPMV/Shit9UUdifW5ZgxjoT6SDYt4zurFjg1yyPbie3sz
         9e/T3nrnOeSMI2rx6HOBAR0DusCa8NHonqx+7iGwCggoXiyP+UC1CerkAcp5mRcvYrO1
         wFvWnQz5mBr125RPCGxrIFi2qp3U/IzoHNcgn7RlILhE99Z25l4kRSUbBObk/pJ0LA/W
         7rXQ+a3qujbrUf5RQSzly/SloipA/j7i4fE0gflw4Ulm2xOSkIVw1Nrbw1W+0tOmwTaH
         Xovw==
X-Gm-Message-State: AOJu0YyVGHkmYKtCbcoewhktGD4f7EKo4DGqke0aFsvRpCX6qQPfezY8
	iQB7AyeKo1dLF1Q1V9nitaf0ddyYSKNxe8jEMdbz5gUUid3iuO0jlO58gkkT9RZVQ7JVPKBBf3Z
	2AUTv4q2v1llWUdpq0X4w2gHnpYbTWwqqqDiEh3sL6g==
X-Gm-Gg: AY/fxX7aAKKNY4eWeJBui12tQo3HAE30H83yZsl9g9pXJ12MWGaO91wx+cg3KXGyH46
	4vXIK2SXmsTia+Lt71zH0jkKDaiHwgeIfUjQ2tPwhQe2DneLmDEYkvRlTiHEz5wfOgZr1AWgR0+
	vMqIKDe49HuftRfd7+GTzZ2SvE5TOzmyRNWkYSN45HIwIM2WbGrGNoRRiye2mSAsRR5vn8xIcAO
	eEv0TplMkbQQTkl3Ocp9hgEG/mcfYHOex6k7J/jY9Uf10F7uSEiacxhTZYRB6/lAu0NhenZV9nB
	dn9lwe0sLVHzG32P4BjIIPFJyQ==
X-Google-Smtp-Source: AGHT+IHhWTKh/qXeWcjnq0+dkeJcyJnq//+PY7yfXGMtqPvS1Xa08j8jvIRN4md7K9RMBAtO+OylwCuJXCC1jzhX2/0=
X-Received: by 2002:a05:7300:d406:b0:2a4:7180:6e1e with SMTP id
 5a478bee46e88-2ac311c7e56mr661014eec.19.1765524706782; Thu, 11 Dec 2025
 23:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <PRAPR10MB5421CC811D1DDDF69E01283690AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <PRAPR10MB5421DDB53D5BE922CBECB47B90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <PRAPR10MB5421B3F7A9A117FD038BA5BC90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <CAOf5uwnOFnQZa3zV06RWBum1z6PC1SUoyFicShC-rL2PMyc0uA@mail.gmail.com>
In-Reply-To: <CAOf5uwnOFnQZa3zV06RWBum1z6PC1SUoyFicShC-rL2PMyc0uA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 12 Dec 2025 08:31:35 +0100
X-Gm-Features: AQt7F2rxfiDz265vsz0IfmXqTy9Kt51BrmwSoJ-zgzV46XUuqBpL2BF7DWZ6j8c
Message-ID: <CAOf5uwmeODc99O0LMs=kLXBuxK7RR6MarHLrg5WZX+o5199CqA@mail.gmail.com>
Subject: Re: Fix the crash issue when restarting the wpa_supplicant or wifi
 driver while BackgroundScanning is enable
To: "Chen Yaming (BSH GDE-EDSCD)" <Yaming.Chen@bshg.com>, 
	"Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>, Grant Erickson <marathon96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

This is the actual code

       /* Distinguish between devices performing passive and active scannin=
g */
        wifi_update_scanner_type(wifi, WIFI_SCANNING_ACTIVE);

        connman_device_ref(device);

        reset_autoscan(device); <=3D=3D=3D reset autoscan is here

        ret =3D g_supplicant_interface_scan(wifi->interface, scan_params,
                                                scan_callback, device);
        if (ret =3D=3D 0) {
                connman_device_set_scanning(device,
                                CONNMAN_SERVICE_TYPE_WIFI, true);


According to your patch you now execute two times. Just an idea,
because the connman_device_ref is a bit
convoluted, is possible to just move up

        connman_device_ref(device);
        reset_autoscan(device);
        /* Distinguish between devices performing passive and active scanni=
ng */
        wifi_update_scanner_type(wifi, WIFI_SCANNING_ACTIVE);

Michael

On Fri, Dec 12, 2025 at 8:04=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Fri, Dec 12, 2025 at 7:37=E2=80=AFAM Chen Yaming (BSH GDE-EDSCD)
> <Yaming.Chen@bshg.com> wrote:
> >
> > Hello:
> >
> >
> >
> >             I repackaged the patch file into a zip file, please check i=
t, thanks!!
> >
>
> Can you try to send an inline patch? You can use git send-email, this
> allow people to review.
>
> Michael
>
>
> >
> >
> > Yaming Chen
> > GDE-EDSCD
> >
> > =E5=8D=9A=E8=A5=BF=E5=8D=8E=E7=94=B5=E5=99=A8=EF=BC=88=E6=B1=9F=E8=8B=
=8F=EF=BC=89=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8, =E4=B8=AD=E5=9B=BD=E6=B1=
=9F=E8=8B=8F=E7=9C=81=E5=8D=97=E4=BA=AC=E5=B8=82=E7=BB=8F=E6=B5=8E=E6=8A=80=
=E6=9C=AF=E5=BC=80=E5=8F=91=E5=8C=BA=E5=B0=A7=E6=96=B0=E5=A4=A7=E9=81=93208=
=E5=8F=B7 210046
> > =E6=89=8B=E6=9C=BA=EF=BC=9A19962032751
> > Yaming.Chen@bshg.com
> >
> >
> >
> >
> >
> > From: Bytemark support@bytemark.co.uk
> > Sent: Friday, December 12, 2025 2:31 PM
> > To: Chen Yaming (BSH GDE-EDSCD) yaming.chen@bshg.com
> > Subject: Your attachment was rejected
> >
> >
> >
> > Dear Chen Yaming (BSH GDE-EDSCD),
> >
> > Your email to our support system could not be accepted in full. The fol=
lowing file(s) were rejected by our system: 0001-wifi-Fix-the-crash-issue-w=
hen-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-=
enable.patch
> >
> > Please try re-sending your attachment using one of the following allowe=
d attachment types: doc|docx|xml|png|gif|jpg|jpeg|zip|rar|pdf|txt|log|xlsx|=
wav.
> >
> > Kind Regards,
> > Bytemark
> >
> >
> >
> >
> >
> > From: Chen Yaming (BSH GDE-EDSCD)
> > Sent: Friday, December 12, 2025 2:28 PM
> > To: 'connman@lists.linux.dev' <connman@lists.linux.dev>
> > Cc: Dembianny Sven (BSH GDE-EDSD7) <Sven.Dembianny@bshg.com>
> > Subject: Fix the crash issue when restarting the wpa_supplicant or wifi=
 driver while BackgroundScanning is enable
> >
> >
> >
> > Hello, conman team:
> >
> >               I am a software development engineer of BSH company. We h=
ave discovered a bug in our project using connman. When BackgroundScanning =
is enable, if the wifi driver or wpa_supplicant is restarted, it will cause=
 connman crash. The parsing of the core dump print call stack shows the fol=
lowing:
> >
> >
> >
> > Core was generated by `/usr/sbin/connmand --nodnsproxy -n'.
> >
> > Program terminated with signal SIGSEGV, Segmentation fault.
> >
> > #0 autoscan_timeout (data=3D0x144bc00) at ../connman-1.44/plugins/wifi.=
c:1382
> >
> > 1382 ../connman-1.44/plugins/wifi.c: No such file or directory.
> >
> > (gdb) bt
> >
> > #0 autoscan_timeout (data=3D0x144bc00) at ../connman-1.44/plugins/wifi.=
c:1382
> >
> > #1 0x76d0f8b4 in ?? () from /usr/lib/libglib-2.0.so.0
> >
> > #2 0x76d0eff6 in g_main_context_dispatch () from /usr/lib/libglib-2.0.s=
o.0
> >
> > #3 0x76d0f24c in ?? () from /usr/lib/libglib-2.0.so.0
> >
> > #4 0x76d0f4a6 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
> >
> > #5 0x0001d126 in main (argc=3D<optimized out>, argv=3D<optimized out>) =
at ../connman-1.44/src/main.c:1253
> >
> >
> >
> > We have created a patch to attempt to fix this issue, please help evalu=
ate and review it=EF=BC=8Cthanks=EF=BC=81=EF=BC=81
> >
> >
> >
> >
> >
> > Best regards=EF=BC=81=EF=BC=81
> >
> >
> >
> >
> >
> >
> >
> > Yaming Chen
> > GDE-EDSCD
> >
> > =E5=8D=9A=E8=A5=BF=E5=8D=8E=E7=94=B5=E5=99=A8=EF=BC=88=E6=B1=9F=E8=8B=
=8F=EF=BC=89=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8, =E4=B8=AD=E5=9B=BD=E6=B1=
=9F=E8=8B=8F=E7=9C=81=E5=8D=97=E4=BA=AC=E5=B8=82=E7=BB=8F=E6=B5=8E=E6=8A=80=
=E6=9C=AF=E5=BC=80=E5=8F=91=E5=8C=BA=E5=B0=A7=E6=96=B0=E5=A4=A7=E9=81=93208=
=E5=8F=B7 210046
> > =E6=89=8B=E6=9C=BA=EF=BC=9A19962032751
> > Yaming.Chen@bshg.com
> >
> >
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



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
