Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690AA2C
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 17:46:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF19E5D323;
	Mon, 14 Feb 2022 18:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644860760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YzhvhpcPhG3P1m8Mfo7ZqS4g3UZ2tU+mly+qa8nHb44=;
	b=s+TK4uvpVpnoRE9d0m7KZi1G34ZJUZgar2UBwhGw2bZtS9vluWfjt3JA3X+H7/H4vFqkJr
	QaY/G3IJybA99LgHt8nDvNa18ocAaNX7sTbzqJNjIaJGv3K1RpiUG90hQfvNKet41aMzfE
	Tp/p5GDAy6Qc33nxQN/xoN5vYfj3pWyucfVrfSkJzN2wWn693PZJCyrEfevpGYl6+G/Um/
	PIxCAy7SoQKFtPm0oVM6wPHdPG/QY3o5FV3LzP/EwhIM7c/bRbaOB/JQXCaNPOeaTKwdQl
	UEreK8W8qw04RnoW9CdnLJHV3K9VGDQWVDpag2Y/Gt64nHh/TutZkbgRvmYv3g==
Date: Mon, 14 Feb 2022 18:45:58 +0100
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: connman issues with enlightenment since last =?utf-8?Q?upgrad?=
 =?utf-8?Q?e_to_version_1=2E41_Bo=C3=AEte_de_r=C3=A9ception?=
Message-ID: <20220214174558.tuvtbfwohy3e63qu@carbon.lan>
References: <CA+iibzAqa2-xPiddMfjX-EmsvMt7dYV39mW5WBLnUNN=B9gYAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+iibzAqa2-xPiddMfjX-EmsvMt7dYV39mW5WBLnUNN=B9gYAA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Feb 14, 2022 at 05:33:25PM +0100, daniel antoine wrote:
> I have seen your answer on lore.kernel.org/connman but not on my
> e-mail. How can I do a log ? by adding /usr/bin/connman -n -d
> /home/user/connmanlog.txt in the connman.service file ? I have tried
> manually, it has functionned but not written the file.

ConnMan writes to stderr for logging, so you need to redirect the stderr
to stdout:

  # connmand -n -d 2>&1 > cm-log.txt


> I can reproduce the problem by just removing the main.conf file with
> EnableCheckOnline=true

Alright, sounds something is not getting the default setup correctly.

> in both cases (host wifi interface ready or online) when I start a
> virtual machine and when I do an upgrade in the VM and reach the repo
> server the vnet0 interface on the host get an address 169.254.xxx.xxx

So there is no DHCP server. ConnMan tries on default to get a DHCP lease
if this fails it will setup the interface using IPv4LL (a.k.a IPv4 link
local or bonjour). Anyway you can configure ConnMan not to use
DHCP/IPv4LL.

Daniel
