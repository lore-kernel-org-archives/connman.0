Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA712CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:24:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FB275CD03;
	Sun, 19 Dec 2021 18:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639934123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=CDbZTD59T4RauLma5O6y7rLoB4nqKrlMD88LhUf7+fo=;
	b=PvONRlxOzjtTbc+lt0vXe5/w5h5566GwplVmKB84iKwSRsFXVeHiIZ9a2hdglT9VfjkDoz
	ieGlMpEJgAqYpWQfQNZazUhN9OcZuUNGnpp6l2lZ1z9p4RvnueH3doTG4Ix4hVVjQck9UF
	3ZTjNIamGI1W40srEhIsAy3cl7JXN8jD8wN0/odbMf8wqO2u9fB4lXKkDCgaVgwFQuYv8J
	LX6dZ0p5PCymUn2g+d90UI2sOr0BdHkXt+1/XhTRDspIj+4HEifPd8Qg0jkCudz3VHgnjv
	/BW4lKnCudLx15pUJZu31f2ZPVZTU4GsSJISU576CY9jKN9iSk908Y9JQomlqg==
Date: Sun, 19 Dec 2021 18:15:18 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jupiter <jupiter.hce@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Armin Kuster <akuster808@gmail.com>,
	comman <connman@lists.linux.dev>,
	oe-core <openembedded-core@lists.openembedded.org>,
	yocto <yocto@lists.yoctoproject.org>
Subject: Re: [yocto] [OE-core] How to create connman_1.40.bbappend to enable
 and to build connman with iwd?
Message-ID: <20211219171518.mzhcanj2d26ukhls@beryllium.lan>
References: <16BAEC7B11896AEA.23256@lists.yoctoproject.org>
 <CAA=hcWSA8-8TCJDD8_Zib11Vaizok-xZvQMqSevjKJLrQ+GuhA@mail.gmail.com>
 <16BB4412EB9EABB0.15594@lists.yoctoproject.org>
 <CANx9H-BczVumN8LwcH6+4SmobRJz=Hxmand2soVyfuoYZVmMQw@mail.gmail.com>
 <CAA=hcWTwe9WM2CoaMyrxWX3zHRRa3QyzgMQd5AC5QPGE61o3rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWTwe9WM2CoaMyrxWX3zHRRa3QyzgMQd5AC5QPGE61o3rA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, Nov 27, 2021 at 04:50:58PM +1100, Jupiter wrote:
> Daniel, how can I verify in the Linux console if the connmand is
> running with iwd or with wpa_supplicant? I have disabled
> wpa_supplicant.service, and I'll remove wpa_supplicant completely when
> I find a way to do it.

ConnMan will only show the WiFi technology when the wpa_supplicant or
iwd is running the background. So it's pretty simple, if iwd is running
and ConnMan knows about WiFi, things are setup correctly.
