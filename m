Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D06F11CA8
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 0E83ACECD1;
	Wed, 29 Nov 2023 13:49:18 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Query about ipv4 connman web page
From: Marcel Holtmann <marcel@holtmann.org>
X-Priority: 3
In-Reply-To: <20231129011659epcms1p57c0faf7151f067f18be5cfef0229f1f9@epcms1p5>
Date: Wed, 29 Nov 2023 13:49:07 +0100
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B9EC47A-CD5C-424F-A5D3-53C320D508A2@holtmann.org>
References: <CGME20231128052502epcms1p4a229137cf6d9bb65b8e463a873688e69@epcms1p5>
 <20231129011659epcms1p57c0faf7151f067f18be5cfef0229f1f9@epcms1p5>
To: wy1115.lee@samsung.com
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Lee,

> Thank you for quick fix.
> It is very impressive experience for me.
>=20
>=20
> I hope to ask the following questions.
> 1. Could you share the reason of "Connection timeout" if possible?
> 2. When I face ipv4.connman.net/online/status.html access issue, can I =
report to this way?=20

after fixing ipv6.connman.net <http://ipv6.connman.net/> it took away =
capacity from ipv4.connman.net <http://ipv4.connman.net/>. Seems there =
are a lot of systems capable of IPv6 these days compared to back in the =
days when the service was created. The majority is still IPv4, but I =
have seen substantial IPv6 usage recently. So just increasing the =
capacity for IPv4 leveled this back to normal.

You might have noticed that ipv6.connman.net <http://ipv6.connman.net/> =
went through actually and ipv4.connman.net <http://ipv4.connman.net/> =
took a connection timeout hit every now and then (still a large =
percentage succeeded). The preference of answering IPv6 over IPv4 is =
something that I don=E2=80=99t understand and I have to investigate (for =
pure personal interest), but that should no longer be an issue.

Issues can be reported here or the newly created Slack channel (which I =
still have to put into the README).

Regards

Marcel

