Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257B4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:13:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AFE35DFF2;
	Sun, 28 Aug 2022 20:13:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661710409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+tRWRZ3nElTj4WdWmoGEhBL70iuEYp3pfpJbu+eGG9Q=;
	b=QufSwFx0TW7Bv5+Rm3H84BlUCChqzqpI8CHfyAFdfnd7vf12KIV+Jb3OrUe01bkaJGP/3n
	ICkHj98sHu40yUm0gEOcui5S6fYVIImkYCKEUutPdw8HnbyJhP6rJTcmw9E5qAb7BPmHdc
	ZSArbS3AF/AoRb0BQ80TlVVzDaVaVsvtc9Ck63w73HXeyP9v7zEWUkYi1aSci6hNv3IVMK
	o86X+dTrZnLaoWrgyx7z499ITkpy9NF6tkibPF770aUSOMfrojlU8mH4gwIfykqT5G5Jkz
	4GQ0zs/U+37OzexbRl+yDhLk3RSKgGb8LANMnoFHNLCB9qIlTX7qhQHqsil0jg==
Date: Sun, 28 Aug 2022 20:13:28 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828181328.qhotnte7fmzgj4bf@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <20220828174050.ate53trz2opzyczg@beryllium.lan>
 <a18acdfc-1399-9d01-851b-7fb4ae9eeec0@dark-templar-archives.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18acdfc-1399-9d01-851b-7fb4ae9eeec0@dark-templar-archives.net>
X-Last-TLS-Session-Version: TLSv1.3

> With this patch, when I'm restarting connman, my network doesn't work. Not
> enough default routes present.
> 
> Here's my routing table without this patch and without VPNs:
> 
> $ ip route
> default via 192.168.1.1 dev eth0
> 192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.158
> 192.168.1.1 dev eth0 scope link
> 
> Here it is with this patch:
> 
> $ ip route
> 192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.158
> 
> eth0 is a wired link, and it uses DHCP for address assignment.

Yeah, I assumed that __connman_ipconfig_get_local() is only used with
IPV4LL which was not true. See my other path. This one should filter out
the invalid GW address.
