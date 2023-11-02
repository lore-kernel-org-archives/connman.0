Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926715D2
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 957A073197
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 22:45:49 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5AAFB7332E
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 22:45:49 -0400 (EDT)
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
Subject: [PATCH 0/6] Fix Segfault from Time Services on Service Removal
Message-Id: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Date: Wed, 1 Nov 2023 19:45:48 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch series fixes a heap-use-after-free fault in =
connman_service_get_nameservers on service removal by:

  1. Qualifying the call to =E2=80=98__connman_timeserver_sync' in =
=E2=80=98__connman_service_ipconfig_indicate_state' with a =
=E2=80=98is_connected' conditional.
  2. Converting the semantics of the ts_service private global in =
src/timeservice.c from a weak reference (that is, it uses simple =
assignment) to a strong reference (that is, it uses =
'connman_service_{ref,unref}=E2=80=99 plus assignment).

Best,

Grant Erickson

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

