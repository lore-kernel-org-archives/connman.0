Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808B30D0B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 4F89FCECEB;
	Tue,  7 Nov 2023 16:20:41 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Address memory leak in
 '__connman_service_timeserver_remove'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BCE23F3F-84F5-4CAE-9F88-13A0FD4765D5@nuovations.com>
Date: Tue, 7 Nov 2023 16:20:31 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <84EF9024-35BB-4D9A-8110-9CE6E6DB7F92@holtmann.org>
References: <BCE23F3F-84F5-4CAE-9F88-13A0FD4765D5@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This addresses a potential memory leak of memory pointed to by 'servers'
> identifed by clang/LLVM scan-build-11.
> ---
> src/service.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

