Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2086EA0
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 62A36731D1
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 20:18:01 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 204D373207
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 20:18:01 -0500 (EST)
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
Subject: [PATCH 0/2] service: Refactor Out and Document Rescheduling an Online
 Check
Message-Id: <066A1AD2-8F82-49B6-BF0A-376CBE8243B4@nuovations.com>
Date: Thu, 9 Nov 2023 17:18:00 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch series factors out and documents rescheduling an online check =
from
=E2=80=98complete_online_check=E2=80=99 into 'reschedule_online_check' =
to make each discrete
and individually and easily auditable.

Grant Erickson (2):
  service: Factor out rescheduling an online check.
  service: Add documentation to 'reschedule_online_check'.

 src/service.c | 108 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 27 deletions(-)

--=20
2.42.0
