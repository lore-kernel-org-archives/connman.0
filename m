Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC015A7
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 18:48:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A0405D7A6;
	Thu, 14 Apr 2022 20:48:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649962106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6/O6CFIcWgKj7TiC1rlokIu5DNmVfnwHuRG3677nwpw=;
	b=xD/H9oF0gfI3tToaOOG0C08WLwodxgrPhmZwv05PsqH1UPOew/5hOdUsmJuSAcuDDkViKy
	aJttSZ/z1Ajrv6/SVXz2Z/JuTdAEGoMrjXxHzs1aN893aVupsDTFb1Sj2htL/2+kG+6CLa
	PU7Oth05yemGxXpB5do5esvEEjQTF30IZWo9WfJvPGJc2AD99MVyV5ug8A3oXI0LNXChDM
	1Gi/gjBjl3UkcV0UGK2SflmMGjBl2zbnFjCUT63Ga6utaPAjIeD2oP+8J4e+s+xim7bBMW
	CY+PCbMgg6BWAOcGuXmqiRL2/U3+vMbgJrvG/zGTZFPnl0+w1dmoqaSftLAVvQ==
Date: Thu, 14 Apr 2022 20:48:25 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ryan Smith <ryan.smith@density.io>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v1] gdhcp: fix server address byte order
Message-ID: <20220414184825.mud3ubskpo3afg65@beryllium.lan>
References: <20220411152039.491710-1-ryan.smith@density.io>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411152039.491710-1-ryan.smith@density.io>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Apr 11, 2022 at 09:20:39AM -0600, Ryan Smith wrote:
> The get_ip function calls inet_ntoa, which expects the IP address
> in network byte order.

Patch applied.

Thanks,
Daniel
