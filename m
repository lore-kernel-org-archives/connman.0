Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4C1DDE9
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc9506cP"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-507975d34e8so1392216e87.1
        for <connman@lists.linux.dev>; Fri, 20 Oct 2023 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697816736; x=1698421536; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePRK1d0hf2wTqdxBF8DQbc+K0lZo6K3TlKcfd7I6pgQ=;
        b=Xc9506cPs7D0gLoDjIdYKbjUE9N7p7pQnnEvWw6jY7tcFddeN/hocHEKqe0qvnTwrs
         blBbK0Kiq8R1W2CHw2QRitekHXgwECWvYOi2TKVWtGBoxzjIyO7ZRePrUsQsd84daJSb
         qbDDIPP5CarttQjRZjBMRFY16/rN2pX/SyL6pX1I2BKNxNTDq0Ya3MoNg/lRUkaYaih9
         ebXKVBQoigXePAjHBE7Sy+HUn703QwTbmMpTLfH8sOaIM+LyX/Kr+5tEO1dVKJbidmeO
         3QhcGwBtgL2qTcnEVJog+/tEX9MdzEmVzmgGGnpX8w6c8ZOZAMQ+u+HLdZDhs8NSD2zP
         jVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816736; x=1698421536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePRK1d0hf2wTqdxBF8DQbc+K0lZo6K3TlKcfd7I6pgQ=;
        b=cdVjhajB7eZvRWSr4Q8wn2OPF6g43jyT41BEuEeaQUX/y9LDZQ9u+Ji2ioOYCB2Nf0
         Cb2wBfHsJIPenUN7xzCSxoRbnt8A4QyIom48vMDYSJXfa1pnJ64DUQrle0h3NoJi35/I
         51UigYuNc21jw/5VW8PkxhjTkUeF+UNS1TMu7YGovYQ7jABkhImH0IOBapAmXGh0rvd4
         5tD1SPe1qkeLOAOQ5IEiO+/jRqczJwrw+aWuse0iXnhxkjSAfyWYOg9z3ntLfhp7NJLF
         HGkf/uWX72nmI8sgG0I1Kt9J6C0wPtuYUlWTbRYZBiF2rxww/cqDMzoWsJoyUPIN7V8Z
         hdew==
X-Gm-Message-State: AOJu0YxsCXKqKS2qByrSNFeRBhGO/CarpO2LptTstATPdvwRROotgKdU
	jRgAu4t+16/ak9f7nG1KrKVMcRJUMcA=
X-Google-Smtp-Source: AGHT+IE6Ww/PIWhMuZpqtcEdzVIJU9mpzTMxRYdCN2N4gl+JiM7M4Y6Rl96YhzbQvSBgSSI+DLVDZg==
X-Received: by 2002:ac2:5dc3:0:b0:500:8f66:5941 with SMTP id x3-20020ac25dc3000000b005008f665941mr1645037lfq.50.1697816735957;
        Fri, 20 Oct 2023 08:45:35 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id j5-20020ac253a5000000b004fb9c625b4asm408479lfh.210.2023.10.20.08.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:45:34 -0700 (PDT)
Date: Fri, 20 Oct 2023 17:49:39 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] doc: add the optional freq parameter to the connmanctl
 manpage
Message-ID: <ZTKhk9lf-gKhS8c8@gmail.com>
References: <20230629100000.49254-1-marcus.folkesson@gmail.com>
 <ZN9IvM5jGHuVlXv1@gmail.com>
 <CAG17S_MnQ1kdE3T-Qocp=Xe2yFbWJJA1e9Mo1J_6gueOTS_VTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RQyyWtixUY1akbFt"
Content-Disposition: inline
In-Reply-To: <CAG17S_MnQ1kdE3T-Qocp=Xe2yFbWJJA1e9Mo1J_6gueOTS_VTw@mail.gmail.com>


--RQyyWtixUY1akbFt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Keith,

I'm also a bit worried about the engagement of this project.
I do use it on both my (personal) PC and in several embedded
Linux systems in my proffession.

I'm willing to taking over the project if we think it will
help the project forward. Although right now it is a bit unclear
what the project actually needs to get a push forward.

What I can offer is keep track of the mailing list, review patches,
manage the git repo and releases.
Anyone is welcome to contact me if there such is interest.

Best regards,
Marcus Folkesson



On Fri, Oct 20, 2023 at 08:30:07AM -0500, KeithG wrote:
> Marcus,
>=20
> I have been watching your investigation with interest. I am a list
> member as well, but have noticed that there seems to be very little
> engagement by any devs in the past year or so. I think Daniel Wagner
> was the primary developer and he was wanting someone to take this
> project over. I also have a feature request that has not yet been
> implemented, though some work has been done. It just doesn't work yet.
>=20
> Are you interested in taking over this project? I, for one, would love
> to see continued development of connman. If no one is maintaining
> connman, I will have to see if I can migrate to another network
> manager. I have been considering nmcli, but it is so complicated in
> comparison.
>=20
> Keith
>=20
>=20
> On Fri, Aug 18, 2023 at 5:30=E2=80=AFAM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> >
> > Ping?
> >
> > Is the mailing list still active?
> >
> > Best regards,
> > Marcus Folkesson
> >
> > On Thu, Jun 29, 2023 at 12:00:00PM +0200, Marcus Folkesson wrote:
> > > Add 'freq' to the parameter list used for WiFi Tethering.
> > >
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > >  doc/connmanctl.1.in | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/doc/connmanctl.1.in b/doc/connmanctl.1.in
> > > index d87472c3..cf662ca3 100644
> > > --- a/doc/connmanctl.1.in
> > > +++ b/doc/connmanctl.1.in
> > > @@ -10,7 +10,7 @@ SYNOPSIS
> > >  .BI enable \ technology\fR|offline\ |
> > >  .BI disable \ technology\fR|offline\ |
> > >  .BI tether \ technology\ \fRon|off\ |
> > > -.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\fR\ |
> > > +.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\ freq\fR\ |
> > >  .BR services \ [\fIservice\fR]\ |
> > >  .BI peers \ peer\fR\ |
> > >  .BI scan \ technology\fR\ |
> > > @@ -86,7 +86,7 @@ by default since tethering it usually breaks local =
networks. See
> > >  for enabling.
> > >  .PP
> > >  .TP
> > > -.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase
> > > +.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase\ [freq]
> > >  Enable or disable wireless tethering, as well set the SSID and passp=
hrase.
> > >  .PP
> > >  .TP
> > > --
> > > 2.40.1
> > >

--RQyyWtixUY1akbFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmUyoY4ACgkQiIBOb1ld
UjJYkhAApjjwxFa8HDk+Ys+v9rXUKpR0vXFwM04Iy8BOw+50nCuycRjv7dhk0du+
88KKl6IQI8S4hES8fwLNEcZp/lSmYipHK4RWdANXl/OFf4+YVC5RtC1w3EaysY5Y
Nh8ddMCv5D8Ap2HQ/dLyvnqVShMh1QPQVSfAucloxn1y4IjIQyt0/qkrz4H5m9dd
nOBvqrOGtu1DavwZS+O9WMIjHwmJ8qD1t9aZFN0HReMHJRxbMDfha0Fbu/2fkLNG
Xv3z3gGDQsxEq+frQhcKmXDrsNCbVgyGD6h1xVF7sgIS+PxvnxpjK/rEnQ26VWZI
xN16vvHCcRjriRFp7b48ochzVAAnCyQ1/DgcpLrrr3+fw6R3TUDQZk4elLYbioU9
rRMTrwajkLbyPlmttN6D+Sqs6gqveAuGRQ1u06ommT77wHPy4iAY5PGcBbMedqBu
PDk/uN8uU27zXLkwj+l3XH1eEuVi5HVLi+A4nMi9nT9OGUlRJTlsP+UzUiAhUJve
Df9hkSFP7/5H8qDtCWlozycUd64e3Ae6oJAZRnqp4r6bNN/Txqj5teshYKMM8eji
JIy78INIF6Eb7XIYi1Y1hnOUATbw1XeC066A4/tJ6/z2u4ZZAOLduNNK88VNlXSf
tLYX4l4ZOyjkIir2uKBtOIXv7vTB7ctXh0C9Xs7lXLhzkrQTR9U=
=7EQ8
-----END PGP SIGNATURE-----

--RQyyWtixUY1akbFt--
