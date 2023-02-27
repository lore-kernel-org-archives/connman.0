Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BE659
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 07:14:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 773FFDAD0E;
	Mon, 27 Feb 2023 08:09:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1677481766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fsPc1gAHwTyEZPr8+R2qIqo8AwOfP5KFdODsP/p/kug=;
	b=Z7dsPZptD9LCrX2Ysg0B5i2/7OcgqAVah1dNsYCaW+2TY7J+3tEI9BSVwEp9MUbkn8N3YM
	xdCgejrN1lC9uWP4lSc4g+g3kY+zucr6EmO0MbxOsFlZUaJU8xQCFSdH3RpaYSLRopIE/Q
	ANUu+s77kKFOiTwNyPDBHiaC237DENAkVT7pfwYmsaJc/w8ZpYRhqh4l99ARmCCirtKDQ1
	D6TmP71QNCarjHxCUUhEP4DwXp91HHs0KIc5SEia/9sdK0k4klx2C7pRpIRnbqMA8pzAW6
	yuZJhEXhDVW7rGKVsKqQrZbo62tu+dOfeNelF1DcsTOQamYGqW8bcXIahYteQw==
Date: Mon, 27 Feb 2023 08:09:23 +0100
From: Daniel Wagner <wagi@monom.org>
To: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: connman@lists.linux.dev
Subject: Re: Unification to connman configuration? Now it 3 separated places.
Message-ID: <20230227070903.rpbd6bleozrv3tjn@carbon.lan>
References: <e69350dd-6028-841f-8f0a-069cb4ec16d1@protonmail.ch>
 <20220130145110.ax6aio73c6le7xrk@beryllium.lan>
 <42368e37-a297-5a1b-193f-b350b58f6d64@protonmail.ch>
 <20220214074545.47utpy7s6afeohwq@carbon.lan>
 <cf41cdd7-6b79-3619-5bc3-64bc1ec18794@protonmail.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf41cdd7-6b79-3619-5bc3-64bc1ec18794@protonmail.ch>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Jan 31, 2023 at 11:29:26AM +0000, Piotr Karbowski wrote:
> Hi,
> 
> On 14/02/2022 08.45, Daniel Wagner wrote:
> > On Sun, Jan 30, 2022 at 09:50:31PM +0000, Piotr Karbowski wrote:
> >> If you were to move the /var/lib/connman/<SERVICE_NAME>/settings to
> >> perhaps subdirectory in /etc/connman/networks/ it could work. One of the
> >> example could be NetworkManager that actually dynamically create files
> >> in /etc.
> >
> > /var/lib/connman/* are not configuration files. These files contain the
> > state. The are under control of ConnMan and will be overwritten.
> >
> > That means these files need to live in space where ConnMan can write to
> > (/etc will not work). Furthermore, embedded devices tend to be vary
> > cautions about write updates and often move such things to a tmpfs.
> >
> > Another problem is the id used to apply to a newly discovered
> > services. The path is constructed using the MAC. In my opinion not very
> > convenient and not really future proof.
> >
> > All this is solvable but it is a bit more work than just moving the dirs
> > around. I think we would need to introduce a new configuration logic here.
> >
> >> That would be pretty clean interface to configure connman. Especially if
> >> you need to pre-create some configs for services manually like 802.1X
> >> that I think is not supported by any userspace utils that ships with
> >> connman.
> >
> > Yes, I do understand the need for something like this. Ideally we
> > wouldn't come up with yet another config file format. Maybe we could
> > reuse the one from systemd-networkd? No idea if this would work, just an
> > idea.
> 
> I recently had to do another round of connman configuration which
> reminded me about this thread.
> 
> Wanted to ask if you still consider this a feature that's worth getting
> into? I kind of got used to the current way but still believe it would
> benefit many to have it unified. I am all into being the tested if you
> ever decide to introduce some new interfaces to configure connman.

Yes, it still makes sense to me. Though I become a very poor maintainer and I
think it is high time to hand over the project to someone else. Without someone
looking over contributions the bit rotting continues and new feature are
certain not going to be implemented by me.
