Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494338FAD
	for <connman@lists.linux.dev>; Sat, 25 Jan 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737804200; cv=none; b=f3SoVeNHiNfk+i4e+TQyU923wemTJOIIRLF90iF1P3bdfcy+BKPnNOSa8nH8LdRI+vZnzmZKCty2y/XOqKPEqB7sYy1qGFbZgFeUNiJ/funIsnR9gEvnZXfpkFy/tg+bKKFlnw08eqUemrNdA1AHhreUp+HJeNbnw9otNCUdw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737804200; c=relaxed/simple;
	bh=nt5c6f3XsKfd7qz3YuKmygxZkUw30BEV8PFLmZUAbRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsFQK6pi5YzQOMQh3rCBfZurV6QEfI+RFTVtQyzvXRVE/3ssYtBfwSBTx/ZBLGYiY3Q309XsL/b/hmrrjpHH4n+XBI19cNSI/nh3kMLzPBpQcWDr4x+VFkIw0mqgmFF32Z3OG4Uqj7O/5sV9lQyGVh5oygFWzLu7u/EPLMCHQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTatqliD; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTatqliD"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5174d53437eso1671736e0c.2
        for <connman@lists.linux.dev>; Sat, 25 Jan 2025 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737804196; x=1738408996; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEW1wIbyTgutsiXLODVyaCw6y54TUMeLOdkmqmfvsY8=;
        b=fTatqliDYEKJvDvrqJ7EiAZhFYoBLcy392vpy6ocW664qWf5+glLUie9prHlrUP4+G
         AR3JZQFKFBid5uIA3ZBv8YVtINyWCPYnbavyBfWcYfK4vF0Tj+d9FMf/1yxSuFvx+ycE
         BDXntWfPQO8zyS/O6bJ0HxDwu62PTPVCQt6rVxt9mh5dDo5KfT4sKAmUOLpFu/cia9si
         EXk2HQBFdvEVaABTcRWiU4V6tiiSI1994Ee5HTPhWONBB2gztIF4Xlq4eznGX7G6F9bY
         +R9WvfZ7JPRsOXPiRXzCc1pP4TKUcMiGoxTJSPKE17z5umAorcxseKbmeVHHJgU/JPhq
         yyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737804196; x=1738408996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEW1wIbyTgutsiXLODVyaCw6y54TUMeLOdkmqmfvsY8=;
        b=oSrt8E12S4bgfeqmftzq+6Cqy97QHWWHfRAXxBLRaB96ub2/9sSAbAtTHit3zuoLo0
         47FBNojmyz2N3ly69aPAtGZgk3aIRH7bdfU4d3hngeQOxlPqK+gbT4k14BBW4adXltCp
         chds/pG9ABCAZ41gqO5/MOdegOb8uixjH2xvo2WYTASwL51jm5gc5P+wW0N0oWSGnyxJ
         NDmmS3gYGD6Yn3yZhlz2wn2p7lgW/FZEW6FfLnwGwWw2sA2QwwyX8bk6itlxX4nFSBNz
         CCKaKuIXrr5n8tG9EIqanJMAS9wYIb0A7N91e9uQ1JQKGs41Bwiw/jKiSdtQ6Ib8aDJ1
         jn/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZvl19KAuaZUsq9GwvvUpC3YIlbBFAlS7CwzUIA1YzZ4zEP7y00+zNzT4kwDenQWnpLi32CHp3@lists.linux.dev
X-Gm-Message-State: AOJu0YzP9jbNVFbpJBmURw8fQWZOFMtWPCgbVA7AbGwRWuTKHqxcF7Mc
	BoV1/C/JjQME5ftsZqJmLX6CRZ2YsN4PkWmNv6X+FynrzUQ3EvCZf3M/bw78SuYz04aHEMH0P+4
	HiJe7fiZ3D4GWBRRuVKeEkTgMAUvN+o+4T+4m6A==
X-Gm-Gg: ASbGncs6whZsKEE/KV+7zMxrVib7bjrs6d3Xcn7RIxkOJB4+whac7VWERAUcf37K0/p
	wEX1Q2a+W1MurH7HkkRAYJqLN5cQLxcx3YE1Y43SCBgI3igMHl+KzVnk40rvZ11x7JaKapQWQi+
	FkRBXCY6dY3EbvrREb37w=
X-Google-Smtp-Source: AGHT+IFpwF2a4reDYFlx7bYsqJn5OSpleOrhmBlfcZFdNXIqSjUHg1qLlh/YZe/C8oUCB+f7wsQY8abQ1GGNYdi3V/4=
X-Received: by 2002:a05:6122:1998:b0:518:9582:dba2 with SMTP id
 71dfb90a1353d-51d5b3b51demr26232417e0c.10.1737804196145; Sat, 25 Jan 2025
 03:23:16 -0800 (PST)
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
 <bb952186-9493-4efc-8256-deaa63c7385f@jolla.com> <CA+iibzBrT7mcgK8ZnsxdYuMqF5E+57z-kCZ-G0PLsWaezkdT4Q@mail.gmail.com>
In-Reply-To: <CA+iibzBrT7mcgK8ZnsxdYuMqF5E+57z-kCZ-G0PLsWaezkdT4Q@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Sat, 25 Jan 2025 12:23:05 +0100
X-Gm-Features: AWEUYZlwj0HL_kFrsfsQ4bxwA3AJ_kvedSDCLfJO87zJMs3dqJ-yCzXzoZRWNOU
Message-ID: <CA+iibzC3xjeN2=SyLU3yhhOEKvPysSbr+obGKKo8G8noCRSOKQ@mail.gmail.com>
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, Grant Erickson <gerickson@nuovations.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>, Gabriel Sanches <gabriel.sanches@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have copy the patches from the dev list and they have all passed ;
The vpn connection continue to drop with in the journalctl

 janv. 25 12:12:01 grat-os1 connman-vpnd[1176]: wlan0 {newlink} index
5 operstate 6 <UP>
janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Adding configuration vpndani=
a
janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Added provider
configuration wireguard
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
type 65534 <NONE>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 144 <DOWN=
>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
operstate 2 <DOWN>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
98513 <UP,RUNNING,LOWER_UP>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
operstate 0 <UNKNOWN>
janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit reache=
d
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags 32912 <DO=
WN>
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
operstate 2 <DOWN>
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
operstate 2 <DOWN>
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6

and

=E2=97=8F connman-vpn.service - ConnMan VPN service
     Loaded: loaded (/usr/lib/systemd/system/connman-vpn.service;
enabled; preset: enabled)
     Active: active (running) since Sat 2025-01-25 12:12:02 CET; 6min ago
 Invocation: c3584a6570fc48deb60efbb589e55903
   Main PID: 1176 (connman-vpnd)
      Tasks: 1 (limit: 4915)
     Memory: 1.1M (peak: 1.7M)
        CPU: 24ms
     CGroup: /system.slice/connman-vpn.service
             =E2=94=94=E2=94=801176 /usr/bin/connman-vpnd -n

janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
type 65534 <NONE>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 144 <DOWN=
>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
operstate 2 <DOWN>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
98513 <UP,RUNNING,LOWER_UP>
janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
operstate 0 <UNKNOWN>
janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit reache=
d
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags 32912 <DO=
WN>
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
operstate 2 <DOWN>
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
operstate 2 <DOWN>
janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6

There was a question about a reverse patch for the iptable. Does I
have missed it

Best regards

Daniel


Le sam. 25 janv. 2025 =C3=A0 11:46, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
>
> Hi Jussi  Grant Christian and Gabiel
>
> I have installed first the Gabriel patch and tested but my vpn
> connexion drops after 5 seconds and finally hangs the wifi connexion
>
> I have continued by installing the eleven and twelves jussi patches
> but my compilation failed with the first patch 11-1
>
>  =3D=3D=3D=3D=3D=3D=3D> name: connman
> =3D=3D=3D=3D=3D=3D=3D> version: 1.43
> =3D=3D=3D=3D=3D=3D=3D> release: 9
> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman1737741659x86_64.cards.tar.xz alre=
ady exist
> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.man1737741659any.cards.tar.xz alr=
eady exist
> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.devel1737741659any.cards.tar.xz a=
lready exist
> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.sources1737741659any.cards.tar.xz=
 already exist
> =3D=3D=3D=3D=3D=3D=3D> Building starting...
> cp allow_group_network.diff /tmp/work/src
> cp vpn6.patch /tmp/work/src
> cp vpn-11-1.patch /tmp/work/src
> cp vpn-11-2.patch /tmp/work/src
> cp vpn-11-3.patch /tmp/work/src
> cp vpn-11-4.patch /tmp/work/src
> cp vpn-11-5.patch /tmp/work/src
> cp vpn-11-6.patch /tmp/work/src
> cp vpn-11-7.patch /tmp/work/src
> cp vpn-11-8.patch /tmp/work/src
> cp vpn-11-9.patch /tmp/work/src
> cp vpn-11-10.patch /tmp/work/src
> cp vpn-11-11.patch /tmp/work/src
> cp vpn-12-1.patch /tmp/work/src
> cp vpn-12-2.patch /tmp/work/src
> cp vpn-12-3.patch /tmp/work/src
> cp vpn-12-4.patch /tmp/work/src
> cp vpn-12-5.patch /tmp/work/src
> cp vpn-12-6.patch /tmp/work/src
> cp vpn-12-7.patch /tmp/work/src
> cp vpn-12-8.patch /tmp/work/src
> cp vpn-12-9.patch /tmp/work/src
> cp vpn-12-10.patch /tmp/work/src
> cp vpn-12-11.patch /tmp/work/src
> cp vpn-12-12.patch /tmp/work/src
> + prepare
> + git clone https://git.kernel.org/pub/scm/network/connman/connman.git
> connman-1.43
> Cloning into 'connman-1.43'...
> remote: Enumerating objects: 41151, done.
> remote: Total 41151 (delta 0), reused 0 (delta 0), pack-reused 41151
> Receiving objects: 100% (41151/41151), 6.41 MiB | 1.64 MiB/s, done.
> Resolving deltas: 100% (31525/31525), done.
> + cd connman-1.43
> + git checkout 263e151fcfb09134dcf17a4147355b0ee9a5eb66
> Note: switching to '263e151fcfb09134dcf17a4147355b0ee9a5eb66'.
>
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by switching back to a branch.
>
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -c with the switch command. Example:
>
>   git switch -c <new-branch-name>
>
> Or undo this operation with:
>
>   git switch -
>
> Turn off this advice by setting config variable advice.detachedHead to fa=
lse
>
> HEAD is now at 263e151f treewide: Fix typo in ARPHRD_PHONET_PIPE
> + patch -Np1 -i /tmp/work/src/allow_group_network.diff
> patching file src/connman-polkit.conf
> Hunk #1 succeeded at 7 with fuzz 2 (offset 2 lines).
> + patch -Np1 -i /tmp/work/src/vpn6.patch
> patching file src/gateway.c
> + patch -Np1 -i /tmp/work/src/vpn-11-1.patch
> patching file src/agent.c
> Hunk #1 FAILED at 201.
> 1 out of 1 hunk FAILED -- saving rejects to file src/agent.c.rej
> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building 'connman.sources1737741659any.card=
s.tar.xz' failed.
>
> I have copy the patches from the e-mail , may be it introduce false
> characters  or must i copy them from the dev list
>
> Best regards
>
> Daniel
>
>
> Le ven. 24 janv. 2025 =C3=A0 20:03, Jussi Laakkonen
> <jussi.laakkonen@jolla.com> a =C3=A9crit :
> >
> > Hi Christian,
> >
> > Actually, that commit is in upstream.
> > https://git.kernel.org/pub/scm/network/connman/connman.git/log/vpn/plug=
ins/wireguard.c
> > - the date on the cherry-picked commits is the date of cherry picking (=
I
> > guess I missed some option while doing this..) but the original commit
> > is there submitted on 2020-07-31.
> >
> > I also pushed the association state and most of the wireguard fixes I'v=
e
> > done to the mailing list. Have fun testing and tell me if it works
> > better, we can always improve it if something is still missing. There
> > are few commits I held back as they could be the next patch set, becaus=
e
> > support for IPv4 and IPv6 addresses, and the route adding fixes are als=
o
> > quite large changes.
> >
> > BR,
> >   - Jussi
> >
> >
> >
> > On 1/23/25 13:35, Christian Hewitt wrote:
> > > Looking here: https://git.kernel.org/pub/scm/network/connman/connman.=
git/log/ I=E2=80=99m not finding "wireguard: Regular reresolve endpoint add=
ress=E2=80=9D and the first page of log goes back to December =E2=80=9923. =
Are we using the wrong upstream?
> > >
> > > Christian
> > >
> > >> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen <jussi.laakkonen=
@jolla.com> wrote:
> > >>
> > >> Hi Christian,
> > >>
> > >> That is actually in upstream, all the commits regarding WireGuard be=
fore July 10, 2024 are taken from the latest upstream and the changes after=
 that are new features.
> > >>
> > >> Well, the vpn.c changes do depend on having the ASSOCIATION state al=
so for VPNs to be implemented, that was proposed in the RFC https://lore.ke=
rnel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced=
39d72dd424884fe105a66fea02a83c708f97 as the state transitions depend on tha=
t bit. But it does not seem to be depending on the gateway.c/connection.c. =
Well, I can try to squeeze time to address the issues Daniel earlier raised=
 on that RFC and push them to upstream, then make a big change on the vpn.c=
 and wireguard.c.
> > >>
> > >> Br,
> > >> Jussi
> > >>
> > >>
> > >> On 1/23/25 13:12, Christian Hewitt wrote:
> > >>> You don't often get email from christianshewitt@gmail.com. Learn wh=
y this is important<https://aka.ms/LearnAboutSenderIdentification>
> > >>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s resolv=
ing to dynamic IP=E2=80=99s upstreamed so this looks interesting:
> > >>> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d=
703f972b866fdbd8bd
> > >>> Is that feature dependent on any other changes? (being lazy.. I did=
n=E2=80=99t read all the commits in that branch yet!).
> > >>> Christian
> > >>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen <jussi.laakkone=
n@jolla.com> wrote:
> > >>> Hello,
> > >>> Regarding WireGuard, I had to make a bunch of changes to the latest=
 version of it to get it running properly on our fork (yes, we upgrade it s=
lowly, now 1.38): https://github.com/sailfishos/connman/commits/master/conn=
man/vpn
> > >>> But I haven't had time to figure out all that is needed for upstrea=
m to be sent first, like this RFC edit that was forgotten because of... "ea=
stern winds blowing into our direction": https://lore.kernel.org/connman/20=
221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a=
66fea02a83c708f97
> > >>> And then the connection.c was modified a lot (and renamed) and I'm =
not sure if these will work on top of that anymore. Mostly because we have =
features that may not have been compatible with latest upstream, like addin=
g a support  for two different devices to be belonging into one service to =
facilitate CLAT support https://github.com/sailfishos/connman/commits/maste=
r/connman/src/connection.c etc. etc. etc.
> > >>> At some point I'll start pushing changes but not sure when I have t=
ime. Mostly they could be RFCs as the changes are big.
> > >>> BR,
> > >>> Jussi
> > >>> On 1/23/25 12:45, daniel antoine wrote:
> > >>> Hi
> > >>> I have opened a ticket for connman-vpn not working with wireguard  =
in
> > >>> April 2024. If you give me the patches I can test them
> > >>> Best regards
> > >>> Daniel
> > >>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
> > >>> <gerickson@nuovations.com> a =C3=A9crit :
> > >>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches <gabriel.sanch=
es@prevas.dk> wrote:
> > >>> I was testing connman's wireguard plugin and got a segmentation fau=
lt.
> > >>> Looking at the backtrace revealed that there are some typos in the =
`src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variabl=
es instead of ipv6 regarding vpn.
> > >>> I simply changed them to ipv6 and got it working.
> > >>> not related to the patch:
> > >>> I had to manually add ip route so the other devices could be pinged
> > >>> The plugin adds routes for the WireGuard.DNS configuration setting
> > >>> # ip route
> > >>> 1.1.1.1 dev wg0 scope link
> > >>> 8.8.8.8 dev wg0 scope link
> > >>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
> > >>> 10.42.0.1 dev end1 scope link
> > >>> <vpn host ip> via 10.42.0.1 dev end1
> > >>> the missing route added manually:
> > >>> ip route add 10.33.0.0/16 dev wg0 scope link
> > >>> an equivalent wireguard file adds it properly (using wg-quick)
> > >>> Is the plugin lacking some implementation?
> > >>> ---
> > >>> src/gateway.c | 6 +++---
> > >>> 1 file changed, 3 insertions(+), 3 deletions(-)
> > >>> diff --git a/src/gateway.c b/src/gateway.c
> > >>> index 16c87f83..b2c211e2 100644
> > >>> --- a/src/gateway.c
> > >>> +++ b/src/gateway.c
> > >>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_se=
rvice *service,
> > >>>                                        is_gateway_config_vpn(
> > >>>                                                new_gateway->ipv4_co=
nfig);
> > >>> -             is_vpn6 =3D do_ipv4 &&
> > >>> -                                     new_gateway->ipv4_config &&
> > >>> +             is_vpn6 =3D do_ipv6 &&
> > >>> +                                     new_gateway->ipv6_config &&
> > >>>                                        is_gateway_config_vpn(
> > >>> -                                             new_gateway->ipv4_con=
fig);
> > >>> +                                             new_gateway->ipv6_con=
fig);
> > >>>        } else {
> > >>>                if (do_ipv4 && new_gateway->ipv4_config)
> > >>> --
> > >>> 2.43.0
> > >>> Gabriel,
> > >>> Great catch on this copy-and-paste typo; thank you!
> > >>> Best,
> > >>> Grant
> > >>
> > >
> >
> >
