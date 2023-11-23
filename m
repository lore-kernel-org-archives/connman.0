Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EB22EFF
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id AE987CECFB;
	Thu, 23 Nov 2023 12:23:29 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] service: Const-qualify 'connman_service_get_interface'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231117211929.705335-1-gerickson@nuovations.com>
Date: Thu, 23 Nov 2023 12:23:19 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <C6981686-B659-4438-AD03-9A42D3B261F0@holtmann.org>
References: <20231117211929.705335-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> Const-qualify the network service argument to make it clear to the
> compiler, static analyzers, and human readers that the function is
> strictly a getter with no network service mutation side effects.
> ---
> include/service.h     | 2 +-
> src/service.c         | 2 +-
> tools/iptables-unit.c | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied.

Regards

Marcel

