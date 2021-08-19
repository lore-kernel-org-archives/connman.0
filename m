Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F72FAD
	for <connman@lists.linux.dev>; Thu, 19 Aug 2021 13:06:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 098005E4FC;
	Thu, 19 Aug 2021 15:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1629378377; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M6kRPJkdfEtQYyPDcB7dQg2cweeT1/5o6vOnahWUa3A=;
	b=Ri7A3ijDIi9w4AkdwT8TXP30XLX4XG4yK4Q4wbItTA4Pu+00kF+M+62cNkNdCDrYTkCfiG
	ri/RbD7W+UQZ9xOLQj+VC0g2o/lWaozAaMogRpomRmgGtxiJJny4g6+J+qCWdwzzBa3gwy
	eQ/FEPKIp0UHLN+hiK4CWm9sB8SX9ZRN+il1Q/nabwUzvbbE66NVq4W9gBbpQpqL3yFuQN
	CrRJtLS6M6Af46eZAEMwW2epNkh4jozS6kiKk7TL1Xh4uoOm72j5Lttaa8vSm80a2id07p
	zU+f6X79kEWAhjbLcq4Nm1wK9iROd8rUbvP4J+sA5qgROCni6auSPvStj9FpNA==
Date: Thu, 19 Aug 2021 15:06:16 +0200
From: Daniel Wagner <wagi@monom.org>
To: Santtu Lakkala <santtu.lakkala@jolla.com>
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
Message-ID: <20210819130616.gtdymlno5fmbi54j@carbon.lan>
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
 <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
 <20210819123003.r4sqio2pquco5qph@carbon.lan>
 <7f49edf3-75eb-3295-cc12-ae21faa903d8@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f49edf3-75eb-3295-cc12-ae21faa903d8@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Aug 19, 2021 at 03:38:08PM +0300, Santtu Lakkala wrote:
> On 19.8.2021 15.30, Daniel Wagner wrote:
> > BTW, the question on the busy loop. I am pretty sure there is no timeout
> > involved if you just return 'continue'. This tells the caller to queue
> > up the callback again without any delay.
> 
> Nope, it called again after the same interval that was passed during
> construction.

Ah, okay, faulty memory here it seems. Anyway, thanks for
explaining.
