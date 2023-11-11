Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A63125CA
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 6650FCED00;
	Sat, 11 Nov 2023 11:20:28 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/2] service: Refactor Out and Document Rescheduling an
 Online Check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <066A1AD2-8F82-49B6-BF0A-376CBE8243B4@nuovations.com>
Date: Sat, 11 Nov 2023 11:20:17 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <39D5EB4A-6F66-485C-9D79-A41522153335@holtmann.org>
References: <066A1AD2-8F82-49B6-BF0A-376CBE8243B4@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This patch series factors out and documents rescheduling an online =
check from
> =E2=80=98complete_online_check=E2=80=99 into 'reschedule_online_check' =
to make each discrete
> and individually and easily auditable.
>=20
> Grant Erickson (2):
>  service: Factor out rescheduling an online check.
>  service: Add documentation to 'reschedule_online_check'.
>=20
> src/service.c | 108 +++++++++++++++++++++++++++++++++++++-------------
> 1 file changed, 81 insertions(+), 27 deletions(-)

both patches have been applied.

Regards

Marcel

