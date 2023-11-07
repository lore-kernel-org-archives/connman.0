Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2A30D0B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 8B8B6CECEB;
	Tue,  7 Nov 2023 16:23:50 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Address scan-build warning in 'get_ipv6_privacy'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2CAC0923-E904-4671-8989-F06F9CAB6213@nuovations.com>
Date: Tue, 7 Nov 2023 16:23:40 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <1AF106AE-B4A4-4865-8652-CE06A4612FF2@holtmann.org>
References: <2CAC0923-E904-4671-8989-F06F9CAB6213@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This addresses an "undefined or garbage value
> returned to caller [core.uninitialized.UndefReturn]"
> warning in 'get_ipv6_privacy' identified by clang/LLVM
> scan-build-11.
> ---
> src/ipconfig.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)

patch has been applied.

Regards

Marcel

