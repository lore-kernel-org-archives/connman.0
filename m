Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D8D26C
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id A9FBBCECD8;
	Sat, 23 Dec 2023 13:21:38 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] ipconfig: Demote RTNL RTM_{ADD,DEL}ROUTE logs from info
 to DBG.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231221070849.2354559-1-gerickson@nuovations.com>
Date: Sat, 23 Dec 2023 13:21:28 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <53F2774E-5457-4E40-9E50-C94CA692A77D@holtmann.org>
References: <20231221070849.2354559-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> With the "continuous" online check mode, logs can become dominated by
> Linux Routing Netlink (rtnl) 'RTM_{ADD,DEL}ROUTE' entries every time
> WISPr adds/deletes a host route for the online check.
> 
> This demotes those log invocations from 'connman_info' to 'DBG'.
> ---
> src/ipconfig.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

