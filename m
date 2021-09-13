Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB03FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 06:43:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9904C5E4FC;
	Mon, 13 Sep 2021 08:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1631515425; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=DAtn8j1VirNvJkFrHzCgqta7jLxCEgmKOsJ8v1fPdyc=;
	b=aCsgNnE/z3kXuB9h9AdCRwhBmOV0kmL1nhrS56ooqDGe0/rcQnNtTPnHJzHu56a211308T
	iBma3ce7xTnXT4Mk/T1B5PiCjlmo/7ux4tiiUnGUtITtE/y+t5P4Mj3y3LgCLTSrx6PNPA
	cwEm5mNVM73w5ykvPl+5gkpdvKO3JY07kPuG/B1LoIHQ5icg/70DMkbDtVJcU81oDGgF3S
	vlPYAZub1hbLpLzXEQCPcEr0fIB6m5dzVODwk4ImO+cDuzLGW/CgBdUplzy+MmQAGoQIWJ
	otTV/xHk0QGUypMayn7AY+F/KoC99pnsXfseSmyN83TXZt5jUxaZXG7LEXzLGw==
Date: Mon, 13 Sep 2021 08:43:45 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 0/5] Add heurestic and customizable value for VPN auth
 errors
Message-ID: <20210913064345.7vbamqejzttgtyhw@beryllium.lan>
References: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Thu, Sep 02, 2021 at 06:11:19PM +0300, Jussi Laakkonen wrote:
> Implement heuristic for auth error counter to avoid losing credentials
> because a VPN server can report back AUTH_FAILED control message
> unnecessarily. This seemed to be common with OpenVPN providers that
> allow only one authentication at a time from one account only and until
> a short leeway-time (usually 30s) after an improper disconnect the
> credentials are allowed again.
> 
> This is achieved by adding a per provider property "AuthErrorLimit" that
> can be set by the user via D-Bus or by a VPN plugin. By default one (1)
> auth error is allowed until credentials are re-requested (or cleared by
> the VPN agent) if there was a successful connection made in the past
> hour. The feature can be disabled by setting value 0 for
> "AuthErrorLimit".
> 
> This was noticed to happen in a scenario where an OpenVPN is connected
> over UDP or TCP (with some providers this seems to happen quite
> frequently on both):
> 1. connect VPN over cellular with autoconnect set
> 2. connection is switched to WiFi and let VPN to autoconnect,
> 3. set cellular off and back on again (WiFi should be preferred here)
> 4. disconnect WiFi and let VPN to autoconnect over cellular
> 5. re-enable WiFi after which VPN server reports AUTH_FAILED to client
> 6. next connection attempt re-requests VPN creds with error set in msg.
> Usually this is enough to time the network disconnects in the sense that
> OpenVPN binary cannot send the disconnect message back to server having
> following in the system log:
>     openvpn: event_wait : Interrupted system call (code=4)
>     openvpn: SIGTERM received, sending exit notification to peer
>     openvpn: write UDP: Network is unreachable (code=101)
>     openvpn: Closing TUN/TAP interface
> 
> As a solution each provider sets a run-time only previous_connect_time
> using the monotonic boot time clock whenever the connection has been
> successful. This, in conjunction with a limit for allowed authentication
> errors is used to determine whether the actual authentication error count
> is reported back to the VPN agent or by returning 0 attempt again with
> the current credentials. After a connection has been made all errors are
> cleared. If the connection abruptly goes away, e.g., the server is lost
> only the conn_error_counter is increased and previous_connect_time is
> cleared but this does not trigger clearing of the authentication error
> and, provided the credentials are still valid, the next attempt succeeds
> when the server is again reachable. Same applies for a proper
> disconnect. Thus, this solution does not interfere with normal cases but
> mitigates unwanted credential loss in case if the VPN server determines
> connection limit being full and reports back with an authentication error
> message.
> 
> OpenVPN sets this value by default to 10 unless already defined and can
> be disabled by setting value zero (0). Some VPNs may not require this
> option and that is why lenience of one (1) auth error is allowed by
> default.
> 
> Also change to report back EALREADY in case a VPN is attempted to be
> disconneced when already disconnecting. It shouldn't be treated as an
> error.

Thanks again for the extensive documentation. I've applied the series. I
assume this has been in production for a while, so it supposed to work
:) And it doesn't look too complex to figure out what's going on. So
let's see if there are any regression reports (which I don't expect)

Thanks,
Daniel
