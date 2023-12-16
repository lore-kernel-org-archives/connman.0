Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F41E4B3
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id AC7E5CECE4;
	Sat, 16 Dec 2023 19:47:06 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 00/11] service/wispr: Add Per-service-unique WISPr Host
 Route Metric/Priority
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231216061223.2199037-1-gerickson@nuovations.com>
Date: Sat, 16 Dec 2023 19:46:56 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <671647AE-51D4-4B49-BA7D-6001827F99EC@holtmann.org>
References: <20231216061223.2199037-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This add and leverages '__connman_service_get_route_metric' to select
> an appropriate service-specific route metric/priority when adding or
> deleting WISPr host routes.
> 
> This allows multiple such routes to coexist simultaneously, supporting
> "continuous" mode online checks in which one or more services may be
> conducting "online" WISPr-based Internet reachability checks as they
> move in and out of reachability success/failure.
> 
> '__connman_service_get_route_metric' is a non-public service
> interface, which attempts to get the route metric/priority for the
> specified service based on the current service and services state.
> 
> If the service is the default or if it is the only service, then the
> metric is zero (0). Otherwise, a low-priority metric (metric > 0)
> unique to the service and its underlying network interface is computed
> and returned.
> 
> Grant Erickson (11):
>  service: Add '__connman_service_get_route_metric'.
>  service: Document '__connman_service_get_route_metric'.
>  wispr: Expand 'DBG' in 'wispr_portal_detect'.
>  wispr: Add 'DBG' to '__connman_wispr_start' error path.
>  wispr: Update 'DBG' in '__connman_wispr_start'.
>  wispr: Refactor 'free_wispr_routes'.
>  wispr: Simplify IPv4 vs. IPv6 host route management.
>  wispr: Document 'free_wispr_route{,s}'.
>  wispr: Document 'wispr_route'.
>  wispr: Document 'wispr_portal_context_route_ops'.
>  wispr: Leverage '__connman_service_get_route_metric'.
> 
> src/connman.h |   2 +
> src/service.c |  98 ++++++++++++++++++++++++
> src/wispr.c   | 207 +++++++++++++++++++++++++++++++++++++++++---------
> 3 files changed, 271 insertions(+), 36 deletions(-)

all 11 patches have been applied.

Regards

Marcel

