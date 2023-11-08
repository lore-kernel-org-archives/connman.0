Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6730656
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgIP+eLi"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-41b7ec4cceeso43958681cf.1
        for <connman@lists.linux.dev>; Wed, 08 Nov 2023 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699459416; x=1700064216; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9Zs3vRkx1OBTW7ShCpbY/heoqq1z1Ul7gVzveuQKKc=;
        b=WgIP+eLiqEERzyxzl5u9K8vjXgeV9c2FU+UwQJz7V9s9tyM5g4G1s4ZOTYZdRTUMYf
         YKhE9iNq5tpZ9Z+pFuCfSxd3KcUYKkh6UVnOqIlzDqnMzkHKb2Nu/O8fQLjuBURFGZcJ
         nj6pIWIq9DuFYnvhDowh/ACSfzT5+CRasqo13yuRuMl82DM/0hmrDIKEzPUUBn5yQSCW
         g/lGzD5JZ6Gxw16LkeaYxM+x6yk3F4JtBoeTZ96TTbWnmfeDo/Qe561AJ6IJjlcYA+Lg
         NyFAE+jc1x4u/sH/HPMC3nlZzyaH3zb7SiI/aFPt54Rc1etrU9uUoinbC7YoqgvNaB7s
         OcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699459416; x=1700064216;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Zs3vRkx1OBTW7ShCpbY/heoqq1z1Ul7gVzveuQKKc=;
        b=aTRKhz1+LMsOwOyhlPUvFP6wyDXkM6nTmKCkN89RxBCdegPe8ryfFBX7uc4AgVCi79
         aJwgVHnvtybOJ/4dMhbco37MRitIwNpzCpIVrQUuqYRR5dZX9I8Ea+1rYxUSJ8nliNGy
         vlD7YolOINUbF37osxZlR4D5KtwQQXI+YMEpK/KzPPCehEn9rK+AnXXK8njMkLdEdo8b
         FBatBBxj2SuFzs3NYLlD2cXCa1vTOv5FNDNZgM/H8/oxAtryUVwd0WktUWgoUhu47RgL
         3eh1qypLEkpTIfP6V50usjRqzJLgnCgXUJ7abPUavjLNHMtBVJ1MTGTvGJlDN2/m2mIx
         pDqg==
X-Gm-Message-State: AOJu0YynJb2pglFFggvbpHtJqCKr4UtG+cHlqDF83O1PcdbA1wmuJjxL
	Chz4s3OTVKqep9vk0jdMMyneWXTcw2yoHdxZawc=
X-Google-Smtp-Source: AGHT+IEz/H1wdqqnoGFpIGyWK6c9NYz0m0Sh3qxkA82kM2D4/MsPv+PjqSRlA7HBBdQpgRuHpfRq1Cx6XnCfhGvCCOM=
X-Received: by 2002:a05:622a:48e:b0:41e:9953:ff93 with SMTP id
 p14-20020a05622a048e00b0041e9953ff93mr2751646qtx.19.1699459415892; Wed, 08
 Nov 2023 08:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2CD24062-D2D6-4E13-A6A9-7EA130D38131@nuovations.com>
 <47128531-37B9-4428-ADE4-6A2251030BF9@nuovations.com> <E9802F66-73D0-49B5-9884-027B757BAE7B@holtmann.org>
 <C03F5DCF-9E72-40BB-AC52-04BBAB498BF9@nuovations.com>
In-Reply-To: <C03F5DCF-9E72-40BB-AC52-04BBAB498BF9@nuovations.com>
From: daniel antoine <univac55@gmail.com>
Date: Wed, 8 Nov 2023 17:03:22 +0100
Message-ID: <CA+iibzBFr5K5q60fR7PH01UHCZf5kYxR_t8niTos8rRgHoGr=w@mail.gmail.com>
Subject: Re: Clarifying ConnMan Configuration Multi-technology Feature Fusion
 and Online/Ready Transitions
To: Grant Erickson <gerickson@nuovations.com>, Marcel Holtmann <marcel@holtmann.org>, 
	connman@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000cc22d30609a63a28"

--000000000000cc22d30609a63a28
Content-Type: multipart/alternative; boundary="000000000000cc22d20609a63a26"

--000000000000cc22d20609a63a26
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi grant

Maybe you can try this PKG file with the last commit for both ell and iwd

Best regards

Daniel



Le mer. 8 nov. 2023 =C3=A0 16:30, Grant Erickson <gerickson@nuovations.com>=
 a
=C3=A9crit :

> On Nov 8, 2023, at 6:46 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> >> I=E2=80=99ve done more testing on this front with some unexpected resu=
lts using
> the configuration below:
> >>
> >> * I have an Ethernet cable connected to the device under test (DUT) to
> an eight port desktop Ethernet switch which, in turn, is connected to
> another local switch which is yet another switch hop away from the backbo=
ne
> and the router.
> >> - If I leave the DUT connected to the desktop switch but disconnect th=
e
> desktop switch from its parent switch and then monitor, I eventually see
> repeated WiSPR failures over Ethernet (404) but I never see Ethernet cede
> the default route to W-Fi and Wi-Fi transition from =E2=80=9CReady=E2=80=
=9D to =E2=80=9COnline=E2=80=9D.
> >> - How many back-to-back WiSPR failures are expected until another
> technology / service takes over the default route?
> >>
> >> I also did a test in which I changed:
> >>
> >> * EnableOnlineToReadyTransition=3Dfalse
> >> * SingleConnectedTechnology=3Dtrue
> >>
> >> relative to the below. In this situation, Wi-Fi went crazy with its
> link transitioning many times a second from associating to configuration =
to
> ready to offline. The console became unusable with repeated:
> >>
> >>   IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> >>   IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> >>
> >> messages.
> >
> > Hmm. I would really prefer you abandon wpa_supplicant and you use iwd.
> Some things that wpa_supplicant does and various hardware drivers are doi=
ng
> is insane and we paper over it. Only when starting with iwd, we can addre=
ss
> things properly.
>
> Marcel,
>
> I=E2=80=99d like to make that move; unfortunately, for the current projec=
t I am
> engaged on, I am locked on linux-4.9.212, glibc-2.28, and GCC 8.x.
> Unfortunately, with that combination, the latest version of ELL I can get
> to build is 0.28 and the latest version of IWD won=E2=80=99t compile agai=
nst it. In
> parallel, the latest version of ELL fails with a number of errors (I=E2=
=80=99ll
> follow up on those later per Denis) and the version of ELL included with
> IWD fails with an overlapping but also unique set of errors.
>
> Unfortunately, untangling all of that is more than the client is willing
> to take on at the moment. I=E2=80=99ve recommended that they pursue IWD a=
fter a
> kernel, glibc, toolchain update in a later effort.
>
> Best,
>
> Grant
>
> --
> Principal
> Nuovations
>
> gerickson@nuovations.com
> http://www.nuovations.com/
>
>
>

--000000000000cc22d20609a63a26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi grant<div><br></div><div>Maybe you can try this PKG fil=
e with the last commit for both ell and iwd</div><div><br></div><div>Best r=
egards</div><div><br></div><div>Daniel</div><div><br></div><div><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">L=
e=C2=A0mer. 8 nov. 2023 =C3=A0=C2=A016:30, Grant Erickson &lt;<a href=3D"ma=
ilto:gerickson@nuovations.com">gerickson@nuovations.com</a>&gt; a =C3=A9cri=
t=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Nov =
8, 2023, at 6:46 AM, Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.=
org" target=3D"_blank">marcel@holtmann.org</a>&gt; wrote:<br>
&gt;&gt; I=E2=80=99ve done more testing on this front with some unexpected =
results using the configuration below:<br>
&gt;&gt; <br>
&gt;&gt; * I have an Ethernet cable connected to the device under test (DUT=
) to an eight port desktop Ethernet switch which, in turn, is connected to =
another local switch which is yet another switch hop away from the backbone=
 and the router.<br>
&gt;&gt; - If I leave the DUT connected to the desktop switch but disconnec=
t the desktop switch from its parent switch and then monitor, I eventually =
see repeated WiSPR failures over Ethernet (404) but I never see Ethernet ce=
de the default route to W-Fi and Wi-Fi transition from =E2=80=9CReady=E2=80=
=9D to =E2=80=9COnline=E2=80=9D.<br>
&gt;&gt; - How many back-to-back WiSPR failures are expected until another =
technology / service takes over the default route?<br>
&gt;&gt; <br>
&gt;&gt; I also did a test in which I changed:<br>
&gt;&gt; <br>
&gt;&gt; * EnableOnlineToReadyTransition=3Dfalse<br>
&gt;&gt; * SingleConnectedTechnology=3Dtrue<br>
&gt;&gt; <br>
&gt;&gt; relative to the below. In this situation, Wi-Fi went crazy with it=
s link transitioning many times a second from associating to configuration =
to ready to offline. The console became unusable with repeated:<br>
&gt;&gt; <br>
&gt;&gt;=C2=A0 =C2=A0IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready<br=
>
&gt;&gt;=C2=A0 =C2=A0IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes rea=
dy<br>
&gt;&gt; <br>
&gt;&gt; messages.<br>
&gt; <br>
&gt; Hmm. I would really prefer you abandon wpa_supplicant and you use iwd.=
 Some things that wpa_supplicant does and various hardware drivers are doin=
g is insane and we paper over it. Only when starting with iwd, we can addre=
ss things properly.<br>
<br>
Marcel,<br>
<br>
I=E2=80=99d like to make that move; unfortunately, for the current project =
I am engaged on, I am locked on linux-4.9.212, glibc-2.28, and GCC 8.x. Unf=
ortunately, with that combination, the latest version of ELL I can get to b=
uild is 0.28 and the latest version of IWD won=E2=80=99t compile against it=
. In parallel, the latest version of ELL fails with a number of errors (I=
=E2=80=99ll follow up on those later per Denis) and the version of ELL incl=
uded with IWD fails with an overlapping but also unique set of errors.<br>
<br>
Unfortunately, untangling all of that is more than the client is willing to=
 take on at the moment. I=E2=80=99ve recommended that they pursue IWD after=
 a kernel, glibc, toolchain update in a later effort.<br>
<br>
Best,<br>
<br>
Grant<br>
<br>
-- <br>
Principal<br>
Nuovations<br>
<br>
<a href=3D"mailto:gerickson@nuovations.com" target=3D"_blank">gerickson@nuo=
vations.com</a><br>
<a href=3D"http://www.nuovations.com/" rel=3D"noreferrer" target=3D"_blank"=
>http://www.nuovations.com/</a><br>
<br>
<br>
</blockquote></div>

--000000000000cc22d20609a63a26--
--000000000000cc22d30609a63a28
Content-Type: application/octet-stream; name=Pkgfile
Content-Disposition: attachment; filename=Pkgfile
Content-Transfer-Encoding: base64
Content-ID: <f_lopy8p7n0>
X-Attachment-Id: f_lopy8p7n0

bWFrZWRlcGVuZHM9KGRidXMgcHl0aG9uLWRvY3V0aWxzIHJlYWRsaW5lKQoKZGVzY3JpcHRpb249
IkludGVybmV0IFdpcmVsZXNzIERhZW1vbiIKdXJsPSJodHRwczovL2dpdC5rZXJuZWwub3JnL2Nn
aXQvbmV0d29yay93aXJlbGVzcy9pd2QuZ2l0LyIKCnBhY2thZ2VyPSJZYW9saW51eCBUZWFtIgpt
YWludGFpbmVyPSJEYW5pYSIKCm5hbWU9aXdkCnZlcnNpb249Mi44CgojTGFzdCBjb21taXQgb24g
aXdkIHJlcG8KX2NvbW1pdDE9YzU3NGM4MGUyN2Y0ZjI4OTNiNTJkZDI5ZGE1ZDAwMzczMDg4ODIy
ZgoKI0xhc3QgY29tbWl0IG9uIGVsbCByZXBvCl9jb21taXQyPTQ1ZTBjYTI4NjExNmJjNWZkNzVj
ZTAzYWE5ODliOTMxODk0Y2VhZmMKCnByZXBhcmUoKSB7CiAgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saWJzL2VsbC9lbGwuZ2l0IGVsbAoKICBjZCBlbGwKICBnaXQg
Y2hlY2tvdXQgJHtfY29tbWl0Mn0KCiAgY2QgLi4KCiAgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL3dpcmVsZXNzL2l3ZC5naXQgaXdkCgogIGNkIGl3ZAog
IGdpdCBjaGVja291dCAke19jb21taXQxfQoKICBhdXRvcmVjb25mIC1maXYKfQoKYnVpbGQoKSB7
CiAgY2QgaXdkCgogIGNwIC91c3IvbGliL3BrZ2NvbmZpZy9uY3Vyc2Vzdy5wYyAvdXNyL2xpYi9w
a2djb25maWcvbmN1cnNlcy5wYwoKICAuL2NvbmZpZ3VyZSAtLXByZWZpeD0vdXNyIFwKICAgICAg
ICAgICAgICAtLXN5c2NvbmZkaXI9L2V0YyBcCiAgICAgICAgICAgICAgLS1sb2NhbHN0YXRlZGly
PS92YXIgXAogICAgICAgICAgICAgIC0tbGliZXhlY2Rpcj0vdXNyL2xpYi9pd2QgXAogICAgICAg
ICAgICAgIC0tZW5hYmxlLXdpcmVkIFwKICAgICAgICAgICAgICAtLWVuYWJsZS1vZm9ubyBcCiAg
ICAgICAgICAgICAgLS1lbmFibGUtaHdzaW0gXAogICAgICAgICAgICAgIC0tZGlzYWJsZS10b29s
cwoKICBtYWtlCiAgbWFrZSBpbnN0YWxsIERFU1RESVI9JFBLRwoKICBybSAvdXNyL2xpYi9wa2dj
b25maWcvbmN1cnNlcy5wYwoKICBpbnN0YWxsIC1kbTcwMCAkUEtHL3Zhci9saWIvZWFkLwogIGlu
c3RhbGwgLWRtNzAwICRQS0cvdmFyL2xpYi9pd2QvCn0K
--000000000000cc22d30609a63a28--
