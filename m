Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C52F509
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id EF0E5CECEB;
	Tue,  7 Nov 2023 16:09:13 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 1/6] vpn: Remove unused __vpn_provider_check_routes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20230930222615.654178-1-denkenz@gmail.com>
Date: Tue, 7 Nov 2023 16:09:03 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <2BA2CC3D-78D4-484A-93EF-082CBD6C9CB5@holtmann.org>
References: <20230930222615.654178-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Denis,

> __vpn_provider_check_routes isn't used anywhere.  Remove it.
> ---
> vpn/vpn-provider.c | 16 ----------------
> vpn/vpn.h          |  1 -
> 2 files changed, 17 deletions(-)

all 6 patches have been applied.

Regards

Marcel

