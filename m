Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0A1F2C4B
	for <connman@lists.linux.dev>; Tue, 28 Jan 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022425; cv=none; b=TN1jWH4qT49t9Rb8OL3WZhwuZuBCtwvAgIAZUkajp+jEjVRUxJElmGwbou0/i9d66BZMgJgZAVIvQCq8lvGdoR3aSSi8dI4YDOU/XziAwVqV+nmu4JAbK9qX7jJBXfDHRF5/uM41qI8otGW9tYAIgglm/5itDxq0FUsclurbANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022425; c=relaxed/simple;
	bh=QhXFEWWQXgvUjNOeYO2Qh4Uqg1DTMcX2b9vBWFDNedc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QSKt3wH0/TjptE+1ovUzAlIpns3aXCRg5Ua5FRavt8Yyv1Q9iDRidhGDrEDXJyHA4uceOfaJlrUnqbsN74Z4edP6gd70pnXOZFwIRbpu/fgdjfuWeMGHu8qGA3KlcovhhEdfGdRg1vBe35hpwCdsSnAWl/ytC1V8L9aMjBbqBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=X2KEdjXI; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="X2KEdjXI"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 71481164A24;
	Mon, 27 Jan 2025 19:00:15 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 03290124EE6;
	Mon, 27 Jan 2025 19:00:14 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: v1.43 - BUG: Connectivity failure when router provides invalid
 PAC settings
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <CAMieACZtdeZvvHWJURtZPpZ_pNXPkC-jFTQHwBEKMFNcMMoQgA@mail.gmail.com>
Date: Mon, 27 Jan 2025 16:00:04 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <43A9D1BF-66D0-4A1B-B189-2946C830D94C@nuovations.com>
References: <CAMieACZtdeZvvHWJURtZPpZ_pNXPkC-jFTQHwBEKMFNcMMoQgA@mail.gmail.com>
To: Scott Valentine <scottv@hawaiienergyconnection.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=fRFhsiFVh+k8fuvcCuaXTwQlCsDc/kn9aebTRCqvjY8=; b=X2KEdjXIhKERQ78mdIUSfqyu1svlLm54RpxS3sQHhShCSjEW0a8axCDXFvkE+w+mbWQRhbvBODcK4JETO+3VpfEz4c6XXara8izqYA6SOts0EGGjl8c0rPcukjB4phJTJ5yZGESk84vTGj9gfRCzQvVIb1SU79LTDZ4HYPqR0YOcdDvklZP16MuRYyQSOUhqqAGV9tOE+Cxn5HITA1sxgUlX3V+6e5FVbpVy0J6IAMkKBEZt/HKi0nArYS0WgN9qzPfs8x5NshP0V5nPN88xxLiaJ5/qTumtqY2NAt95woonrOh9VPcYLp47G36vBD4Ip2j0J3WBsbhI+Owa5/Q9iA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Scott,

You may be interested in this patch series:

=
https://lore.kernel.org/connman/20241212052817.2021264-1-gerickson@nuovati=
ons.com/T/#t

Our solution was to enable the PACrunner daemon as follows and the =
PACrunner plugin (which seems to recognize it=E2=80=99s an invalid PAC =
URL and returns =E2=80=9CDirect=E2=80=9D):

=
PKG_CONFIG_LIBDIR=3D"$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.=
2.0/$(BUILD_CONFIG)/third_party/glib/usr/lib/pkgconfig:$(PROJECT_ROOT)/res=
ults/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(BUILD_CONFIG)/third_party/dbus/usr=
/lib/pkgconfig:$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(=
BUILD_CONFIG)/third_party/curl/usr/lib/pkgconfig" \
$(PROJECT_ROOT)/third_party/pacrunner/repo/configure -C \
AR=3D"$(SYSROOT)/usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-ar" =
CPP=3D"$(SYSROOT)/usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-cpp"=
 CC=3D"$(SYSROOT)/usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-gcc"=
 =
CXX=3D"$(SYSROOT)/usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-g++"=
 =
RANLIB=3D"$(SYSROOT)/usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-r=
anlib" =
STRIP=3D"$(SYSROOT)/usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-st=
rip" \
CPPFLAGS=3D"--sysroot=3D$(PROJECT_ROOT)/rootfs -mcpu=3Dcortex-a8 =
-mfloat-abi=3Dhard -mfpu=3Dneon -isystem =
/opt/fwds/sysroots/cortexa9t2hf-neon-dey-linux-gnueabi/usr/include =
-I$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(BUILD_CONFIG)=
/third_party/linux/linux-dey/include =
-I$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(BUILD_CONFIG)=
/third_party/curl/usr/include" \
CFLAGS=3D"--sysroot=3D$(PROJECT_ROOT)/rootfs -mcpu=3Dcortex-a8 =
-mfloat-abi=3Dhard -mfpu=3Dneon -fno-omit-frame-pointer =
-fno-strict-aliasing" \
CURL_CFLAGS=3D"" \
=
CURL_LIBS=3D"-L$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(=
BUILD_CONFIG)/third_party/curl/usr/lib/ -lcurl" \
=
DBUS_CFLAGS=3D"-I$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/=
$(BUILD_CONFIG)/third_party/dbus/usr/include/dbus-1.0 =
-I$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(BUILD_CONFIG)=
/third_party/dbus/usr/lib/dbus-1.0/include" \
=
DBUS_LIBS=3D"-L$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(=
BUILD_CONFIG)/third_party/dbus/usr/lib/ -ldbus-1" \
=
GLIB_CFLAGS=3D"-I$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/=
$(BUILD_CONFIG)/third_party/glib/usr/include/gio-unix-2.0 =
-I$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(BUILD_CONFIG)=
/third_party/glib/usr/include/glib-2.0 =
-I$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(BUILD_CONFIG)=
/third_party/glib/usr/lib/glib-2.0/include" \
=
GLIB_LIBS=3D"-L$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(=
BUILD_CONFIG)/third_party/glib/usr/lib/ -lglib-2.0 -Wl,-rpath-link =
-Wl,$(PROJECT_ROOT)/results/$(PRODUCT_CONFIG)/digi/dey/8.2.0/$(BUILD_CONFI=
G)/third_party/pcre/usr/lib" \
--with-sysroot=3D$(PROJECT_ROOT)/rootfs \
--build=3Dx86_64-pc-linux-gnu \
--host=3Darm-dey-linux-gnueabi \
--target=3Darm-dey-linux-gnueabi \
--disable-debug \
--disable-duktape \
--disable-test \
--disable-unit \
--enable-curl \
--prefix=3D/usr \
--sysconfdir=3D/etc \
--localstatedir=3D/var

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


> On Jan 27, 2025, at 3:44=E2=80=AFPM, Scott Valentine =
<scottv@hawaiienergyconnection.com> wrote:
>=20
> Apologies for the repeat - I lost the subject line so I am resending.
>=20
> While testing an upgrade from v1.33 to v1.43, we experienced an issue
> where some of our devices were failing to establish internet
> connectivity, while the older version of connman had no problems.
>=20
> We have identified the source of the issue as a buggy proxy
> configuration from the ISP provided router. Specifically, these are
> Hawaiian Telecom provided Zyxel wireless routers. The router DHCP
> server supplies a PAC URL option with essentially an empty value of
> [0x0a, 0x0d, 0x00], as well as a domain name option of "home".
>=20
> This ultimately results in a call to __connman_wpad_start() with an
> invalid configuration that should not succeed (I think?), but does
> (due to the hostname also being set by the DHCP server), even though
> the PAC URL is null.
>=20
> WPAD then calls __connman_service_set_proxy_autoconfig() which results
> in the following broken configuration for the service proxy:
>            dict entry(
>               string "Proxy"
>               variant                   array [
>                     dict entry(
>                        string "URL"
>                        variant                            string
> "http://wpad.home/wpad.dat"
>                     )
>                     dict entry(
>                        string "Method"
>                        variant                            string =
"auto"
>                     )
>                  ]
>            )
>=20
> I believe the correct fix for this could be to check the PAC URL
> either before starting WPAD, or within __connman_wpad_start(), the
> latter requiring a getter for the service->pac property. N.B. I don't
> really know much of anything about WPAD or PAC.
>=20
> For now, I can work around the issue with a small patch to force the
> proxy method to "direct" in service.c: check_proxy_setup, but I'm not
> super confident that this is the best approach:
>=20
> diff -uNrp old/src/service.c new/src/service.c
> --- old/src/service.c   2024-09-01 23:34:15.000000000 -1000
> +++ new/src/service.c   2025-01-27 13:11:52.713053125 -1000
> @@ -1731,8 +1731,18 @@ static bool check_proxy_setup(struct con
>         * to AUTO with an empty URL.
>         */
>=20
> -       if (service->proxy !=3D CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN)
> +       DBG("proxy %d, config %d, pac %s", service->proxy,
> service->proxy_config,
> +                       service->pac);
> +
> +       if (service->proxy !=3D CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN) =
{
> +               if ((service->proxy =3D=3D =
CONNMAN_SERVICE_PROXY_METHOD_AUTO) &&
> +                               (service->pac =3D=3D NULL)) {
> +                       DBG("OVERRIDING PROXY METHOD");
> +                       connman_service_set_proxy_method(service,
> +                               CONNMAN_SERVICE_PROXY_METHOD_DIRECT);
> +                }
>                return true;
> +       }
>=20
>        if (service->proxy_config !=3D =
CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN &&
>                (service->proxy_config !=3D =
CONNMAN_SERVICE_PROXY_METHOD_AUTO ||
>=20
>=20
> Mahalo!
> -Scott V.
