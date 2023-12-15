Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503D63A6
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La53CQMu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c580ba223so3390025e9.3
        for <connman@lists.linux.dev>; Thu, 14 Dec 2023 20:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702615908; x=1703220708; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR7olhCfcmXENRM7yC5om/HykXNIsW7S3UUrqhRjzFM=;
        b=La53CQMuZEW+xd2oPP5AH4b1pg8FUN2Vb9hX0BgEC2tjUlm8RGiYfnVH4TNN/ApWEf
         ijsoIeVwav84DDDk2BHpV2upSGDOKMqIfOikVcE9Vrz1j357qWTwVBL8PLlxuh8gW+Pk
         4+dhRtBya69zGI8qrxoXzr2dnxPcKDVxlT7g6GcGhT5plF6pSeNGCqCcci29N7Y4dWe9
         HT6tNxwCKdll13hl4V3QWBfmCFjHjDb1u4T9wcAOWfCh8uPhtIJvc1EX+4AoJ9HMUr1b
         Rf5dFefWq7LzfDbyVnrmV6k8Z4/JbNypUUQ0AT+E48PhySKx80B/ApkbtTaYyYVZicUl
         y03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702615908; x=1703220708;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR7olhCfcmXENRM7yC5om/HykXNIsW7S3UUrqhRjzFM=;
        b=jYIzcIm2rJ2CzJFhhlBJ4gCfboC7NKxb85k87f6aEwECo0E7Q9eTNWIMcdLx+NwBgE
         YqFH+llBgV28Olfx8r+qopIfksl/4EV/TT+m+W+zQoyjgwQYgtsDtW11dsbotd2IZ4G7
         2bxXe5A58nU9POczaAJeFaEdbVIwQxNyJIA6VZfO6uM35sohODCNHzrPJSRAMP7NOB7P
         Yp3lywo1j6VcrwxK1ALLxzr6wMZMTAvftYRbnxx3zWdWk3BhXeT1p608kyfr/mPww5wH
         maPHNz0XDaHxSOYMd0ECh1QNQ0/G+Y2UODm0TXpDIaNB5rbBUpxxnny2lmySkfNNcMG7
         PAEQ==
X-Gm-Message-State: AOJu0YwTDSpyAtuUY9/M4+rXDEXKhuKgsiv6AaUina+bx5tTMNEhR+Hz
	1aH4Tf/ekUjdD1L9TiOY+iM=
X-Google-Smtp-Source: AGHT+IEBGl6G/odtK5hM750ubT6p0cL4W/d7J4P5ZEzahDf+4+3+IvjujbwylaPtVdYcic551+sJSg==
X-Received: by 2002:a05:600c:2041:b0:40b:5e59:cca4 with SMTP id p1-20020a05600c204100b0040b5e59cca4mr5498997wmg.133.1702615907922;
        Thu, 14 Dec 2023 20:51:47 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b0040c4afa027csm16173756wmb.13.2023.12.14.20.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 20:51:47 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: RFC: There Are No Routes for Non-default Services
From: Christian Hewitt <christianshewitt@gmail.com>
X-Priority: 1
In-Reply-To: <4C194197-1C1D-4FB4-A526-4284D6545A37@nuovations.com>
Date: Fri, 15 Dec 2023 08:51:34 +0400
Cc: connman@lists.linux.dev,
 =?utf-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAB1AC37-E077-4067-B245-5CE862CB22B7@gmail.com>
References: <4C194197-1C1D-4FB4-A526-4284D6545A37@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

[snip]

Hello Grant,

I=E2=80=99m not on the mailing list and this ended up in Junk so I =
missed the opportunity to test/comment before the series was merged.

Using current connman HEAD support for WireGuard via connman-vpn is =
broken (cannot create a connection) and results in loss of internet =
connectivity on hosts where the vpn connection is configured (via =
scripts or a simple systemd service) to start automatically on boot.

If I start the host with no active VPN connection the ethernet service =
started and I have internet access. Once I initiate a VPN connection the =
journal shows:

Dec 15 08:11:23 RPi5 systemd[1]: Starting connman.service...
Dec 15 08:11:23 RPi5 connmand[1284]: Connection Manager version 1.42
Dec 15 08:11:23 RPi5 systemd[1]: Started connman.service.
Dec 15 08:11:23 RPi5 connmand[1284]: Checking loopback interface =
settings
Dec 15 08:11:23 RPi5 connmand[1284]: System hostname is RPi5
Dec 15 08:11:23 RPi5 connmand[1284]: lo {newlink} index 1 address =
00:00:00:00:00:00 mtu 65536
Dec 15 08:11:23 RPi5 connmand[1284]: lo {newlink} index 1 operstate 0 =
<UNKNOWN>
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {create} index 2 type 1 =
<ETHER>
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {RX} 40998 packets 52398192 =
bytes
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {TX} 13806 packets 1176407 =
bytes
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {update} flags 102467 =
<UP,RUNNING,LOWER_UP>
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {newlink} index 2 address =
B8:27:EB:B5:D9:A2 mtu 1500
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {newlink} index 2 operstate 6 =
<UP>
Dec 15 08:11:23 RPi5 connmand[1284]: ipconfig state 3 ipconfig method 1
Dec 15 08:11:23 RPi5 connmand[1284]: Adding interface eth0 [ ethernet ]
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} address 172.16.40.25/24 =
label eth0 family 2
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 0.0.0.0/0 gw =
172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 0.0.0.0/0 gw =
172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 65.109.130.17/32 =
gw 172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 82.165.8.211/32 gw =
172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 167.99.210.149/32 =
gw 172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 172.16.40.0/24 gw =
0.0.0.0 scope 253 <LINK> table 254 <main> metric 0
Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 172.16.40.1/32 gw =
0.0.0.0 scope 253 <LINK> table 254 <main> metric 0
Dec 15 08:11:23 RPi5 connmand[1284]: Aborting (signal 11) =
[/usr/sbin/connmand]
Dec 15 08:11:23 RPi5 connmand[1284]: ++++++++ backtrace ++++++++
Dec 15 08:11:23 RPi5 connmand[1284]: Error in backtrace format
Dec 15 08:11:23 RPi5 connmand[1284]: +++++++++++++++++++++++++++
Dec 15 08:11:23 RPi5 systemd[1]: connman.service: Main process exited, =
code=3Dexited, status=3D1/FAILURE
Dec 15 08:11:23 RPi5 systemd[1]: connman.service: Failed with result =
'exit-code'.

And since things faulted before completing connection setup the routing =
is messed up:

RPi5:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use =
Iface
167.99.210.149  172.16.40.1     255.255.255.255 UGH   0      0        0 =
eth0
172.16.40.0     *               255.255.255.0   U     0      0        0 =
eth0
172.16.40.1     *               255.255.255.255 UH    0      0        0 =
eth0

And connman is stuck in a restart loop:

=E2=97=8F connman.service - Connection service
     Loaded: loaded (/usr/lib/systemd/system/connman.service; disabled; =
preset: disabled)
     Active: activating (start) since Fri 2023-12-15 08:32:38 +04; 2s =
ago
   Main PID: 2970 (connmand)
      Tasks: 2 (limit: 9036)
        CPU: 1ms
     CGroup: /system.slice/connman.service
             =E2=94=94=E2=94=802970 /usr/sbin/connmand -nr =
--config=3D/etc/connman/main.conf

Dec 15 08:32:40 RPi5 systemd[1]: connman.service: Scheduled restart job, =
restart counter is at 453.
Dec 15 08:32:40 RPi5 systemd[1]: Starting connman.service=E2=80=A6

NB: Zoltan=E2=80=99s previous patch which broke the default route on =
WireGuard connections can still be reverted but makes no difference.

Help!

Christian

