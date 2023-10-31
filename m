Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D83D27A
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D3CA273347
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 12:32:11 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9FDFE73356
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 12:32:11 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Address Sanitizer: connmactl Leaks 75 Bytes on 5 Allocations
Message-Id: <F5E5C78A-CD41-45B6-B5E0-06F059D35D9F@nuovations.com>
Date: Tue, 31 Oct 2023 09:32:10 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Connman Community:

After compiling the connman project with the address sanitizer =
(-fsanitize=3Daddress -fno-omit-frame-pointer =
-fno-optimize-sibling-calls -O0) running the following commands:

    # connmanctl=20
    connmanctl> help
    connmanctl> services
    connmanctl> enable wifi
    connmanctl> enable cellular
    connmanctl> technologies
    connmanctl> services
    connmanctl> agent on
    connmanctl> connect <redacted>
    Passphrase? <redacted>
    connmanctl> quit

The GCC 12 address sanitizer reports:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    =3D=3D515=3D=3DERROR: LeakSanitizer: detected memory leaks

    Direct leak of 39 byte(s) in 3 object(s) allocated from:
        #0 0x76a448cc in __interceptor_strdup =
(/lib/libasan.so.8+0x528cc)
        #1 0x769e0452 in rl_save_prompt (/usr/lib/libedit.so.0+0x1a452)

    Direct leak of 23 byte(s) in 1 object(s) allocated from:
        #0 0x76a448cc in __interceptor_strdup =
(/lib/libasan.so.8+0x528cc)
        #1 0x76aceffc  (/lib/libasan.so.8+0xdcffc)

    Direct leak of 13 byte(s) in 1 object(s) allocated from:
        #0 0x76a448cc in __interceptor_strdup =
(/lib/libasan.so.8+0x528cc)
        #1 0x46a28  (/usr/bin/connmanctl+0x46a28)

    SUMMARY: AddressSanitizer: 75 byte(s) leaked in 5 allocation(s).

For those interested, I=E2=80=99ve created a clone / fork at =
https://github.com/Nuovations/connman/ with this issue at =
https://github.com/Nuovations/connman/issues/8.

I=E2=80=99ll continue to report progress both on this list and there.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

