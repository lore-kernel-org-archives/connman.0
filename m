Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D97462
	for <connman@lists.linux.dev>; Tue, 20 Sep 2022 16:12:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36C555E14C;
	Tue, 20 Sep 2022 18:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1663689970; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uIxrQzUrI5YxZlmCMcQtOeidu4mgd4J7B8bCala3t98=;
	b=Blu2lD9PwX97mM1W7TjLjUddzB3GHaCu6lK9Vtpt9XShA96F+pjpsA5k/RRCNRjdh0NxfE
	2s2d+QYbUoM3glMa9aMari8S7Iof9QxbRkNrukC0HNo7y0W4cTbfDUA34fAjYbNtRF/UpH
	aUkUq7flPf1pybR2ZjS3H93Y0c7C3kGLjt0iE5h7ExJLzgn+Erxq9ZTsYnvo0kKN3rWAT2
	0y/EjJCoSzC2e2FCjEYK/XeSdKsAzRZTnQj+F0TgzujA9byjnFUJb0CPXwRWLt35BfnCKj
	XgBHXuR09RzEMMnjFL3lClFGdrjjZpikivbHWm4ufN6wKvJnuB3jEzmyQgz6cA==
Date: Tue, 20 Sep 2022 18:06:06 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, john@metanate.com
Subject: Re: [PATCH] wifi: Handle invalid-key case on WPA-SAE authentication
 failure
Message-ID: <20220920160606.cn6ljof42phuqqon@carbon.lan>
References: <20220914184610.258763-1-ariel.dalessandro@collabora.com>
 <20defbe5-b144-ff2b-8bfb-1621368be5d9@collabora.com>
 <ee0c2aa7-1d4e-e18c-562c-56bc20744bcf@collabora.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0c2aa7-1d4e-e18c-562c-56bc20744bcf@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Sep 20, 2022 at 09:08:29AM -0300, Ariel D'Alessandro wrote:
> +cc Daniel, in case you have any possible feedback :-)

I've seen it. Just not yet found time to look at. From a quick glance, it
looks good. I'll apply this evening. Sorry, I know I am really not
moving things forward... :(
