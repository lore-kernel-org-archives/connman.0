Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7A35959
	for <connman@lists.linux.dev>; Mon, 20 Jul 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536525; cv=none; b=GAd8NFxaXTQD6PoRRxOO4gbGutZ49J7UAxsUBCWvd/uUs2ZDfYo75xIXaO0CweSoU+ZR1pVnKJzDKrDl5Yplmxn+LJ5RMPcsPJ4vnukLCbDIpYI+Zah/+UZ7mR6oYmg+izPQt0J/0vIn/4CCKcWLgOouDIEOgQ9gCfLgobrfaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536525; c=relaxed/simple;
	bh=zYp3TWNt4arsj7KMnZ3v7+3hHO5YVIGHsioB7f7CFZE=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=ZeDoZ5l0yPyOKvs6qLu3ziJ0LjCtJ1iz1Q94Ho8M/s2XlVaSTgWP2qC87tr3/PS+9xvPFDHX1SQkhixNXWPVCQd8mB0zzMuY1kKlctG0WUMftdsSCjarANRfSkes/dTZBOTTE9Bhfif7sLCISR5F1HbhF/z7a9hLSktYN/lDN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=KkK8Su2d; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="KkK8Su2d"
Received: from fews03-sea.riseup.net (fews03-sea-pn.riseup.net [10.0.1.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4h3YW04vwPzDqFw
	for <connman@lists.linux.dev>; Mon, 20 Jul 2026 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1784535948; bh=+soO4vysrG+fF8CKQd50BFky4DIDXVFJmOHeGqrShk8=;
	h=Date:From:To:Subject:From;
	b=KkK8Su2dSPulzdG4shkkoHS875kwyM/LkyxVMcb4sCEyfoYaymozViItRYuS7q88N
	 1NBOTB9Iu7MitHDzKXs+5KFTisik+uGmZONTAbw2idNux09yOUM5dDkfz1LWEcao5t
	 YwYQpVSgpe3ztIMPZUeferLh6eim+lFdqMXVhl0A=
X-Riseup-User-ID: C47ABF88194AD6A91308AE7D7DA13C5A04D33327EB6E637658C2E80EC24F351E
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews03-sea.riseup.net (Postfix) with ESMTPSA id 4h3YW03d9Jz1y5b
	for <connman@lists.linux.dev>; Mon, 20 Jul 2026 08:25:48 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 20 Jul 2026 08:25:48 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: [BUG] connmand leaks file descriptors / UDP sockets to port 53 during
 virtual interface routing transitions (wg0)
Message-ID: <3320bac079b787c9b7f011fdd0dcb893@riseup.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello ConnMan Developers,

I am tracking a structural file descriptor leak in connmand when paired
with out-of-band virtual interfaces (specifically a kernel-space
WireGuard wg0 tunnel managed outside of ConnMan's D-Bus layers). 

The leak has been observed across multiple ARM-based embedded
configurations running the ConnMan daemon package profiles.

### Symptom
When the external virtual interface modifies global system routing table
layers, connmand begins spawning incremental UDP client sockets
targeting the local gateway on port 53. These sockets are abandoned in
an ESTABLISHED or CLOSE_WAIT state and are never closed via system
calls. The accumulation continues unchecked at a constant rate until
hitting the 1024 system file descriptor cap, flatlining system network
capability.

### Diagnostic Evidence (Gathered from active sessions)

1. Active Process Runtime Environment:
/usr/sbin/connmand -nr --config=/storage/.config/connman_main.conf

2. File Descriptor State (Steadily climbs to 1024 flatline threshold):
# ls -1 /proc/$(pidof connmand)/fd | wc -l
Output: 372 (and mounting)

3. Socket Allocation Trace (Stuck unique local source ports routing
outbound):
udp        0      0 192.168.178.53:48179    192.168.178.1:53       
ESTABLISHED
udp        0      0 192.168.178.53:48255    192.168.178.1:53       
ESTABLISHED
udp        0      0 192.168.178.53:57314    192.168.178.1:53       
ESTABLISHED
tcp        0      0 192.168.178.53:37104    212.227.81.55:80       
CLOSE_WAIT

4. Active Routing Table Constraints:
0.0.0.0/1 dev wg0 scope link
default dev wg0 scope link
128.0.0.0/1 dev wg0 scope link

### Workaround Insights
Invoking connmand explicitly with the `--nodnsproxy` runtime parameter
cleanly suppresses the rapid-fire port 53 socket accumulation on modern
builds, though internal tracking sockets still exhibit a slow paired
resource leak over time on older versions of the network daemon when the
network interface state changes.

It appears the internal Route Netlink (rtnl) sub-system or the internal
DNS proxy caching engine fails to perform proper handle reclamation
actions when external routing layers override primary paths.

Could anyone look into the resource tracking architecture to check where
these proxy sockets might be missing close() calls during route changes?

Best regards,
Doemela
