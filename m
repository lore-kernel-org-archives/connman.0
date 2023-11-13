Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1822F09
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B51E3730EE
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 13:38:29 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:c8d5:962d:86fc:6954] (unknown [IPv6:2601:647:5a00:15c1:c8d5:962d:86fc:6954])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 807F8730FE
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 13:38:29 -0500 (EST)
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
Subject: When 'EnableOnlineCheck' Is Asserted Two Recurring IPv4 and One IPv6
 Reachability Checks Get Scheduled
Message-Id: <5B0B6864-28B9-4891-B30A-6024F9D8CED8@nuovations.com>
Date: Mon, 13 Nov 2023 10:38:28 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

ConnMan Community:

The latest issue I am jumping into in top-of-tree now that the two =
heap-use-after-free issues have been
addressed is "When 'EnableOnlineCheck' Is Asserted Two (2) Recurring =
IPv4 and One (1) IPv6
Reachability Checks Get Scheduled=E2=80=9D rather than one of each. Feel =
free to track progress here:

    https://github.com/Nuovations/connman/issues/74

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

