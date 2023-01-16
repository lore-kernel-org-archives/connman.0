Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09B1363
	for <connman@lists.linux.dev>; Mon, 16 Jan 2023 07:52:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E252DAC2E;
	Mon, 16 Jan 2023 08:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1673855552; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F6jkFjn7ccZ+UxgwXR9p2zEKkk3tOnjrvQClshIj0xk=;
	b=QPeInFsm5jYbjcMdzHCIPkm9dodJe4WixPS2TbHOYl4pzPF52+3sIZ0eN+XggWiHa26f72
	Nd8L/lwmcn+xuAErb7oXUB/OMYDS4/stcNOP3bYPyE9msnFgJZNFejQzmyxK1Y/KnJ8GrO
	EZcvf5rRWgpJoEoMVl8ehB5pzjZIW1pl1KQRRi6BsW4lsZln3IgJRW80rDwbceXMauxnDX
	HINFV8Qi+Gm9Jl/RA/b0G00O29iczfwTBiQmIwPsRxEy98RLki0vtSVHRQubOwuh8kF0Ck
	HFfb2mAGj13w7MUQySc4E7oa0ZEKP4FK5sPLtQd8L/KIDnzFtRDo1lBszjsYAw==
Date: Mon, 16 Jan 2023 08:52:31 +0100
From: Daniel Wagner <wagi@monom.org>
To: lists@jade.fyi
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] service: Fix an additional case of autoconnect breakage
 under iwd
Message-ID: <20230116075231.pfwuothbkq2v56zk@beryllium.lan>
References: <CAFA9we_1LwKgh1Dm7eBT6DwaFPf0f8hxA4O9o2PMsR0ddrxeTA@mail.gmail.com>
 <20230111190837.209460-1-lists@jade.fyi>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111190837.209460-1-lists@jade.fyi>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jade,

On Wed, Jan 11, 2023 at 02:08:37PM -0500, lists@jade.fyi wrote:
> From: Jade Lovelace <lists@jade.fyi>
> 
> Error flow:
> - __connman_service_create_from_network() creates network, but it is not
>   favorite since it is not yet saved
> - trigger_autoconnect is skipped since !favorite
> 
> *** User calls Connect() ***
> - iwd plugin gets connect() call
> - iwd plugin finds out about new known network and copies the
>   autoconnect state of the iwd_network to the iwd_known_network, which
>   is false since it was zero initialized and nobody called
>   connman_network_set_autoconnect on it.
> - 💥 iwd plugin tells iwd to set AutoConnect to false
> - service_indicate_state() calls __connman_service_set_favorite(service,
>   true)
> - nobody tells the iwd plugin about the change in favorite state
> 
> This patch calls trigger_autoconnect right at the end there, which will
> then propagate the outcome of the favorite state to the iwd plugin. I
> think this patch is the right design for the current architecture of the
> autoconnect state management, but I think the autoconnect design
> probably needs some changes outside the scope of this patch since it is
> too easy to make these mistakes.


All four patches applied after minor documentation tweaking (e.g.
s/connman/ConnMan/ etc). I removed the Signed-off-by because we don't have
defined how this has to be interpreted in this project (read we are lacking the
DCO document which explains sets the rules).

Thanks,
Daniel
