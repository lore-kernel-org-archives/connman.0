Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72246B4
	for <connman@lists.linux.dev>; Tue, 27 Sep 2022 16:54:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 650E65E2E1;
	Tue, 27 Sep 2022 18:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1664297635; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KxSEpc/VQUe61+uKPegWkbnYN63odNe5nZTw8SoaD3A=;
	b=zXzar72um+FnfRnfaCkZuzR0GcQLy9oXoaJwyLcJlql1HYIjykQyU2cQNHEAyMDl9T7a23
	yPNruc56d/OY+kdjHalf3wk2+/1WmzlOOGoLdXjFA/iHKlR9h33ojSdtBJPRU+EVfOhUHB
	SZ5XLcImPDbaY4c07TeiizcBhcbn1GV7uWQc8L5foH1LeOhcPOMrgeOb0tp1Dcr8/f8WQ7
	OUucuCG+yfWXp9K5dcqMCr9JBtvVQkFnqo/MNRo40Jm5YNS4x+eqXLxp0Fm15eri4p/MtJ
	1DYv7qn2On7fpnI6z802GXwtfzlAgK4KRG9QbIwwpHSQLTefAVqlSJ7nh7kv/w==
Date: Tue, 27 Sep 2022 18:53:54 +0200
From: Daniel Wagner <wagi@monom.org>
To: "Kohler, Benjamin" <bkohler@gentoo.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] gresolv: add missing include to fix clang-16 build
Message-ID: <20220927165354.r4r4ja44s7ud5wwo@beryllium.lan>
References: <20220922154517.2326482-1-bkohler@gentoo.org>
 <20220926062121.3pzyqaurugbfqfko@beryllium.lan>
 <89685598-3419-33a4-52a3-d452374a0c68@gentoo.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89685598-3419-33a4-52a3-d452374a0c68@gentoo.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Sep 27, 2022 at 08:49:25AM -0500, Kohler, Benjamin wrote:
> Sorry, I had a working patch but then submitted a different one based on
> gcc's warning message recommendation.  This should work better:

Thanks! Patch applied!

Daniel
