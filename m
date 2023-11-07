Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFEDF72
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id BB412CECEB;
	Tue,  7 Nov 2023 16:12:25 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Const-qualify 'connman_ipconfig_get_index'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <486CCD85-633C-4362-9EF0-D429B88792E9@nuovations.com>
Date: Tue, 7 Nov 2023 16:12:15 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <C92DC1D9-B532-45FE-8941-2798ADA74072@holtmann.org>
References: <486CCD85-633C-4362-9EF0-D429B88792E9@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Const-qualify the network service argument to make it clear to the
> compiler, static analyzers, and human readers that the function is
> strictly a getter with no network mutation side effects.
> 
> ---
> src/connman.h  | 2 +-
> src/ipconfig.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

