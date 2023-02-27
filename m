Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B07EF
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 07:55:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70891DAC06;
	Mon, 27 Feb 2023 08:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1677484521; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/gcvEk0dd4Wvjo33FPBAyP4rvZ+S9dv3R1/0O2fKOWQ=;
	b=iGDIqdpFcMYtQGPDUfD1zX4pOjHb4ImvSPl0ks+2N7FjJOYqjHmKZ6vAzkTr5OIsdARTzp
	ciylNRgZn8klsRl9zS4fSq2tvmg7T6FCUTJp2uChsV/BA65CC6r4CJpjxde3rkqX1O2G0n
	mmTCxRvaWyY18O4USujUE8I3Ish+OR25AMezh+kifPeGebKlX1synQhUwLbMBBvu7YLM0R
	hqcYwLnM4HteLIxhZn5nj3fI5ztHNlkrklNUuaRf36dNihoBPyO+QvEyafCWrWX/qck6VG
	Hqkc0c8h7hsHXb2Besr2mad9mCIGhnVoPEBxUFT3+WkxMQf99fRNhlj1hs8kGg==
Date: Mon, 27 Feb 2023 08:55:20 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jade Lovelace <jade@jade.fyi>
Cc: connman@lists.linux.dev
Subject: Re: Passing the --nodevice option multiple times appears to replace
 the previous values
Message-ID: <20230227075520.zaf3dte3cjckyake@carbon.lan>
References: <CAFA9we8U1=_7gkiPuXUS2P1n5Bb1=7s5mNCsJf6-7G6vryZ0Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA9we8U1=_7gkiPuXUS2P1n5Bb1=7s5mNCsJf6-7G6vryZ0Rw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jade,

On Tue, Feb 07, 2023 at 02:39:32PM -0800, Jade Lovelace wrote:
> I have been running into a frustrating issue where the connman
> interface ignore lists are misbehaving for me. I was invoking connman
> like so:
> 
> ExecStart=/nix/store/k479wdfq88g5qfhlkpr6maqfzj5q8jf6-connman-1.41/sbin/connmand
> --config=/nix/store/z07f0rkb95d8zjba99pjcy6v7152y5qi-connman.conf
> --nodaemon --wifi=iwd_agent --nodevice=en --nodevice=eth
> --nodevice=tailscale0 --debug=plugins/iwd.c --nodevice=veth
> --nodevice=hostonly
> 
> This had surprising implications in that it seemed like the nodevice
> options were having no observable effect. I went spelunking in the
> source code and found that there seems to be no combining logic for
> the "nodevice" option if specified multiple times, although I may be
> misunderstanding it. Is this intended behaviour?

The argument parser expects it in the form of

  --nodevice=en,eth,tailscale0,veth,hostonly

As far I can tell from quickly looking at the code, the last argument
will win. The filter logic is in

   __connman_device_isfiltered()

BTW veth is already in the global ignore list.

> Also, the man page doesn't seem to adequately describe the behaviour
> of the nodevice option: it is unclear that it uses wildcard matching
> with g_pattern_match_simple from the wording:
> 
> > -I interface[,...], --nodevice=interface[,...]
> >   Never manage these network interfaces.

Yeah, not very good indeed. We could use the same wording as for --noplugin.

Thanks,
Daniel
