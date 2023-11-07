Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530230D1E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id ADE98CECEB;
	Tue,  7 Nov 2023 17:00:10 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Add a callback parameter to '__connman_wispr_start'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <F050F2F9-BFBF-4590-9B91-1115E276F4B1@nuovations.com>
Date: Tue, 7 Nov 2023 17:00:00 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <D4741E6F-13FC-4CCC-8E9D-BF7F732F8F92@holtmann.org>
References: <CF970CC5-5AF5-4680-81C1-EB58F8FF44CC@nuovations.com>
 <F050F2F9-BFBF-4590-9B91-1115E276F4B1@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This callback provides two benefits.
> 
> The first is making static the implementation of the WISPr closure
> function defined in src/service.c.
> 
> The second is that it will make easier closing several failure path
> "holes" that currently do not properly "bookend" requests to
> '__connman_wispr_start' by making the closure of those holes
> independent of the function providing the closure.
> ---
> src/connman.h | 10 ++++++----
> src/service.c |  9 ++++++---
> src/wispr.c   | 16 +++++++++-------
> 3 files changed, 21 insertions(+), 14 deletions(-)

patch has been applied.

Regards

Marcel

