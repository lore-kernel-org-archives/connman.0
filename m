Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64DDF72
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 8FBB7CECEC;
	Tue,  7 Nov 2023 16:14:48 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Rename 'start_wispr_when_connected'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D769C836-3C52-4615-A17A-8CACAD0B0AE3@nuovations.com>
Date: Tue, 7 Nov 2023 16:14:38 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A28E71A2-D35D-4339-96B2-A3628D1F093B@holtmann.org>
References: <D769C836-3C52-4615-A17A-8CACAD0B0AE3@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> The current name implies that a deferred action is "hooked" and that when
> the service becomes "connected"; a WISPr-based reachability probe will
> start. The revised name, 'start_wispr_if_connected' implies, correctly,
> a one-shot chance to start WISPr if the service is "connected" at the
> time of the call.
> 
> ---
> src/service.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied.

Regards

Marcel

