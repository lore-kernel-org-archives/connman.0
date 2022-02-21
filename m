Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076907B
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:22:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0DEA5D3A0;
	Mon, 21 Feb 2022 09:22:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645431723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3uf2QgRaci6YXUGLryFnBfrzuejCF3JY/BFcxa/ZtKk=;
	b=zSZsWmOVEBRhA+Uh0pjxnenrmWFj9+8W86dr9MC4NpHunp0KQ+o4T7AJ48PkhghLSou9fw
	auLXDYBe7uqO8amBU7rfkh4UsaLULXWTZ9RiPxNqkglry2SZuE6ebi37PcQ1z1nDG+42nV
	GNwhyt64fcSOU1oNHcomU5uXaxZ/Nrii+vPfFHdRT7eHd+adxPJjg5REjzr3JuDmJSWZxL
	oq0Ul4zbgsNMCZ2jZYUFDkyKSlXeKbzjDNTPdkBRd914zkTlOlexuq5gTK+QgHkK64L4qE
	YFir1N6y/bOZyK2esMxM+vkS1BZzTmfzHtyUHMmBugN1gOlgWe80O7YlALsRIg==
Date: Mon, 21 Feb 2022 09:22:03 +0100
From: Daniel Wagner <wagi@monom.org>
To: Niel Fourie <lusus@denx.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] wifi: Duplicate GSupplicantSSID pointer members
Message-ID: <20220221082203.pb736e7vsladjle7@beryllium.lan>
References: <20220211134518.3601268-1-lusus@denx.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211134518.3601268-1-lusus@denx.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Niel,

Sorry for the late respone.

On Fri, Feb 11, 2022 at 02:45:18PM +0100, Niel Fourie wrote:
> In ssid_init(), the pointer members of GSupplicantSSID *ssid was
> initialised to point to members of a connman_network, which get
> freed and replaced, causing ssid's pointers to point to freed heap
> memory. To mitigate this, these members are duplicated and then
> freed and along with ssid when no longer needed.

Patch applied just with a small nitpick change (see below)

Thanks,
Daniel


> 
> Signed-off-by: Niel Fourie <lusus@denx.de>
> ---
>  gsupplicant/supplicant.c | 41 ++++++++++++++++++--
>  plugins/wifi.c           | 80 ++++++++++++++++++++++------------------
>  2 files changed, 82 insertions(+), 39 deletions(-)
> 
> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> index 470d99eb..e140b825 100644
> --- a/gsupplicant/supplicant.c
> +++ b/gsupplicant/supplicant.c
> @@ -810,6 +810,32 @@ static void remove_peer(gpointer data)
>  	g_free(peer);
>  }
>  
> +static void remove_ssid(gpointer data)
> +{
> +	GSupplicantSSID *ssid = data;
> +
> +	if (ssid) {

I've change this to an early return.

