Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215570
	for <connman@lists.linux.dev>; Thu,  5 Aug 2021 06:07:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86BD760D9D;
	Thu,  5 Aug 2021 08:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1628143625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=B6xngoNPv11TwBv6LvE8Vtv3VZd5KekJXuJGpKBsW3Q=;
	b=DWPPOjYv0XLscrrnevS7cVlcBZ7kXDvJUaXsoGwfJ+zLvOjhyOzTXKWdXNHSoI6DnCW2Q9
	YCXOk9zp08wFWdQq07fPiiumSUzjVkyXfFXVrKALxW7KztVqXZswCi4puS3xysLAKm/h1R
	b6b7+MaM4cr56P/3vz36pGPNEItlnrs9tJdmGYku0ScmdT5QrE2hin+THAIQQso4FG/Iqm
	T0H4gsApaGFbnAaN1902l+YCTO5OfSW995mThuIicHv+kR9Oj+aJuMmDXFO66TjDv49TFd
	pQbwKbC10veG+8kqZOgrPeGBpuMZolOVW6ydDx2OpeIbKdUgcNzB0DW9wP/vpQ==
Date: Thu, 5 Aug 2021 08:07:04 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com,
	marcel@holtmann.org
Subject: Re: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
Message-ID: <20210805060704.maeaww6q75x4obqy@beryllium.lan>
References: <20210804212315.265376-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804212315.265376-1-ariel.dalessandro@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ariel,

On Wed, Aug 04, 2021 at 06:23:14PM -0300, Ariel D'Alessandro wrote:
> Hi all, Daniel:
> 
> WPA3 support has been recently added to connman (wpa_supplicant). As
> we've been discussing on a previous thread, this only supports
> WPA3-Personal-only mode.
> 
> This RFC patchset adds support for WPA3-Personal transition mode, which
> supports both WPA2-Personal (PSK) and WPA3-Personal (SAE).
> 
> Based on the AP accepted key management protocols, connman configures
> wpa_supplicant as follows:
> 
> * WPA3-Personal-only mode: key_mgmt="SAE" ; ieee80211w=2
> * WPA3-Personal transition mode: key_mgmt="SAE WPA-PSK" ; ieee80211w=1
> 
> This patch applies cleanly on top of current master branch (commit
> e36a38d8).
> 
> I'd like to hear any thoughts you might have about this.
> For reference, see wpa_supplicant configuration [0].

This looks good. If no one speaks up I am going to apply it.

Daniel

ps: we have a new mailing list (connman@lists.linux.dev). The old one
was shutdown.


> 
> Regards,
> Ariel D'Alessandro
> 
> [0] https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
> 
> Ariel D'Alessandro (1):
>   gsupplicant: Add support for WPA3-Personal transition mode
> 
>  gsupplicant/supplicant.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> -- 
> 2.30.2
> 
