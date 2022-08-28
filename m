Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A84699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 17:49:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3515F5DE97;
	Sun, 28 Aug 2022 19:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661708974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5quPGojSkx0L7GiVOZUj4nmxwtJ+dZzU4e7GWBl/HDQ=;
	b=QxxeqzQe7uVfDL1SbEVTLp3+5BdW2jamuAO4hxARC4zCzeZMWEjZqDvNHdehDNAXn94iWI
	eyuKnSls0yiCuXvVmIL3esdZfqZIKJjKM0tQtH0psPX2rEzMsm11Io5IXmZUNrM1O/V19w
	rnVygIbezI0laUIQTJiy5qcWtHwlM0Q+T9vuhoHQaoePm2Ml6Atpn9H0lDu4tQQ5OJeefM
	MZKcMULd22imn8Uw3afejGfV1J1CYAfnsP2ssmnSWp2GnOX4T04iL7/jfTvH2OtvzF+ltb
	lx8QHtdNFBKghZEr4Rotr/sQF97zwEtCpbVktBcJu8CIq8RHhlW+RYx5rMl58Q==
Date: Sun, 28 Aug 2022 19:49:33 +0200
From: Daniel Wagner <wagi@monom.org>
To: Quen Jankosky <quen.jankosky@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Default Routing Issues, And Potential Solution
Message-ID: <20220828174933.tywzdlt4rgpbjar5@beryllium.lan>
References: <CAFT6v_b-nE0TkTRDNcEPgb6wDue0NAwWPBEDevVfA=VBDD-rqg@mail.gmail.com>
 <20220828140621.fs5vy55x2g2minl6@beryllium.lan>
 <CAFT6v_YpO1EC3wxaovLnNN=nF9wg4i_543rm39RLW6Ewg5Xp9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFT6v_YpO1EC3wxaovLnNN=nF9wg4i_543rm39RLW6Ewg5Xp9Q@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Sun, Aug 28, 2022 at 04:42:04PM +0000, Quen Jankosky wrote:
> Thank you for the insight, but I'm still not really sure about much here.
> 
> On Sun, Aug 28, 2022 at 2:06 PM EST5EDT Daniel Wagner <wagi@monom.org>
> wrote:> https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/overview-api.txt#n116
> 
> I viewed this doc, it was certainly helpful to gaining me more insight
> to what I'm trying to figure out here, but some things it describes
> are still unclear. In all honesty, I am left more confused. For
> example, here: https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/overview-api.txt#n130

Yeah, it's written with a GUI in mind...

> Within overview-api.txt:
> >To change the default connection to your access point, the user needs to
> >manually drag the access point service to the top of the list. Connection
> >Manager will not take down default routes if there is no reason to do so.
> >A working connection is considered top priority.
> 
> ... I don't really know whats being described here. The documentation
> doesn't go over any specific way to do this "dragging," and as a
> result I'm just kind of lost on how you really are supposed to
> prioritize a specific service for the default route.

The 'dragging' can be achieved by using the move-before or move-after
D-Bus API

> It's also
> explicitly stated that the order number is an internally handled
> value, which means (at least from how I can interpret it), there's no
> real way to determine the order of the services on a daemon startup.

There are some ordering rules, like prefer certain technology (e.g. WiFi
over GSM) and within a technology favorites before non-favorites. But
you are right, there is no fain grained default ordering. If you want to
do this, it's possible to write your own auto-connect plugin which is
able to support more fine grained ordering.

> Is there a way to set the order number for a specific service in their
> configuration file, or at least through the d-bus or connmanctl
> interface?

No, such a fine grained API doesn't exist. Technology perference and
Favorites are the existing (default) APIs.
 
> > Does it still happen if you disable the auto connect and wispr feature?
> 
> I am aware of the auto connect feature, but I haven't seen anything
> about wispr in the man pages. Is it for the latest connman version? I
> did see your commit from yesterday involving it. I am not willing to
> change the autoconnect feature, however, since the solution to
> manually change the default route is mostly a hack when connman should
> allow me easily configure which service has it.

I was just asking if the problem is related to these two features.

> I apologize if I'm not understanding any of this, but this all seems
> unclear even in documentation.

All good. There is not a lot of documentation, that's
true. Unfortunately, you are not the first one to find this out but
there is no one stepping up to work on it.

Daniel
