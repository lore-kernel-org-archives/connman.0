Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70A2C82
	for <connman@lists.linux.dev>; Fri, 19 Nov 2021 08:30:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6590060F75;
	Fri, 19 Nov 2021 09:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1637310610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=//KRq1BCDoiBmyzJ0lFeYlLWBJtVoqCEBtNwC/dZuPc=;
	b=nxF5KiT+QJ0rA4Rfwa4ah3ReiaTNDWbWCk7ZMPHdWGwqSGZ/aHrRIEnVamaUqTXYh2jiwj
	PsXbFvhjI0/yMsIioP67zRHl8Pw7GGCXBLc2+O41SlIGoAHHvJUgIaxFMQoFAOC/+xyIQH
	dhZABDV+a8QVVzi6eX6F85mUAzvBs4V7oyu+53xqDurNAjKHXLO5r4ssfkY8gHE2yxGb71
	2wU11c6E9mJEzM6/+r45kqEyQJg86EJOHOf+1tDzgrQ1fccS+u0UJmGpufIxEy8sG/DA03
	hJnWuB3pDnkRLVr7f9rlZHCRE2eurQoQheU3jA26NrvvOAKotzw5HK5zEp2RfA==
Date: Fri, 19 Nov 2021 09:30:09 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v1 0/2] Improve OpenVPN configuration value processing
Message-ID: <20211119083009.x5zm5fyf2m2zqzzv@carbon.lan>
References: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
 <20211118210239.syttg5jfgbdmgfzm@beryllium.lan>
 <71ae9054-041d-aff9-8e33-1fc8a016ea18@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ae9054-041d-aff9-8e33-1fc8a016ea18@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Fri, Nov 19, 2021 at 10:09:27AM +0200, Jussi Laakkonen wrote:
> Oops, sorry. My build env did not complain about that so I guess I
> overlooked that bit.

No worries. My normal build didn't catch it either. I have a commit hook
which builds any patch I add. This one triggered.

Cheers,
Daniel
