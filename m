Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D817C6
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9D9B873189
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:48:57 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 67454731F8
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:48:57 -0400 (EDT)
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
Subject: [PATCH 0/2] Rename and Document 'switch_default_service'
Message-Id: <37EFB709-B379-4AE2-85F6-0D74564EF4C8@nuovations.com>
Date: Thu, 2 Nov 2023 17:48:56 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch patch series renames and documents the =
=E2=80=98switch_default_service' function.

The function =E2=80=98switch_default_service' is used in two contexts:

  1. =46rom =E2=80=98__connman_service_move', which may be called from =
either the public D-Bus
      =E2=80=9CMoveAfter" or =E2=80=9CMoveBefore" method requests or =
from =E2=80=98connman_provider_set_split_routing' in "src/provider.c".
  2. =46rom =E2=80=98service_update_preferred_order' in which the first =
argument is guaranteed to the default service.

In the D-Bus =E2=80=9CMoveAfter" or =E2=80=9CMoveBefore" contexts, the =
=E2=80=98switch_default_service' is a misnomer since neither
service argument, in particular the first, is guaranteed to be the =
default service. Consequently,
=E2=80=98switch_default_service' is renamed to the more neutral =
=E2=80=98switch_service_order' to reflect its varied usage in the
above contexts.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

