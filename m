Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED97A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 07:36:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 115AC5D336;
	Mon, 14 Feb 2022 08:36:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644824215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Uh2HDanN7fVqMqnqxuNMsIngaCj2OFfCmzidrNVZpF8=;
	b=aXUyQWTl2ywwiMmUy7EYCucBCexbAmzwRfDdvg7Hoy6pGgXaAu+iUpa6yACBVpVZFeDNQs
	QEMSZeFeJ7qc4G6m1ZMEGHE+FdbOz1m09FABAlEGqV8Izaq3KAPCZ4cMfTMAyBeAfAndO4
	A/Y4+V4N6F7k5X9Ms7xRtdYMgQp1kCZZJ+xhYZRWNCR1EeKbbOU4320MvPOE/aRdOfRmYc
	8XOVKLPb3FeP5vM9cDmpMMOj5/JQwmBMa7mgY5UxgfN1Peb/AmdPnuuc5x1DhAGuZwQ9Yj
	9GugtR10cSxM6DdrtJuwE7CM/u6c7GT/GXErPc12NFrt5WD4MfwTsdaGQw75oA==
Date: Mon, 14 Feb 2022 08:36:54 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Use same signal strength calculation as
 wpa_supplicant
Message-ID: <20220214073654.5wwvht6ntswylci5@carbon.lan>
References: <20220214021357.522946-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214021357.522946-1-net147@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonathan,

On Mon, Feb 14, 2022 at 01:13:57PM +1100, Jonathan Liu wrote:
> Fixes the signal strength reported by connman being lower when using iwd
> compared to wpa_supplicant.
> ---
>  plugins/iwd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index ac3d1e17..2a245fe2 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -1128,7 +1128,9 @@ static unsigned char calculate_strength(int strength)
>  	 * ConnMan expects it in the range from 100 (strongest) to 0
>  	 * (weakest).
>  	 */
> -	res = (unsigned char)((strength + 10000) / 100);
> +	res = (unsigned char)(120 + strength / 100);
> +	if (res > 100)
> +		res = 100;

Can you explain your math here? The original code maps the reported
signal strength linearly to the ConnMan's range.

Daniel

