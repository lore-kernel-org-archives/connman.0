Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9735443A
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 15:41:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1642A5E01E;
	Sun, 28 Aug 2022 17:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661701285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dQNK680O/1YoooPbV/djRLN8wWXH+sow3OQYr5YtS1w=;
	b=0ptArtYL7AQ/5Fop40nyO7bfzYgZJKNp2F64VP5mh3WSubVESQy60pnM34uBpaW2niqZPE
	gUF0hL9vurK6dHBwmOvA4UE+tJPOKjnZKyS1oP97zGqfI9zoj6rPeuB4RnI/OwEADYXTQn
	lMOqy6aSS4GvOy0EKXUFl2OiPKIMJ7jItmB2anLNwvUqYKFCzMl3i66KYa2GWEV7GhY0yL
	nHYJh99EC1WLfHkgrvkMXjojwCEmxVBXRDSF76049lhIw9gTDGvm0jfQm1oddkob+XROYJ
	24asfRFU5CQCfYfJlRJNAPLswIB/kEOIhdvT1ihEEnrfwnb8J4CfItvHawDRNg==
Date: Sun, 28 Aug 2022 17:41:23 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jakub Jirutka <jakub@jirutka.cz>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] resolver: Add path to resolv.conf to config options
Message-ID: <20220828154123.5tyxlsz5gecx6udc@beryllium.lan>
References: <20220615165350.11431-1-jakub@jirutka.cz>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615165350.11431-1-jakub@jirutka.cz>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jun 15, 2022 at 06:53:50PM +0200, Jakub Jirutka wrote:
> Before (current state):
> If the <STATEDIR> (/var/run/connman) directory exists, ConnMan writes
> resolvfile into <STATEDIR>/resolv.conf. If it doesn't exist, it writes
> into /etc/resolv.conf. If it fails, it does nothing.
> 
> Problem:
> This is unclear and error prone. The user (or package maintainer) may
> create the /var/run/connman directory for a pidfile or whatever and
> surely doesn't expect ConnMan to suddenly stop updating
> /etc/resolv.conf. Or the user doesn't want ConnMan to touch
> /etc/resolv.conf (e.g. openresolv or similar tool is used),
> ever. Configuring this use case by creating directory /run/connman (as
> suggested e.g. on
> https://wiki.archlinux.org/title/ConnMan#/etc/resolv.conf) is really
> weird... and error prone.
> 
> After:
> The user can explicitly set path for the resolvfile in connman.conf via
> "ResolvConf" option. If this option is set, ConnMan writes
> resolvfile to the specified file (and creates it if doesn't exist). If
> it fails (e.g. directory doesn't exist or file is not writable) or the
> path is /dev/null or an empty string, it does nothing.
> If this option is not set, it behaves as before.

Patch applied. Thanks!
