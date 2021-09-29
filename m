Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2372
	for <connman@lists.linux.dev>; Wed, 29 Sep 2021 09:23:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B6CB5E30A;
	Wed, 29 Sep 2021 11:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1632907002; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qymPL9+hvDZY3FqyZx46N/TrGFBBRj1xEDf39nV91Ac=;
	b=tiTdm4wkTuFwyR751ACI21GCpmi7H9dHy0VePTFYl/O4lgZrpSI1ReoopKFHPUl7xsyH1W
	LYRs37z5F0OgP5AWa+np4xs8dXSXckME/Yj/nmrmQ0yNroS2oJKjL+DlO3N2Uq9fdn33tq
	8jsA+DXbpjpPJz7fVqxNtzicOE93/6w/3ltlE8Xznh4qjvF5aAKnVELVSaYlaNA00b6utL
	2eKPNA0uvvhqXAgQId0kON4VPpGwC0+IZKwT6dcj94n2kxVeklyv9OC+VPGQuFxays/9wI
	9YztmgUh8aPPVs8q/zCUS7EMNWn1tK6GqcRZ9NXmSs/t5c6o4IxVIvDAD2UjAg==
Date: Wed, 29 Sep 2021 11:16:41 +0200
From: Daniel Wagner <wagi@monom.org>
To: HENRIET Vivien <vivien.henriet@overkiz.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] wifi: Choose a random channel when opening an ap
Message-ID: <20210929091641.fg4v7pbol2nysgrd@carbon.lan>
References: <20210923124429.1123-1-v.henriet@overkiz.com>
 <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Vivien,

On Wed, Sep 29, 2021 at 08:57:25AM +0000, HENRIET Vivien wrote:
> Hi Daniel,
> 
> Could you have a look to this patch?

Sorry for the delay. Anyway, I think it would be better to make this
configurable or smarter instead of a random channel selection. I just
checked what iwd is doing and if I got it right, the iwd daemon does the
channel selection itself.

> I would like to be able to open the WiFi AP on different channel.
> The simplest way to do it, is to select a random channel, which fit my need.
> Do you think its acceptable to integrate this way?

Random channel selection is a bit a wild solution :).

> I've got also other ideas to achieve the same goal:
> - Add an optional channel parameter when opening the AP

This is what I would suggest. Alternatively, can't we use some metrics
from the last scan to figure out which channel is crowded?

> - Add a global config to set the channel

Generally I would like to avoid adding more config option if there is a
way to figure it out.

Daniel

