Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B467C8FD
	for <connman@lists.linux.dev>; Wed, 11 Oct 2023 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 070C07328C
	for <connman@lists.linux.dev>; Tue, 10 Oct 2023 23:37:36 -0400 (EDT)
Received: from [IPv6:2601:647:5a83:8c51:bc21:9cd0:a8d0:7ba9] (unknown [IPv6:2601:647:5a83:8c51:bc21:9cd0:a8d0:7ba9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C00E1732E7
	for <connman@lists.linux.dev>; Tue, 10 Oct 2023 23:37:35 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Clarifying ConnMan Configuration Multi-technology Feature Fusion and
 Online/Ready Transitions
Message-Id: <2CD24062-D2D6-4E13-A6A9-7EA130D38131@nuovations.com>
Date: Tue, 10 Oct 2023 20:37:34 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

I am working with connman at commit 24180d1243bf on a system with =
Ethernet, Wi-Fi, and Cellular with the following configuration:

    [General]
    AllowDomainnameUpdates=3Dfalse
    AllowHostnameUpdates=3Dfalse
    AlwaysConnectedTechnologies=3Dethernet,wifi,cellular
    BackgroundScanning=3Dtrue
    DefaultAutoConnectTechnologies=3Dethernet,wifi,cellular
    EnableOnlineCheck=3Dtrue
    EnableOnlineToReadyTransition=3Dtrue
    =
FallbackTimeservers=3D0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.=
ntp.org
    FallbackNameservers=3D8.8.8.8,8.8.4.4
    PreferredTechnologies=3Dethernet,wifi,cellular
    SingleConnectedTechnology=3Dfalse
    TetheringTechnologies=3D

I=E2=80=99ve pored over connman.conf.5 a number of times now and =
acknowledge that =E2=80=98EnableOnlineToReadyTransition=E2=80=99 is =
marked experimental; however, I am trying to understand how the above =
configuration is supposed to work relative to my understanding of how I =
believe it should work relative to how it documented in connman.conf.5.

What I see happening is that net.connman.Manager.State is frequently =
flipping between =E2=80=9CReady=E2=80=9D and =E2=80=9COnline=E2=80=9D =
(on the order of seconds) and that a majority of the time, none of the =
connected services associated with the above three technologies is ever =
=E2=80=9COnline=E2=80=9D, just =E2=80=9CReady=E2=80=9D.

My expectation is that Ethernet would be marked =E2=80=9COnline=E2=80=9D =
and steadily stay there until such time as there is a failure of some =
sort for that technology, at which time I=E2=80=99d expected =E2=80=9CWi-F=
i=E2=80=9D to then get promoted to =E2=80=9COnline=E2=80=9D if possible =
and, failing that, =E2=80=9CCellular=E2=80=9D promoted to =E2=80=9COnline=E2=
=80=9D.

Am I misunderstanding and/or misconfiguring things relative to my =
assumptions?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

