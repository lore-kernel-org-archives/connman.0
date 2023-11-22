Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0B4EB3F
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8+EUFXh"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32d895584f1so4861748f8f.1
        for <connman@lists.linux.dev>; Wed, 22 Nov 2023 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700664847; x=1701269647; darn=lists.linux.dev;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6XvtVGWF17s3mWC14ASlYAO1m51zf5fr75l2UGC2MI=;
        b=Z8+EUFXhpQ1J60jy6BtWiVIo+u3SCY2+cF/RmldlnZGcV3ETa68bJnnEfplZreAwOM
         nXx/jUwh84vDI06bO9V3J0IGCgu2PlXmxmIXh9dHVUQvdTlKR0yzRoShA/b8IiXF0lYf
         7e3OT1gVIJd2diJV4kUEl5cnfv4vt7npSrrBTQ17+Xab6yVToA7mDOYbF6sLINWeBkwo
         nOyXpTG6t9S1GyxaX3ADE0GthjaekcYzRjLptm0UYYWcafCbhPfJPEG27pmASw4aOvVF
         g8BkfeauRsait6ibETQDZtL8pbSI/PE7oiiChzM1Rzn1fMPjGoiin+CiXc4C++WJapk7
         K6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664847; x=1701269647;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6XvtVGWF17s3mWC14ASlYAO1m51zf5fr75l2UGC2MI=;
        b=Ew+8qtz3I7PonSwijFOTDzRKSczUjr1RJ3WoPAdV+AnTOnkKLwjzFbynahuGB/rC/8
         5M9iiCdY1Y62scHYTZfiwOUOVxuRLIfphYG1tWcR32MGL17lBUoKOLVgZeMMGktFJUpa
         R/ltLDVt7yLba0mKQMeSe1QKWRbDbu7uoMWI8wTPWAQBZNaj/JZOkahDwaNGptTXDLgi
         mbHnLwHe77tvRDExbWkiVZr9z8n8cpY25+j4wRohuwjamJtDY9Yu+XOCyAL4jQke5Ksu
         t4K0t7Xl2fm9JozW6SVYccH5/n4hVQWL9x6g83dTF49dXHOaQCywSHIlerbIvNePMiEw
         iH1A==
X-Gm-Message-State: AOJu0YxQLiSKCDS3dy/W/CFt8F+uW8EaWAd05m0805MwuEZC1HEs3jeU
	eI5iXIx3TBvI30Kz7gr/1k37kLlCGrw=
X-Google-Smtp-Source: AGHT+IGS5V1HHuXFj+/avAMmRkW1H23/zrdZdkSmZIdQ8GJfZURcvz4tRsqbEt5W1i4k82aL4xRwVg==
X-Received: by 2002:a05:6000:156c:b0:332:c65a:8f1f with SMTP id 12-20020a056000156c00b00332c65a8f1fmr2719014wrz.47.1700664846804;
        Wed, 22 Nov 2023 06:54:06 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id m3-20020adffa03000000b00323293bd023sm17365425wrr.6.2023.11.22.06.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:54:06 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: =?utf-8?Q?Regression_caused_by_=22Don=27t_add_route_for_invalid_d?=
 =?utf-8?Q?st_and_gateway_address_combinations=E2=80=9D?=
Message-Id: <A9CCB4B1-2A45-4C97-95E4-FBEDFAA8CD13@gmail.com>
Date: Wed, 22 Nov 2023 18:53:52 +0400
Cc: =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@gmail.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Commit 9eb1772d31b6 ("Don't add route for invalid dst and gateway =
address combinations=E2=80=9D) causes a regression in WireGuard support =
through the connman-vpn agent. I presume the wg0 interface matches the =
definition of "unspecified destination address coupled with unspecified =
gateway=E2=80=9D added.

This is my routing table with the WireGuard interface (wg0) active:

RPi5:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use =
Iface
default         172.16.50.1     0.0.0.0         UG    0      0        0 =
eth0
1.1.1.1         *               255.255.255.255 UH    0      0        0 =
wg0
8.8.8.8         *               255.255.255.255 UH    0      0        0 =
wg0
10.127.0.0      *               255.255.255.0   U     0      0        0 =
wg0
65.109.130.17   172.16.50.1     255.255.255.255 UGH   0      0        0 =
eth0
167.299.200.14  172.16.50.1     255.255.255.255 UGH   0      0        0 =
eth0
172.16.50.0     *               255.255.255.0   U     0      0        0 =
eth0
172.16.50.1     *               255.255.255.255 UH    0      0        0 =
eth0

As wg0 does not have the default route =E2=80=9Call-traffic" is not =
routed down the VPN tunnel as defined in the connman-vpn WireGuard =
configuration:

WireGuard.AllowedIPs =3D 0.0.0.0/0

This is the routing table after reverting 9eb1772d31n6:=20

RPi5:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use =
Iface
default         *               0.0.0.0         U     0      0        0 =
wg0
1.1.1.1         *               255.255.255.255 UH    0      0        0 =
wg0
8.8.8.8         *               255.255.255.255 UH    0      0        0 =
wg0
10.127.0.0      *               255.255.255.0   U     0      0        0 =
wg0
65.109.130.17   172.16.50.1     255.255.255.255 UGH   0      0        0 =
eth0
167.299.200.14  172.16.50.1     255.255.255.255 UGH   0      0        0 =
eth0
172.16.50.0     *               255.255.255.0   U     0      0        0 =
eth0
172.16.50.1     *               255.255.255.255 UH    0      0        0 =
eth0

And =E2=80=9Call-traffic=E2=80=9D is routing through the tunnel again.

I don=E2=80=99t code so can=E2=80=99t figure out how to fix this myself. =
I=E2=80=99ll happily test any patches you share though, and can provide =
remote access to test devices if needed.

Christian=
