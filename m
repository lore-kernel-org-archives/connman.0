Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166A3FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:22:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A0875E3F6;
	Sun, 29 Aug 2021 21:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630264919; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FQUYWnBszY8Ru/9ZTgpNT5UqNqo+SfaaZG4YoU8oBBM=;
	b=XqWUBeNpqaPWOdVu22Ye2PSJiiWIve3UXigGDj2ZiFAUEnTmiURhKTegfPlLYWqYmSzj22
	3+XN+/dhVvS8oHsTRXCX7Ohiva7Zi4KQknMSethEW745s4pgWlq5ZzZMwBUlF4pT6CU9Z+
	5/oIth70AMW+jSlCBlO8oFPSF6a9KaHs9DsbWJDFpoyflk4vMdk2DR9eICtSCRO08FHQBu
	/i1IvH8gspseqb1Csf126oROLxt0lkuErimn0lNgwX2VZWcFv+3bAXhP0q0sqCL0L8Mcsy
	Rw4eJvWzXtfJlMEHs9ZTYCH7gDuNIAkUInoZPAl/8PfQrDDNKsKoHtY+gWNsFg==
Date: Sun, 29 Aug 2021 21:21:58 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Prevent auto connection during passphrase
 request
Message-ID: <20210829192158.3zdnc2hsdaqwuhsz@beryllium.lan>
References: <PR1PR02MB47941F36176A2E8723EB139193319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <MRZP264MB15442670841BF0B75B350B2A93C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB15442670841BF0B75B350B2A93C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Wed, Aug 25, 2021 at 12:27:50PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Was there any progress on this subject? Does it still require some clarification?

No all good. Thanks for extending the commit message. This will be handy
to figure out what it tries to fix if there is a problem with this
change.

Patch applied.
Thanks,
Daniel
