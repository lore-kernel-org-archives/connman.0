Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001D2AB59
	for <connman@lists.linux.dev>; Mon, 16 Oct 2023 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6B23A7313F
	for <connman@lists.linux.dev>; Mon, 16 Oct 2023 11:46:45 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:1038:a890:925d:fc9b] (unknown [IPv6:2601:647:5a00:15c1:1038:a890:925d:fc9b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3184773162
	for <connman@lists.linux.dev>; Mon, 16 Oct 2023 11:46:45 -0400 (EDT)
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
Subject: Request for Comment: Implementing Non-link-level Failure Monitoring /
 Failover
Message-Id: <1B47C370-F3D5-4F60-9753-46D39CAB6728@nuovations.com>
Date: Mon, 16 Oct 2023 08:46:42 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Connman Community:

I spent most of Friday doing integration testing between connmand and my =
application infrastructure inflicting various communications failures =
and observing how the event chain responds.

Perhaps as no surprise to those here, connmand appears to only be =
responsive to local link failures. That is, with Ethernet, only a first =
hop link loss or cable pull at the device under test (DUT) seems to =
cause a failover to Wi-Fi. Likewise, with Wi-Fi, only a complete loss of =
association to the access point seems to cause a failover to Cellular.

So, for example, removing an Ethernet link several hops away from the =
DUT or from the Wi-Fi access point, inducing DNS failures, etc. do not =
seem to cause default service failovers. However, I can clearly see the =
WiSPR liveness probes failing with 4xx status=E2=80=94so the right =
signals seem to be present to induce failover.

If the community is supportive, I would propose some upstream =
changes=E2=80=94the precise details TBD=E2=80=94that:

    1. After some configurable number of WiSPR liveness probes failing =
on the currently =E2=80=9Conline=E2=80=9D link, connmand declares a =
service no longer =E2=80=9Conline=E2=80=9D.
        a. =E2=80=9Conline=E2=80=9D to =E2=80=9Cready=E2=80=9D does not =
=E2=80=9Cflap=E2=80=9D as it does now for the default service.
        b. Once it is =E2=80=9Conline=E2=80=9D, it stays =E2=80=9Conline=E2=
=80=9D until those configurable number of WiSPR liveness probes fail.
    2. In response to the configurable number of liveness problems, =
moves the default route to the next available service (for example, =
Wi-Fi or Cellular from Ethernet or Wi-Fi, respectively).
        a. For the =E2=80=9Cno longer =E2=80=98online=E2=80=99=E2=80=9D =
service, connmand would then go into TBD (Fibonacci?) back off for WiSPR =
probes and would promote the service back to default only when some =
configurable number of WiSPR liveness probes succeed.

Thoughts?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

