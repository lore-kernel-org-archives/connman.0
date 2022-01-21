Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A462CA7
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 07:48:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 939945CD01;
	Fri, 21 Jan 2022 08:48:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642751333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YFouYNiFQXKs4osrrS60DwtePSYcuwFezaTBy6yM3Gk=;
	b=IoMr3EtObBzZgi1vfoj4zeP8CI2MSh0DhdzVoPMx8/q4bmX4mITbR7hQ+mGHhH28Vyf9tp
	yHvQ+9nP0NUOAJFqCPpYfIjNX707bIvgvb4wMQM586gQyHww+Q13KJEgrkkZTbVkUOgO0S
	UjSrgl/oGx3budCXgQeVRbpPu1ckcYAJVFmYUkUbnHZsesweBt8gZ6UwQjA8+5oaGYsS4k
	61ZeYdZKGsIigCPypaNAsIcrsPnpoTp+aPC3/e70mv/vqCVWemMydsxTDHvIHk3APFv5wt
	xxfG+Wi3yBUG83fk4JQoEgD1tBKw65uloAbeuVK47tfSkkyfH0y3NNw0/HC/Gg==
Date: Fri, 21 Jan 2022 08:48:53 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Fix station in scan callback
Message-ID: <20220121074853.t3vugo7mtwtpwmcj@beryllium.lan>
References: <20220118102842.1199829-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544DC10A3C17E1934D4CF0893589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB1544DC10A3C17E1934D4CF0893589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Jan 18, 2022 at 10:39:34AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> The station shall be searched in stations table instead of networks.
> Fixes: 8371114aaef9 ("iwd: Hookup manual scan trigger")

Patch applied. Thanks!

> ---
>  plugins/iwd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index b0e17a4d6396..bb97262eff38 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -555,7 +555,7 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
>  	const char *path = user_data;
>  	struct iwd_station *iwds;
>  
> -	iwds = g_hash_table_lookup(networks, path);
> +	iwds = g_hash_table_lookup(stations, path);
>  	if (!iwds)
>  		return;
>  
> -- 
> 2.25.1
> Hi Daniel,
> 
> I wish you a happy new year!

Thank you, same to you!

> It seems that I am still accountering the tabs -> spaces issue.
> I try to send the patch back in the message.

Ah, back to your MS setup, I see. Attaching the patches works. We don't
have that many patches so I can handle it.

Daniel
