Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F718661C
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265899; cv=none; b=gPtHApcDFE/16OJyyoXsZ8Lprll1Uls7aPnmT2QerbPftDVkLLJmdDCRmuRU1sDRvnU7UBrU/cFFC7n6f7wAKFDBCgQl9cpxHb8psHKgIuhdJjJ4GqhzVPpuanIAlKBzwl1Psqavs1Fh/vUwG59qR3tHB4xQ4/9t+BIweKnSNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265899; c=relaxed/simple;
	bh=HTZjUiGiTfapj00FRaSiLY03WVY6eJHY0sDNH4e76c8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EjU1sdPOXsyQj4XtophprqxIrNMljUaC3KWi/zzakBtHWHMYAfqVYHywcRxD6ZZhNfrMxSWF5J+tQw/T0FqCaisWrNPdw3Pk9o2pYR3PoZw0Lj8VmEYxqYLLbHqEfBhEz0Bbwv0yzq7kqSq2AxFTIsM3uA8Xbc1o+5QdoHcei9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f372.dip0.t-ipconnect.de [79.249.243.114])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2CBD2CECDC;
	Mon,  2 Sep 2024 10:31:36 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] set pkt_len when packet is received using L3 listening
 mode so that the ACK can be processed correctly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240322132455.833-1-john.mark@kistler.com>
Date: Mon, 2 Sep 2024 10:31:25 +0200
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DA593F6-29B0-4B25-BE6F-D826AF1A196E@holtmann.org>
References: <20240322132455.833-1-john.mark@kistler.com>
To: John Mark <john.mark@kistler.com>
X-Mailer: Apple Mail (2.3776.700.51)

Hi John,

> The packet length is not set correctly when an IPv4 L3 ACK is received =
from a
> DHCP server.  This causes the packet to be rejected for having no
> MESSAGE_TYPE option and the lease is not renewed at the T1 point (or =
any
> subsequent retry).  Instead, the lease gets re-bound at the T2 point.
>=20
> ---
> gdhcp/client.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/gdhcp/client.c b/gdhcp/client.c
> index 82017692..c58c7be9 100644
> --- a/gdhcp/client.c
> +++ b/gdhcp/client.c
> @@ -2316,6 +2316,7 @@ static gboolean listener_event(GIOChannel =
*channel, GIOCondition condition,
> } else {
> re =3D dhcp_recv_l3_packet(&packet,
> dhcp_client->listener_sockfd);
> + pkt_len =3D (uint16_t)(unsigned int)re;
> xid =3D packet.xid;
> }
> } else if (dhcp_client->listen_mode =3D=3D L_ARP) {

is this still needed? The patch does no longer apply.

Regards

Marcel

