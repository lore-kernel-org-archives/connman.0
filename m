Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1AF22F0C
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id BA497CECFB;
	Thu, 23 Nov 2023 12:25:03 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] service: Group online check state by IP configuration
 type.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231117230325.714769-1-gerickson@nuovations.com>
Date: Thu, 23 Nov 2023 12:24:53 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <51A57FB1-739B-4DA3-9FE4-B4A9FED47BBE@holtmann.org>
References: <20231117230325.714769-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> As the implementation of the continuous online check mode (also known
> as, EnableOnlineToReadyTransition) evolves, there is an increasing
> need for spatial locality of online check state by IP configuration
> type.
> 
> Consequently, rather than having a collection of individual data
> members in the service structure decorated with '_ipv4' and '_ipv6'
> and accessing them one-by-one, group them into a common
> structure. Then, instantiate that structure twice in the service
> structure, once for IPv4 and once for IPv6. This allows for the
> desired spatial locality.
> ---
> src/service.c | 142 +++++++++++++++++++++++++++++---------------------
> 1 file changed, 84 insertions(+), 58 deletions(-)

patch has been applied.

Regards

Marcel

