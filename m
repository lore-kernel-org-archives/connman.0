Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BA29CA
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 07:54:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2D8D5CFB6;
	Fri, 21 Jan 2022 08:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642751687; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=q5WNBWAdPjX/lqJHTu+WJzp4GVuJZZXXinluEvkObuw=;
	b=UbNSOEHgVRfFgTGwPqJctQZyv2Oc8tbOYZkFUObtH1IbhZHZlZ393vN23b2DM5MdtDOOen
	NgXo+o7AH1Nx79PL17ZDOmOnrBhMDUyMQOsET9UqXZkBEmHjzhVbJ+pKD99MspnzlQxC9E
	f+oyP7ibljKllDBjAS74/FrPccifaHTAdSp7e3bUYfQKL15aZGy8UYnwXfkTbeuqXDDR0j
	pV8PKc4cK9oZnjlMLxvGbLjZpnGvL5/nYnkrLj7ZTh7V+rNJy0YwUQWXHLaHOdiBueP3G3
	JeSrjhaIrrgv9YcRchKB+FGXxwGV5lbNKdDJZsySOEw7dWb3YZo0Nl2gxF3r2g==
Date: Fri, 21 Jan 2022 08:54:47 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Mark only reachable networks as available
Message-ID: <20220121075447.nazzfzcc5h2lcnv3@beryllium.lan>
References: <20220118125207.1204244-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154437A17FE29544A015748A93589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154437A17FE29544A015748A93589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Jan 18, 2022 at 12:56:30PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Only reachable networks, with a significant signal strength, shall be
> marked as available.

Patch applied. I was not aware that iwd shows networks with no signal
strength. Thanks!

Daniel


