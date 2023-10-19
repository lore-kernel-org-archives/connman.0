Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0764396
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A783B73225;
	Wed, 18 Oct 2023 23:00:36 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:7c62:ced4:eab6:4bac] (unknown [IPv6:2601:647:5a00:15c1:7c62:ced4:eab6:4bac])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5AC24732C1;
	Wed, 18 Oct 2023 23:00:36 -0400 (EDT)
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
Subject: Update on Chasing Down a Crash in connman_service_get_nameservers on
 Cellular Service Removal
Message-Id: <E50A909D-122E-4D14-A330-868A8EF9997F@nuovations.com>
Date: Wed, 18 Oct 2023 20:00:35 -0700
Cc: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Connman Community:

I know some of you (Denis, I believe from git log history) are working =
on clang static and dynamic analysis for connman.

To the extent it helps, I have been chasing down an issue in top-of-tree =
(53964711baee916ae163e64d5229e3822935e100) in which when Quectel / =
Nimblelink QMI cellular goes away on my system, I get a connman signal =
11 abort. Unfortunately, there is no backtrace in this case since n_ptrs =
(0) is less than offset (2) in the print_backtrace call.

Today, doing some other development and debug work, I was able to narrow =
down the downstream cause of the abort. It seems that things are =
crashing somewhere within =
src/service.c:connman_service_get_nameservers().

When name servers are established for the cellular service from the =
provider, there end up being two (2) name servers. The core problem =
seems to be that g_strv_length(service->nameservers) incorrectly returns =
7 (it really only has two (2)) which results in:

		for (i =3D 0; i < len; i++)
			nameservers[i] =3D =
g_strdup(service->nameservers[i]);

attempting to copy strings that do not exist past the end of the actual =
bounds of service->nameservers. So, it would seem that at some point, =
service->nameservers becomes corrupt with its terminating null getting =
overwritten by something else. I=E2=80=99ve get to zero in on the nature =
of =E2=80=9Cgetting overwritten by something else=E2=80=9D.

I also periodically get this in the output after an abort:

    malloc(): smallbin double linked list corrupted

I am also able to cause the abort, nearly on demand with near 100% =
reproducibility, by issuing =E2=80=98connmanctl disable cellular=E2=80=99.=


More as I learn and discover it.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

