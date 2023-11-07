Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3B2C872
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id B3662CECEB;
	Tue,  7 Nov 2023 16:39:11 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/6] Fix Segfault from Time Services on Service Removal
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Date: Tue, 7 Nov 2023 16:39:01 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2DF90DC-0FE3-4A8F-913B-EC42BACC9B1F@holtmann.org>
References: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series fixes a heap-use-after-free fault in =
connman_service_get_nameservers on service removal by:
>=20
>  1. Qualifying the call to =E2=80=98__connman_timeserver_sync' in =
=E2=80=98__connman_service_ipconfig_indicate_state' with a =
=E2=80=98is_connected' conditional.
>  2. Converting the semantics of the ts_service private global in =
src/timeservice.c from a weak reference (that is, it uses simple =
assignment) to a strong reference (that is, it uses =
'connman_service_{ref,unref}=E2=80=99 plus assignment).

all 6 patches have been applied.

Regards

Marcel

