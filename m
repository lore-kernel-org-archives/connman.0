Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331915221
	for <connman@lists.linux.dev>; Mon,  9 Jan 2023 21:03:10 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-142b72a728fso10071835fac.9
        for <connman@lists.linux.dev>; Mon, 09 Jan 2023 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRSTazFIkhtPo6oSgVQQMDQzSZFFCGG2mAwmL7pNTIQ=;
        b=V9hJHTYQO8QiSPmyYudURaB4NkTyF2Lt5M70vJQmBAqLzI8+twskMDRwTZZO+xADKq
         3VL3/CWwcKVEamKm4Y5GObsAgeEaPHVquMREKXSYdHgE60VLxAUiUvVrVs6vILXqAKxv
         pC0ygHqE8eQuxMld+iSngNVRuYlRGY77guQKYsqkTbBs+lIvBsqVc7I1LgN2xNkCcNjr
         zgJ9vLZnn2ZWsxpWRzqjnpsRpKZTFJZqCONRGtORWloL6YZdpsjVrvjRd4xL3N6o5trK
         pHcRoNfzDeawaPq6MaBZXZMaZP5UfUpsOpREOkCTYU8oZ+lfWQFi4vxezUWihx5QUFGb
         1zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRSTazFIkhtPo6oSgVQQMDQzSZFFCGG2mAwmL7pNTIQ=;
        b=A83obGd2IchYlv3e89nHfe4vBZIiWFRVKBsceugksUQayvbtBzAFfQgclukALLjOHC
         b0pZQ6vhYkQkaEdZjgQtP7tsrD4mdqROGZ6S9MqEGJJERD7V/vNsybxZyZJMgX4PWndA
         xV1N2bz9xd/82YYEC/qu67/uQyBDarFZOu4te6ZpiYBnsvD8leAaUhcQ0XWoaBbt1kGZ
         G+blROpBjPpyZfN8VIaq1oWhS7axkTCmdOV5BrZ2LUB4s+h6PhLOEs+FL2K8WzoT6dBz
         +tdWO7/pYO+IBP8NUWh1MZRfCMJawNaTyX9GKaCfa0N0kInqCeUlIeBkYQ6aQiJizZqw
         gC6w==
X-Gm-Message-State: AFqh2kon6Jd6nqDTaFfRL99zJRvOBZ7/tGk1El3fDXJYw3J4UWW0F7Xh
	MK8P6fxEjgAWwa3FKJ39x1xKCa9Fm5NoiEgggPZrVB1zZTLXPnxyyHSYZA==
X-Google-Smtp-Source: AMrXdXuuDSlXk+JgY10pntBs92ARXPJMI+EGWlcZ6Tf8n0OM1gM0WlrMF2bI0xI0B5xE3Arj+xbRPd6C+H8T5FPgigY=
X-Received: by 2002:a05:6870:d99a:b0:143:7889:c525 with SMTP id
 gn26-20020a056870d99a00b001437889c525mr3756647oab.171.1673298189716; Mon, 09
 Jan 2023 13:03:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230107215023.8288-1-lists@jade.fyi> <20230107215023.8288-4-lists@jade.fyi>
In-Reply-To: <20230107215023.8288-4-lists@jade.fyi>
From: Jade Lovelace <lists@jade.fyi>
Date: Mon, 9 Jan 2023 16:02:58 -0500
Message-ID: <CAFA9we_1LwKgh1Dm7eBT6DwaFPf0f8hxA4O9o2PMsR0ddrxeTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] plugins/iwd: fix iwd autoconnect being set wrongly on
 new connections
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I think I found that this still doesn't fix the issue, surprisingly. I
am going to investigate further.

On Sat, Jan 7, 2023 at 4:50 PM <lists@jade.fyi> wrote:
>
> From: Jade Lovelace <lists@jade.fyi>
>
> Due to an extremely subtle bug in tracking the autoconnect state from
> connman on through to iwd, iwd was incorrectly being sent zero-initialized
> default data as the autoconnect value.
>
> In particular, what happened is as follows:
> - A new iwd_network is created for the iwd.Network that appears, which
>   also creates an associated connman_network. In the process of creating
>   the connman_network, the iwd plugin receives a callback that correctly
>   sets the cm_autoconnect state of the iwd_network.
> - Connman's Service.Connect() function is called via D-Bus, which calls
>   into the iwd plugin, which in turn calls iwd.Network.Connect() over
>   D-Bus.
> - The connection completes and the following fire:
>     - iwd.KnownNetwork created event, which is supposed to initialize the
>       cm_autoconnect state to that of the iwd_network, but this does not
>       occur since the iwd_network does not yet have a KnownNetwork
>       associated, so it remains uninitialized
>     - PropertyChanged event on the corresponding iwd.Network object,
>       with the new KnownNetwork property value, springing the trap set
>       earlier by synchronizing the zero-initialized
>       iwd_known_network.cm_autoconnect state to the iwd KnownNetwork
>
> In practice, this looks like:
> -> net.connman.iwd.Network.Connect() on /net/connman/iwd/0/3/0000000000000000000000_psk
> <- RequestPassphrase()
> -> (passphrase)
> -> Set('AutoConnect', False) on /net/connman/iwd/0000000000000000000000_psk
>
> This was found by investigating why my computer was not automatically
> connecting to some networks after coming out of sleep, and finding that
> the iwd AutoConnect setting was false on those networks while connman
> thought it was true (in fact, this was the case! The connman iwd plugin
> thought otherwise).
>
> Reproduction:
>
> connmanctl> agent on
> Agent registered
> connmanctl> config wifi_9cb6d0f7daaf_00000000_managed_psk --remove
> connmanctl> connect wifi_9cb6d0f7daaf_00000000_managed_psk
> Agent RequestInput wifi_9cb6d0f7daaf_00000000_managed_psk
>   Passphrase = [ Type=psk, Requirement=mandatory ]
> Passphrase? 00000000
> Connected wifi_9cb6d0f7daaf_00000000_managed_psk
>
> $ busctl get-property net.connman.iwd /net/connman/iwd/00000000_psk net.connman.iwd.KnownNetwork AutoConnect
> b false
>
> Then sleep the machine and observe that the network is not automatically
> reconnected.
>
> Signed-off-by: Jade Lovelace <lists@jade.fyi>
> ---
>  plugins/iwd.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index 9d437b3d..1f6743e4 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -41,7 +41,15 @@ static GDBusClient *client;
>  static GDBusProxy *agent_proxy;
>  static GHashTable *adapters;
>  static GHashTable *devices;
> +/**
> + * Mapping from dbus path -> struct iwd_network, tracking the set of Network
> + * objects seen by iwd.
> + */
>  static GHashTable *networks;
> +/**
> + * Mapping from dbus path -> struct iwd_network, tracking the set of iwd
> + * KnownNetwork objects.
> + */
>  static GHashTable *known_networks;
>  static GHashTable *stations;
>  static GHashTable *access_points;
> @@ -84,6 +92,11 @@ struct iwd_device {
>         struct connman_device *device;
>  };
>
> +/**
> + * Structure tracking an net.connman.iwd.Network D-Bus object.
> + *
> + * This is mapped one-to-one to a connman_network object.
> + */
>  struct iwd_network {
>         GDBusProxy *proxy;
>         char *path;
> @@ -95,10 +108,17 @@ struct iwd_network {
>
>         struct iwd_device *iwdd;
>         struct connman_network *network;
> -       /* service's autoconnect */
> +       /*
> +        * connman_service's autoconnect.
> +        *
> +        * See Note [Managing autoconnect state] for more details.
> +        */
>         bool cm_autoconnect;
>  };
>
> +/**
> + * Structure tracking a net.connman.iwd.KnownNetwork D-Bus object.
> + */
>  struct iwd_known_network {
>         GDBusProxy *proxy;
>         char *path;
> @@ -109,7 +129,11 @@ struct iwd_known_network {
>         bool iwd_auto_connect;
>         int auto_connect_id;
>
> -       /* service's autoconnect */
> +       /*
> +        * connman_service's autoconnect.
> +        *
> +        * See Note [Managing autoconnect state] for more details.
> +        */
>         bool cm_autoconnect;
>  };
>
> @@ -1153,11 +1177,58 @@ static void network_property_change(GDBusProxy *proxy, const char *name,
>
>                 iwdkn = g_hash_table_lookup(known_networks,
>                                         iwdn->known_network);
> -               if (iwdkn)
> +               if (iwdkn) {
> +                       /* See Note [Managing autoconnect state] */
> +                       iwdkn->cm_autoconnect = iwdn->cm_autoconnect;
>                         update_auto_connect(iwdkn);
> +               }
>         }
>  }
>
> +/*
> + * Note [Managing autoconnect state]:
> + *
> + * We need to set the iwd_known_network's cm_autoconnect status from the
> + * iwd_network, which has in turn been set to the corresponding
> + * connman_service's state when it first appeared (due to
> + * __connman_service_create_from_network).
> + *
> + * The management of the autoconnect state between connman and its plugins and
> + * iwd is rather subtle and prone to bugs:
> + * - Connman itself determines the autoconnect state in struct connman_service,
> + *   which we cannot directly see; we only see cm_network_set_autoconnect
> + *   callbacks.
> + *
> + * - The iwd plugin maintains an independent state machine tracking iwd's view of
> + *   the world, which processes events in a non atomic fashion; for
> + *   instance, a iwd.KnownNetwork created event will appear before the
> + *   corresponding PropertyChanged setting the KnownNetwork property of the
> + *   iwd.Network corresponding to the created iwd.KnownNetwork.
> + *
> + * A typical flow of a network being newly connected to looks like so:
> + * - An iwd.Network appears, and add_network registers a connman_network
> + *   structure with Connman. Connman then in turn creates a service via
> + *   __connman_service_create_from_network.
> + *
> + * - The iwd plugin receives a callback from connman to set the autoconnect
> + *   state, setting the cm_autoconnect state of the iwd_network. At this point,
> + *   there is no iwd_known_network yet.
> + *
> + * - Connman receives a Connect() request on the connman.Service, which is
> + *   forwarded to the iwd plugin via cm_network_connect. The iwd plugin calls
> + *   Connect() on the corresponding iwd.Network (possibly using the iwd
> + *   plugin's agent to get credentials if necessary).
> + *
> + * - Around the time that the connection completes, a iwd.KnownNetwork created
> + *   event appears, followed by a PropertyChanged event noting the change in
> + *   the iwd.Network's KnownNetwork property.
> + *
> + *   This is the first time that we can associate the iwd.KnownNetwork with the
> + *   corresponding iwd.Network and iwd_network. We have the Connman-side
> + *   autoconnect status in the iwd_network structure at this point, so we
> + *   synchronize the autoconnect state with iwd here.
> + */
> +
>  static unsigned char calculate_strength(int strength)
>  {
>         unsigned char res;
> @@ -1303,7 +1374,7 @@ static void ap_property_change(GDBusProxy *proxy, const char *name,
>         if (!iwdap)
>                 return;
>
> -        if (!strcmp(name, "Started")) {
> +       if (!strcmp(name, "Started")) {
>                 dbus_bool_t started;
>
>                 dbus_message_iter_get_basic(iter, &started);
> @@ -1742,6 +1813,16 @@ static void create_known_network(GDBusProxy *proxy)
>                 iwdkn->name, iwdkn->type, iwdkn->hidden,
>                 iwdkn->last_connected_time, iwdkn->iwd_auto_connect);
>
> +       /*
> +        * Although we initialize the autoconnect state of this
> +        * iwd_known_network here, it is only initialized in the case of
> +        * networks that already existed prior to startup: in the
> +        * case of a new iwd.KnownNetwork appearing, we are called before the
> +        * iwd_network.known_network field is initialized by a subsequent
> +        * PropertyChanged event.
> +        *
> +        * See Note [Managing autoconnect state].
> +        */
>         init_auto_connect(iwdkn);
>
>         g_dbus_proxy_set_property_watch(iwdkn->proxy,
> --
> 2.38.1
>
