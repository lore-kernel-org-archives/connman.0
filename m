Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E21DFC9
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 17AAACECD1;
	Wed, 29 Nov 2023 13:56:25 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] service: Const-qualify 'service' param in
 '*_nameserver_{add,del}_routes'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231128203504.1194193-1-gerickson@nuovations.com>
Date: Wed, 29 Nov 2023 13:56:14 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <E0DB7549-5C96-4270-9B15-0BC0B0B22C7D@holtmann.org>
References: <20231128203504.1194193-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> Const-qualify the network service arguments of
> '__connman_service_nameserver_{add,del}_routes' to make it clear to
> the compiler, static analyzers, and human readers that the functions
> have no network service mutation side effects.
> ---
> src/connman.h | 4 ++--
> src/service.c | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied.

Regards

Marcel

