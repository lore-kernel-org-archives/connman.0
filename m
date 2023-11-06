Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327E2EAFC
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DBF717316C
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:07:16 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A88237321A
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:07:16 -0500 (EST)
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
Subject: [PATCH 0/3] service: Change and leverage downgrade function return
 signature.
Message-Id: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
Date: Mon, 6 Nov 2023 14:07:15 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch series adds the function =
=E2=80=98service_ipconfig_downgrade_online_state' which attempts to =
downgrade the specified IP configuration state of the specified service =
to ready if it is online.

In addition, it leverages =E2=80=98service_ipconfig_downgrade_online_state=
' by reimplementing 'service_downgrade_online_state=E2=80=99 and
=E2=80=98service_downgrade_online_state_if_default' against it.

The return signatures of =E2=80=98service_downgrade_online_state' and =
=E2=80=98service_downgrade_online_state_if_default' are changed from =
=E2=80=98void' to
=E2=80=98bool' to allow callers to know, without additional sideband =
checks, whether service state was downgraded.

Finally, this newly-changed =E2=80=98bool' return status of =
=E2=80=98service_downgrade_online_state' in =E2=80=98complete_online_check=
' is leveraged to avoid polling service state before and after the call =
to =E2=80=98service_downgrade_online_state' to determine whether to take =
downgrade-specific action.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

