Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E775249EF
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2E9A4CECC3;
	Fri, 15 Dec 2023 09:51:40 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 1/1] inet: Eliminate dead store in
 'iproute_default_modify'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231215005820.2141277-1-gerickson@nuovations.com>
Date: Fri, 15 Dec 2023 09:51:29 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <72BEB751-F845-43D8-8BE8-337DE53CDA5B@holtmann.org>
References: <20231215005820.2141277-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> In 'iproute_default_modify' there is a dead store to
> 'rth.req.u.r.rt.rtm_scope' with 'RT_SCOPE_NOWHERE' only to be
> overwritten two lines later with 'RT_SCOPE_UNIVERSE' without an
> intervening read.
> 
> This eliminates the dead store of 'RT_SCOPE_NOWHERE'.
> ---
> src/inet.c | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied.

Regards

Marcel

