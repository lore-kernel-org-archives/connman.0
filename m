Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EA2CA5
	for <connman@lists.linux.dev>; Sun, 30 Jan 2022 14:36:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 969415CFFF
	for <connman@lists.linux.dev>; Sun, 30 Jan 2022 15:36:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643553390; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding; bh=0C45ySCMBygJjgJEmC3dOTGerJjhEVSofPZQzjRSnJ4=;
	b=fDvIRaOBbpzaMROKaXIQKdpGRnvkZs2ou1fNT7aRFxdU6b3mBjm3oNsVX4qv2OAUMv64bX
	wudkogvgwdyixxOgdHO+Go+4LYz92vDUvwvNv3sfh9K3PLJiA3+ZY/JwfJG3qxZKu5/KHj
	1XaqKp2fyIblqog1CcbMMzhobUOsrvhQK7nWCEo632Abtnymy0qZ4nOeCZ3EutDcjLqm4Q
	tzPq1/PtAuUEdBYJx0n+a8pVVSCij50nzs8aYRBnkfTN+2rCrylgjPRwm77jwBfqPF03lm
	QeGI54DM9T7/0Jr6Cce1KH7K25fniND5E+twJSBa6JRGbdV0yXgFLQJdtZkHYQ==
Date: Sun, 30 Jan 2022 15:36:28 +0100
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: ConnMan release 1.41
Message-ID: <20220130143628.rccsvpb34hwcayff@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

A bit late to announce it but we have a new release of ConnMan. Again it's a
CVE driven release. So if you are using the built in dnsproxy you should
upgrade now.

If you are an iwd user, this update also brings a bunch of bug
fixes. Overall, the iwd plugin seems to be usable. So no reason not
to switch over to iwd.

For wpa_supplicant users there is now WPA3-SAE support.

There rest are bug fixes all over the place. Nothing too serious but
still

A big thanks to all contributors:

Ariel D'Alessandro, Christian Taedcke, Emmanuel VAUTRIN, Jussi
Laakkonen, Lukáš Karas, Marcel Holtmann, Matt Vogt, Matthias Gerstner,
Michael Trimarchi, Rahul Jain

Daniel

ver 1.41:
       Fix issue with RTNL netlink message alignment.
       Fix issue with dnsproxy and timeout for TCP feature.
       Fix issue with dnsproxy and busy loop in TCP server.
       Fix issue with WiFi connection with no passphrase.
       Add support for wpa_supplicant and WPA3-SAE functionality.
       Add support for D-Bus ObjectManager interface.
