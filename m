Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838F636
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:29:00 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62A49220EE;
	Fri, 10 Jun 2022 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLp/BGWoEmDKxBUfGRNNp7qXkO19ZdEALsoYv2ilp20=;
	b=BAqlTyqo7qAWqbFFI1UgEXYI96gIaj1ZNEqzMty/VfQCOnK0rhL46pS8mesfOHm9TO6ovq
	xafI5oVp9L8mNUoNwnvwK4M7MwgBjwUUxsKhYEUVfCD0lFV7CricoudiK1xRuM/4YmgXn7
	vW4LOVA7AreuOS5aWc4EA72RKHdmebY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLp/BGWoEmDKxBUfGRNNp7qXkO19ZdEALsoYv2ilp20=;
	b=gGKyWG5wOtrrlwx9dkBbJRS4L5w4gJw0ScJVXQXiRcRUuzEYCXC0HoraEB6gEjZ59lwLzW
	8G85sVwjjmjqkdCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AFFB139ED;
	Fri, 10 Jun 2022 12:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TwMyFgU5o2ITMAAAMHmgww
	(envelope-from <matthias.gerstner@suse.de>); Fri, 10 Jun 2022 12:28:53 +0000
Date: Fri, 10 Jun 2022 14:28:53 +0200
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Subject: Re: dnsproxy: first round of refactoring, TCP bugfix
Message-ID: <YqM5Ba4onOngveiT@kasco.suse.de>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
 <20220525070110.xx3pfx6fo3mdfhsy@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C60BxSZ7cVEeMpAl"
Content-Disposition: inline
In-Reply-To: <20220525070110.xx3pfx6fo3mdfhsy@beryllium.lan>


--C60BxSZ7cVEeMpAl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, May 25, 2022 at 09:01:46AM +0200, Daniel Wagner wrote:
> Though we need set the C standard to C99 I suppose:
>=20
>=20
> src/dnsproxy.c: In function =E2=80=98refresh_dns_entry=E2=80=99:
> src/dnsproxy.c:394:9: error: ISO C90 forbids mixed declarations and code =
[-Werror=3Ddeclaration-after-statement]
>   394 |         int age =3D 1;
>       |         ^~~

I will switch to AC_PROG_CC_C99 in autoconf, hopefully that is enough.

> and my compiler complained about a few things:
>=20
> src/dnsproxy.c:410:25: error: comparison of integer expressions of differ=
ent signedness: =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=
=80=99} and =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
>   410 |         if (entry->hits > age)

I used a slightly older GCC for the patches, the next round will have
them fixed, hopefully.

> BTW, since this contribution is major I would suggest you add your
> copyright statement to the file as well.

Will do, although it feels a bit weird to me ;-)

Cheers

Matthias

--C60BxSZ7cVEeMpAl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE82oG1A8ab1eESZdjFMQFyXGSNVMFAmKjOQQACgkQFMQFyXGS
NVOJAA//UR24vicgDRW1I08V0E5HCljkkAUquUbqW4RBQph8Au+b0ldu2fYtjG4F
+ybWUs5wgA2IPsj9S8CcFDilKoKuZGpY+CuWZam91DoFpelw5HkIS2l3sjU/SrIT
ycuV8O0ynviK1zsgWF/YtSBuPc9uwwBiFzO8DM6z3rTXsy0tcOTCkYFs5EiurNxT
xa+YLDgjr4NS3QOWP7GxXUF3gTF/1MBNjVqjYYYHWYkbzrop9QwKvCE+NzGBPyqo
K9WVwCRtubdQLVRy5cmFmRE9r7zU/18bEWvYPGazFYsJ8FifrwzbK0H/R+PjhwGz
cq2YreUqhZ1uknGDA4bcIBV8LGtKQHOOTIvxIHVR1ZU3g8+qUrQFxKE/JyQWZCUm
+5XtgE55fweIPlQHAXpBgRoiJ8eHlBcMPrpM0O7Rw+n3R7AxnznpF6Uqs6imRwOR
yeFtRPuTP7WVyga5mS0fsBJ+/YiaCgWJTxVnKriIT+R3v7SpavtV5zWaF5OGzQNN
/aiNo1ogPigVhl36E1EDddWiyWDLyy3BgpFs669WKAxNFTSFb3EHbbAoPtb487ZA
0I0j9t6rOHT2TvlBCdjiyBpvCDR6XUeNsHPVAsJ+Zeo7gAPfHb7qny2tjhcmDLP/
6NQOlX2yuQA7Ej1O//ovJgwlqYwNnNf8VqnQpcZE1sYajmfyIp4=
=HlE0
-----END PGP SIGNATURE-----

--C60BxSZ7cVEeMpAl--
