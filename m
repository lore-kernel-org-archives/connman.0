Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC22C872
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 6BA69CECEB;
	Tue,  7 Nov 2023 16:32:33 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Address -Werror=implicit-fallthrough compilation errors.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <B77C1AEA-B348-4E93-BF9D-DBD10518C0F8@nuovations.com>
Date: Tue, 7 Nov 2023 16:32:22 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <50191017-78F7-4A8F-927D-C240DA2AC8BD@holtmann.org>
References: <B77C1AEA-B348-4E93-BF9D-DBD10518C0F8@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This addresses -Werror=implicit-fallthrough compilation errors
> surfaced by GCC when --enable-maintainer-mode is asserted
> by using an explicit connman_iptables_entry_is_valid function
> rather than a copied-and-pasted switch statement with the
> inherent implicit fall through behavior.
> 
> ---
> src/iptables.c | 47 ++++++++++++++++-------------------------------
> 1 file changed, 16 insertions(+), 31 deletions(-)

patch has been applied.

Regards

Marcel

