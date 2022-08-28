Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45C3214
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 14:06:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E93A15CD23;
	Sun, 28 Aug 2022 16:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661695582; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2NOXsv6kRkQ66ok3upv1ozqnz+nc7EVrNQ3MFyJpPTY=;
	b=K1w6UqlWlgA2E3Wyz5Gijwtx+DvgLI11+c3naPZrDUIxe4kA2D1qsHf6aitCXILSd4av7m
	CtyVLpDUtKKRQpmhLzZBqvy7/mGu2f7dOiHwfE3jqivMkSD3aLuBU1K4ke2NC/y373bPx+
	B5lNS5wc9rm1rmoLYYd+zkgqnXDvZexFxLbVTXfSA3h10msXug17OnEPGUWBFDl9CEb2BA
	Q4q0Zq+d5A8QHjTl/1VFkbaGLW92UvbYh/URWEtA9RrjeIr2KwBas3OpHAb4PLm8v/seM3
	DKbHd/PDkc6JYEQnQb1qjtg5BjSb/Zv8ayQsqk31mC6rl0ZPiICvJ064rq3igQ==
Date: Sun, 28 Aug 2022 16:06:21 +0200
From: Daniel Wagner <wagi@monom.org>
To: Quen Jankosky <quen.jankosky@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Default Routing Issues, And Potential Solution
Message-ID: <20220828140621.fs5vy55x2g2minl6@beryllium.lan>
References: <CAFT6v_b-nE0TkTRDNcEPgb6wDue0NAwWPBEDevVfA=VBDD-rqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFT6v_b-nE0TkTRDNcEPgb6wDue0NAwWPBEDevVfA=VBDD-rqg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 01:08:19AM +0000, Quen Jankosky wrote:
> To begin my main issue here, I've discovered that what `default` route
> gets set in the `ip route` table by connman is mostly arbitrary.

It's not.

> Whether there is some sort of setting for this, I have not been able
> to find, and have only seen a single post relating to this same issue.

https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/overview-api.txt#n116

> ... As you can see, on Bar, I have no trouble accessing the internet
> being which is being routed on `192.168.0.1`. However, on Foo, I am
> unable to access the internet from my WiFi network despite both of
> these devices using connman and similar configuration settings; it's
> arbitrary.

It's not arbitrary.

> This is extremely frustrating, since it forces me to need
> to disconnect my direct copper connection between my two devices in
> order to have any access to the internet on Foo, or disable the
> connmand service altogether and manually configure my network (not
> ideal for portable devices!). Even if I manually change the default
> route to the correct one, connman changes it back after a few seconds.
> I feel this is problematic and needs some kind of solution.

Does it still happen if you disable the auto connect and wispr feature?

