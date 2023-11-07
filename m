Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD32D02E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 82CCDCECEE;
	Tue,  7 Nov 2023 19:51:18 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/2] Add and Leverage Service Default Introspection
 Function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6FD25675-87BF-4532-A9C9-49E606AC65C5@nuovations.com>
Date: Tue, 7 Nov 2023 19:51:08 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AB85D5F-43BB-4DAF-AA49-187240AF698F@holtmann.org>
References: <6FD25675-87BF-4532-A9C9-49E606AC65C5@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series adds an introspection function, =
connman_service_is_default to determine whether the specified service is =
the default service (that is, the service with the default route).
>=20
> In addition, this adds a DBG statement to switch_default_service which =
leverages this newly-added function since, in the fullness of time, =
neither of the service arguments are guaranteed to be the default =
service.

both patches have been applied.

Regards

Marcel

