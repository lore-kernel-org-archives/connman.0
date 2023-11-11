Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470318E31
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7E26A730EF;
	Sat, 11 Nov 2023 12:44:50 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1EE4473127;
	Sat, 11 Nov 2023 12:44:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH v6 0/3] gweb: refactor parse_url for IPv6 addresses.
Message-Id: <D7CD4553-EAFB-4A13-8847-668F8E909424@nuovations.com>
Date: Sat, 11 Nov 2023 09:44:49 -0800
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Prior to this change, 'parse_url' failed to correctly handle RFC 2732-
compliant URLs with bracketed IPv6 addresses such as:

    http://[2001:db8:4006:812::200e]:8080/online/status.html

Such bracketing is necessary when using IPv6 addresses to disambiguate
the host component from the port component due to the presence of the
colon (':') in IPv6 addresses. As such, prior to this change, such URLs
resulted in the brackets and the IPv6 address being passed to GResolv
which, unsurprisingly, failed to successfully forward resolve since the
resulting host was neither a valid host name nor a valid IPv6 address.

As a result, support for such RFC 2732-compliant bracketed IPv6
addresses has been added with this change which refactors the
previously-monolithic 'parse_url' into several, focused functions:

    * parse_request_and_proxy_urls
        - parse_request_url
            o parse_url_components
                + parse_url_scheme
                + parse_url_host_and_port
                    * parse_url_host
                    * parse_url_port
                + parse_url_path
        - parse_proxy_url

In particular, 'parse_url_host' is the new function responsible for
parsing the host and correctly handling one of seven possible
combinations of host and port, two of which include bracketed IPv6
addresses.

In addition, 'parse_url_host' will now return an error on an empty,
non-existent host and 'parse_url_port' will return an error on invalid,
out-of-range ports.

Grant Erickson (3):
  gweb: Rename 'parse_url'.
  gweb: Refactor 'parse_request_and_proxy_urls'.
  gweb: Add documentation to URL parsing functions.

 gweb/gweb.c | 855 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 789 insertions(+), 66 deletions(-)

-- 
2.42.0


