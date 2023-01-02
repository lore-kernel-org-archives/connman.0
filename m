Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9120EC
	for <connman@lists.linux.dev>; Mon,  2 Jan 2023 08:16:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E13A7DB6EF;
	Mon,  2 Jan 2023 09:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1672647376; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XEPEBvt3KlMNmIqqLLFpgNC32Y6NKIFh7saMIEIYcSo=;
	b=oHriLVgW7nzbexluW7khqZkgChwdL02wx1DU00aao0Vcc/d/v49FUMQstONkd4w/H0b89K
	afPNH0itebs6kZzcq+UOcSxhOzasJIU6hH4Uf+JpTawVz2WrjOmTQkWk807p6ZGt0DIXB2
	t+z9oU3IqVIzVR/lOmlbjA1eXKkCIVU0QH6f5yX6TL0r3hW85mXN7Gq3Nk/+aRe+XI3oL+
	xpdF5LeFX8CF425FPD49uhLZtOJRsaWfNYNzV81EuI39R6WfneqXwASWpQzCqXhT1LSnC8
	gwv/ZKTfQ1TjLZP9sSsbJOxgdnlpEx7wfobhGDQY3fiW/VOnqXcdQWcos9H0SQ==
Date: Mon, 2 Jan 2023 09:16:15 +0100
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>,
	"i . Dark_Templar" <darktemplar@dark-templar-archives.net>
Subject: Re: [PATCH v1 0/2] Fix a couple of regression
Message-ID: <20230102081615.cq5s2hyxgv7yryih@beryllium.lan>
References: <20221218192820.22937-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218192820.22937-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Dec 18, 2022 at 08:28:18PM +0100, Daniel Wagner wrote:
> A bunch of fixes for the recentently reported regressions:
> 
>  - https://lore.kernel.org/connman/66993511-8b3c-bf48-beaf-9ff9e6ee446b@gmail.com/T/#u
>  - https://lore.kernel.org/connman/b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net/
> 
> Daniel Wagner (2):
>   ipconfig: Do not filter out 0.0.0.0 gateway routes
>   main: Add Hamachi interface to ignore list

Both patches applied.
