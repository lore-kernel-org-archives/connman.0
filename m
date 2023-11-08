Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427E1798A
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AA35E730EE;
	Wed,  8 Nov 2023 11:46:09 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74] (unknown [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5BD1E731EF;
	Wed,  8 Nov 2023 11:46:09 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/2 v2] service: Add documentation to proxy-related
 functions.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <C517B845-D840-4A21-8B2F-5898F4104D7A@holtmann.org>
Date: Wed, 8 Nov 2023 08:46:09 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B2C9799-31F5-423B-B94F-482A7565FB82@nuovations.com>
References: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
 <B5EF6141-E568-42FF-80CD-B010B5ABA14C@nuovations.com>
 <142A53C6-7DB5-49AA-8B7C-763412123A9D@nuovations.com>
 <C517B845-D840-4A21-8B2F-5898F4104D7A@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 8, 2023, at 6:36 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Grant,
>=20
>> Add documentation to the proxy-related functions, 'check_proxy_setup'
>> and '__connman_service_set_proxy_method'.
>> ---
>> src/service.c | 41 +++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 41 insertions(+)
>=20
> sorry, but still doesn=E2=80=99t apply cleanly.

Re-submitted as v3 with "[PATCH 2/2 v3] service: Add documentation to =
proxy-related functions.=E2=80=9D.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

