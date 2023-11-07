Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EAA3158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id D94C4CECEE;
	Tue,  7 Nov 2023 20:04:22 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/2] Document and rename 'portal_manage_status'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <184BE851-F653-4B6B-B5DF-DE548DD62F3E@nuovations.com>
Date: Tue, 7 Nov 2023 20:04:12 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F982789-0CF5-4CCF-9585-A40FAC22DC8D@holtmann.org>
References: <184BE851-F653-4B6B-B5DF-DE548DD62F3E@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series documents and renames =E2=80=98portal_manage_status'.
>=20
> The function is renamed from =E2=80=98portal_manage_status' to =
=E2=80=98portal_manage_success_status' as it exclusively handles HTTP =
200 "OK" success status and no others.

both patches have been applied.

Regards

Marcel

