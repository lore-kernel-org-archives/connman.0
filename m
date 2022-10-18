Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A07B
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:55:18 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35DC933E78
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666083317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fovNWezNgaqAvl6foUJyxCYlFXSYaYFndCSKq864cw=;
	b=XDxCo0Kuk9IkkmDeX2AvvkPXl2shCY45g8U+OISuMDMfy1vNqdkEAYnpOIqFgKjmjWcNoc
	xCfIQ/C3Ph6/uzidaYdiaDp7b79O0cJJWzZNQWd75d2Q4cfE+rslJqmhJ8mcnXldpX6IiS
	7aqL7UPkplgXivVRSXtLCD0+x9FJMcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666083317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fovNWezNgaqAvl6foUJyxCYlFXSYaYFndCSKq864cw=;
	b=2pM2Y+ZPMH6nfD6IJraqI2MbDXv+9xHTg2bgii6CfJ/743mG4Jzdm2JFalIvrU/kdbqDdn
	Ru8hZvDt/l4pqlCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C5E2139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jwLOCvVpTmPodAAAMHmgww
	(envelope-from <matthias.gerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:55:17 +0000
Date: Tue, 18 Oct 2022 10:55:15 +0200
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: Re: dnsproxy: first round of refactoring, TCP bugfix
Message-ID: <Y05p9FJvQGPuuEL4@kasco.suse.de>
References: <20221018084746.21959-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dTXUGQoEQPA0slxV"
Content-Disposition: inline
In-Reply-To: <20221018084746.21959-1-matthias.gerstner@suse.de>


--dTXUGQoEQPA0slxV
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Oct 2022 10:55:15 +0200
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: Re: dnsproxy: first round of refactoring, TCP bugfix

On Tue, Oct 18, 2022 at 10:47:30AM +0200, Matthias Gerstner wrote:
> From Matthias Gerstner <matthias.gerstner@suse.de> # This line is ignored.
> From: Matthias Gerstner <matthias.gerstner@suse.de>
> Reply-To:=20
> Subject: dnsproxy: first round of refactoring, TCP bugfix
> In-Reply-To:=20

Sorry, it seems I've messed up the summary.

This is the same patch series with the minor changes you requested in
patch 03/16.

--dTXUGQoEQPA0slxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE82oG1A8ab1eESZdjFMQFyXGSNVMFAmNOafQACgkQFMQFyXGS
NVMy6A//WSqI2WR/1gQxk1Z9EURvCLXes2tHMbTP5yAuyqT/xrmFDTFcb4hxX23j
1SoAk+tU/D9OgtTk9VuFX4Autw+h08Gv7Z3cMegeXr8NK+6uwBhKup3kK9e80rYE
IVzv4+plKkl+f6+OkqIfiLXWcKbEkONQhw7JKyJTZWIlHI0uMXbcUTyi2QyN0NbJ
ad7/qSUEXetLXh+ffcXUfLKeUcVXm5+GA3Uudhyoz0XZqy9rFtzWCVhVDfiUVxbv
PJ2y27A5JuExrHMMJnu7scmDa983ndYG0uyhfj9Udsev1Iz38CLRKEk0R0wb1hrF
e6ncvPQZG2mSvqm4i2vkp/22uKIzoriSDr8QztMO48V7VoJ6W6psYlq9AB73WRVQ
UhS2MUR6atB+3pDTbzU3aU8KRBmkhemRl7w7bZ3ewCTQQOBlgrX1s7Dt5vS3y5MS
DVj5q6Ood/m1I0fp2wvs0HiOxJi2UjSiysyKoXUC8WZAiQKIAR5EQCfkw5mxP8VG
6fgCw3PeYmtDbXzJXEFq5rpA3xbHAe+lF0wVYzf7X2NtgIYOeu8UYO+po8cCuwO0
XM6dTIyTwNYMzEKgw1KrVx0CyYzYK7tEB3rIBcYoxpq3x9m8q0wGg4snVQliPnhM
sMc7xZwCCmba0AxBWmb17qJ4WQM1uhhPYF8J87/YQubNdZPr1wM=
=eknA
-----END PGP SIGNATURE-----

--dTXUGQoEQPA0slxV--
