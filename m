Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688F3FB35
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 41700CECD9;
	Thu, 14 Dec 2023 12:35:18 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: RFC: __connman_service_get_route_metric
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <129F38C5-2B36-40FB-A240-EE0542FCB5D7@nuovations.com>
Date: Thu, 14 Dec 2023 12:35:07 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE15E661-4815-49A0-A9B8-1B2BF41FC2A8@holtmann.org>
References: <129F38C5-2B36-40FB-A240-EE0542FCB5D7@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> Was out on my morning ride this morning and had this revelation: =
https://github.com/Nuovations/connman/issues/6:
>=20
> Addressing https://github.com/Nuovations/connman/issues/5 will "paper =
over it"; however, fundamentally, there is the same high- vs. =
low-priority routing metric at play here for online check failover. For =
the online check / WiSPr, host routes for the IPv4 or IPv6 URL host are =
installed and removed.
>=20
> INSTALLED
>=20
> static bool wispr_route_request(...)
> {
>    switch (wp_context->type) {
>    case CONNMAN_IPCONFIG_TYPE_IPV4:
>        result =3D connman_inet_add_host_route(if_index, address, =
gateway);
>        break;
>    case CONNMAN_IPCONFIG_TYPE_IPV6:
>        result =3D connman_inet_add_ipv6_host_route(if_index, address, =
gateway);
>        break;
>=20
>    [=E2=80=A6]
>=20
>    return true;
> }
>=20
> REMOVED
>=20
> static void free_wispr_routes(...)
> {
>    switch (wp_context->type) {
>    case CONNMAN_IPCONFIG_TYPE_IPV4:   =20
>        connman_inet_del_host_route(route->if_index, route->address);
>        break;
>=20
>    case CONNMAN_IPCONFIG_TYPE_IPV6:
>        connman_inet_del_ipv6_host_route(route->if_index, =
route->address);
>        break;
>=20
>    [=E2=80=A6]   =20
> }
>=20
> However, note that there is not a metric parameter in =
connman_inet_{add,del}{_ipv6,}_host_route. So, in a failover scenario, =
there may be host routes installed for one or more of Ethernet, Wi-Fi, =
and Cellular as each tries to recover online connectivity. However, =
since the metric for all is implicitly zero, one and only one network =
interface index will get the host route and all the others will silently =
fail (because connman_inet_{add,del}{_ipv6,}_host_route silently =
swallows -EEXIST).
>=20
> In the recent set of patches to =
https://github.com/Nuovations/connman/issues/5, I'd commented in =
compute_low_priority_metric:
>=20
> static uint32_t compute_low_priority_metric(...)
> {
>    [=E2=80=A6]
>=20
>    /*
>     * The algorithm uses the network interface index since it is
>     * assumed to be stable for the uptime of the network interface
>     * and, consequently, the potential maximum lifetime of the route.
>     *
>     * The algorithm establishes UINT32_MAX as the metric base (the
>     * lowest possible priority) and a somewhat-arbitrary 2^20 as the
>     * ceiling (to keep metrics out of a range that might be used by
>     * other applications). The metric is then adjusted in increments
>     * of 1,024 (2^10) from the base, but less than the ceiling, by
>     * multiplying the increment by the network interface index. This
>     * is easy and simple to compute and is invariant on service
>     * order.
>     *
>     * In the fullness of time, the "rule of least astonishment" for
>     * Connection Manager might be that low priority metrics follow
>     * the service order with the default service always having metric
>     * zero (0) and lowest priority metric assigned to the lowest
>     * priority service, etc. Achieving this would require 1) caching
>     * the computed metric in the gateway data since services may
>     * re-sort by the time we are asked to recompute high- and
>     * low-priority routes and we need a stable and matching metric to
>     * successfully delete a previously-created route and 2) having
>     * access to an API (such as
>     * '__connman_service_get_order(data->service)') that exposes a
>     * strictly-in/decreasing service order with no duplicates. Today,
>     * there is no such API nor is there such a durable service order
>     * meeting that mathematical requirement.
>     */
>=20
>    return MAX(metric_ceiling, metric_base - (data->index * =
metric_index_step));
> }
>=20
> However, because this routing metric is needed across multiple modules =
(right now, both wispr.c and connection.c) the right approach given this =
revelation might be an API:
>=20
>    __connman_service_get_route_metric(const struct connman_service =
*service);
>=20
> where the default service returns zero (0) and the rest return a =
metric reflective of their service order, between some ceiling (say, =
2^20) and some floor (say, UINT32_MAX).
>=20
> This could then be applied easily to both gateway network and on-link =
network routes as well, making routing determinant based on service =
order, not kernel preference, for all routes.
>=20
> Thoughts on the proposed:
>=20
>    __connman_service_get_route_metric(const struct connman_service =
*service);
>=20
> API?

I would say go for it and try it out. See if it works.

Regards

Marcel

