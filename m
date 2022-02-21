Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4252568
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:51:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 946675D336;
	Mon, 21 Feb 2022 09:51:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645433479; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=S7uoYSUokqFBhA6RaOXkbTetyHypzzDG/7x6smQKDGI=;
	b=W7F5zkZ6S6gq3rOs65aPThFx1n1hoC2YIxW1IERhO9TyayNtWsMyHWmVKRqGHB1652nrQF
	YTdjnOIQQHGipXu7OfcLh5A29P8Oj4Akt8yQH0LnLEgi4d45ODAEzbK4QR6xbcB3LoBBOk
	DpoTN3tcaa0WkSHGSnZhXtuxIv69FhmMfQ9aj6GqqeSz+kdSSrvPllfteqVnFHMfesCtkV
	jE0uspnXNGsChMJyhBHZRgZSTHGnoMNj7XK4bZggG3zNdVxMF9l0DIvNsnQHUqnnBxAlzc
	U7CVBJ4ROIL9yuhGYsH22khLlmCDhbN7NfRePyOxx6Xp/cUvRBgyd7vwmWqW8A==
Date: Mon, 21 Feb 2022 09:51:19 +0100
From: Daniel Wagner <wagi@monom.org>
To: matthias.gerstner@suse.de
Cc: connman@lists.linux.dev
Subject: Re: dnsproxy: some initial refactoring and integration test
Message-ID: <20220221085119.eawwfhp7qf76bhnb@beryllium.lan>
References: <20220217113113.24088-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217113113.24088-1-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Matthias,

On Thu, Feb 17, 2022 at 12:31:06PM +0100, matthias.gerstner@suse.de wrote:
> These are the first steps towards a bigger effort to refactor the dnsproxy
> code. Some smaller fixes of compiler warnings and refactorings are already
> included. Mostly this adds an integration test facility though that allows to
> easily test the basic code paths of the dnsproxy without the need for root
> privileges or extensive configuration. With this future changes to the
> codebase can be more easily checked for regressions.

Nice contribution. I've updated small nitpicks and applied patch
1-6. I think patch 7 should just hook up into the tools build target and
it doesn't need any special Makefile hackery.

Thanks,
Daniel
