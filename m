Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B3D264
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 5CCF9CECD8;
	Sat, 23 Dec 2023 13:22:10 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/5] Address Unhandled Gateway Route Lifecycle
 Events/Transitions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231220055613.2287074-1-gerickson@nuovations.com>
Date: Sat, 23 Dec 2023 13:22:00 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <E03A875B-7269-453D-860C-362515E875BE@holtmann.org>
References: <20231220055613.2287074-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,


> There were a number of "escapes" or unhandled events and transitions
> that did not adhere to the documented gateway configuration lifecycle
> / state machine.
> 
> Failure to handle these was resulting in duplicate default routes, no
> default routes, and incorrect default route priorities for some
> services and their underlying network interfaces.
> 
> These "escapes" were handled in three primary ways with this patch series:
> 
>  1. Leveraging '__connman_inet_rtnl_recv' in 'iproute_default_modify'.
>  2. Leveraging -ESRCH returned by 'iproute_default_modify'.
>  3. Adding explicit conditional cases for the "escapes" not otherwise
>     covered by (1) and (2).
> 
> Grant Erickson (5):
>  inet: Use '__connman_inet_rtnl_recv' for RTNL default route
>    transaction.
>  gateway: Handle -ESRCH in 'unset_default_gateway_route_common'.
>  gateway: Address unhandled gateway lifecycle events/transitions.
>  gateway: Add and leveage 'gateway_config_set_{,in}active'.
>  gateway: Expand the @param documentation for
>    'yield_default_gateway{,_for_type}'.
> 
> src/gateway.c | 80 +++++++++++++++++++++++++++++++++++++++------------
> src/inet.c    |  6 ++++
> 2 files changed, 68 insertions(+), 18 deletions(-)

all 5 patches have been applied.

Regards

Marcel

