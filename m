Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B61F584C
	for <connman@lists.linux.dev>; Fri, 12 Dec 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523080; cv=none; b=KUx/cpuWEHAszzaODRXDsiZUn2FGs41Lx3UiKyeboex7CDlJMA73hJNHYXgj9xasAc8V2PMlT9hPaMJw5f/sD3NKbV8D7UG6wTNEyDXCjJ+n5GOJAh97qV5qkIOuoduWcHgPbqn2qLpwY9HvPmytG5tlhOcww1XxumVs7RDlIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523080; c=relaxed/simple;
	bh=+vHSYFwPpFQyOOVR0guD2Lr+h/whg3mBQslVqmy8LSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8/e+0GsvL02UMc6S4vxuu1ErZPHNgNVWoIYKl4IfF4Shhir5WxoIOOOzIWG+fT3aJA9NFZ+dnT9RFc+lUHdSMT3eKfYQ/9MXcD+96MIpqSafTwNtyYUZyafbVk+h7wdHf49h5TpXbdSv0jfrEIBvxyQuoPMvSX72h0ppvim2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=kW9RBe3m; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kW9RBe3m"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bde0f62468cso914613a12.2
        for <connman@lists.linux.dev>; Thu, 11 Dec 2025 23:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1765523078; x=1766127878; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIWKsAtOiqJa8nlIS7lx/drPtH5uO7+VxYPwQf6S6pU=;
        b=kW9RBe3msMkXDapiCD9X7kKQy44mtP5fyBW+SJ1laWoUpo17uUiBy8rYFZk2CJv+d+
         ARiK+HAmhJsZXcI7Uehd6EANxbw1+zvSMVFwNeTrBKiRBvlN/dlxU/4kmR+X2VypeJv/
         xuDOpaSFKrlClZRlnRB1CqFlNiQcxGYrY4WOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765523078; x=1766127878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIWKsAtOiqJa8nlIS7lx/drPtH5uO7+VxYPwQf6S6pU=;
        b=oBoEsgmvLogUU71jJjoR35gareBAAtlvC5sf/zUIk1Ll8CIXNXUEXTrDuE4ub4Y/io
         WE7KsJvUMDkZQT/1Jvq+zPZESc6ypHqfqJxk0AZ0qtnazhVq16CkDSRa6o03589z8lHk
         Gzng6NUxR/VFFeJCJZJwPwyMYIWe8F9BEMnUYuKmYwq97UXdexXPQFwu5Ff18rr63dkG
         ypuWFyU/suPbc6b0u31AGRr2lsqDG8bNF56/B5tw1zh0aEqleVpinksy/nCJGvEJZ6P9
         GwH487YOT7r5KdLonFGq2TOZUatW5FnKGqypq5qiHPXZAon4+0Sk5JZzwO4rWNceu0F8
         uUkg==
X-Gm-Message-State: AOJu0Yx1O/dw74Qw8HM0Nz7jeP4Aw4rSGk9KQffIYz/CNgyKF6mfPQw2
	27l8UiYP5gtz1xSfw7kXQjzF7RxoEIRcW/mUcgTcNsqwpXij6Ne+Yy4TL8KGV2VtUVxfGTYqh4W
	9YglEcnyAGcUpfLUPLUGtxoYJsjP33sDfd/okKgNcGQ==
X-Gm-Gg: AY/fxX7WKCyKpCDxmIboyR1ogYAdV4L7EsfealjB32hd7RMDNj77TWOnr0Hb3zY75VF
	HveZB3IXIQQZS95vhdZ2K7PZnRTGk12jjAinCNajCLm/g1UCd3CC9utBBXC234oweKyAHMC14Lo
	Hq4pn+KqsNkVW8LmvPdWCuE7OCwMTj55Y79y19Hip9bCzyHE/i/YUIzKmv0jugRK/iwznYQFWXW
	IlUTxERjNQ1PCjq6IJUpeBdSiylwAGw4arpBCc9q1AfSSPsbCaVppdMYbsdpL2PyYCa3rC4Mswq
	3ps8O3BKBED7eL0BPmQh6127ZzyazFXXbCmc
X-Google-Smtp-Source: AGHT+IGDSU35THaIUHGMZJaEXsUi22FHYBDD2EQfif8ENVoL9zDD7BHvkKDIOJPeDiFGx++mzO7knLw+R/NWMQJ6PdM=
X-Received: by 2002:a05:7300:e1b3:b0:2ac:2d7:6a6b with SMTP id
 5a478bee46e88-2ac301a4c3fmr664510eec.11.1765523077817; Thu, 11 Dec 2025
 23:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <PRAPR10MB5421CC811D1DDDF69E01283690AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <PRAPR10MB5421DDB53D5BE922CBECB47B90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <PRAPR10MB5421B3F7A9A117FD038BA5BC90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PRAPR10MB5421B3F7A9A117FD038BA5BC90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 12 Dec 2025 08:04:26 +0100
X-Gm-Features: AQt7F2o9jwWgmABeGb7zFwOTBZaHe5vx8wab_3MVnQ_dZPL6K3HNUYisZKO9wSs
Message-ID: <CAOf5uwnOFnQZa3zV06RWBum1z6PC1SUoyFicShC-rL2PMyc0uA@mail.gmail.com>
Subject: Re: Fix the crash issue when restarting the wpa_supplicant or wifi
 driver while BackgroundScanning is enable
To: "Chen Yaming (BSH GDE-EDSCD)" <Yaming.Chen@bshg.com>, 
	"Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Dec 12, 2025 at 7:37=E2=80=AFAM Chen Yaming (BSH GDE-EDSCD)
<Yaming.Chen@bshg.com> wrote:
>
> Hello:
>
>
>
>             I repackaged the patch file into a zip file, please check it,=
 thanks!!
>

Can you try to send an inline patch? You can use git send-email, this
allow people to review.

Michael


>
>
> Yaming Chen
> GDE-EDSCD
>
> =E5=8D=9A=E8=A5=BF=E5=8D=8E=E7=94=B5=E5=99=A8=EF=BC=88=E6=B1=9F=E8=8B=8F=
=EF=BC=89=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8, =E4=B8=AD=E5=9B=BD=E6=B1=9F=
=E8=8B=8F=E7=9C=81=E5=8D=97=E4=BA=AC=E5=B8=82=E7=BB=8F=E6=B5=8E=E6=8A=80=E6=
=9C=AF=E5=BC=80=E5=8F=91=E5=8C=BA=E5=B0=A7=E6=96=B0=E5=A4=A7=E9=81=93208=E5=
=8F=B7 210046
> =E6=89=8B=E6=9C=BA=EF=BC=9A19962032751
> Yaming.Chen@bshg.com
>
>
>
>
>
> From: Bytemark support@bytemark.co.uk
> Sent: Friday, December 12, 2025 2:31 PM
> To: Chen Yaming (BSH GDE-EDSCD) yaming.chen@bshg.com
> Subject: Your attachment was rejected
>
>
>
> Dear Chen Yaming (BSH GDE-EDSCD),
>
> Your email to our support system could not be accepted in full. The follo=
wing file(s) were rejected by our system: 0001-wifi-Fix-the-crash-issue-whe=
n-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-en=
able.patch
>
> Please try re-sending your attachment using one of the following allowed =
attachment types: doc|docx|xml|png|gif|jpg|jpeg|zip|rar|pdf|txt|log|xlsx|wa=
v.
>
> Kind Regards,
> Bytemark
>
>
>
>
>
> From: Chen Yaming (BSH GDE-EDSCD)
> Sent: Friday, December 12, 2025 2:28 PM
> To: 'connman@lists.linux.dev' <connman@lists.linux.dev>
> Cc: Dembianny Sven (BSH GDE-EDSD7) <Sven.Dembianny@bshg.com>
> Subject: Fix the crash issue when restarting the wpa_supplicant or wifi d=
river while BackgroundScanning is enable
>
>
>
> Hello, conman team:
>
>               I am a software development engineer of BSH company. We hav=
e discovered a bug in our project using connman. When BackgroundScanning is=
 enable, if the wifi driver or wpa_supplicant is restarted, it will cause c=
onnman crash. The parsing of the core dump print call stack shows the follo=
wing:
>
>
>
> Core was generated by `/usr/sbin/connmand --nodnsproxy -n'.
>
> Program terminated with signal SIGSEGV, Segmentation fault.
>
> #0 autoscan_timeout (data=3D0x144bc00) at ../connman-1.44/plugins/wifi.c:=
1382
>
> 1382 ../connman-1.44/plugins/wifi.c: No such file or directory.
>
> (gdb) bt
>
> #0 autoscan_timeout (data=3D0x144bc00) at ../connman-1.44/plugins/wifi.c:=
1382
>
> #1 0x76d0f8b4 in ?? () from /usr/lib/libglib-2.0.so.0
>
> #2 0x76d0eff6 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.=
0
>
> #3 0x76d0f24c in ?? () from /usr/lib/libglib-2.0.so.0
>
> #4 0x76d0f4a6 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
>
> #5 0x0001d126 in main (argc=3D<optimized out>, argv=3D<optimized out>) at=
 ../connman-1.44/src/main.c:1253
>
>
>
> We have created a patch to attempt to fix this issue, please help evaluat=
e and review it=EF=BC=8Cthanks=EF=BC=81=EF=BC=81
>
>
>
>
>
> Best regards=EF=BC=81=EF=BC=81
>
>
>
>
>
>
>
> Yaming Chen
> GDE-EDSCD
>
> =E5=8D=9A=E8=A5=BF=E5=8D=8E=E7=94=B5=E5=99=A8=EF=BC=88=E6=B1=9F=E8=8B=8F=
=EF=BC=89=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8, =E4=B8=AD=E5=9B=BD=E6=B1=9F=
=E8=8B=8F=E7=9C=81=E5=8D=97=E4=BA=AC=E5=B8=82=E7=BB=8F=E6=B5=8E=E6=8A=80=E6=
=9C=AF=E5=BC=80=E5=8F=91=E5=8C=BA=E5=B0=A7=E6=96=B0=E5=A4=A7=E9=81=93208=E5=
=8F=B7 210046
> =E6=89=8B=E6=9C=BA=EF=BC=9A19962032751
> Yaming.Chen@bshg.com
>
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
