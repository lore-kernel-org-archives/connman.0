Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2B29CA
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 06:52:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80BEC60F75;
	Fri, 15 Oct 2021 08:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634280770; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RvHnN8A24KAUDv3BqFFN2xtYPaxcJkBBll3/dAAKFxs=;
	b=p/6niR4TZtuqCva4nxPESGmbsuFXMMl9Vn+80BFKhQEaxo9bRrQpp6nNlEvKoUlQmb+W0D
	kRXU7F41NlJWTBS/zo0kyNP+Qs4xxTA+dLqWaa4+bJjulTRbyE60YSOoPwFRB+nh3SCMOA
	zSvnmhGCchg41PPBqPcMYUDXW6F3vv7zOWedtwrIVgchsN1WYxPiZirssKfjW7RvlO2fds
	l2hHmi7C/C4BrcLvhHYcEn+kDjJW/uDYsfkbFvNfh0BOqfiRkgeYhPrdAODR0noFNSrX19
	nYnqnivUpmuGg4xonIrBsEIEOY31GITheid9sfsDQ5rob5xfxMv3kNbVgGFogA==
Date: Fri, 15 Oct 2021 08:52:50 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 2/4] tethering: Add possibility to configure the access
 point frequency
Message-ID: <20211015065250.nt2bprsnsrpdfeoq@beryllium.lan>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <20211007213021.58712-2-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007213021.58712-2-michael@amarulasolutions.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Thu, Oct 07, 2021 at 11:30:19PM +0200, Michael Trimarchi wrote:
> When the tethering mode is started, a WiFi ap is created using the fixed
> channel 1 (2412 MHz). Add a way to configure the channel

I had to update this patch because of my changes in your patch
#1. Nothing scary, so I applied it directly.

Thanks,
Daniel
