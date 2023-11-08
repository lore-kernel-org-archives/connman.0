Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE1199A5
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6C2B3731B0;
	Wed,  8 Nov 2023 10:42:06 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74] (unknown [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1B91C7327E;
	Wed,  8 Nov 2023 10:42:06 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Allow running bootstrap-configure from anywhere.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <58F4FE4A-55EB-4072-8E20-E39E307D7918@holtmann.org>
Date: Wed, 8 Nov 2023 07:42:04 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <202EFB29-EE03-4CCD-AF97-E8A34F24E605@nuovations.com>
References: <E57C2057-AEAD-49B1-8577-6FD27680A4B2@nuovations.com>
 <58F4FE4A-55EB-4072-8E20-E39E307D7918@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 8, 2023, at 6:44 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Frequently it is valuable to do non-colocated source and build
>> directories. This updates 'bootstrap-configure' such that it may be
>> run in any arbitrary directory such that builds so bootstrapped and
>> configured may be non-colocated.
>> ---
>> bootstrap-configure | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/bootstrap-configure b/bootstrap-configure
>> index ed5ecd78..d8c9cfce 100755
>> --- a/bootstrap-configure
>> +++ b/bootstrap-configure
>> @@ -1,11 +1,13 @@
>> #!/bin/sh
>>=20
>> +ourdir=3D$(cd $(dirname "${0}") && pwd)
>> +
>> if [ -f config.status ]; then
>> make maintainer-clean
>> fi
>>=20
>> -./bootstrap && \
>> -    ./configure --enable-maintainer-mode \
>> +(cd "${ourdir}" && ./bootstrap) && \
>> +    "${ourdir}/configure" --enable-maintainer-mode \
>> --enable-debug \
>> --prefix=3D/usr \
>> --mandir=3D/usr/share/man \
>=20
> can you help me out on how to use it. For me this was always just for =
the devs.

Interestingly, in that mode, there are a whole bunch of compiler =
warnings and errors enforced that aren=E2=80=99t otherwise =E2=80=9Cin =
the field=E2=80=9D. Does it make sense to standardize those across all =
=E2=80=9Cmodes=E2=80=9D of building and maybe place =E2=80=9C-Werror=E2=80=
=9D in a =E2=80=9C=E2=80=94enable-werror=E2=80=9D option via configure =
(as many projects do these days)?

> 	./bootstrap-configure
> 	make
>=20
> And you got started with the git tree. Since bootstrap-configure also =
never made it into any tarballs and that is on purpose.
>=20
> Before I make any change here, I need to fully grok it since this is =
one of the pieces that I keep consistent across multiple projects.

The use case I=E2=80=99ve been using this for, to ensure that I can =
pre-flight the CI I=E2=80=99ve set up at =
<https://github.com/Nuovations/connman/blob/master/.github/workflows/build=
.yml#L65> is:

    % cd connman
    % mkdir build-clang-iptables
    % cd build-clang-iptables
    % ../bootstrap-configure -C CC=3Dclang =E2=80=94with-firewall=3Diptabl=
es
    % make -j
    % cd ..
    % mkdir build-clang-nftables
    % cd build-clang-nftables
    % ../bootstrap-configure -C CC=3Dclang =E2=80=94with-firewall=3Dnftabl=
es
    % make -j
    % cd ..
    % mkdir build-gcc-iptables
    % cd build-gcc-iptables
    % ../bootstrap-configure -C CC=3Dgcc =E2=80=94with-firewall=3Diptables=

    % make -j
    % cd ..
    % mkdir build-gcc-nftables
    % cd build-gcc-nftables
    % ../bootstrap-configure -C CC=3Dgcc =E2=80=94with-firewall=3Dnftables=

    % make -j

If =E2=80=98bootstrap-configure=E2=80=99 did not have any configuration =
options (those would ideally be defaulted in through =E2=80=98configure') =
as with this =
<https://github.com/nestlabs/nlbuild-autotools/blob/master/scripts/bootstr=
ap-configure>, then I could just do:

    % cd connman
    % ./bootstrap
    % mkdir build-clang-iptables
    % cd build-clang-iptables
    % ../configure -C CC=3Dclang =E2=80=94with-firewall=3Diptables
    % make -j
    % cd ..
    % mkdir build-clang-nftables
    % cd build-clang-nftables
    % ../configure -C CC=3Dclang =E2=80=94with-firewall=3Dnftables
    % make -j
    % cd ..
    % mkdir build-gcc-iptables
    % cd build-gcc-iptables
    % ../configure -C CC=3Dgcc =E2=80=94with-firewall=3Diptables
    % make -j
    % cd ..
    % mkdir build-gcc-nftables
    % cd build-gcc-nftables
    % ../configure -C CC=3Dgcc =E2=80=94with-firewall=3Dnftables
    % make -j

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

