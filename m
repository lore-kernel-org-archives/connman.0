Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07C2568
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:49:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A56C15D2B7;
	Mon, 21 Feb 2022 09:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645433397; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QVED4LqPKxGpiEPiQXTJaEdlZwkC+0mBMAlgO5f4QZ8=;
	b=C/ok7sUVa/jN7ItcwBYAvDksNExqxRioYW1CQV12y9knK+AkwVM9q6mGzVjM0f+U1mfpB+
	9Y8ZsjfuClCUHilI8ikEe5zV+zpcgVwIM2XrcosHPMwHYZegZGWr6Q58uzNf8DeQMTO8gQ
	J1U7QMmA9pX1ctXxiWuLBOsmWz5NIHgLF9DFe0ebEed/inM96bq33wZxGZIHPZtNNvewkh
	km3oK34eoHbcIDyH3BBiuEqHAoJyfgLwr7HVMwy+gjhoJzqv7oxIUV+wzCYzU9+ZUnULh+
	KGqHOmx3ktvJVPPhexPycbzp0OinUFvGP5x3Y0FFOa2PfxJyvPnNx9PzWFDB0g==
Date: Mon, 21 Feb 2022 09:49:57 +0100
From: Daniel Wagner <wagi@monom.org>
To: matthias.gerstner@suse.de
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 3/7] dnsproxy: protocol_offset: remove error return case
 and return size_t
Message-ID: <20220221084957.zqbegzw3vquilc2k@beryllium.lan>
References: <20220217113113.24088-1-matthias.gerstner@suse.de>
 <20220217113113.24088-4-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217113113.24088-4-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Feb 17, 2022 at 12:31:09PM +0100, matthias.gerstner@suse.de wrote:
> From: Matthias Gerstner <matthias.gerstner@suse.de>
> 
> There is never any socket created that is not UDP or TCP, so this error
> should never occur unless some memory corruption or similar occured.
> Therefore `abort()` on unexpected values instead.
> 
> This simplifies the calling code since the error case no longer needs to
> be covered (which can also be dangerous when forgotten, because then
> negative error codes are used in calculations).
> ---
>  src/dnsproxy.c | 41 ++++++++++++++---------------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/src/dnsproxy.c b/src/dnsproxy.c
> index b195f447..d04057fa 100644
> --- a/src/dnsproxy.c
> +++ b/src/dnsproxy.c
> @@ -233,7 +233,7 @@ static guint16 get_id(void)
>  	return rand;
>  }
>  
> -static int protocol_offset(int protocol)
> +static size_t protocol_offset(int protocol)
>  {
>  	switch (protocol) {
>  	case IPPROTO_UDP:
> @@ -243,9 +243,9 @@ static int protocol_offset(int protocol)
>  		return 2;
>  
>  	default:
> -		return -EINVAL;
> +		// this should never happen

We always use /* */ comment style. I've updated this accordingly.
