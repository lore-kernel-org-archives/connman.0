Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C61366
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 9376CCECD0;
	Wed,  8 Nov 2023 15:36:00 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Const-qualify 'service' arguments in name and time
 server  getters.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D9B864AE-58A6-4384-8FA1-60F2B28B29F0@nuovations.com>
Date: Wed, 8 Nov 2023 15:35:49 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <687E4CB8-AF16-43A0-B51A-CD9EA27C0896@holtmann.org>
References: <70D6ACF5-703E-48D2-841A-24E63F889D9E@nuovations.com>
 <D9B864AE-58A6-4384-8FA1-60F2B28B29F0@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Const-qualify the 'service' arguments in name and time server getter
> functions to make it clear to the compiler, static analyzers,
> and human readers that there are no mutation side effects with
> such arguments and that the returned results are immutable and must
> be copied if mutation is desired.
> ---
> include/service.h |  6 +++---
> src/connman.h     |  2 +-
> src/service.c     | 10 +++++-----
> src/timeserver.c  | 14 +++++++-------
> 4 files changed, 16 insertions(+), 16 deletions(-)

patch has been applied.

Regards

Marcel

