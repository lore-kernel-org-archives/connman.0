Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AB1AD52
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 056A9CECEB;
	Tue,  7 Nov 2023 17:05:54 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Const-qualify service comparison functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <EBAC877C-BD4C-46DD-A58F-452AC8CBEF7B@nuovations.com>
Date: Tue, 7 Nov 2023 17:05:44 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <8E458B44-C9D9-4B6A-8492-DF447A749AB7@holtmann.org>
References: <EBAC877C-BD4C-46DD-A58F-452AC8CBEF7B@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Const-qualify the network service arguments in service comparison
> functions to make it clear to the compiler, static analyzers, and
> human readers that the functions are strictly observers of service
> state with no network service mutation side effects.
> ---
> src/service.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

patch has been applied.

Regards

Marcel

