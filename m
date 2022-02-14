Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035F7A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 07:45:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 267115D36B;
	Mon, 14 Feb 2022 08:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644824746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5P6uW27jZy5Mtzq7c2aQlz4nnE6k5rKj9ZigWHuiCg4=;
	b=niZhdRXmEzE0Lui3ebfGJyZwSF05PqPZr/4ff/zvfwjMeMCiR4BRk48pVIoDjuj/v7J91e
	E4NzwZehx1oHskdxKGOR1hnVc3LcOvztcPY27sM/W0uDMPyDMtXlgmC6TBPLlvTiJjrIco
	auCFjVIiuw2wgPDbuKvMDaPAEsPmToqyLl6MgRgIweGobsvJs/GAGmZkfYAcaRG7RbXjOx
	0Fm9pzU7/Fs5HFkYWb5rfSrb5PjxZ0TbnYy9KsE+PtUQgwQ7GmWisaIVUZaYbyDkCpf8K+
	kczZLp9P2z+tVPrjS8+LW+EhukI5a8WmgxAB4C9duevXWr1qwBYpp7mXxsHA8w==
Date: Mon, 14 Feb 2022 08:45:45 +0100
From: Daniel Wagner <wagi@monom.org>
To: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: connman@lists.linux.dev
Subject: Re: Unification to connman configuration? Now it 3 separated places.
Message-ID: <20220214074545.47utpy7s6afeohwq@carbon.lan>
References: <e69350dd-6028-841f-8f0a-069cb4ec16d1@protonmail.ch>
 <20220130145110.ax6aio73c6le7xrk@beryllium.lan>
 <42368e37-a297-5a1b-193f-b350b58f6d64@protonmail.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42368e37-a297-5a1b-193f-b350b58f6d64@protonmail.ch>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Jan 30, 2022 at 09:50:31PM +0000, Piotr Karbowski wrote:
> If you were to move the /var/lib/connman/<SERVICE_NAME>/settings to
> perhaps subdirectory in /etc/connman/networks/ it could work. One of the
> example could be NetworkManager that actually dynamically create files
> in /etc.

/var/lib/connman/* are not configuration files. These files contain the
state. The are under control of ConnMan and will be overwritten.

That means these files need to live in space where ConnMan can write to
(/etc will not work). Furthermore, embedded devices tend to be vary
cautions about write updates and often move such things to a tmpfs.

Another problem is the id used to apply to a newly discovered
services. The path is constructed using the MAC. In my opinion not very
convenient and not really future proof.

All this is solvable but it is a bit more work than just moving the dirs
around. I think we would need to introduce a new configuration logic here.

> That would be pretty clean interface to configure connman. Especially if
> you need to pre-create some configs for services manually like 802.1X
> that I think is not supported by any userspace utils that ships with
> connman.

Yes, I do understand the need for something like this. Ideally we
wouldn't come up with yet another config file format. Maybe we could
reuse the one from systemd-networkd? No idea if this would work, just an
idea.

Daniel
