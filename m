Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD72C81
	for <connman@lists.linux.dev>; Thu, 14 Oct 2021 11:46:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 409E15E306;
	Thu, 14 Oct 2021 13:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634211981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=E8Ij5SFc0P3A36vKmFdNZlc/sp6CfbqeZY7mbVvt6A0=;
	b=CYsNIN3kLw8tje4dzI1Um+eNEeA9vQiiv1c8/2ill9AJvxziTmwQfdaQPGkR8Ab5auH33P
	Tjy6gN5eGnrIB1EtRcJyFkgkY+LSAiW87Nwh2mlSIRXMaljOV9fcz5yWoKPWyOd3QtdB1c
	7vwnZXscT8uHEU+MzuzjEiqTQLBuFy8yY5Age95G/7AfO4wPpC+9hpEt9iYLD7d5u2IGFN
	pNAJZ6tQUrxMu+KVsj4KpptUOYdcsuiAe1KzXU5G7eTXCxKcKv2hhv5uoOpojMVPuUma4K
	I2se3R/J/nQHOUJkLCc/OMn70J8uWl5J2iqbAJgPQYBzIzsmmuEU1YgbwBsymw==
Date: Thu, 14 Oct 2021 13:46:18 +0200
From: Daniel Wagner <wagi@monom.org>
To: Thomas Green <TGreen2@Sorenson.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: origin of the settings file
Message-ID: <20211014114618.ady2bsmfxae6yfpn@carbon.lan>
References: <DM6PR04MB7003B851E2E4CD0BEDAAA5BE9FB79@DM6PR04MB7003.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR04MB7003B851E2E4CD0BEDAAA5BE9FB79@DM6PR04MB7003.namprd04.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Thomas,

On Wed, Oct 13, 2021 at 10:33:39PM +0000, Thomas Green wrote:
> I'm looking at the file ${LIBDIR}/connman/settings, and trying to figure out
> where it is coming from.  I look in the recipe and don't see it, and
> in the install portion of the .bb file, and don't see it.  Where does
> it come from, when is it created, and how do I make it default to
> Enable=true?

This file contains the state of ConnMan and will created at runtime. You
don't have to package. As this file is under control of ConnMan you can
only modify when the daemon is not running. So you could ship a setting
file which fits your need, just make sure it is written before you start
ConnMan.

Daniel

