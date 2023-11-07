Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53D930D0B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id CD943CECEB;
	Tue,  7 Nov 2023 16:25:47 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Const-qualify 'gchar *' arguments in ipconfig 
 getters/setters.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <F9F0D72A-3FF6-4045-B847-EA891BC4E0A8@nuovations.com>
Date: Tue, 7 Nov 2023 16:25:37 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <CD210C2E-65BC-49EA-BEC6-90DC2E39754C@holtmann.org>
References: <F9F0D72A-3FF6-4045-B847-EA891BC4E0A8@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Const-qualify the 'gchar *' arguments in ipconfig getter/setter
> functions to make it clear to the compiler, static analyzers,
> and human readers that there are no mutation side effects with
> such arguments.
> ---
> src/ipconfig.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch does not apply cleanly using git am.

Regards

Marcel

