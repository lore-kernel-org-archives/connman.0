Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFC2C19B
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C53D773174;
	Fri, 22 Dec 2023 11:24:20 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138] (unknown [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5C834731D1;
	Fri, 22 Dec 2023 11:24:20 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] connection: Rename 'connection.c' to 'gateway.c'
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <d6dfa0ff-202a-49f7-b097-f098334764ce@jolla.com>
Date: Fri, 22 Dec 2023 08:24:19 -0800
Cc: connman@lists.linux.dev,
 marcel@holtmann.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <496375AA-E120-4C67-8253-A5DF4DD01154@nuovations.com>
References: <20231213200001.1994492-1-gerickson@nuovations.com>
 <93ee2de3-a7bf-4a43-9893-799af7bb97aa@jolla.com>
 <1857CD1F-DCD2-414F-B0A7-7E167242A058@nuovations.com>
 <d6dfa0ff-202a-49f7-b097-f098334764ce@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 20, 2023, at 9:10 AM, Jussi Laakkonen <jussi.laakkonen@jolla.com> =
wrote:
> On 12/20/23 07:53, Grant Erickson wrote:
>> On Dec 19, 2023, at 5:32 AM, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>> I'm not really understanding what is the real benefit here in =
renaming connection.c to gateway.c. Granted (pun), it is more clear name =
for it but it still has some vpn-related functionality to get the =
physical device index etc. so it is still misleading.
>>>=20
>>> My point here is that this just brings a lot of drawbacks:
>>> - It is rather complex now to apply patches from older versions, =
forks or heavily patched forks to upstream that contain changes to old =
connection.c
>>> - It is really not straightforward just to pick an upstream patch =
made with changes to connection.c into these older versions or forks =
that from one reason or another, or like million reasons, like with our =
fork, cannot just be updated directly to latest upstream.
>>> - And the name was there for... 15 years? It really hasn't gone =
through so much changes that it would need to be renamed from my =
opinion.
>>>=20
>>> =46rom my perspective the simple SWOT analysis here would result a =
negative outcome to renaming and positive towards keeping the name.
>>>=20
>>> Also, choose vs. yield, well, for non-native English speakers the =
first would be more obvious in definition and one glance of the name =
would tell what it is supposed to do. Personally I'd prefer concise =
language throughout the project, the function does not really give up =
anything but selects the most suitable one, right? The commit:
>>> =
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/src/conn=
ection.c?id=3D64a986109880828a4aa727ecb7a82cb97b004623
>>>=20
>>> It is good that stuff gets documented here but reformatting should =
not be done just because reformatting needs. I'd say that compatibility =
should weight there a lot when deciding whether to rename or not.
>>>=20
>>> If the process of upstreaming because of this kind of changes =
becomes rather complex (even more than it already is because of historic =
reasons) and time required to do them increases a lot it just might be =
that those patches do not get done/sent. But this is just my view on the =
matter.
>> Jussi,
>> In terms of the file and function rename(s), I approached both as =
someone who was somewhat-initiated in having worked on connman some 13 =
years ago but was coming back to it with fresh eyes. I reasoned that if =
file and function names (those in connection.c/gateway.c, in particular) =
were confusing to me, then they would be more so to someone even less =
initiated than I. To the extent Marcel and the community were =
supportive, I submitted the patches. Having substantially refactored a =
large portion of connection.c/gateway.c, I believe it is more =
understandable for the uninitiated today than it was before.
>> For my own insight, are there specific down-revision features of =
connman on which Sailfish (I assume Sailfish is the fork in question) =
would not or could not work with top-of-tree connman?
>> Best,
>> Grant
>=20
> Hi Grant,
>=20
> I was just concerned that the contributions in form of new features =
and fixing existing we and many others have been doing becomes even more =
difficult with renaming of the content hence the differences of the =
forks. Personally I try to avoid renaming much in order to not to break =
any workflows people already have. I'd just reason it in this way that =
better to have a bit of odd naming than break anything ;).
>=20
> But this "yield" word just really sounded odd, especially since the =
definition would be, from my perspective, ok in thread/fork-related =
cases, or in what https://www.merriam-webster.com/dictionary/yield =
defines but in selecting the default gw it just seems a bit off? Sorry =
about the nag on this.

In breaking down the syntactic and semantic choice of =E2=80=9Cchoose=E2=80=
=9D versus =E2=80=9Cyield=E2=80=9D, to me, =E2=80=9Cchoose=E2=80=9D =
implied =E2=80=9Cyou have two gateways to consider that are, at the =
outset, equal. That is, choose one of the two specified gateways and =
then give it the (what is now) high-priority (that is, metric 0) default =
route. However, the reality (somewhat complicated more now by the =
existence of BOTH high- and low-priority default routes) is not only =
that the action of the function is not simply a side-effect-free choice =
but also that it is a demotion / unset / give up / yielding of the =
high-priority default route for one of the two gateways.

Regardless of its function name, on entry to the function one of the two =
gateways holds the high-priority (that is, metric 0) default route, so =
there is not such much a choice between equal gateways. On exit from the =
function, one of those two gateways will have unset it / given it up / =
have =E2=80=9Cyielded=E2=80=9D the high-priority default route and will =
have assumed a low-priority (that is, metric > 0) default route. It is =
not until after =E2=80=98yield_default_gateway=E2=80=99 is called that =
the activated, if it was not the gateway to unset / give up / yield the =
high-priority route, is promoted from its low-priority route to the =
high-priority route.

Given that this demotion / unset / give up / yielding of the =
high-priority default route was a central and key side-effect of this =
function being called, I felt that =E2=80=9Cyield=E2=80=9D was a much =
more apt action verb than =E2=80=9Cchoose=E2=80=9D.

Comparing it to, say, =E2=80=9Cpthread_yield=E2=80=9D, in that case it =
is a thread giving up or yielding the processor / scheduler. In this =
case, it is a gateway giving up or yielding the high-priority default =
route.

Does that help color and explain the rationale I had?

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

