Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB32A1AE
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 1629BCECD0;
	Wed,  8 Nov 2023 15:37:04 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 2/2 v2] service: Add documentation to proxy-related
 functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <142A53C6-7DB5-49AA-8B7C-763412123A9D@nuovations.com>
Date: Wed, 8 Nov 2023 15:36:53 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C517B845-D840-4A21-8B2F-5898F4104D7A@holtmann.org>
References: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
 <B5EF6141-E568-42FF-80CD-B010B5ABA14C@nuovations.com>
 <142A53C6-7DB5-49AA-8B7C-763412123A9D@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Add documentation to the proxy-related functions, 'check_proxy_setup'
> and '__connman_service_set_proxy_method'.
> ---
> src/service.c | 41 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

sorry, but still doesn=E2=80=99t apply cleanly.

Regards

Marcel

