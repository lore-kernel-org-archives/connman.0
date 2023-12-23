Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2BD26C
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id ADE13CECD8;
	Sat, 23 Dec 2023 13:21:15 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] wispr: Make 'wispr_route_request' route add 'DBG'
 consistent.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231220014118.2265388-1-gerickson@nuovations.com>
Date: Sat, 23 Dec 2023 13:21:05 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <4720D9E3-8C2E-4003-85AA-8DFF779A1F61@holtmann.org>
References: <20231220014118.2265388-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This makes the route addition 'DBG' in 'wispr_route_request'
> consistent with the route deletion 'DBG' in 'free_wispr_route'.
> ---
> src/wispr.c | 30 ++++++++++++++++++------------
> 1 file changed, 18 insertions(+), 12 deletions(-)

patch has been applied.

Regards

Marcel

