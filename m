Received: from web-bm.overkiz.com (web-bm.overkiz.com [92.222.103.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48F2C80
	for <connman@lists.linux.dev>; Thu, 14 Oct 2021 06:31:13 +0000 (UTC)
Received: from [10.0.1.137] (unknown [185.81.55.234])
	(Authenticated sender: julien.barrault.external@overkiz.com)
	by web-bm.overkiz.com (Postfix) with ESMTPSA id B09BC1BF29D;
	Thu, 14 Oct 2021 08:31:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=overkiz.com;
	s=202003; t=1634193065;
	bh=254kUaZ1uPSIJL5/VCX5XrhwSLK0xLwNI1cMnVzBAdQ=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=TtlJ/x/opRJfoS+DE0NIO+HjYRxl6JxpMyYaad24qcBu4hp8k/TEmBTFmTiV1KO1M
	 vkq9yPrgm3VCCWquHSaetrEN4C8LFBdbGa0zOzKW9TvAjAjHjQ4ZOYeqV21ByKxKEz
	 0LfMKnQSNP0AtMjpgy93mD+/t46tHVp0BvNuXGTvpY+oFKRIbqPf4YPwJt7SUgW8yr
	 vDBGMUP9J0zmmWX51+bRA78PdQ0p48qqy/lfXt6Uxow36OxHfwTY8kaIQdg72xvGse
	 AotaehAoqvx36vpNhxEAn28tfJlHWNYThA2IkmpbblO3dm5Jek4fmIHULHhGCe8l0J
	 3FPdc5p4MHr1g==
Subject: Re: [PATCH 1/4] tethering: Reduce the number of parameters of
 tech_set_tethering
To: Michael Trimarchi <michael@amarulasolutions.com>,
 connman@lists.linux.dev, Daniel Wagner <wagi@monom.org>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
From: Julien Barrault <julien.barrault.external@overkiz.com>
Message-ID: <65509ce0-a5d9-9161-7454-a93b8147c4ed@overkiz.com>
Date: Thu, 14 Oct 2021 08:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20211007213021.58712-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Bm-Milter-Handled: f125012e-72d2-4729-b87c-a5ab9341072c
X-Bm-Transport-Timestamp: 1634193065799

Hi Michael,

I've tested these 4 patches, it seems to work perfectly

I'm keen to see it approved and released :)

Julien


On 07/10/2021 23:30, Michael Trimarchi wrote:
> connman_echnology is an opaque type but has all the parameters to handle
> the connection. Those parameters are only used in wifi tethering
> one and not in other technologies
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   include/technology.h |  8 ++++++--
>   plugins/bluetooth.c  |  1 -
>   plugins/ethernet.c   |  1 -
>   plugins/gadget.c     |  1 -
>   plugins/wifi.c       | 25 ++++++++++++-------------
>   src/technology.c     | 20 ++++++++++++--------
>   6 files changed, 30 insertions(+), 26 deletions(-)
>
> diff --git a/include/technology.h b/include/technology.h
> index 7508a9a1..7febd109 100644
> --- a/include/technology.h
> +++ b/include/technology.h
> @@ -44,8 +44,13 @@ void connman_technology_regdom_notify(struct connman_technology *technology,
>   
>   enum connman_service_type connman_technology_get_type
>   				(struct connman_technology *technology);
> +
> +bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
> +						const char **ssid, const char **psk);
> +
>   bool connman_technology_get_wifi_tethering(const char **ssid,
> -							const char **psk);
> +						const char **psk);
> +
>   bool connman_technology_is_tethering_allowed(enum connman_service_type type);
>   
>   struct connman_technology_driver {
> @@ -60,7 +65,6 @@ struct connman_technology_driver {
>   	void (*remove_interface) (struct connman_technology *technology,
>   								int index);
>   	int (*set_tethering) (struct connman_technology *technology,
> -				const char *identifier, const char *passphrase,
>   				const char *bridge, bool enabled);
>   	int (*set_regdom) (struct connman_technology *technology,
>   						const char *alpha2);
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 53361034..57cc8a29 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -882,7 +882,6 @@ static void bluetooth_tech_remove(struct connman_technology *technology)
>   }
>   
>   static int bluetooth_tech_set_tethering(struct connman_technology *technology,
> -		const char *identifier, const char *passphrase,
>   		const char *bridge, bool enabled)
>   {
>   	GHashTableIter hash_iter;
> diff --git a/plugins/ethernet.c b/plugins/ethernet.c
> index 6146b1c0..0bf7fc41 100644
> --- a/plugins/ethernet.c
> +++ b/plugins/ethernet.c
> @@ -407,7 +407,6 @@ static void eth_tech_disable_tethering(struct connman_technology *technology,
>   }
>   
>   static int eth_tech_set_tethering(struct connman_technology *technology,
> -				const char *identifier, const char *passphrase,
>   				const char *bridge, bool enabled)
>   {
>   	if (!connman_technology_is_tethering_allowed(
> diff --git a/plugins/gadget.c b/plugins/gadget.c
> index 1b44bbb5..2d58df3e 100644
> --- a/plugins/gadget.c
> +++ b/plugins/gadget.c
> @@ -294,7 +294,6 @@ static void gadget_tech_disable_tethering(struct connman_technology *technology,
>   }
>   
>   static int gadget_tech_set_tethering(struct connman_technology *technology,
> -				const char *identifier, const char *passphrase,
>   				const char *bridge, bool enabled)
>   {
>   	DBG("bridge %s enabled %d", bridge, enabled);
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 578b4be7..cebe6886 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -183,7 +183,6 @@ static bool wfd_service_registered = false;
>   
>   static void start_autoscan(struct connman_device *device);
>   static int tech_set_tethering(struct connman_technology *technology,
> -				const char *identifier, const char *passphrase,
>   				const char *bridge, bool enabled);
>   
>   static int p2p_tech_probe(struct connman_technology *technology)
> @@ -2791,8 +2790,6 @@ static void ap_create_fail(GSupplicantInterface *interface)
>   		wifi->tethering = false;
>   
>   		ret = tech_set_tethering(wifi->tethering_param->technology,
> -				wifi->tethering_param->ssid->ssid,
> -				wifi->tethering_param->ssid->passphrase,
>   				wifi->bridge, true);
>   
>   		if ((ret == -EOPNOTSUPP) && (wifi_technology)) {
> @@ -3336,14 +3333,20 @@ static void tech_remove(struct connman_technology *technology)
>   	wifi_technology = NULL;
>   }
>   
> -static GSupplicantSSID *ssid_ap_init(const char *ssid, const char *passphrase)
> +static GSupplicantSSID *ssid_ap_init(const struct connman_technology *technology)
>   {
>   	GSupplicantSSID *ap;
> +	const char *ssid, *passphrase;
> +	bool ret;
>   
>   	ap = g_try_malloc0(sizeof(GSupplicantSSID));
>   	if (!ap)
>   		return NULL;
>   
> +	ret = connman_get_wifi_tethering_from_technology(technology, &ssid, &passphrase);
> +	if (ret == false)
> +		return NULL;
> +
>   	ap->mode = G_SUPPLICANT_MODE_MASTER;
>   	ap->ssid = ssid;
>   	ap->ssid_len = strlen(ssid);
> @@ -3458,8 +3461,7 @@ static void sta_remove_callback(int result,
>   }
>   
>   static int enable_wifi_tethering(struct connman_technology *technology,
> -				const char *bridge, const char *identifier,
> -				const char *passphrase, bool available)
> +				const char *bridge, bool available)
>   {
>   	GList *list;
>   	GSupplicantInterface *interface;
> @@ -3512,14 +3514,14 @@ static int enable_wifi_tethering(struct connman_technology *technology,
>   		info->wifi = wifi;
>   		info->technology = technology;
>   		info->wifi->bridge = bridge;
> -		info->ssid = ssid_ap_init(identifier, passphrase);
> +		info->ssid = ssid_ap_init(technology);
>   		if (!info->ssid)
>   			goto failed;
>   
>   		info->ifname = g_strdup(ifname);
>   
>   		wifi->tethering_param->technology = technology;
> -		wifi->tethering_param->ssid = ssid_ap_init(identifier, passphrase);
> +		wifi->tethering_param->ssid = ssid_ap_init(technology);
>   		if (!wifi->tethering_param->ssid)
>   			goto failed;
>   
> @@ -3561,7 +3563,6 @@ static int enable_wifi_tethering(struct connman_technology *technology,
>   }
>   
>   static int tech_set_tethering(struct connman_technology *technology,
> -				const char *identifier, const char *passphrase,
>   				const char *bridge, bool enabled)
>   {
>   	GList *list;
> @@ -3589,13 +3590,11 @@ static int tech_set_tethering(struct connman_technology *technology,
>   	}
>   
>   	DBG("trying tethering for available devices");
> -	err = enable_wifi_tethering(technology, bridge, identifier, passphrase,
> -				true);
> +	err = enable_wifi_tethering(technology, bridge, true);
>   
>   	if (err < 0) {
>   		DBG("trying tethering for any device");
> -		err = enable_wifi_tethering(technology, bridge, identifier,
> -					passphrase, false);
> +		err = enable_wifi_tethering(technology, bridge, false);
>   	}
>   
>   	return err;
> diff --git a/src/technology.c b/src/technology.c
> index 672d6ea8..e0457890 100644
> --- a/src/technology.c
> +++ b/src/technology.c
> @@ -264,8 +264,7 @@ static int set_tethering(struct connman_technology *technology,
>   		if (!driver || !driver->set_tethering)
>   			continue;
>   
> -		err = driver->set_tethering(technology, ident, passphrase,
> -				bridge, enabled);
> +		err = driver->set_tethering(technology, bridge, enabled);
>   
>   		if (result == -EINPROGRESS)
>   			continue;
> @@ -356,8 +355,16 @@ enum connman_service_type connman_technology_get_type
>   	return technology->type;
>   }
>   
> -bool connman_technology_get_wifi_tethering(const char **ssid,
> -							const char **psk)
> +bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
> +						const char **ssid, const char **psk)
> +{
> +	*ssid = technology->tethering_ident;
> +	*psk = technology->tethering_passphrase;
> +
> +	return true;
> +}
> +
> +bool connman_technology_get_wifi_tethering(const char **ssid, const char **psk)
>   {
>   	struct connman_technology *technology;
>   
> @@ -373,10 +380,7 @@ bool connman_technology_get_wifi_tethering(const char **ssid,
>   	if (!technology->tethering)
>   		return false;
>   
> -	*ssid = technology->tethering_ident;
> -	*psk = technology->tethering_passphrase;
> -
> -	return true;
> +	return connman_get_wifi_tethering_from_technology(technology, ssid, psk);
>   }
>   
>   static void free_rfkill(gpointer data)
