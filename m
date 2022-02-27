Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0984A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 17:47:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2F0B5D30E;
	Sun, 27 Feb 2022 18:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645984033; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Wz5TVlmtqkwdzsbqW6YBItV+RR8wrRZA55h6hDqMSYQ=;
	b=rly/KXz8WFW4+exaIOxmKjVrcmQNRmMwIWskroKTjKBX/XT5E+iqu2CHrlstcM1ebv+Zkm
	pQm5jjn21t1XQYE0wPrPDqx1iYlhyzUwxsfsbkVJyqpl6eRHa6JFXB7zl52iwmMxqAV/sh
	UqAo+JHehOaVnz5MDA1Xykb14PjlChEacFEoEfpbFDGM/e2+91IrE+ZLY+Cvv3+3nvyTCu
	lLAQsDXcq6GZplo9kTZDznzeoUfZ8OEAdqkNCLn2JqW5IqgCyNXUd3Lewgb1IUakXi+tt/
	LxJxdMPnq3rmLFv6L6ksP3WSOYZWux/D5KaY2lDPeXWabqwLyqYQwdE2zojUcw==
Date: Sun, 27 Feb 2022 18:47:13 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [WIP PATCH v2] iwd: Fix disabling tethering not working for
 brcmfmac
Message-ID: <20220227174713.hgfgkp4a6czudalr@beryllium.lan>
References: <20220215102638.599189-1-net147@gmail.com>
 <CANwerB0jFWpnTkpF1qispnAw5K1X__OQjMP=xEEGe9UHLDMd1g@mail.gmail.com>
 <20220221083259.yj2gjrqbeplny645@beryllium.lan>
 <CANwerB1ETxcgeGhaCg3zRmjCZ-uAUaeDY0mePe9Mg1z2xCh9wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANwerB1ETxcgeGhaCg3zRmjCZ-uAUaeDY0mePe9Mg1z2xCh9wQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonathan,

On Fri, Feb 25, 2022 at 07:33:22PM +1100, Jonathan Liu wrote:
> > I think your approach is correct. The order of cleanup should be in the
> > in reverse to the setup steps. We add the interface to the bridge when
> > we get the Started signal. If I am not completely mistaken we should
> > first undo this operation and then call Stop.
> >
> > The only thing I need to double check if we do not leak any resources
> > due to the -EIO I saw there when I quickly looked at.
> 
> Would you be willing to have an attempt at this as you are more
> familiar with connman+iwd?
> brcmfmac is quite common - it is used for Raspberry Pi for example.

I gave it a quick test run on my setup and guess what I was also getting
EBUSY without your patch. So this definitely fixes stuff. Let's see if my
worries of -EIO might cause issues. But we can deal with this later.

Thanks,
Daniel
