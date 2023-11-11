Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8B366
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id A7849CED02;
	Sat, 11 Nov 2023 17:51:56 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 2/3 v5] gweb: Refactor 'parse_request_and_proxy_urls'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <917F8BD6-CFF4-451C-ADCB-3EC0F3DA6E0A@nuovations.com>
Date: Sat, 11 Nov 2023 17:51:46 +0100
Cc: connman@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C94EAA2C-AB90-45BD-BE49-6182620E70B2@holtmann.org>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <F9934E45-7ABB-40D7-9631-9BC6D1406EAC@nuovations.com>
 <B19D916B-9B73-4BBD-8373-971BBC13AE91@nuovations.com>
 <917F8BD6-CFF4-451C-ADCB-3EC0F3DA6E0A@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> Prior to this change, 'parse_request_and_proxy_urls' failed to =
correctly
> handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:
>=20
>    http://[2001:db8:4006:812::200e]:8080/online/status.html
>=20
> Such bracketing is necessary when using IPv6 addresses to disambiguate
> the host component from the port component due to the presence of the
> colon (':') in IPv6 addresses. As such, prior to this change, such =
URLs
> resulted in the brackets and the IPv6 address being passed to gresolv
> which, unsurprisingly, failed to successfully forward resolve since =
the
> resulting host was neither a valid host name nor a valid IPv6 address.
>=20
> As a result, support for such RFC 2732-compliant bracketed IPv6 =
addresses
> has been added with this change which refactors the =
previously-monolithic
> 'parse_request_and_proxy_urls' into several, focused functions:
>=20
>    * parse_request_and_proxy_urls
>        - parse_request_url
>            o parse_url_components
>                + parse_url_scheme
>                + parse_url_host_and_port
>                    * parse_url_host
>                    * parse_url_port
>                + parse_url_path
>        - parse_proxy_url
>=20
> In particular, 'parse_url_host' is the new function responsible for =
parsing
> the host and correctly handling one of seven possible combinations of =
host
> and port, two of which include bracketed IPv6  addresses.
>=20
> In addition, 'parse_url_host' will now return an error on an empty, =
non-
> existent host and 'parse_url_port' will return an error on invalid, =
out-of-
> range ports.
> ---
> gweb/gweb.c | 455 ++++++++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 390 insertions(+), 65 deletions(-)

hmmm, my email client lost track of what is in this series. The =
threading failed badly and I have no idea which versions are the latest =
that I should apply. Do you mind sending a v6 with a cover letter so it =
starts a new thread. Thanks.

Regards

Marcel

