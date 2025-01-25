Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5961ADC98
	for <connman@lists.linux.dev>; Sat, 25 Jan 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802023; cv=none; b=QfKW3Tdw8Q/U/zMhNJW5lTG2w3ooZtaQCI4JO6E0j6R1UledsHdhv63oS27KD5eOk2ExKDSMHWOT0qYNcfzx99W2p8WV6rgoc/ILxDH2B6mIpaoA5klnigG0k6Cp2YBDkUoSGxt8FbE7ocC+SbvU47cl5PEBEuakAkWWnq2Usys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802023; c=relaxed/simple;
	bh=18ARqdZvLUuC+a03EZqOa9DzRZIPUSrn5pwmXwQDqNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs5A+DBnNQgUrPZjnBEi+00TkKFtYFr5HI+J2MQZdIb5Ke6NZ3Sf1tBrpGLtYw5R+r6yN9Z3RPtGIkjpjzLly8Z8XL659b8YwQr0i7iYstGmDGpBQ7gvVuqT8wp7R9Zd1mZ0e098Qiuyn3UUls7SijsI09W+QFqFLfLfmHQqsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+6pBdJk; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+6pBdJk"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5188c6f260cso949490e0c.1
        for <connman@lists.linux.dev>; Sat, 25 Jan 2025 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737802020; x=1738406820; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YMzADrI4ZpniulWsNHGMoCWuGlnQz7OEHqDDXXq1kI=;
        b=I+6pBdJkdM/6wiz2JSXAJ5LgHpgRbPqYlqufHZKV380MNkqFUipXoPkcoTdt3lmzZR
         IxHBOjIVuwrOgeBuc13qRmPK51/8SJwrU3Ms4XOCbTKDPN1jC1y/jvQOz6j9exrqEJBs
         2voupLSX0s/R/YKSsJt7svo0iNgi/N6F68JBqr2OgVxMAdCZcmJ7lOP6AzQoZFuovdNH
         vwa6x0cmPFfSWAIrRG4Z89qDN0kCemy7lNoaK6cpddxhJU+xDZ0XsILjC78wU8RY9Gyu
         6RaBdsNytK9NiSZ+X+ecpN5gdWeiTZuKIjYBDw+VCe+kJrHk4Wen5gwEcBLByodPPteP
         X9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737802020; x=1738406820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YMzADrI4ZpniulWsNHGMoCWuGlnQz7OEHqDDXXq1kI=;
        b=N4A3ZvfAZ7/sn0i5Fl6bZxta+wORepl58zXU7wEJflM7sDe8jjPiuxlW5BMWXplKej
         MMNERIxPU1zimH8Uq5GSe81u29orlUQ9ePzjFBTimViMe7hZXCue3KWTjkfkS9uH/OeK
         y+bV5E+QR304pxoPGqKf7Ct0xF7c72OyRPdlfhVrdX0RG3H7tmdCCpAZyDV3EH57jwU1
         /2axtx5efnS7eXSkuUQMFjvT8IK4NfW7qb+C2g6nAOM0e0K3bmMpe9Spv3Txn0ykPDvM
         3fqCgrYGR3x3VOS1c8KRYdF7c+TBwzTqZllcdYDKPDYMJvBhtXcWY8gYfBPXQxvMif6B
         z9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX+/1dYqqFtuplPmyA63np6Ujcwyt6k9bwBZBqSHZLddqBctA2yjkdIfOY35Xu6c2ctHHscljn2@lists.linux.dev
X-Gm-Message-State: AOJu0YwTzR46nCc3RSefC94APwZq2eKWO5jasv2gZjAgfosugildcEp2
	+ufsnrGs5j2rjrqTnVq8ucaMC4K09wnsPBqmnvwdDeZM9XRnV0rS/mP46y+70NQHy/6q2n9YuSJ
	RGvZesQlg9KPYmbfyEe1JA/wKqnw=
X-Gm-Gg: ASbGncvzSOyTeFoX3NZFo45ZypSx5hrEOQCIX1RK7AKVKDdHXikKbzJWy/OSDMmQHPl
	Kv154h9W5U+NwD5AfD6ltEaawFkJjLoZPk8mIVyQe2OKYqyLKcyFY+peAz7W9DRgZe0c6EpfecZ
	BYP9nsKa0nV0ruyB33IeE=
X-Google-Smtp-Source: AGHT+IH8F8NK4GdU5X+bLAL4LWAK7nOLBX4VEPxbhq4vLJJEcQN5m08jVeF4g3jXyQbD6DKs8wS2HkC5aC8xdtnN04Y=
X-Received: by 2002:a05:6122:887:b0:515:5008:118b with SMTP id
 71dfb90a1353d-51d51b60240mr24145092e0c.1.1737802020259; Sat, 25 Jan 2025
 02:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com> <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com> <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com> <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
 <bb952186-9493-4efc-8256-deaa63c7385f@jolla.com>
In-Reply-To: <bb952186-9493-4efc-8256-deaa63c7385f@jolla.com>
From: daniel antoine <univac55@gmail.com>
Date: Sat, 25 Jan 2025 11:46:49 +0100
X-Gm-Features: AWEUYZk6SN1FO2pwsnwU4an6n3uDZCMArzch2ctd1nC8DV944ZsaRNWPcGGkL-E
Message-ID: <CA+iibzBrT7mcgK8ZnsxdYuMqF5E+57z-kCZ-G0PLsWaezkdT4Q@mail.gmail.com>
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, Grant Erickson <gerickson@nuovations.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>, Gabriel Sanches <gabriel.sanches@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jussi  Grant Christian and Gabiel

I have installed first the Gabriel patch and tested but my vpn
connexion drops after 5 seconds and finally hangs the wifi connexion

I have continued by installing the eleven and twelves jussi patches
but my compilation failed with the first patch 11-1

 =3D=3D=3D=3D=3D=3D=3D> name: connman
=3D=3D=3D=3D=3D=3D=3D> version: 1.43
=3D=3D=3D=3D=3D=3D=3D> release: 9
=3D=3D=3D=3D=3D=3D=3D> WARNING: connman1737741659x86_64.cards.tar.xz alread=
y exist
=3D=3D=3D=3D=3D=3D=3D> WARNING: connman.man1737741659any.cards.tar.xz alrea=
dy exist
=3D=3D=3D=3D=3D=3D=3D> WARNING: connman.devel1737741659any.cards.tar.xz alr=
eady exist
=3D=3D=3D=3D=3D=3D=3D> WARNING: connman.sources1737741659any.cards.tar.xz a=
lready exist
=3D=3D=3D=3D=3D=3D=3D> Building starting...
cp allow_group_network.diff /tmp/work/src
cp vpn6.patch /tmp/work/src
cp vpn-11-1.patch /tmp/work/src
cp vpn-11-2.patch /tmp/work/src
cp vpn-11-3.patch /tmp/work/src
cp vpn-11-4.patch /tmp/work/src
cp vpn-11-5.patch /tmp/work/src
cp vpn-11-6.patch /tmp/work/src
cp vpn-11-7.patch /tmp/work/src
cp vpn-11-8.patch /tmp/work/src
cp vpn-11-9.patch /tmp/work/src
cp vpn-11-10.patch /tmp/work/src
cp vpn-11-11.patch /tmp/work/src
cp vpn-12-1.patch /tmp/work/src
cp vpn-12-2.patch /tmp/work/src
cp vpn-12-3.patch /tmp/work/src
cp vpn-12-4.patch /tmp/work/src
cp vpn-12-5.patch /tmp/work/src
cp vpn-12-6.patch /tmp/work/src
cp vpn-12-7.patch /tmp/work/src
cp vpn-12-8.patch /tmp/work/src
cp vpn-12-9.patch /tmp/work/src
cp vpn-12-10.patch /tmp/work/src
cp vpn-12-11.patch /tmp/work/src
cp vpn-12-12.patch /tmp/work/src
+ prepare
+ git clone https://git.kernel.org/pub/scm/network/connman/connman.git
connman-1.43
Cloning into 'connman-1.43'...
remote: Enumerating objects: 41151, done.
remote: Total 41151 (delta 0), reused 0 (delta 0), pack-reused 41151
Receiving objects: 100% (41151/41151), 6.41 MiB | 1.64 MiB/s, done.
Resolving deltas: 100% (31525/31525), done.
+ cd connman-1.43
+ git checkout 263e151fcfb09134dcf17a4147355b0ee9a5eb66
Note: switching to '263e151fcfb09134dcf17a4147355b0ee9a5eb66'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to fals=
e

HEAD is now at 263e151f treewide: Fix typo in ARPHRD_PHONET_PIPE
+ patch -Np1 -i /tmp/work/src/allow_group_network.diff
patching file src/connman-polkit.conf
Hunk #1 succeeded at 7 with fuzz 2 (offset 2 lines).
+ patch -Np1 -i /tmp/work/src/vpn6.patch
patching file src/gateway.c
+ patch -Np1 -i /tmp/work/src/vpn-11-1.patch
patching file src/agent.c
Hunk #1 FAILED at 201.
1 out of 1 hunk FAILED -- saving rejects to file src/agent.c.rej
=3D=3D=3D=3D=3D=3D=3D> ERROR: Building 'connman.sources1737741659any.cards.=
tar.xz' failed.

I have copy the patches from the e-mail , may be it introduce false
characters  or must i copy them from the dev list

Best regards

Daniel


Le ven. 24 janv. 2025 =C3=A0 20:03, Jussi Laakkonen
<jussi.laakkonen@jolla.com> a =C3=A9crit :
>
> Hi Christian,
>
> Actually, that commit is in upstream.
> https://git.kernel.org/pub/scm/network/connman/connman.git/log/vpn/plugin=
s/wireguard.c
> - the date on the cherry-picked commits is the date of cherry picking (I
> guess I missed some option while doing this..) but the original commit
> is there submitted on 2020-07-31.
>
> I also pushed the association state and most of the wireguard fixes I've
> done to the mailing list. Have fun testing and tell me if it works
> better, we can always improve it if something is still missing. There
> are few commits I held back as they could be the next patch set, because
> support for IPv4 and IPv6 addresses, and the route adding fixes are also
> quite large changes.
>
> BR,
>   - Jussi
>
>
>
> On 1/23/25 13:35, Christian Hewitt wrote:
> > Looking here: https://git.kernel.org/pub/scm/network/connman/connman.gi=
t/log/ I=E2=80=99m not finding "wireguard: Regular reresolve endpoint addre=
ss=E2=80=9D and the first page of log goes back to December =E2=80=9923. Ar=
e we using the wrong upstream?
> >
> > Christian
> >
> >> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen <jussi.laakkonen@j=
olla.com> wrote:
> >>
> >> Hi Christian,
> >>
> >> That is actually in upstream, all the commits regarding WireGuard befo=
re July 10, 2024 are taken from the latest upstream and the changes after t=
hat are new features.
> >>
> >> Well, the vpn.c changes do depend on having the ASSOCIATION state also=
 for VPNs to be implemented, that was proposed in the RFC https://lore.kern=
el.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39=
d72dd424884fe105a66fea02a83c708f97 as the state transitions depend on that =
bit. But it does not seem to be depending on the gateway.c/connection.c. We=
ll, I can try to squeeze time to address the issues Daniel earlier raised o=
n that RFC and push them to upstream, then make a big change on the vpn.c a=
nd wireguard.c.
> >>
> >> Br,
> >> Jussi
> >>
> >>
> >> On 1/23/25 13:12, Christian Hewitt wrote:
> >>> You don't often get email from christianshewitt@gmail.com. Learn why =
this is important<https://aka.ms/LearnAboutSenderIdentification>
> >>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s resolvin=
g to dynamic IP=E2=80=99s upstreamed so this looks interesting:
> >>> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d70=
3f972b866fdbd8bd
> >>> Is that feature dependent on any other changes? (being lazy.. I didn=
=E2=80=99t read all the commits in that branch yet!).
> >>> Christian
> >>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen <jussi.laakkonen@=
jolla.com> wrote:
> >>> Hello,
> >>> Regarding WireGuard, I had to make a bunch of changes to the latest v=
ersion of it to get it running properly on our fork (yes, we upgrade it slo=
wly, now 1.38): https://github.com/sailfishos/connman/commits/master/connma=
n/vpn
> >>> But I haven't had time to figure out all that is needed for upstream =
to be sent first, like this RFC edit that was forgotten because of... "east=
ern winds blowing into our direction": https://lore.kernel.org/connman/2022=
1213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66=
fea02a83c708f97
> >>> And then the connection.c was modified a lot (and renamed) and I'm no=
t sure if these will work on top of that anymore. Mostly because we have fe=
atures that may not have been compatible with latest upstream, like adding =
a support  for two different devices to be belonging into one service to fa=
cilitate CLAT support https://github.com/sailfishos/connman/commits/master/=
connman/src/connection.c etc. etc. etc.
> >>> At some point I'll start pushing changes but not sure when I have tim=
e. Mostly they could be RFCs as the changes are big.
> >>> BR,
> >>> Jussi
> >>> On 1/23/25 12:45, daniel antoine wrote:
> >>> Hi
> >>> I have opened a ticket for connman-vpn not working with wireguard  in
> >>> April 2024. If you give me the patches I can test them
> >>> Best regards
> >>> Daniel
> >>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
> >>> <gerickson@nuovations.com> a =C3=A9crit :
> >>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches <gabriel.sanches=
@prevas.dk> wrote:
> >>> I was testing connman's wireguard plugin and got a segmentation fault=
.
> >>> Looking at the backtrace revealed that there are some typos in the `s=
rc/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variables=
 instead of ipv6 regarding vpn.
> >>> I simply changed them to ipv6 and got it working.
> >>> not related to the patch:
> >>> I had to manually add ip route so the other devices could be pinged
> >>> The plugin adds routes for the WireGuard.DNS configuration setting
> >>> # ip route
> >>> 1.1.1.1 dev wg0 scope link
> >>> 8.8.8.8 dev wg0 scope link
> >>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
> >>> 10.42.0.1 dev end1 scope link
> >>> <vpn host ip> via 10.42.0.1 dev end1
> >>> the missing route added manually:
> >>> ip route add 10.33.0.0/16 dev wg0 scope link
> >>> an equivalent wireguard file adds it properly (using wg-quick)
> >>> Is the plugin lacking some implementation?
> >>> ---
> >>> src/gateway.c | 6 +++---
> >>> 1 file changed, 3 insertions(+), 3 deletions(-)
> >>> diff --git a/src/gateway.c b/src/gateway.c
> >>> index 16c87f83..b2c211e2 100644
> >>> --- a/src/gateway.c
> >>> +++ b/src/gateway.c
> >>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_serv=
ice *service,
> >>>                                        is_gateway_config_vpn(
> >>>                                                new_gateway->ipv4_conf=
ig);
> >>> -             is_vpn6 =3D do_ipv4 &&
> >>> -                                     new_gateway->ipv4_config &&
> >>> +             is_vpn6 =3D do_ipv6 &&
> >>> +                                     new_gateway->ipv6_config &&
> >>>                                        is_gateway_config_vpn(
> >>> -                                             new_gateway->ipv4_confi=
g);
> >>> +                                             new_gateway->ipv6_confi=
g);
> >>>        } else {
> >>>                if (do_ipv4 && new_gateway->ipv4_config)
> >>> --
> >>> 2.43.0
> >>> Gabriel,
> >>> Great catch on this copy-and-paste typo; thank you!
> >>> Best,
> >>> Grant
> >>
> >
>
>
