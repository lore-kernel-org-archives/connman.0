Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F336B14
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id BFCCCCECD4;
	Wed,  8 Nov 2023 19:34:29 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 2/3 v3] gweb: Refactor 'parse_request_and_proxy_urls'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a4e95ca1-61e0-40ee-a1dc-7d170075bc1a@gmail.com>
Date: Wed, 8 Nov 2023 19:34:19 +0100
Cc: Grant Erickson <gerickson@nuovations.com>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B81EE347-C1BC-42EF-9414-22400C9DB8B4@holtmann.org>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <538FAB81-E180-4D6D-B405-150F8553F843@nuovations.com>
 <6cb6beb7-73f1-4743-bff6-f822ae282786@gmail.com>
 <FBB34102-662F-49AC-A11F-7E92A455C5D9@nuovations.com>
 <a4e95ca1-61e0-40ee-a1dc-7d170075bc1a@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Denis,

>>>=20
>>> Looks like you're running over > 80 chars here.
>> checkpatch.pl warns at 100 though the coding style docs mention 80. =
Which takes precedence?
>=20
> I think the Linux kernel changed to 100 lines by default some time in =
the last two years.  Don't remember exactly.  We are still using 80 by =
inertia.
>=20
> I'm fine switching to > 80 lines, but lets have a separate discussion =
about this.

I prefer we stick with the 80 chars per line. We don=E2=80=99t have to =
be super strict about it and can let it slide every now and then. =
However I really prefer that if you hit 80 chars per line, then you take =
a step back check if your code is too complex or your function or =
variables are to long.

We need this 80 chars marker as a mental checkpoint for everybody to =
simplify their code and make the logic understandable even you get back =
to it years later.

Regards

Marcel

