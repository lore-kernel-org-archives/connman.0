Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80270
	for <connman@lists.linux.dev>; Sat, 19 Jun 2021 19:03:44 +0000 (UTC)
Received: by kirsty.vergenet.net (Postfix, from userid 1001)
	id 9D92525BFD0; Sun, 20 Jun 2021 05:03:36 +1000 (AEST)
Date: Sat, 19 Jun 2021 20:03:29 +0100
From: Carsten Haitzler <raster@rasterman.com>
To: connman@lists.linux.dev
Subject: Bug - 1.40 stops wifi password popup for agent
Message-Id: <20210619200329.20a38c0960c156a956cbeb21@rasterman.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
X-Pants: on
X-Cluestick: Get jiggy with it!
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Arch Linux just upgraded to connman 1.40. 1.39 worked fine. Just the upgrade to
1.40 means enlightenment's connman agent no longer pops up a password box.
Something in this release broke that.

specifically the agent no longer gets RequestInput called. I bisected this down
to:

561f318003c14fff56720309b6c9dfdbceb8dd87

https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=561f318003c14fff56720309b6c9dfdbceb8dd87

This broke that. Using iwd instead of wpa_supplicant. wpa_supplicant works fine.

-- 
------------- Codito, ergo sum - "I code, therefore I am" --------------
Carsten Haitzler - raster@rasterman.com

