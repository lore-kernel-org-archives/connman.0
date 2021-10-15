Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873C2C82
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 06:52:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B961D61817;
	Fri, 15 Oct 2021 08:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634280724; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=x4kvdytv2OWUA/1oVEjzEcyoa9WuONgzQAfVjhQkwK0=;
	b=g7bAUOO8xbWc0KVtXHYTH9/rmcPdTDZ3Idka2TizuJWE+MTfVSzhHSRGm239BK+bg1MB5b
	0RcuxfwEc7C8jvlISgU7ajsKAyE3a/F9OhQprr0yWBbESgopTm2kTJYL9Qp3MC2J2O0fRR
	Y3g/3ZPe3+1kKYoxDVeoB1F7hGWNmOlDxo+dFutxtKVMKi6+ZE6bcICrItMxe1G9/BzXPS
	CTCA/XalGySY7JdI1zgZKU746l4qb9b1bW45vLwkISl3YhLykF+g8KJ8M3ofR9mnp7gKCe
	XiT9c5gDw30P1pfJSXm90mSmDXTtUp+Vla/H/6W4sN2z/bcZZmzXQaFSUy/umQ==
Date: Fri, 15 Oct 2021 08:51:59 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 1/4] tethering: Reduce the number of parameters of
 tech_set_tethering
Message-ID: <20211015065159.5dz6dg743ykx5rn7@beryllium.lan>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007213021.58712-1-michael@amarulasolutions.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Thu, Oct 07, 2021 at 11:30:18PM +0200, Michael Trimarchi wrote:
> connman_echnology is an opaque type but has all the parameters to handle
> the connection. Those parameters are only used in wifi tethering
> one and not in other technologies
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  include/technology.h |  8 ++++++--
>  plugins/bluetooth.c  |  1 -
>  plugins/ethernet.c   |  1 -
>  plugins/gadget.c     |  1 -
>  plugins/wifi.c       | 25 ++++++++++++-------------

plugins/iwd.c was missing. I updated it accordingly.

>  src/technology.c     | 20 ++++++++++++--------
>  6 files changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/include/technology.h b/include/technology.h
> index 7508a9a1..7febd109 100644
> --- a/include/technology.h
> +++ b/include/technology.h
> @@ -44,8 +44,13 @@ void connman_technology_regdom_notify(struct connman_technology *technology,
>  
>  enum connman_service_type connman_technology_get_type
>  				(struct connman_technology *technology);
> +
> +bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
> +						const char **ssid, const char **psk);
> +
>  bool connman_technology_get_wifi_tethering(const char **ssid,
> -							const char **psk);
> +						const char **psk);
> +

I decided to not to add connman_get_wifi_tethering_from_technology() and
instead just extend connman_technology_get_wifi_tethering() as the newly
introduced function name is awkward and doesn't fit. Furthermore, it's
just a simple wrapper.

Patch applied.

Thanks,
Daniel

