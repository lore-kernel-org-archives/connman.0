Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC27EF
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 08:01:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E13A4DAD0E;
	Mon, 27 Feb 2023 09:01:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1677484891; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YuED4b2t2ZroLyrW8j97RoR4tHjgf3G1SgpTVALuuDA=;
	b=riNBi0d8jLUumpl4jmtI/zAgoYKX1yacu1xuov8+0dooRzBLs0Ax1SCv958WVYVStjkXhD
	U1kJNyArnxqRXDJshiHcHYOqUYOyNF76IWIA6n0nZB+kwYcxlOuoXFBnNRf0tg0pvleJfQ
	n/eae89a6Ka0fT5FHjCclfz/7R5hyaBU0unq8cWvRnF7Y5rZ/VZUTy1FVfGBPBulR24EjN
	DIDqQJoT78AhWGGZKQK7g3XTOb2ncdYoKg5ixqZDsFPZhwj1HXzY7lyklgallpAq6yyw7o
	IEcJakGmgihEmK2Xtjj0UldbT6GhkvLF9NRXmcWuz5uOIOsW/IjiK6f1+aG8uw==
Date: Mon, 27 Feb 2023 09:01:30 +0100
From: Daniel Wagner <wagi@monom.org>
To: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: connman@lists.linux.dev
Subject: Re: No 6GHz networks found if connman does the scan, but connman see
 them if 'iw DEV scan' used instead.
Message-ID: <20230227080130.gtmid6ojmjmn6h4q@carbon.lan>
References: <2712e513-6def-4ed1-d88a-68c961f995e3@protonmail.ch>
 <91794321-2d0b-0c40-3d02-9880c20c7cab@protonmail.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91794321-2d0b-0c40-3d02-9880c20c7cab@protonmail.ch>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Feb 26, 2023 at 07:21:08PM +0000, Piotr Karbowski wrote:
> If you have any hints how can I get 6 GHz fully operational with
> connman, please let me know.

I suppose the best strategy is getting iwd to work in standalone first. ConnMan
is a user of iwd, so it doesn't really do anything 'special' in the iwd plugin.
The wpa_supplicant plugin on the other hand has a lot of wireless logic in there
and it is likely there are some limitiations.
