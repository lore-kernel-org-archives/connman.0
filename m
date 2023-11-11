Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28281BDD1
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 0A48FCED02;
	Sat, 11 Nov 2023 19:16:51 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v6 0/3] gweb: refactor parse_url for IPv6 addresses.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D7CD4553-EAFB-4A13-8847-668F8E909424@nuovations.com>
Date: Sat, 11 Nov 2023 19:16:40 +0100
Cc: connman@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <2717EB84-A614-4954-85D8-48F391769EF4@holtmann.org>
References: <D7CD4553-EAFB-4A13-8847-668F8E909424@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> Prior to this change, 'parse_url' failed to correctly handle RFC 2732-
> compliant URLs with bracketed IPv6 addresses such as:
> 
>    http://[2001:db8:4006:812::200e]:8080/online/status.html
> 
> Such bracketing is necessary when using IPv6 addresses to disambiguate
> the host component from the port component due to the presence of the
> colon (':') in IPv6 addresses. As such, prior to this change, such URLs
> resulted in the brackets and the IPv6 address being passed to GResolv
> which, unsurprisingly, failed to successfully forward resolve since the
> resulting host was neither a valid host name nor a valid IPv6 address.
> 
> As a result, support for such RFC 2732-compliant bracketed IPv6
> addresses has been added with this change which refactors the
> previously-monolithic 'parse_url' into several, focused functions:
> 
>    * parse_request_and_proxy_urls
>        - parse_request_url
>            o parse_url_components
>                + parse_url_scheme
>                + parse_url_host_and_port
>                    * parse_url_host
>                    * parse_url_port
>                + parse_url_path
>        - parse_proxy_url
> 
> In particular, 'parse_url_host' is the new function responsible for
> parsing the host and correctly handling one of seven possible
> combinations of host and port, two of which include bracketed IPv6
> addresses.
> 
> In addition, 'parse_url_host' will now return an error on an empty,
> non-existent host and 'parse_url_port' will return an error on invalid,
> out-of-range ports.
> 
> Grant Erickson (3):
>  gweb: Rename 'parse_url'.
>  gweb: Refactor 'parse_request_and_proxy_urls'.
>  gweb: Add documentation to URL parsing functions.
> 
> gweb/gweb.c | 855 ++++++++++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 789 insertions(+), 66 deletions(-)

all 3 patches have been applied.

Regards

Marcel

