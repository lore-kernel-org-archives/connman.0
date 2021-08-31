Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A33FC2
	for <connman@lists.linux.dev>; Tue, 31 Aug 2021 07:22:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C45B60E0C;
	Tue, 31 Aug 2021 09:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630394528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=O9UuVqViGqG6xciH2E0I0fsTCIDoR4dwWkwIhO28Rhc=;
	b=qqecr8yhQBdQRhrNhcjOob/Z7G1vHdyfRW6RebwJPSEaQrAw/Px/LHtU9GV3U6q06CgHZV
	dWK0Vd53h6V8kMlvvEMVfHVq+Ew9+RD6EFz1PckKaYN5SqdSgtgNtzYmSdoT317Y0CKcK6
	+rKqGgCOk/hsNo+cJBzOTaEKwGGpEEoqnJqWRWKCX2a/pPZRvw1rp6UOi/nUg4L6a4TayG
	pEAZgJHeLkuiPogO7KgRc9V2a3KLphE2C9VTl5zuseP+RQq2JQ1VJKs1XvRL68RKsYLjbK
	ruhdBpFe90HWklm9NohcR/izm48TuAwf741GDN6O3XYbZwMLZmr7VWLrW3qH9Q==
Date: Tue, 31 Aug 2021 09:22:07 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Implement connmand state monitoring to vpnd
Message-ID: <20210831072207.4gezq2fkmrdszac6@beryllium.lan>
References: <20210830092405.30964-1-jussi.laakkonen@jolla.com>
 <20210830170631.ni5frzfk6v6jn7s6@beryllium.lan>
 <a0d28b35-d3d0-8454-c1ab-159c6ccd728f@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d28b35-d3d0-8454-c1ab-159c6ccd728f@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Tue, Aug 31, 2021 at 10:00:40AM +0300, Jussi Laakkonen wrote:
> > I fixed up some small whitespace issues in the first patch and dropped
> > the else block in do_connect(). Also added the 'void' argument to
> > get_connman_state() (all complains from checkpatch).
> > 
> 
> Ok, that is cool. Apparently my git did not find any whitespace issues with
> the patches as I do check that prior to sending, hmm.

No worries. I am using the whitespace mode in emacs to highlight issues,
but still I manage to add random whitespace damages. At least the end of
line stuff is pretty much gone with this help.

> Great, thanks. I'm curious, what kind of workflow you have now and what I
> should take account for prior to sending the patches. Does the b4 require
> that all of those patches are in the same thread or otherwise reset the
> versioning when re-sending the patches as a new set?

b4 is really targeting towards full series with consistent version
numbers in all patches posted as new mail thread. It understands the
versioning strategies and workflow. For example if I tell it to use v2
instead of v3, it will tell me, there is a v3 on the mailing list
(subject of the cover letter has to match). Overall, it's an absolute
awesome tool and I am glad we are hosted on lists.linux.dev, so that I
can use it. Konstantin did a very nice presentation recently on b4:

  https://people.kernel.org/monsieuricon/

Anyway the idea is that you have changes in your git tree and to create
a new posting do something along the lines of:

  git format-patch HEAD~~ -o ../patches/fancy-feature -v1 --cover-letter
  [edit cover letter]
  git send-email ../patches/fancy-feature/v1* --to=connman

and after reworking the commits, you do the same just use '-v2'.

BTW, if you want to add a change log per patch, you can use 'git notes'
and use 'git format-patch --notes' to add them. I haven't used this so
far, but looks very useful. Have to play with it :)

> Also, it wouldn't hurt to download Linus' checkpatch.pl :)

Yeah, just use it with a grain of salt. It tends to be too eager but it
helps to get some consistency into the code base.

Daniel
