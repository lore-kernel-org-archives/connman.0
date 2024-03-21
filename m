Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137557301
	for <connman@lists.linux.dev>; Thu, 21 Mar 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018346; cv=pass; b=MrJPjzEnSpgfCFR6b2OjwYkI6hv1OpxHgLk0zxt2Qg5sSfJTqATg2vlc36qoX25Up/nALxF5SAmsx3M4yHLrS3kZVB05N40ILaNHUsr7IA+fVqErg366tRIkr38x4iUZ1kVcJtIflOgaTIaVnI9DPuuGpm/3npvmbMQ8I+gyHZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018346; c=relaxed/simple;
	bh=T7Y1Es+HCs0qZ3x3uFRSDPCx0TSvfE5un6zznhJIC3w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DG4WeTwxM2DRI2I7jZMzMmGTVM4rsNkrkw1KIJWfVli1jjiYLzy3ISEJKCsdeNGvVewtyNYAMVVUwFsG8u2gw+A12qL3vokg2GaJ8MjO7WN3Ga0WgRP8ouMisyxkA4IR+4RzSGaNEt2KvOfnBdLNqU1hLYF/jRnagsA3UCrDZWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freebsd.org; spf=pass smtp.mailfrom=freebsd.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=NSZVgz/Y; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freebsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebsd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="NSZVgz/Y"
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4V0j2v38MBz4fsj
	for <connman@lists.linux.dev>; Thu, 21 Mar 2024 10:52:23 +0000 (UTC)
	(envelope-from misha@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2610:1c1:1:6074::16:84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "freefall.freebsd.org", Issuer "R3" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4V0j2v2Gyzz4CXN
	for <connman@lists.linux.dev>; Thu, 21 Mar 2024 10:52:23 +0000 (UTC)
	(envelope-from misha@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711018343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=T7Y1Es+HCs0qZ3x3uFRSDPCx0TSvfE5un6zznhJIC3w=;
	b=NSZVgz/YNlVrCzBgL6OLMGBouL8XiZgQs8b1cdnji63EhXUX+pT0FVQgojCaq0YixRUz7P
	fUK8OczT5SB5n8ZteZLOCibaduUsHFKrhzS134VAHr55d2fqy0/KUsZYys1pKURqc17Cg4
	DgG2GIW0DiUKLKQFzQEeOvewiYs1MQuxsWVa6qJ3xcuU+HopsaE9rUiTkI9/muyemPZg8a
	fP7wgKvX4Syq3aniXWQV58U9jfGfBV1/c2qIqzYI0O47+oI9MKRq3pZ8zJjPTFomyi2JEH
	xx4xNcWVQ9ssKE3t0uPxYfdUcJKE+BJgyyEIejZ4LbG1d4/TRvL4LxeWRyJfvw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711018343; a=rsa-sha256; cv=none;
	b=ijdQvEHxXyCVOkb88dZI97Jk1vWsC36e79A/iIQQzsJS/vG4s4vjAJW3TL37IMjgTZAVhJ
	2YB0fh/SnCDKX5JMo6fsbrpxWN/mI0EYmNipMq1bTHoqwTpgho8h2FcWWAw3OaBfo8fUFh
	7o9grLGcyByD/rMUZajmux9PuitnpYM3YPBD+leiNTVqei3sJx1pUNmLvXEH5m2bm1c6zN
	00UpuM079EVQc5x2gowwXFk+Ztq931rG0f6OLk1uAgSptelGXTWvsDzHA7nNYVqLWqhN+j
	8CX3u6RD+x3uP3YwmchqWUtaSsUVnWWi//5u4ICfvo42GJGCS0awIaWcX+bXMg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711018343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=T7Y1Es+HCs0qZ3x3uFRSDPCx0TSvfE5un6zznhJIC3w=;
	b=DEb7BfzlQ1MzjvdaI2s/wzyAo8zH6ALVDEZ6zn65RoIHTUM7OjkEQu3orXfw03Ffvt8nnR
	LlzmdwShV1plcZQOU9dr9W0KXdbxMCUNN5jPAcEXdErJdu+j0NZwzvJOpe/J5XYlUaJPol
	JwmiGuCPXuGZZQO8xmuocQYsJ8NdYnsbxveThSkPoBMtYDLPzZQidTK75fnDAB8USFptFV
	lQBru5caHiZ1NLs7RMsip4oKVZoNqbjMm/WhqnR4chg9DvdDrDdIQ+Y+15KzzjWmT0U9lJ
	pK5/gbO4Jb62aLnN4yNb71PxQGD4QOfcgPs96o+Vi5oMLcs3Xg4rJUkr7WXUwg==
Received: by freefall.freebsd.org (Postfix, from userid 1401)
	id 44970B564; Thu, 21 Mar 2024 10:52:23 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:52:23 +0300
From: Mikhail Pchelin <misha@freebsd.org>
To: connman@lists.linux.dev
Subject: restart required after adding EAP config file
Message-ID: <ZfwRZwIj0vC6e5aq@freefall.freebsd.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ I'm not subscribed, please keep me CC'ed ]

I'm running 1.42, when I create eap.config file in STORAGEDIR it's not
being applied right away for wireless services - I see no '*' sign near
my SSID in 'services' output. 'connect'ing to it gives EINVAL and debug
logs say:

EAP type has not been found. Most likely ConnMan is not able to find a
configuration for given 8021X network. Check SSID or Name match with the
network name.

If I restart connmand, the SSID becomes configured as intended and I can
connect.

Is this behaviour intentional?

What pieces should I look at to make connmand apply *.config files to
currently known SSIDs without restart?
