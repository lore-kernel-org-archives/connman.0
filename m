Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC42CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:22:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D85E05CD19;
	Sun, 19 Dec 2021 18:22:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639934547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=z/pEitauj/zOIRoubwp+4J4r8AGNsnDKXoFivTllBBA=;
	b=ukGTgwTBd7TNVem+5/vTV6KOWq8WdBoTLxG4OyLRqpOz3A23utyhMLEvC+MzHnlq09tWb+
	rdKrwI/VOCcUYQAjL0a928golpcbHyjdy3tZfN1Ie0osMMcCAObY4gPVK7BzFVBU6TlzTn
	dQNzJ7z9MMIBybCyt56t3yQ+P+pXxlgmOWE+5hm34/NmxsJ0po0Nkuh6B/+/QCtMrQ2h3i
	BpSALUFGrQehawzSxsyZWTScEzvwwrSFGN9U0WHJj3iKHgx3yUrmo0QGw2vQx1fEHgYr+L
	5B0zk3XNb6m5c+Y9amVQb3S0WpozDwJY95uQHMnp2dzOGlux5EPD1M00nQncNg==
Date: Sun, 19 Dec 2021 18:22:26 +0100
From: Daniel Wagner <wagi@monom.org>
To: Klaus Ethgen <Klaus@ethgen.ch>
Cc: connman@lists.linux.dev
Subject: Re: Too many wlans
Message-ID: <20211219172226.73tupsi7z24hkiiy@beryllium.lan>
References: <Ya4LuuATLuB7waD6@ikki.ethgen.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya4LuuATLuB7waD6@ikki.ethgen.ch>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Mon, Dec 06, 2021 at 02:10:18PM +0100, Klaus Ethgen wrote:
> Hello,
> 
> I found a bug in connman when too many networks are stored into
> /var/lib/connman.
> 
> I shuttle between different locations and today, connman stopped showing
> networks at all. After some debugging, I found the following Messages in
> wpa_supplicant debug output:
> ```
> wlan0: Event SCAN_RESULTS (3) received
> Scan results did not fit - trying larger buffer (8192 bytes)
> Scan results did not fit - trying larger buffer (16384 bytes)
> Scan results did not fit - trying larger buffer (32768 bytes)
> Scan results did not fit - trying larger buffer (65535 bytes)
> ioctl[SIOCGIWSCAN]: Argument list too long
> wlan0: Failed to get scan results
> wlan0: Failed to get scan results - try scanning again
> ```
> 
> The `Argument list too long` got my interest and I looked into
> /var/lib/connman finding 104 directories in the form
> wifi_XXXXXXXXXXXX_XXXXXXXX_managed_XXXXXXXXX.

Do you have the exact log for this? ConnMan uses GLib APIs for iterating
over files and directory. I would be very surprised if GLib is not able
to deal with this small numbers of entries.

> After deleting all directories and restarting connman, everything went
> back to working state.

I don't think 104 known networks are a real resource problem as long
there is enough memory in the system. But even then, I don't think
ConnMan needs more than a few kb per known network.

> So, if that directories is an issue, could it be cleaned up?

Yes you can cleanup the directories but it's recommended not to do this
while ConnMan is running.

I think by deleting all known networks and previously corrupted? entry
got removed which prevented the proper working before.

Daniel
