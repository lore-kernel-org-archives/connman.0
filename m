Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE732C82
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 07:04:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE6416183C;
	Fri, 15 Oct 2021 09:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634281441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jMEpWs1IS1yJ9FmsqfrMizEAMHnzLmpMiBEJGW0DHYI=;
	b=icVx4fsLLwCvQMRGHyESBvSv7mDJJnJZUp1bRCeqPHH4Crf/2+kSx/ZzmH7FRvfNg75iNY
	/P5iZ9UWwCSqhWQ2lrOMOEJxp85skeNUIQkObUXJVNyTQWM9OdrSCMCRbCCEL/Yzq6AABL
	i6dVehX1a/yAZk664QUA2FPy+p3CzQqV8cTE8MxI0p78UL++/tUk/Ej/GeX1XDtxIxkysk
	bheYHH1F6sxDuT4Kp3OP46vdVhBojFRhy94/t9tcQVDKlUqkRuKcWpphXDTvoeqJqrHBBz
	BO40n9sV3afhIWggAJX6u2oCAyCcuxS1HeoEpf861M7/p5bKs20Rv+5iHZSBAQ==
Date: Fri, 15 Oct 2021 09:04:01 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 2/4] tethering: Add possibility to configure the access
 point frequency
Message-ID: <20211015070401.of3ybrtbt2p2vm2o@beryllium.lan>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <20211007213021.58712-2-michael@amarulasolutions.com>
 <20211015065250.nt2bprsnsrpdfeoq@beryllium.lan>
 <CAOf5uwkB6FYrpzs0djVB8EYe3-rG8C0o+JfzoV7+3B_YtU1OrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwkB6FYrpzs0djVB8EYe3-rG8C0o+JfzoV7+3B_YtU1OrA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Oct 15, 2021 at 09:01:15AM +0200, Michael Nazzareno Trimarchi wrote:
> I have done git remote update. Nothing new there ;)

Try again. I wrote the email before I did the 'git push' :)
