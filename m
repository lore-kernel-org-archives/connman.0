Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C91E9B3D
	for <connman@lists.linux.dev>; Tue, 12 May 2026 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578370; cv=pass; b=O2cqPDTpc8QfZK5KRxxetKAyuBHxn4i3TeUMSZZAE88bPhWiooD6grIyzVyYJEixHym+ySPbs7ercW6wE2bt0djuINXla8UEU0RqLtDYnrvXib2oAzQppFtMujOf7vJCyFW5IW3iGQEQFX9yboTveQYKOkgDSOrPd0zLIB2BDj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578370; c=relaxed/simple;
	bh=eig2EHY7TDfB+ME9fnfpjWIJhEsO0S0p2YBQV/luQtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGyTgy+dXtyF1zZOWZDI5u4+aDy8M3gSDaPo6mxujqhahyhMIZY/HDee5U7+TYq/r+aFqf5wOIw0qP2/VUuC5oATwlZMNCTQpX24GI2FEUpWa6YkFRW9toQ+fuyN7ehI3ND9JAsDHkDzhfhGkq1lapKDkB7KCU2BLrYQ+Dw50tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=kk+0nZ3o; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kk+0nZ3o"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c156c4a9efso7084068eec.1
        for <connman@lists.linux.dev>; Tue, 12 May 2026 02:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778578368; cv=none;
        d=google.com; s=arc-20240605;
        b=GLpCMFnKyQYQ3Trq37onAGnnRZZnc3l7ll+RWg1SYr7VQ05xJYb6KVmUGWxGF12b6h
         rQNe1PgMV13C4kVUhOfT49v9ztOnRtpgT6cc9sZbwHL/iR+2LuGLMME5OqQrmJd1WZ2d
         WEdXCYvCbM61jqe0+bj5eomYj4vxJ9Eq5Utcy4lbAE8B4bR8vNw97Ss0yk1KJmMLKv0j
         9S5BnlqVoEYAD+EINmrEnMLdzDKwJczxFGNDXe5fnLFWX+PvA368rctAJVgpNSS9PINL
         cerVbVwiVmD2HZeD7nY158blS/NP/WywsjJD5ctdUXuBEhk5Qy0b3UaIa09IbYEqewgu
         Ts+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bwsGIPKYiUX/iNjJWVrRQy3E3yXSP5EIS7Iq3gXa/6k=;
        fh=S9a26PpJpbsZqXMW7Hja4/b49lR8lYFPlcDdQXiW3rg=;
        b=KVkMmJQ0/yqQ8YgKklTdvuOFNyMKN5qD7pXO89UN4BL8e9VQA8XdhDpeO9S5KreCmF
         cCFdi0LzfmWR7PVs/MNTeYV1GENtZyftT2r8xyTSzGmC42qGSb+9Yo8SOEsuZrh/z3My
         h+d9suyLcU2d9+QW8GnRy/I6nWzgbFCWdwdGtL3RQHTVfrHVSLDrp4gtqbcSxse26Hgl
         mFOa0Mq1zdE4ImSgiEnmViRr/+dMEa1Ogr4noW807Gl+VwbHi+wmZ3i4pRoBmxJzzbYD
         MO+cLPpDjyXcOl1hpal6FRsBs/WAwDl9QswJdYpPReUp9lz3ekNwIyoufieUkFEDcX6h
         X0nA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1778578368; x=1779183168; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bwsGIPKYiUX/iNjJWVrRQy3E3yXSP5EIS7Iq3gXa/6k=;
        b=kk+0nZ3or3hUE5QpXIomq4pKXsIkSSZHsyopGn0y3DYuMKOlW1rPB4VEDGz/XdlTAt
         jJtqaDz1WRUa7xAO/lG/CdrsiAPM2kj7JGnbmFcZ+JZ5I4zu1tYukOeF8oMN5nPN2e/U
         jsupPGRalReMgyf29SdK+bBqVo3LSE847B7K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578368; x=1779183168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwsGIPKYiUX/iNjJWVrRQy3E3yXSP5EIS7Iq3gXa/6k=;
        b=gxFmmoJoPe8+SHPUVAZThGfUn8jTyyVMEIzkkFHO1OSY7CoM5R3oGNO/234rlCYgWd
         1Epl4etnHsmcmRpgOv7zIQF6fN58dycVBWWzuP1tPK0k4ZTG/S8mS12xoEWUJzi40k2W
         FY1sF9IF+Uyr4emsRDhLn/mNpUSn0aQPtGCWjcXVCh3XRvkDkMd6zeYiY7TufgVdnAeR
         9EoS4YE5laE7cNBXLB9AVREKkgLp6XxlAxjkWz7MIbvd5vWqay4X6z2AFtgDKr/SVA09
         L0nHyXx9Y9tOFe19U8udXLX9Up5ERtff4xu6QOJtOU0SSrZPNZPlYDMHkQ1XlZtIfQiJ
         08Hw==
X-Gm-Message-State: AOJu0YxmspRJWH1VVI6IeJmz1ow17fhEags0odnpDGF9HGRQRbOvH3sW
	TgIvHyARjKtu5DWyJ3iXrgvVFvBG8pWGDF0OYb32PKZhVg84NKo1M7H/afiSWxTjWJgA1gL4hPb
	Pj4uLFpNfSVNI3Sn4naDsq3K64oBu3f1AiDXTPXYL1g==
X-Gm-Gg: Acq92OGz3H6MSYDpzf8zpkFgsXB+CjEVw4GWAqLkpO5BkX0RJKnf56cqNc36piZ6cI4
	B7bJe8Yn/a6dMnk1YuLJcyp47bOcmH7GaSKx7JQ4E9v2wpYSBW38oKAEQdpTaJpmGCNWjCWGpAq
	whmTyKj3eE9ZPPqlW5yPeRW0NuR6ibodTjlDGw9R4qoChViStfgtJZN0dlgY2kzRKlJZlnJR31a
	YAaHoYqgziXIg9PoB3R1o5y3J8f8frcQDP87VenP+n0nIP+vx4oQKgMI01/cyMN4dzGmJ40drlz
	uOXlDS+3i5cHkeQDxRrDhyPFbOmxS17rSB15+LGCxMsv8QE=
X-Received: by 2002:a05:7300:6c29:b0:2ed:e14:e954 with SMTP id
 5a478bee46e88-2f550b41597mr12616090eec.30.1778578368276; Tue, 12 May 2026
 02:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
In-Reply-To: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 12 May 2026 11:32:35 +0200
X-Gm-Features: AVHnY4I6prAb4iNK2UajzgH7Uh0u_YoiUYbfsD05DaJ4Fiv7yMycq2vQnz38cug
Message-ID: <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
Subject: Re: Connection to a WPA2 Wi-Fi router fails
To: =?UTF-8?Q?Fran=C3=A7ois_Galea?= <fgalea@free.fr>, 
	Sven Dembianny <sven.dembianny@bshg.com>
Cc: connman@lists.linux.dev, wbx@openadk.org
Content-Type: multipart/mixed; boundary="000000000000d92b0706519b8b03"

--000000000000d92b0706519b8b03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, May 12, 2026 at 11:14=E2=80=AFAM Fran=C3=A7ois Galea <fgalea@free.f=
r> wrote:
>
> Hello,
>
> This was tested on a Zynq (Cortex-A9) and a RPi4, on a 32-bit Arm
> Buildroot Linux system.
>
> The Wi-Fi router uses WPA2 Personnal authentication.
>
> Problem starts from buildroot releases including connman 1.45. Previous
> releases using connman 1.44 and prior are working fine. Also switching
> from 1.45 to 1.44 in a buildroot version that includes connman 1.45 works=
.
>
>
> If a connection was previously successfully set up, for instance from
> connman 1.44 or older, `/var/log/messages` contains:
>
> Jan  1 00:00:11 zest daemon.info connmand[141]: Adding interface wlan0 [
> wifi ]
> Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {update} flags
> 36867 <UP>
> Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {newlink} index 2
> address 9A:8F:85:81:67:B4 mtu 1500
> Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {newlink} index 2
> operstate 2 <DOWN>
> Jan  1 00:00:11 zest daemon.info dbus-daemon[120]: [system] Successfully
> activated service 'fi.w1.wpa_supplicant1'
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags
> 36931 <UP,RUNNING>
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
> address 8C:3D:16:20:0E:4A mtu 1500
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
> operstate 0 <UNKNOWN>
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags
> 36867 <UP>
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
> address 8C:3D:16:20:0E:4A mtu 1500
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
> operstate 2 <DOWN>
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
> address 8C:3D:16:20:0E:4A mtu 1500
> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
> operstate 2 <DOWN>
> Jan  1 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi ]
> state is association
> Jan  1 00:00:11 zest daemon.warn connmand[141]: Interface wlan0 [ wifi ]
> error "invalid-key"
> Jan  1 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi ]
> state is failure
>
>
> Otherwise, when creating a new connection:
>
> # connmanctl
> Error getting VPN connections: The name net.connman.vpn was not provided
> by any .service files
> connmanctl> services
>
> connmanctl> enable wifi
> Enabled wifi
> connmanctl> scan wifi
> Scan completed for wifi
> connmanctl> services
>      Kamoulox             wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
>      Livebox-D050
> wifi_8c3d16200e4a_4c697665626f782d44303530_managed_psk
>      Freebox-3B4B3C
> wifi_8c3d16200e4a_46726565626f782d334234423343_managed_psk
>      patetalex            wifi_8c3d16200e4a_7061746574616c6578_managed_ps=
k
>      DRAME                wifi_8c3d16200e4a_4452414d45_managed_psk
> connmanctl> agent on
> Agent registered
> connmanctl> connect wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
> Agent RequestInput wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
>    Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory, Alternates=3D[ W=
PS ] ]
>    WPS =3D [ Type=3Dwpspin, Requirement=3Dalternate ]
> Passphrase? my_wifi_passphrase
> Agent ReportError wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
>    invalid-key
> connmanctl> Retry (yes/no)? no
> Error
> /net/connman/service/wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk:
> Input/output error
> connmanctl>


I think that change only asks the agent who established the connection
to try the various method. Is the patch in attach work?
* sven *: Does it cover your use case too?

Michael


>
>
>
>  From both situations it appears the wifi passphrase is not accepted.
>
> wbx (as CC of this email) noticed that reverting commit
> 5e73b55e00b97e1867397258b72f0d6e5ad7d31d allows connections to work again=
.
>
> Is it a known situation?=E2=80=AFIs there a patch available?
>
> Best,
>
> Fran=C3=A7ois
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

--000000000000d92b0706519b8b03
Content-Type: text/x-patch; charset="US-ASCII"; name="auth.patch"
Content-Disposition: attachment; filename="auth.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mp2fltyk0>
X-Attachment-Id: f_mp2fltyk0

ZGlmZiAtLWdpdCBhL2dzdXBwbGljYW50L3N1cHBsaWNhbnQuYyBiL2dzdXBwbGljYW50L3N1cHBs
aWNhbnQuYwppbmRleCA1ZTI4OTk1My4uYjE4ODA1NzQgMTAwNjQ0Ci0tLSBhL2dzdXBwbGljYW50
L3N1cHBsaWNhbnQuYworKysgYi9nc3VwcGxpY2FudC9zdXBwbGljYW50LmMKQEAgLTQ5NTUsOCAr
NDk1NSwxNSBAQCBzdGF0aWMgdm9pZCBhZGRfbmV0d29ya19zZWN1cml0eShEQnVzTWVzc2FnZUl0
ZXIgKmRpY3QsIEdTdXBwbGljYW50U1NJRCAqc3NpZCkKIAkJYWRkX25ldHdvcmtfc2VjdXJpdHlf
Y2lwaGVycyhkaWN0LCBzc2lkKTsKIAkJYnJlYWs7CiAJY2FzZSBHX1NVUFBMSUNBTlRfU0VDVVJJ
VFlfUFNLOgotCQlrZXlfbWdtdCA9ICJTQUUgV1BBLVBTSyBXUEEtUFNLLVNIQTI1NiI7Ci0JCWll
ZWU4MDIxMXcgPSBHX1NVUFBMSUNBTlRfTUZQX09QVElPTkFMOworCQlpZiAoc3NpZC0+a2V5bWdt
dCAmIEdfU1VQUExJQ0FOVF9LRVlNR01UX1NBRSkgeworCQkJLy8gQVAgc3VwcG9ydHMgU0FFLCBz
byB3ZSBwcm92aWRlIHRoZSBmdWxsIHN1aXRlIGZvciByb2FtaW5nL3RyYW5zaXRpb24KKwkJCWtl
eV9tZ210ID0gIlNBRSBXUEEtUFNLIFdQQS1QU0stU0hBMjU2IjsKKwkJCWllZWU4MDIxMXcgPSBH
X1NVUFBMSUNBTlRfTUZQX09QVElPTkFMOworCQl9IGVsc2UgeworCQkJLy8gQVAgaXMgbGVnYWN5
OyBkb24ndCBjb25mdXNlIGl0IHdpdGggU0FFL1NIQTI1NiBzdHJpbmdzCisJCQlrZXlfbWdtdCA9
ICJXUEEtUFNLIjsKKwkJCWllZWU4MDIxMXcgPSBHX1NVUFBMSUNBTlRfTUZQX09QVElPTkFMOwor
CQl9CiAJCWFkZF9uZXR3b3JrX2llZWU4MDIxMXcoZGljdCwgc3NpZCwgaWVlZTgwMjExdyk7CiAJ
CWFkZF9uZXR3b3JrX3NlY3VyaXR5X3BzayhkaWN0LCBzc2lkKTsKIAkJYWRkX25ldHdvcmtfc2Vj
dXJpdHlfY2lwaGVycyhkaWN0LCBzc2lkKTsK
--000000000000d92b0706519b8b03--
