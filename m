Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD928E7
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:31:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E5D95E06E
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 20:31:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661711476;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=dfmNsvdrSygV4AwoqEqdn/NRBPNH/v+s0s4rLMePiNg=;
	b=fDTypZuiR18QBuROaFt9JlXLMvWJPrfaCCICD4E3ww60MlYeAEpHyx0Of2Cb3H5ClTIBkq
	Zen/8S2eHFEQ5/oU7yAleiaN3zdTtSqzr8JGJICkEg0DDuHqp80Fy3mvBtu/0GqbJObN7W
	sg5sO9wI7p2aPXY0G2nj5MK4UpdhKyWUiy56/DiJpQa1kGWJnMTNBZtxNyu7D92+x3qx44
	tOsMdTZ/Lag2FyRI66pzEf0+SI5oaLgr3FQsictwNAC5NpHumA2aOwec3jKuLAVKhbQ+BI
	KjrztpgWmUjRT3zR6GYbYDys0zE+NWU/qLi+ILry1139f0SabURnXP1/8L10uw==
Date: Sun, 28 Aug 2022 20:31:16 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH] wisrp: Handle wispr_portal_detect failures
Message-ID: <20220828183116.zed3nrbl5thf5qjj@beryllium.lan>
References: <20220828135322.21582-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828135322.21582-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 03:53:22PM +0200, Daniel Wagner wrote:
> __connman_wispr_start() should handle any errors reported by
> wispr_portal_detect.
> 
> While at it also return early if the service type is not supported.

applied
