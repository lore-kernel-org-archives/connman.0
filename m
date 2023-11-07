Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA83158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 918A8CECEE;
	Tue,  7 Nov 2023 20:06:00 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/3] service: Change and leverage downgrade function
 return signature.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
Date: Tue, 7 Nov 2023 20:05:50 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D5675A8-B93C-42BC-A04B-69044C07B74E@holtmann.org>
References: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series adds the function =
=E2=80=98service_ipconfig_downgrade_online_state' which attempts to =
downgrade the specified IP configuration state of the specified service =
to ready if it is online.
>=20
> In addition, it leverages =E2=80=98service_ipconfig_downgrade_online_sta=
te' by reimplementing 'service_downgrade_online_state=E2=80=99 and
> =E2=80=98service_downgrade_online_state_if_default' against it.
>=20
> The return signatures of =E2=80=98service_downgrade_online_state' and =
=E2=80=98service_downgrade_online_state_if_default' are changed from =
=E2=80=98void' to
> =E2=80=98bool' to allow callers to know, without additional sideband =
checks, whether service state was downgraded.
>=20
> Finally, this newly-changed =E2=80=98bool' return status of =
=E2=80=98service_downgrade_online_state' in =E2=80=98complete_online_check=
' is leveraged to avoid polling service state before and after the call =
to =E2=80=98service_downgrade_online_state' to determine whether to take =
downgrade-specific action.

all 3 patches have been applied.

Regards

Marcel

