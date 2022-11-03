Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A75A31
	for <connman@lists.linux.dev>; Thu,  3 Nov 2022 07:25:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23D9F5D021;
	Thu,  3 Nov 2022 08:20:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1667460011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WwwEeNFHc2oyxeoVzp834LkiftA3FHbvHQBi8hHBKwg=;
	b=ddKIGxv4rL/8ApKuhK3Bom/Ln1awnZfHYe97Ji1fpsVIedveW3jrBBdFB6vYrUGJCpq/iY
	Xr2yx7nUzvSk5GXq8uHAcUHYsNIPE7yss9zv4TGG84hZaIr67MpmHgQZ0NYLrfgxh4goQn
	wyc2LjqXjHfJQf5VOVXgAze28fKWAOJGy5h8Vvq8kbeCg/m05dPf0T7zQV0OUIxkjfAcU4
	lC1zQ8JOIMPPx9HGPSwwTDVmEj2DfcPxrgKu2zP3nHcG6W2QLmZn/aH7hSNuSrhe4iw1lF
	1jqF/1GO9I8WnNGKFQpn0iG69FXGDMMAuYUocTsWj+UbYX4/+2pb2FJehvkQ/g==
Date: Thu, 3 Nov 2022 08:20:10 +0100
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: dnsproxy: first round of refactoring, TCP bugfix
Message-ID: <20221103072010.45drt42czmiryunu@beryllium.lan>
References: <20221027103258.29129-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027103258.29129-1-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Matthias,

On Thu, Oct 27, 2022 at 12:32:43PM +0200, Matthias Gerstner wrote:
> Sorry about the messed up previous set of patches.

No worries. Thanks for keeping it going.

> So this round features the following changes:
> 
> - every commit should now successfully compile and also compile without
>   warnings

One patch didn't apply cleanly due to the latest changes in dnsproxy.c
but it was easy to fix.

> - as requested I let go off most of the mixed code/declarations at the loss of
>   some const variables that now need to be declared non-const at the start
>   of the functions. In a few spots I left a little mixed code / declarations
>   just at the beginning of the function block to allow for early exits when
>   e.g. insufficient input data is supplied. Declarations at the beginning of
>   for/while/if blocks still remain where suitable.

All patches applied.

Thanks a lot!
Daniel
