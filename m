Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520303158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id F0F99CECEE;
	Tue,  7 Nov 2023 19:59:10 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/3] service: Rename and Document Service State
 Downgrade-related Functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
Date: Tue, 7 Nov 2023 19:59:00 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <03DBE79A-33EF-4462-A081-2F6529599C05@holtmann.org>
References: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series renames and documents two service state =
downgrade-related functions:
>=20
>    * downgrade_state
>    * apply_relevant_default_downgrade
>=20
> These are renamed such that their names more clearly align with their =
role and action and that there is a consistent nomenclature for related =
functions.
>=20
> Service state downgrade becomes an important action in a =
multi-technology environment with "EnableOnlineToReadyTransition" =
asserted.

all 3 patches have been applied.

Regards

Marcel

