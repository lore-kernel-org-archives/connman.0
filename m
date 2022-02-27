Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E14A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 17:45:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F2A65D30E;
	Sun, 27 Feb 2022 18:45:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645983925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dFTgdxW/zk+8ERjreZf6qXDHbiaX2D14CUNkSZf5rV4=;
	b=zaayeA77+WmDmRxNXWpKLIH4znH4LU8j8siwnpbt3SlP7EiJJ5HMY/JwErIui1bIMGfbpT
	xvlgCUcGntyMwOdbjfj7BGvpSPVtWF7sJX5IHuB8NVaON3VWuGiQ9UDPm+cFPxY7QS+Sz7
	LIJpogKoVpWjLZT7aI/SD13TcvuN7syHmkzQIOdUYSE28Cs0QgfMeAyWPu0+HdUxgJo9Ci
	pcg16fuhGJN25EpbNXESAsml1s0TTil/EWZjcKtKXOEJLVtNwtZHipizFDgEa4y8ozCl8k
	aqZq5DZab8vMrd6IYKAwVerN3PSImUD5UF+NvLmIsyDkz+QgA0xh6p8Gw0vHfg==
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>,
	connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [WIP PATCH v2] iwd: Fix disabling tethering not working for brcmfmac
Date: Sun, 27 Feb 2022 18:45:23 +0100
Message-Id: <164598391365.21419.4482762881203885138.b4-ty@monom.org>
In-Reply-To: <20220215102638.599189-1-net147@gmail.com>
References: <20220215102638.599189-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 15 Feb 2022 21:26:38 +1100, Jonathan Liu wrote:
> For Broadcom BCM4356 chipset with brcmfmac driver, changing from AP mode
> to station mode returns -EBUSY if the wireless interface is a member of
> a bridge.
> 
> To resolve the issue, the wireless interface is removed from the tether
> bridge before changing the mode rather than after.
> 
> [...]

Applied, thanks!

[1/1] iwd: Fix disabling tethering not working for brcmfmac
      commit: 5d1eebad7cffeae7d7b6b11d03d04f73bdd503bc

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
