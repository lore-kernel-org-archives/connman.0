Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0BAD26A
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 79F4D73147
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 02:56:44 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3F4FF731C2
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 02:56:44 -0500 (EST)
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
Subject: [PATCH 0/3] Refactor and Document GWeb Parsing Functions to Handle
 RFC 2732 IPv6 Bracketed Hosts
Message-Id: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
Date: Mon, 6 Nov 2023 23:56:42 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch series addresses a failure of gweb/gweb.c:'parse_url' to
correct handle RFC 2732-compliant bracketed IPv6 addresses by renaming
GWeb 'parse_url' to 'parse_request_and_proxy_urls', refactoring it,
and documenting it.

Prior to this change, 'parse_request_and_proxy_urls' failed to
correctly handle RFC 2732-compliant URLs with bracketed IPv6
addresses such as:

    http://[2001:db8:4006:812::200e]:8080/online/status.html
    
Such bracketing is necessary when using IPv6 addresses to disambiguate
the host component from the port component due to the presence of the
colon (':') in IPv6 addresses. As such, prior to this change, such URLs
resulted in the BOTH brackets AND the IPv6 address being passed
to GResolv which, unsurprisingly, failed to successfully forward
resolve since the resulting host was neither a valid host name nor a
valid IPv6 address.

As a result, support for such RFC 2732-compliant bracketed IPv6
addresses has been added with this change which refactors the
previously-monolithic 'parse_request_and_proxy_urls' into several,
focused functions:
    
   * parse_request_and_proxy_urls
        - parse_url_components
            o parse_url_scheme
                + parse_url_scheme_with_default
            o parse_url_host_and_port
                + parse_url_host
                + parse_url_port
            o parse_url_path
    
In particular, 'parse_url_host' is the new function responsible for
parsing the host and correctly handling one of seven possible
combinations of host and port, two of which include bracketed IPv6
addresses.
    
In addition, 'parse_url_host' will now return an error on an empty,
non-existent host and 'parse_url_port' will return an error on
invalid, out-of-range ports.

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

