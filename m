Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACF31A62
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 09F50CECE4;
	Sat, 16 Dec 2023 19:47:33 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/9] inet: Add Missing Gateway Parameter to Host Route
 Deletion Interfaces
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231216082805.2221938-1-gerickson@nuovations.com>
Date: Sat, 16 Dec 2023 19:47:22 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <EF39FEFE-A513-4363-B711-8EBDDCD075AD@holtmann.org>
References: <20231216082805.2221938-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> Routing table manipulation, host routes among them, should be
> fundamentally symmetric. The routing table entry parameters used to
> add a route should be identical to those used to delete the same
> route. Otherwise, an 'ESRCH' error may occur which, at present, are
> suppressed due to commit e03a01d3182d ("inet: Fix error handling when
> adding/removing routes") that is masking route deletion errors where
> this gateway parameter asymmetry is occurring.
> 
> This adds a previously-missing gateway address parameter to the
> 'connman_inet_del_{,ipv6_}host_route' functions. In addition, call
> sites to 'connman_inet_del_{,ipv6_}host_route' are updated to pass the
> gateway parameter.
> 
> In addition, in the process, this refactors 'nameserver_del_routes'
> into a second, helper function 'del_nameserver_route' such that host
> route deletion is separated from DNS server iteration. This structure
> now mirrors that of 'nameserver_add_routes' and 'add_nameserver_route'
> since, again, route addition and deletion should be symmetric.
> 
> NOTE: This is only the first half of the necessary change. The second
> half is revising the actual implementation of
> 'connman_inet_del_{,ipv6_}host_route' to take advantage of the
> newly-added gateway parameter. Implementation notes in each of
> 'connman_inet_del_{,ipv6_}host_route' have been added toward that end.
> 
> Grant Erickson (9):
>  service: Refactor 'nameserver_del_routes'.
>  service: Add gateway parameter to DNS host route deletion paths.
>  inet: Add gateway parameter to 'connman_inet_del_{,ipv6_}host_route'.
>  inet: Document 'connman_inet_{add,del}_{,ipv6_}host_route'.
>  service: Const-qualify 'add_nameserver_route'.
>  service: Add 'DBG' to 'add_nameserver_route'.
>  inet: Document '{add,del}_nameserver_route'.
>  inet: Document 'nameserver_{add,del}_routes'.
>  inet: Document '__connman_service_nameserver_{add,del}_routes'.
> 
> include/inet.h |  17 ++--
> src/connman.h  |   1 +
> src/gateway.c  |  33 +++++---
> src/inet.c     | 184 ++++++++++++++++++++++++++++++++++++++--
> src/service.c  | 225 ++++++++++++++++++++++++++++++++++++++++++++-----
> 5 files changed, 419 insertions(+), 41 deletions(-)

all 9 patches have been applied.

Regards

Marcel

