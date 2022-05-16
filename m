Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3D7A
	for <connman@lists.linux.dev>; Mon, 16 May 2022 06:47:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 737FF5D91F;
	Mon, 16 May 2022 08:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1652683672; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UX4lCGN32ARnqATbUTOghlVwUROzXZImJ9IsW6jyT9Y=;
	b=XC0ss2pXXmtEm0DOHJBlI4Dr+ipT2YEOtyxUe3UBCrupQoF+jk5897cyf1RUbBH4IRiiyb
	ddqanZgxo3yxG9YXIF//W9zuFVWHx2UBuXFK1t4WxXQaUOaKdnSGhMPtgpppW5cZj0//J7
	gK9Pn8fDadrpykumEFBPTpdnomXq+n8/OE7miUK/H1jrvDe20VBw1H7mNmSNjiVF4RHnsS
	kr2I+/1Cgq8pwrPV+sZUDIwIEjYof4pqvULRq7U0BzqL7BpqEytcL7cV9DXTHjH9qH+BYZ
	aJngD4VNp6Pv0gS5YxCzZgoSIbAr+Jt7lcAAfQWS9n9BJgqxIq5ZMNTfAexhmQ==
Date: Mon, 16 May 2022 08:47:51 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jakub Jirutka <jakub@jirutka.cz>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] timeserver: Add EnableNTPClient option to connman.conf
Message-ID: <20220516064751.3e7mwpketsdgjm5h@beryllium.lan>
References: <20220414001208.4026-1-jakub@jirutka.cz>
 <20220414190515.toyyuk55zylrq25g@beryllium.lan>
 <925411a3-f77c-77db-ce12-0e064932c9ac@jirutka.cz>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <925411a3-f77c-77db-ce12-0e064932c9ac@jirutka.cz>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub

On Sat, Apr 16, 2022 at 12:51:09AM +0200, Jakub Jirutka wrote:
> On 14/04/22 21:05, Daniel Wagner wrote:
> > On Thu, Apr 14, 2022 at 02:12:08AM +0200, Jakub Jirutka wrote:
> > > The builtin NTP client can now only be disabled via DBus or manually
> > > editing the state file /var/lib/connman/settings
> > > (`TimeUpdates = "manual"`). These options are not optimal for a setup
> > > where a standalone NTP client is used.
> > > 
> > > The approach for disabling NTP client (in timeserver.c) is based on the
> > > existing code for handling state setting `TimeUpdates = "manual"`.
> > > 
> > > I originally wanted to implement this using CLI option, just
> > > like --nodnsproxy, but after reading the message from Daniel Wagner
> > > on ML (Unification to connman configuration? Now it 3 separated places)
> > > regarding --nodnsproxy, I concluded that the config file is preferred.
> > 
> > I am not against the idea to have the default configurable via the
> > config file, but please make just the default behavior so that the D-Bus
> > API still works (unless I read your patch wrong).
> 
> Do you mean that it should be possible to enable the NTP client via D-Bus
> even if it’s disabled in the config? This would introduce, in my opinion, a
> quite unexpected behaviour; it would mean that:
> 1. the state settings (controlled via D-Bus) have higher priority than the
> config file;
> 2. once the NTP client is enabled via D-Bus, it cannot be disabled via the
> config file.

Yes, that is what I meant. One of the reason why we have this kind of
messy configuration situation is that we tried hard to avoiding to add
options to conf file and only have the D-Bus API. As it turns out this
didn't age too well. This is why I think the D-Bus should have
preference over the static configuration as this is/was the primary way
to configure the system.

> I think that it should be just the opposite – if the user set
> EnableNTPClient=false in the config, the NTP client should be completely
> disabled, analogous to the --nodnsproxy option.

The dnsproxy setting doesn't have a corresponding D-Bus API.

> Now that I think about it, I
> should probably also update net.connman.Clock to correctly report
> TimeUpdates=manual when the NTP client is disabled.

:)

Daniel
