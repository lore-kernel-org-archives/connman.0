Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6817724
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id D796FCECD0;
	Wed,  8 Nov 2023 15:38:41 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/3] Refactor and Document GWeb Parsing Functions to
 Handle RFC 2732 IPv6 Bracketed Hosts
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
Date: Wed, 8 Nov 2023 15:38:31 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B48879CA-FADB-43EB-ADD1-CB142D9365E9@holtmann.org>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series addresses a failure of gweb/gweb.c:'parse_url' to
> correct handle RFC 2732-compliant bracketed IPv6 addresses by renaming
> GWeb 'parse_url' to 'parse_request_and_proxy_urls', refactoring it,
> and documenting it.
>=20
> Prior to this change, 'parse_request_and_proxy_urls' failed to
> correctly handle RFC 2732-compliant URLs with bracketed IPv6
> addresses such as:
>=20
>    http://[2001:db8:4006:812::200e]:8080/online/status.html
>=20
> Such bracketing is necessary when using IPv6 addresses to disambiguate
> the host component from the port component due to the presence of the
> colon (':') in IPv6 addresses. As such, prior to this change, such =
URLs
> resulted in the BOTH brackets AND the IPv6 address being passed
> to GResolv which, unsurprisingly, failed to successfully forward
> resolve since the resulting host was neither a valid host name nor a
> valid IPv6 address.
>=20
> As a result, support for such RFC 2732-compliant bracketed IPv6
> addresses has been added with this change which refactors the
> previously-monolithic 'parse_request_and_proxy_urls' into several,
> focused functions:
>=20
>   * parse_request_and_proxy_urls
>        - parse_url_components
>            o parse_url_scheme
>                + parse_url_scheme_with_default
>            o parse_url_host_and_port
>                + parse_url_host
>                + parse_url_port
>            o parse_url_path
>=20
> In particular, 'parse_url_host' is the new function responsible for
> parsing the host and correctly handling one of seven possible
> combinations of host and port, two of which include bracketed IPv6
> addresses.
>=20
> In addition, 'parse_url_host' will now return an error on an empty,
> non-existent host and 'parse_url_port' will return an error on
> invalid, out-of-range ports.

the v2 can=E2=80=99t be applied using git am.

Applying: gweb: Rename 'parse_url'.
Applying: gweb: Refactor 'parse_request_and_proxy_urls'.
.git/rebase-apply/patch:387: trailing whitespace.
int err =3D 0;  .git/rebase-apply/patch:461: trailing whitespace.
int err =3D 0;  .git/rebase-apply/patch:520: trailing whitespace.
int err =3D 0;  error: 3 lines add whitespace errors.
Patch failed at 0002 gweb: Refactor 'parse_request_and_proxy_urls=E2=80=99=
.

Regards

Marcel



