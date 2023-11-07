Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5031581
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 1C76ACECEB;
	Tue,  7 Nov 2023 16:29:23 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Address -Werror=old-style-declaration compilation errors.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BAA7A12F-BC05-41DE-A9F7-ABE3A2E6C9AD@nuovations.com>
Date: Tue, 7 Nov 2023 16:29:12 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <BC1EDBDB-C15E-4A24-89F1-760CAFF2468E@holtmann.org>
References: <BAA7A12F-BC05-41DE-A9F7-ABE3A2E6C9AD@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This addresses -Werror=old-style-declaration compilation errors surfaced
> by GCC when --enable-maintainer-mode is asserted.
> ---
> unit/test-iptables.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

