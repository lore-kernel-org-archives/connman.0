Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D721168B2
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 361F5730F7;
	Wed, 20 Dec 2023 00:53:35 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:b417:6c4b:929a:d416] (unknown [IPv6:2601:647:5a00:15c1:b417:6c4b:929a:d416])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E3AF173128;
	Wed, 20 Dec 2023 00:53:34 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] connection: Rename 'connection.c' to 'gateway.c'
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <93ee2de3-a7bf-4a43-9893-799af7bb97aa@jolla.com>
Date: Tue, 19 Dec 2023 21:53:34 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1857CD1F-DCD2-414F-B0A7-7E167242A058@nuovations.com>
References: <20231213200001.1994492-1-gerickson@nuovations.com>
 <93ee2de3-a7bf-4a43-9893-799af7bb97aa@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 19, 2023, at 5:32 AM, Jussi Laakkonen <jussi.laakkonen@jolla.com> =
wrote:
> I'm not really understanding what is the real benefit here in renaming =
connection.c to gateway.c. Granted (pun), it is more clear name for it =
but it still has some vpn-related functionality to get the physical =
device index etc. so it is still misleading.
>=20
> My point here is that this just brings a lot of drawbacks:
> - It is rather complex now to apply patches from older versions, forks =
or heavily patched forks to upstream that contain changes to old =
connection.c
> - It is really not straightforward just to pick an upstream patch made =
with changes to connection.c into these older versions or forks that =
from one reason or another, or like million reasons, like with our fork, =
cannot just be updated directly to latest upstream.
> - And the name was there for... 15 years? It really hasn't gone =
through so much changes that it would need to be renamed from my =
opinion.
>=20
> =46rom my perspective the simple SWOT analysis here would result a =
negative outcome to renaming and positive towards keeping the name.
>=20
> Also, choose vs. yield, well, for non-native English speakers the =
first would be more obvious in definition and one glance of the name =
would tell what it is supposed to do. Personally I'd prefer concise =
language throughout the project, the function does not really give up =
anything but selects the most suitable one, right? The commit:
> =
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/src/conn=
ection.c?id=3D64a986109880828a4aa727ecb7a82cb97b004623
>=20
> It is good that stuff gets documented here but reformatting should not =
be done just because reformatting needs. I'd say that compatibility =
should weight there a lot when deciding whether to rename or not.
>=20
> If the process of upstreaming because of this kind of changes becomes =
rather complex (even more than it already is because of historic =
reasons) and time required to do them increases a lot it just might be =
that those patches do not get done/sent. But this is just my view on the =
matter.

Jussi,

In terms of the file and function rename(s), I approached both as =
someone who was somewhat-initiated in having worked on connman some 13 =
years ago but was coming back to it with fresh eyes. I reasoned that if =
file and function names (those in connection.c/gateway.c, in particular) =
were confusing to me, then they would be more so to someone even less =
initiated than I. To the extent Marcel and the community were =
supportive, I submitted the patches. Having substantially refactored a =
large portion of connection.c/gateway.c, I believe it is more =
understandable for the uninitiated today than it was before.

For my own insight, are there specific down-revision features of connman =
on which Sailfish (I assume Sailfish is the fork in question) would not =
or could not work with top-of-tree connman?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

