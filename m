Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F393DF72
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id B97C0CECEB;
	Tue,  7 Nov 2023 16:13:43 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Const-qualify 'connman_{network,provider}_get_index'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <F5EB01CB-FAAC-4370-A256-D3920ABFF56C@nuovations.com>
Date: Tue, 7 Nov 2023 16:13:33 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <03872073-F4C5-48E1-9640-CF80B22C0EBB@holtmann.org>
References: <F5EB01CB-FAAC-4370-A256-D3920ABFF56C@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Const-qualify the network and provider arguments to make it clear to
> the compiler, static analyzers, and human readers that the function
> is strictly a getter with no network or provider mutation side effects.
> 
> ---
> include/network.h  | 2 +-
> include/provider.h | 2 +-
> src/network.c      | 2 +-
> src/provider.c     | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied.

Regards

Marcel

