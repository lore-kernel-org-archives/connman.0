Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316D18C01
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 10EC7CECC3;
	Fri, 15 Dec 2023 09:50:21 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/8] inet: Add IPv{4,6} Host/Network Route Add/Delete with
 Metric / Priority Functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231215001032.2127527-1-gerickson@nuovations.com>
Date: Fri, 15 Dec 2023 09:50:10 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <CCA00372-09E7-4F3A-BD73-D55B560ECFA8@holtmann.org>
References: <20231215001032.2127527-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This adds and documents
> 'connman_inet_{add,del}_{,ipv6_}{host,network}_route_with_metric'
> functions that provide the ability to add/delete an IPv4 or IPv6 host
> or network route with an explicit metric / priority.
> 
> As a convenience, the
> 'connman_inet_{add,del}_{,ipv6_}network_route_with_metric' network
> route functions allow the caller to provide the IPv4 or IPv6 network
> address in masked (for example, 169.254.0.0/16) or unmasked (for
> example, 169.254.75.191/16) form. The function will mask the address,
> based on the provided prefix length, before modifying the route with
> it.
> 
> Grant Erickson (8):
>  inet: Relocate 'rtnl_route_cmd2string'.
>  inet: Reorder IPv6 host and network route function declarations.
>  inet: Add IPv{4,6} host/network route functions with metric/priority.
>  connection: Document 'inet_get_addr_data'.
>  connection: Document 'inet_mask_addr_data'.
>  connection: Document 'inet_modify_host_or_network_route'.
>  connection: Document 'inet_modify_{,ipv4_,ipv6_}{host,network}_route'.
>  inet: Document IPv{4,6} host/network route functions with
>    metric/priority.
> 
> include/inet.h |   43 +-
> src/inet.c     | 1275 ++++++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 1271 insertions(+), 47 deletions(-)

all 8 patches have been applied.

Regards

Marcel

