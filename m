Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9ED3FF5
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:34:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8073617E3;
	Mon,  4 Oct 2021 08:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633329253; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v4+9RXnddCYPGN/J632uK8Q3Kj30F4bIXsdzNTg6Zgo=;
	b=E+dZIbvSTxopSl/JlRNBixvtKumw8FgUUBezgKuWvSXxsUFJi5+vx2I+NgcFn5bHOerDiJ
	qLr05FygEB1wbMGHVTB0nCa1brPObkE1HGC4BIhENYNqo8D0RBZUeKtNmhxeaaf4TJXa/9
	hw9sUoa6SweDa2J9Tx1XgLCYXLsIxgP+xIugxpfhtEqD0ToF1v6AXPOYXhSoN1d5aIIXTp
	JOOb0+1pliTSG3JuLJKAaFa2+xzzG1HyoWgQE/CjHFXVaU87LrSEc0mp24SLknhj2+BqBR
	xFZGmc57OZ/Z0a+TZ2EqPgDC7dF1aN7JfI/CJUSLCLBM+3his2tXh/dJZszb3g==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	"VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] service: Report errors to user in native mode
Date: Mon,  4 Oct 2021 08:34:09 +0200
Message-Id: <163332924025.22211.16547270907956272336.b4-ty@monom.org>
In-Reply-To: <MRZP264MB1544E59B5B25F0CF95C7A07993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <MRZP264MB1544E59B5B25F0CF95C7A07993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 1 Oct 2021 12:20:27 +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> When the native mode is activated, the user still needs to be informed
> of errors in failure state, via the agent.
> 

Applied, thanks!

[1/1] service: Report errors to user in native mode
      commit: b9a0a039ccc5697d413f61c9afe7c8c2b6dbd607

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
