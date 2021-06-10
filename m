Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AB70
	for <connman@lists.linux.dev>; Thu, 10 Jun 2021 11:35:12 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 45253500517
	for <connman@lists.linux.dev>; Thu, 10 Jun 2021 13:35:04 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 111D250026A
	for <connman@lists.linux.dev>; Thu, 10 Jun 2021 13:35:04 +0200 (CEST)
Date: Thu, 10 Jun 2021 13:35:03 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: [ANNOUNCE] ConnMan release v1.40
Message-ID: <20210610113503.ob45lhssqy5hk4ki@beryllium.lan>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We have a new ConnMan release v1.40. It's bug fix release with a fix for
a buffer overflow in dnsproxy (CVE-2021-33833).

Noteworthy are the improvements for iwd. It fixes the autoconnect
interaction between ConnMan and iwd. ConnMan relies completely on iwd to
handle the autoconnect for WiFi.

The OpenConnect VPN plugin got a rewrite and uses libopenconnect for
authentication. This avoids the output screen scrapping done previously.

Thanks everyone who contributed directly or indirectly for their
support.

As you might have noticed ConnMan's mailing list has moved. The project
is now longer hosted on the 01.org infrastructure. This will not change
anything [1]. The last few years I was the only active
maintainer/developer doing it in my spare time so everything will stay
the same (including my very slow responses, sorry).

Thanks,
Daniel

[1] BTW, I've never bothered to collect the old mails. Though with lore
as mail archive I'd like to restore it.If anyone has a complete (or
nearly) complete archive, please share it with me.


Alyssa Ross (1):
      README: fix typo

Daniel Wagner (17):
      service: Fix integer type for online check interval
      mailmap: Update non-canonical log entries
      ethernet: Copy interfance names obeying lengths rules
      wireguard: Copy interfance names obeying lengths rules
      service: Remove unused __connman_service_disconnect_all()
      service: Factor auto connect trigger code into a new function
      iwd: Init AutoConnect of know networks
      iwd: Filter out connect failure for auto connect mode
      network: Add __connman_network_native_autoconnect()
      service: Teach autoconnect algorithm native mode
      wifi: Open code g_memdup
      peer: Open code g_memdup
      service: Disable native autoconnect calls for providers
      timerserver: Fix time update manual->auto
      README: Update mailing list info
      AUTHORS: Mention Valery's contributions
      AUTHORS: Mention Alyssa's contributions

Emmanuel VAUTRIN (9):
      wifi: Check valid network in disconnect callback
      wifi: Reset disconnecting status of any network
      service: Add online check interval config options
      service: Add online to ready transition feature
      service: Complete only after user connection retries
      service: Fix disconnection search before connecting
      service: Allow only user connection after WiFi failure
      wispr: Support of common redirection status codes
      main: Cleanup of vendor class id and wifi config options

Jonathan Liu (1):
      iwd: Fix typo in error message when stopping AccessPoint mode

Jussi Laakkonen (5):
      dnsproxy: Enable DNS servers on connected VPN if split routing changes
      vpn: Return transport ident with get_property()
      provider: Add function to get transport ident from VPN
      service: Sort VPNs using the transport service if connected
      ipconfig: Refactor /proc value get/set to separate functions

Justin Maggard (1):
      timeserver: Fix false error message

Marcel Holtmann (2):
      README: Remove the 01.org website and the 01.org Jira
      Release 1.40

Santtu Lakkala (1):
      Rewrite openconnect plugin to use libopenconnect

Valery Kashcheev (1):
      dnsproxy: Check the length of buffers before memcpy
