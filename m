Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477130D0B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 37CB1CECEB;
	Tue,  7 Nov 2023 16:22:53 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Address scan-build warning in 'get_ipv6_state'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAFEDF00-18C4-4712-807A-370425E6A110@nuovations.com>
Date: Tue, 7 Nov 2023 16:22:43 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <B941F0B5-E343-44FF-8E8D-49C020217BB3@holtmann.org>
References: <CAFEDF00-18C4-4712-807A-370425E6A110@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This addresses an "assigned value is garbage or undefined
> [core.uninitialized.Assign]" warning in 'get_ipv6_state'
> identified by clang/LLVM scan-build-11.
> ---
> src/ipconfig.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

