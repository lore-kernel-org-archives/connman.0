Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D176AD52
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 50082CECEB;
	Tue,  7 Nov 2023 16:31:15 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Address -Werror=unused-but-set-parameter compilation
 errors.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <28C6849C-16CE-4125-8FA9-B1F2CA52D733@nuovations.com>
Date: Tue, 7 Nov 2023 16:31:04 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <F8A909F9-B7ED-4539-A432-E1BFBA59D4A4@holtmann.org>
References: <28C6849C-16CE-4125-8FA9-B1F2CA52D733@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This addresses -Werror=unused-but-set-parameter compilation errors
> surfaced by GCC when --enable-maintainer-mode is asserted.
> ---
> unit/test-iptables.c | 8 --------
> 1 file changed, 8 deletions(-)

patch has been applied.

Regards

Marcel

