Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9724699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:00:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0638A5DF77;
	Sun, 28 Aug 2022 20:00:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661709610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OuKOpNC9jxP3vWPx/aEp+UVcJcjMo5+rxAQk6xHzoG4=;
	b=oPk7oeAjHsfMhUmC4OliIn9zzPEdvvc699eLqbvzDZCzWuivlrjvHt4S+JkCPumKWnWWCQ
	v2QLMQR8KIbIJl2sR+VJTQKeRYPCwQ8BZO1l7eRCes5YixUGnjAZAvJXzpVaMlgavPckuv
	HgS9JioyvTnFe4Y6JNxd0hoRBTQcOUCXHww0TqWGMJhUPu2+im5F6tvOm9dIG4kbZhLLMT
	PyG45OG3LyUyiU+kkadmXR/C8YxtM+YSaXKPlKGeun7MIZLVm45NIqt9yZJEkn/2xTAU1V
	n1CIF/8LL8gvP+F65XcCny5h6k2nRmchqXFpDin3TxPZBLpEVX5Ki3EhIDNUFQ==
Date: Sun, 28 Aug 2022 20:00:09 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828180009.xifu45ui3qa7pckn@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <20220828174050.ate53trz2opzyczg@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828174050.ate53trz2opzyczg@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 07:40:50PM +0200, Daniel Wagner wrote:
> Well, we should set a GW for IPV4LL DHCP leases:
> 
> 
> diff --git a/src/network.c b/src/network.c
> index 2090e7fe944e..68679f5939b3 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -444,9 +444,11 @@ static void dhcp_success(struct connman_network *network)
>         if (err < 0)
>                 goto err;
>  
> -       err = __connman_ipconfig_gateway_add(ipconfig_ipv4);
> -       if (err < 0)
> -               goto err;
> +       if (!__connman_ipconfig_get_local(ipconfig_ipv4)) {
> +               err = __connman_ipconfig_gateway_add(ipconfig_ipv4);
> +               if (err < 0)
> +                       goto err;
> +       }
>  
>         __connman_service_save(service);

meh, this doesn't work. let me spin another patch
