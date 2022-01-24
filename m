Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFC29CA
	for <connman@lists.linux.dev>; Mon, 24 Jan 2022 08:25:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C2B85CFEC;
	Mon, 24 Jan 2022 09:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643012732; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=76vm0XfCnL92oLczEt86RDCHZAVc2cHy6gbjItLPMP8=;
	b=efEr0QgH0e/tNOD2bR3HFhLfrgY/8ST3Y9AOUYPMBr9Tz5Y5YinDQpM7rZVZ3FtrWNXYMH
	hN4w2GRc8T2N3uk5iXTpoGTXTlLDTrmvD0X5zerD+FviG+BU2HrlmC/MkROSEuYfWnW9q9
	DO2TDOFeCiZzauHevxGYPelA9JjAs50MPKZ5R1EEKLMdaUUWsrtNl/PUGQy+XGPdNvfeza
	VT3X9g2BHjHw7V2MAqTr/nPhuX7euD0w+7NfF0FmGPtsxEEKcv3cUxbv3oE827s2O/coTq
	1I84srwVC6OGL70cx3Mox3+Qe6tm4XM9RFn9+n9TN+QD3XqJrLY9krHlZp/L3A==
Date: Mon, 24 Jan 2022 09:25:31 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v3] service: Fix native connection with wrong passphrase
Message-ID: <20220124082531.x5ldrhrypwg2nu3t@carbon.lan>
References: <20220121102736.3323889-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB1544B85627F19D2599911150935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123132351.ppud4auaysfmcfx3@beryllium.lan>
 <MRZP264MB1544FAB6EF32AED6479EC82D935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123164646.fzmcfsav2tb7vpba@beryllium.lan>
 <MRZP264MB154442FC5C38510C1526952C935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154442FC5C38510C1526952C935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Jan 23, 2022 at 05:04:33PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > I used the patch from the attachment, not the email. I was not happy
> > with the indention levels and the useless brackets.
> Ah sorry, I haven't noticed the double parentheses.
> For the indentation, in order to respect the 80 line max size,
> I never know how to format the test conditions. Is it 2 extra tabs to
> differ from the execution code (1 extra tab)?

There are no fixed rules. But the usual thing is to stay consistent with
the rest of the code. There are always variations between files but I
try to keep it consistent at least within a file. Obviously, these days
we have clang-reformat & Co and we could use them to get everything
consistently formatted. Though this boat has sailed long time ago.

Daniel
