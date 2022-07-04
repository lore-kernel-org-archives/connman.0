Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBABF23B5
	for <connman@lists.linux.dev>; Mon,  4 Jul 2022 09:23:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 124585D175;
	Mon,  4 Jul 2022 11:15:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1656926133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/lww6NfAxKekNcXrnrSuXh4Ml907PPCcZEt7SXf59dA=;
	b=HWkFcZs3l6LTHtW6EWVbMfSu8J6N98mCAZhZH2Ci+KohvzX0878DxV/yDQWgXUMGLPPAG2
	8J7WVGwI/GVXS0MiKaYyJ2F+Mp6UUU1o2QRe30ST2JBKW4QndIuD/j8ei1Fw8VxDQ6xRU0
	zIsPK/9WCoP2ipt/X0PKCcn+9YxHYPxdZd7I9MrSwS5wHGZLCrIkyRGvThvj7mQdwFYKwX
	jXbo28qnwaydjPXICPcu8UTdQsRgc0YpWaSi/7/VOhx6pz/J3Jj7239+0So+emjU8y9Npz
	2KjElZTOxP27g4iqZQaSU1BzL5yqq7HOrx1DQItoDLAC8mGS4E+JEMnghheJEQ==
Date: Mon, 4 Jul 2022 11:15:32 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jupiter <jupiter.hce@gmail.com>
Cc: connman@lists.linux.dev, iwd <iwd@lists.01.org>
Subject: Re: iwd + connman
Message-ID: <20220704091532.zkqt6pnvzsk3touf@beryllium.lan>
References: <CAA=hcWTmGCSQFEMABzUU742ZE-2LJNR38+B55Kzr3HrLjcOO-g@mail.gmail.com>
 <CAG17S_P6OaYseePAe_f9TZa6Q-DcC+T-Tmk9QSRsA8DOqPYgOg@mail.gmail.com>
 <CAA=hcWSj5TFgisTA8qM=y+C7-ckEMSHXYprgAU2KkDkPsU8qMg@mail.gmail.com>
 <CAA=hcWQbsLZQASJ-F3DeM2CxZBTtd-q2WExCUKEcP5FLnmbHbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWQbsLZQASJ-F3DeM2CxZBTtd-q2WExCUKEcP5FLnmbHbA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jun 22, 2022 at 04:24:13PM +1000, Jupiter wrote:
> Any comments about the connman working with iwd to support
> EnableNetworkConfiguration=false configuration?

If I understood this correctly this feature correctly, ConnMan expect at
this point that EnableNetworkConfiguration is set to false. ConnMan
wants to do DHCP itself.
