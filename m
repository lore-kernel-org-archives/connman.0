Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2B672
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 17:06:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D84AE5E3FE;
	Mon, 30 Aug 2021 19:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630343192; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hRKdM5xvdxGAr17OvxTCv3QWTlziA1yIgh4wr0DyHkc=;
	b=BTEkP70dDOpcGbHMNKcpUB+Oy2HmK3/MAMStBh0T4503EgLBGqk/uZV3g2GCt+Ri+ymfC5
	A6Q9qkNtwDW0wV4iS9LpwSkjhhzO1dhpslIKyFhKtyhSx/YLXSj/HlhXOHq9eZAKx2eIYS
	0NT3G4qU/cJpZwMeu93OPY5AudLEkoz+jGDdxO2V+ddNc2aTw3OJqPugQoSqSFFhesFjiq
	zTqdo13yf0IrLbR3zC+bH3FDVIAep005FJZA8ctDhrXFAz22mpqEHBHtQeNVXktzTIgDVr
	vM4Hn2S6EhAdeUzacpvNWye7oKiriAYHegtF17Sz5iYU/A3/cK8DlB6yf6kRPg==
Date: Mon, 30 Aug 2021 19:06:31 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Implement connmand state monitoring to vpnd
Message-ID: <20210830170631.ni5frzfk6v6jn7s6@beryllium.lan>
References: <20210830092405.30964-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830092405.30964-1-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Mon, Aug 30, 2021 at 12:24:03PM +0300, Jussi Laakkonen wrote:
> Implement connmand state monitoring into vpnd to keep track of the state
> changes in regards to connectivity and D-Bus registration. vpnd retrieves the
> state from connmand using Manager interface when started and otherwise it
> monitors PropertyChanged signals as well as utilizes D-Bus service monitoring
> to get the changes.
>
> This change prevents connecting VPNs when connmand is not yet online or has
> gone away from D-Bus (e.g., restart). In case VPN is connected before the state
> has been queried a delayed connection function is utilized to connect that VPN
> when online/ready state is reached.
>
> In case connmand is offline or gone from D-Bus ENOLINK is returned as an error.
> This is handled in plugins/vpn.c and returned back to the caller as NoCarrier
> D-Bus error message.
>
> Changes since V2:
>  - Updated vpn-provider patch to v3: cleanups, reformat, remove agent checks.
>  - Updated vpn patch to v2: do handle ENOLINK properly and reformat.
>
> Jussi Laakkonen (2):
>   vpn-provider: Implement connmand online state checking
>   vpn: Refactor connect_reply() and handle NoCarrier ->  ENOLINK error

I fixed up some small whitespace issues in the first patch and dropped
the else block in do_connect(). Also added the 'void' argument to
get_connman_state() (all complains from checkpatch).

Also I had to fallback to my old workflow and cherrypick the patches. b4
was not happy with the thread:

  Grabbing thread from lore.kernel.org/connman/20210830092405.30964-2-jussi.laakkonen%40jolla.com/t.mbox.gz
  Will use the latest revision: v3
  You can pick other revisions using the -vN flag
  Checking attestation on all messages, may take a moment...
  ---
    [PATCH v3 1/2] vpn-provider: Implement connmand online state checking
    ERROR: missing [2/2]!
  ---

Anyway, I gave it a quick test, all looks good. Patches applied.

Thanks,
Daniel
