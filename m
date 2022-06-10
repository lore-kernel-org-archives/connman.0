Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343D636
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:26:18 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 357431FD3A;
	Fri, 10 Jun 2022 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654863970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ieTEJ/i+1fp3mAHWboebFQTh1XCiCcl7KKglab8Areo=;
	b=bl6C8L8pLWeHBN0UJ6uppqsg7szxJoYsW5K2UHD+BMxsPKbEVZYFWW+H++B/ryWnZLcEnu
	ivf7ZFBna8JgdkfImWHMEbJPd44UnAkTVWX6cJBw89GpZa3o9qOdy7BAf1GSxcpEp/bdP6
	wvpwxjmmU+YArxOn321hdlpve115AMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654863970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ieTEJ/i+1fp3mAHWboebFQTh1XCiCcl7KKglab8Areo=;
	b=/uFFSUa+jXzTl2eFbj1awT5soASQ96Yu4hpgHnT9GoCiT0gPrU4Ex9MsK0uB9vMi7wxcqu
	+2QA5MRSBCCkOOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E322139ED;
	Fri, 10 Jun 2022 12:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UoE7C2I4o2LoLgAAMHmgww
	(envelope-from <matthias.gerstner@suse.de>); Fri, 10 Jun 2022 12:26:10 +0000
Date: Fri, 10 Jun 2022 14:26:09 +0200
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 03/12] dnsproxy: refactoring of update_cached_ttl() and
 append_data()
Message-ID: <YqM4YXG2KSWlIKj2@kasco.suse.de>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
 <20220419103501.30553-4-matthias.gerstner@suse.de>
 <20220525064509.6oohjixx3laz2plg@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QnnOdm05loGF0qkV"
Content-Disposition: inline
In-Reply-To: <20220525064509.6oohjixx3laz2plg@beryllium.lan>


--QnnOdm05loGF0qkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, May 25, 2022 at 08:45:09AM +0200, Daniel Wagner wrote:
> On Tue, Apr 19, 2022 at 12:34:52PM +0200, Matthias Gerstner wrote:
> > +	ptr +=3D DNS_HEADER_SIZE;
> > +	len -=3D DNS_HEADER_SIZE;
>=20
> here the  'sizeof(struct ...)' is hidden in the define
>=20
> > +
> > +	if (len < sizeof(struct domain_question) + 1)
> > +		return;
> > =20
> > -	/* skip the query, which is a name and 2 16 bit words */
> > -	l =3D dns_name_length(c);
> > -	c +=3D l;
> > -	len -=3D l;
> > -	c +=3D 4;
> > -	len -=3D 4;
> > +	/* skip the query, which is a name and a struct domain_question */
> > +	size_t name_len =3D dns_name_length(ptr);
> > +
> > +	ptr +=3D name_len + sizeof(struct domain_question);
>=20
> and here we have the sizeof(struct ...). Personally I prefer the later
> over the former because I don't have to lookup what the define is
> doing. But then I do understand that it a good name of a define helps to
> read. So just pick one version of it.

I mostly wanted the define because of the frequently occuring and
complex `sizeof(domain_hdr)` calculations. For the sake of unity I will
add a few additional defines for the other sizeof() occurences.

Cheers

Matthias

--QnnOdm05loGF0qkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE82oG1A8ab1eESZdjFMQFyXGSNVMFAmKjOGEACgkQFMQFyXGS
NVPVKg//YHbL8RfphXiXdEWoqqEiILlFSq61LnUBODy0dyAudst2sOxM3SdxmHmS
z8IVMfgvOSFgj27YFXynS6zhEX6BdlPObaW2OTjg+Ys3ZVy/r055WbQYjaFHXV/5
e2RyeEbbXvvkdwZrnxnHrncKJtNmU4NiytL/FVyCeIDjaSODhWL+gxCHZfQZlJoT
WYfIpkQ2q3XJBiZRTRawLlDiLqpJntTmc7CVzMGCtn6RIwN9qELNTR5q2Dun5eM4
etdJTUl/Fxm02yl05P839/7TuYnOXrKjSH0bZe+mzGmxgbBtSL3esPRhQ4A5lou2
MEjk7Th/7YLkb7yan9egaIDq9zxsGJpDxsxQmtuTW4eBMoKRxRZ2IitMLN1QIZ0O
60NtFjf70RnaQUgh6W7ZGCoNhHIVXai22S3c99hOEUqZN9kCxXGPmlf2vARX0mdQ
h6ByE932lE1IFIh4TkxXsO9xJVo6oAGnP0FlqkaWHofYMvuXSPd3uvuoMgaTG1UQ
U9G7RjcMIazEOa/rmsudu3oJIVF3rrmc0EoFykm7y1aiCLTaHMBM4N0dhT1Qr9rV
l4V2ph9euuLcXzQfolbcbr1oZj1PraAsqQtCrrvvqRSyWXcDTQUrGvFWe8UMiYTP
w5JwLtFmR1+6wLmiu3FilJ1/fIfI+kwG2b/hisXz/BJg5jzuVes=
=N+fE
-----END PGP SIGNATURE-----

--QnnOdm05loGF0qkV--
