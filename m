Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A13158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 1B062CECEE;
	Tue,  7 Nov 2023 19:57:48 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/2] service: Add Debug and Documentation to Proxy-related
 Functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
Date: Tue, 7 Nov 2023 19:57:37 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E514ADB-AF0C-4140-BAA1-76FB0CFE039D@holtmann.org>
References: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series adds =E2=80=98DBG' statements and function =
documentation to service proxy-related functions to aid in debugging.
>=20
> In a multi-technology environment with =
"EnableOnlineToReadyTransition=E2=80=9D asserted, there seem to be times =
where WISPr =E2=80=9Conline=E2=80=9D checks =E2=80=9Cfall down a hole=E2=80=
=9D due to proxy method initialization. These additions have proven =
helpful in tracking down the issues.

I applied patch 1/2, but 2/2 didn=E2=80=99t apply cleanly.

Regards

Marcel

