Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41791B0F17
	for <connman@lists.linux.dev>; Mon,  2 Jun 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850077; cv=none; b=KiCbakJVasjbtAUbY/Aqnc6W6JuLZJr5LmLjtIEMe1ULPjbGwLnr67vlIS2PTuNyvyo+tP3gKP0Ajm072WNmY/X+mfYtLFgB5Jx3H6I7uCAO3p+xXe+JKAexEWdvA9MvpsrNo0+BmWoPEt8eTgU/IVf8lz5NFjsZ3bO7IXHeGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850077; c=relaxed/simple;
	bh=VS+VnGod+MKyS0nHbQVtSjGvJSGP927AmqLm+BWzJNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foeL7ewog2D+4plYYWWm/Nl25jWGxhnGYv376jG1Vqx0dOBeohDNDxzgF5OEMAbJ9/Pmr2H1JDt6winSCM6dv/NFgvPfQpBXUksYhBXV2nL2WjP7DF435qVa57oU5fG9RI8xzBlUYR/ogYoC5h7SP9nSoVtknnbZ4kmBThxxd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=SZEjnLpp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SZEjnLpp"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so4321828a12.2
        for <connman@lists.linux.dev>; Mon, 02 Jun 2025 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1748850075; x=1749454875; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFqTy4VGOSeChAha0IJi7a6/eT/Vvdy48z4zkG2NxXo=;
        b=SZEjnLppR1upqr5ZT2CJDQwRMYIxdIMC/QYWsZ+xwv2utraDAal8RgYF8f2HO3iVfH
         FKYbdiozM5FpZ89FYi1JM7YYxzNywrvJOq7R80XB7u+D34fCtoBEEJoD8rvCTJr6Zy5T
         ojALyAd9EWIt7P27a8+LqrCEK69gLpNNjwNWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748850075; x=1749454875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFqTy4VGOSeChAha0IJi7a6/eT/Vvdy48z4zkG2NxXo=;
        b=JdbLaaml+Xo5zaRmULTKRcbbFeSxL2+0OesxL5v0+ft7YuLAC8XTTB8lyEbwvZ+3Rn
         aWUQyoPVEcKtUE3bMJCAEzd/2vsnGhkEexWmgA9TYNanJcvEjyJdjocIyDxD2Ye2QboC
         IWx8IAsTqogCrVfOQuGeaFiWs0oFrK0k73wJYCJ20dbayAPUFw8MkhEGxLYLdNQThgZa
         i8MCpmjte6c130v+cVr6rB9fcKOEdbxG627zgiBNNwpa+0pGu6szixDGrNENzu/DR89z
         I+aDtWsynpyoLpumjM3ACEHb0Ejl9YQtSDFMq4SAGZoE9soQzsm9gR32ke+F24UwF4+l
         hG5A==
X-Gm-Message-State: AOJu0YyI+KjdpVfOH5CnA5tgKuIXExsQkt5OofLNrI+SlLyt1qop2fNs
	LIxwahNwI/WnS3xIjlF/xfdZkSD3IAAd3vQDYW5baC3Dihj6LIPFFT9xO2Ico/8X8n3Lvx3/N86
	mAtrLRwhbJUt4j4r8beJKoJyJZaEodofi81csJPPdOH0Dj+i8xIhf9TE=
X-Gm-Gg: ASbGnctJ0yo7JbRxHTzfNgZpQlv8ynibycqF4Y/AMs2E25n6R1lOk2Sf52IwD2SosuM
	NSw8OuWHC0TNSjepxImWJyQB1SsgfsjwxWGqPMwFHP6xu3JljzdbKPqMv47hSJRQjcHdOC+Cuyx
	H1lgr5lfLtQpxX9mzKtc3jDnb6j+zN9v0=
X-Google-Smtp-Source: AGHT+IFLxhW0EY01G/uEv31ORFOAFd4lbcdYZBcQq/52LaW/3RjcmOL6LJFPtnDyo1160yE8V4uwAeAxDLCofTkXtbM=
X-Received: by 2002:a17:90b:3e84:b0:311:c1ec:7d12 with SMTP id
 98e67ed59e1d1-3127c85025amr9203390a91.23.1748850074837; Mon, 02 Jun 2025
 00:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SE1P216MB2647222FA0265D346F4C13C1F062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB2647222FA0265D346F4C13C1F062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 2 Jun 2025 09:40:53 +0200
X-Gm-Features: AX0GCFuMewQZP9wEdd0ht5ql6WUx32zgcBPcbm9B4IeouQwAxYuP-wZlRPDh3V8
Message-ID: <CAOf5uwnBz5gC8+u2PBJAmqa0NnBkww_oG41O=91K4zbcTuTUkg@mail.gmail.com>
Subject: Re: [PATCH] connman : Introduce softap with ip feature to connman
To: "Shailesh Rathod/LGSI GPOS Dev" <shailesh.rathod@lge.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>, 
	"Vasu Kantubukta/LGSI Connectivity Team" <vasu.kantubukta@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 2, 2025 at 8:33=E2=80=AFAM Shailesh Rathod/LGSI GPOS Dev
<shailesh.rathod@lge.com> wrote:
>
> From: Shailesh Rathod<shailesh.rathod@lge.com>
> Date: Mon, 21 Apr 2025 18:16:09 +0900
>
> Introduce softap with ip feature to connman
>
> By default, ConnMan supports tethering with a passphrase.
> However, it does not support configuring tethering with a
> specific IP address and channel.For certain applications
>  it is essential to set a specific IP address for the SoftAP.
>
> To enable support for specifying the IP address
> and channel, new properties TetheringIPAddress and
> TetheringChannel should be added.
>
> Signed-off-by: Shailesh Rathod<shailesh.rathod@lge.com>
> ---
>  src/connman.h    |  15 ++++++
>  src/technology.c | 122 +++++++++++++++++++++++++++++++++++++++---
>  src/tethering.c  | 136 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 267 insertions(+), 6 deletions(-)
>
> diff --git a/src/connman.h b/src/connman.h
> index 32ba559..4241a58 100644
> --- a/src/connman.h
> +++ b/src/connman.h
> @@ -676,9 +676,24 @@ bool __connman_config_address_provisioned(const char=
 *address,
>
>  #include <connman/tethering.h>
>
> +struct connman_station_info {
> +        bool is_connected;
> +        char *path;
> +        char *type;
> +        char ip[64];
> +        char mac[32];
> +        char hostname[64];
> +};
> +
> +

Can you drop this extra blank line?

Anyway how is different from the one sent by Roman some time ago?

Michael


>  int __connman_tethering_init(void);
>  void __connman_tethering_cleanup(void);
>
> +GHashTable *__connman_tethering_get_sta_hash();
> +
> +void __connman_tethering_list_clients(DBusMessageIter *array);
> +int __connman_tethering_set_enabled_with_ip(const char *ip);
> +
>  const char *__connman_tethering_get_bridge(void);
>  int __connman_tethering_set_enabled(void);
>  void __connman_tethering_set_disabled(void);
> diff --git a/src/technology.c b/src/technology.c
> index 270d83d..719c680 100644
> --- a/src/technology.c
> +++ b/src/technology.c
> @@ -69,6 +69,8 @@ struct connman_technology {
>         char *tethering_ident;
>         char *tethering_passphrase;
>         int tethering_freq;
> +       char *tethering_ipaddress;
> +    unsigned int tethering_channel;
>
>         bool enable_persistent; /* Save the tech state */
>
> @@ -195,6 +197,16 @@ static void technology_save(struct connman_technolog=
y *technology)
>                 g_free(enc);
>         }
>
> +       if (technology->tethering_channel)
> +                g_key_file_set_integer(keyfile, identifier,
> +                                    "Tethering.Channel",
> +                                    technology->tethering_channel);
> +
> +    if (technology->tethering_ipaddress)
> +                g_key_file_set_string(keyfile, identifier,
> +                                    "Tethering.IP",
> +                                     technology->tethering_ipaddress);
> +
>         if (technology->tethering_freq =3D=3D 0)
>                 technology->tethering_freq =3D 2412;
>
> @@ -225,18 +237,25 @@ int connman_technology_tethering_notify(struct conn=
man_technology *technology,
>                                                         bool enabled)
>  {
>         int err;
> +       const char *ip;
>
>         DBG("technology %p enabled %u", technology, enabled);
>
>         if (technology->tethering =3D=3D enabled)
>                 return -EALREADY;
>
> -       if (enabled) {
> -               err =3D __connman_tethering_set_enabled();
> -               if (err < 0)
> -                       return err;
> -       } else
> -               __connman_tethering_set_disabled();
> +       ip =3D technology->tethering_ipaddress;
> +
> +    if (enabled) {
> +        if (!ip || strlen(ip) =3D=3D 0)
> +            err =3D __connman_tethering_set_enabled();
> +        else
> +            err =3D __connman_tethering_set_enabled_with_ip(ip);
> +
> +        if (err < 0)
> +            return err;
> +    } else
> +        __connman_tethering_set_disabled();
>
>         technology->tethering =3D enabled;
>         tethering_changed(technology);
> @@ -417,6 +436,17 @@ bool connman_technology_get_wifi_tethering(const str=
uct connman_technology *tech
>         return true;
>  }
>
> +unsigned int connman_technology_get_wifi_tethering_channel(void)
> +{
> +        struct connman_technology *technology;
> +
> +        technology =3D technology_find(CONNMAN_SERVICE_TYPE_WIFI);
> +        if (!technology)
> +                return 0;
> +
> +        return technology->tethering_channel;
> +}
> +
>  static void free_rfkill(gpointer data)
>  {
>         struct connman_rfkill *rfkill =3D data;
> @@ -479,6 +509,12 @@ static void technology_load(struct connman_technolog=
y *technology)
>
>         enc =3D g_key_file_get_string(keyfile,
>                                 identifier, "Tethering.Passphrase", NULL)=
;
> +
> +       technology->tethering_channel =3D g_key_file_get_integer(keyfile,
> +                identifier, "Tethering.Channel", NULL);
> +
> +    technology->tethering_ipaddress =3D g_key_file_get_string(keyfile,
> +                identifier, "Tethering.IP", NULL);
>         if (enc) {
>                 technology->tethering_passphrase =3D g_strcompress(enc);
>                 g_free(enc);
> @@ -597,6 +633,15 @@ static void append_properties(DBusMessageIter *iter,
>                 connman_dbus_dict_append_basic(&dict, "TetheringPassphras=
e",
>                                         DBUS_TYPE_STRING,
>                                         &technology->tethering_passphrase=
);
> +       if (technology->tethering_ipaddress)
> +        connman_dbus_dict_append_basic(&dict, "TetheringIPAddress",
> +                    DBUS_TYPE_STRING,
> +                    &technology->tethering_ipaddress);
> +
> +    if (technology->tethering_channel)
> +        connman_dbus_dict_append_basic(&dict, "TetheringChannel",
> +                    DBUS_TYPE_UINT32,
> +                    &technology->tethering_channel);
>
>         connman_dbus_dict_append_basic(&dict, "TetheringFreq",
>                                 DBUS_TYPE_INT32,
> @@ -1016,6 +1061,55 @@ static DBusMessage *set_property(DBusConnection *c=
onn,
>                                         DBUS_TYPE_STRING,
>                                         &technology->tethering_passphrase=
);
>                 }
> +       } else if (g_str_equal(name, "TetheringChannel")) {
> +                dbus_uint32_t channel;
> +
> +                if (type !=3D DBUS_TYPE_UINT32)
> +                        return __connman_error_invalid_arguments(msg);
> +
> +                dbus_message_iter_get_basic(&value, &channel);
> +
> +                if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI)
> +                        return __connman_error_not_supported(msg);
> +
> +                if (channel =3D=3D 0 || channel > 13)
> +                        return __connman_error_invalid_arguments(msg);
> +
> +                if (technology->tethering_channel !=3D channel) {
> +
> +                        technology->tethering_channel =3D channel;
> +                        technology_save(technology);
> +
> +                        connman_dbus_property_changed_basic(technology->=
path,
> +                                        CONNMAN_TECHNOLOGY_INTERFACE,
> +                                        "TetheringChannel",
> +                                        DBUS_TYPE_UINT32,
> +                                        &technology->tethering_channel);
> +                }
> +        } else if (g_str_equal(name, "TetheringIPAddress")) {
> +                const char *str =3D NULL;
> +
> +                dbus_message_iter_get_basic(&value, &str);
> +
> +                if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI)
> +                        return __connman_error_not_supported(msg);
> +
> +                if (!str || strlen(str) =3D=3D 0) {
> +                        g_free(technology->tethering_ipaddress);
> +                        technology->tethering_ipaddress =3D NULL;
> +                        return __connman_error_invalid_arguments(msg);
> +                }
> +                if (g_strcmp0(technology->tethering_ipaddress, str) !=3D=
 0) {
> +                        g_free(technology->tethering_ipaddress);
> +                        technology->tethering_ipaddress =3D g_strdup(str=
);
> +                        technology_save(technology);
> +
> +                        connman_dbus_property_changed_basic(technology->=
path,
> +                                        CONNMAN_TECHNOLOGY_INTERFACE,
> +                                        "TetheringIPAddress",
> +                                        DBUS_TYPE_STRING,
> +                                        &technology->tethering_ipaddress=
);
> +                }
>         } else if (g_str_equal(name, "TetheringFreq")) {
>                 dbus_int32_t freq;
>
> @@ -1257,6 +1351,7 @@ static void technology_put(struct connman_technolog=
y *technology)
>         g_free(technology->regdom);
>         g_free(technology->tethering_ident);
>         g_free(technology->tethering_passphrase);
> +       g_free(technology->tethering_ipaddress);
>         g_free(technology);
>  }
>
> @@ -1935,3 +2030,18 @@ void __connman_technology_cleanup(void)
>
>         g_free(global_regdom);
>  }
> +
> +void __connman_technology_sta_count_changed(enum connman_service_type ty=
pe, int stacount)
> +{
> +        struct connman_technology *technology;
> +
> +        technology =3D technology_find(type);
> +        if (technology =3D=3D NULL)
> +                return;
> +
> +        connman_dbus_property_changed_basic(technology->path,
> +                                        CONNMAN_TECHNOLOGY_INTERFACE, "S=
taCount",
> +                                        DBUS_TYPE_INT32, &stacount);
> +
> +
> +}
> \ No newline at end of file
> diff --git a/src/tethering.c b/src/tethering.c
> index f930a26..7039037 100644
> --- a/src/tethering.c
> +++ b/src/tethering.c
> @@ -49,6 +49,7 @@
>  #endif
>
>  #define BRIDGE_NAME "tether"
> +#define SUBNET_MASK_24 "255.255.255.0"
>
>  #define DEFAULT_MTU    1500
>
> @@ -200,6 +201,7 @@ static void unregister_all_clients(void)
>         g_hash_table_foreach(clients_table, unregister_client, NULL);
>  }
>
> +
>  int __connman_tethering_set_enabled(void)
>  {
>         int index;
> @@ -363,6 +365,140 @@ void __connman_tethering_list_clients(DBusMessageIt=
er *array)
>         g_hash_table_foreach(clients_table, append_client, array);
>  }
>
> +static char *get_ip(uint32_t ip)
> +{
> +        struct in_addr addr;
> +
> +        addr.s_addr =3D htonl(ip);
> +
> +        return g_strdup(inet_ntoa(addr));
> +}
> +
> +int __connman_tethering_set_enabled_with_ip(const char *ip)
> +{
> +        int index;
> +        int err;
> +        const char *gateway;
> +        const char *broadcast;
> +        const char *subnet_mask;
> +        const char *start_ip;
> +        const char *end_ip;
> +        const char *dns;
> +        unsigned char prefixlen;
> +        char **ns;
> +
> +        DBG("enabled %d", tethering_enabled + 1);
> +
> +        if (__sync_fetch_and_add(&tethering_enabled, 1) !=3D 0)
> +                return 0;
> +
> +        err =3D __connman_bridge_create(BRIDGE_NAME);
> +        if (err < 0) {
> +                __sync_fetch_and_sub(&tethering_enabled, 1);
> +                return 0;
> +        }
> +
> +        index =3D connman_inet_ifindex(BRIDGE_NAME);
> +
> +        __connman_ippool_newaddr(index, ip, 24);
> +
> +        struct in_addr inp;
> +        uint32_t start, mask;
> +
> +        if (inet_aton(ip, &inp) =3D=3D 0)
> +                return 0;
> +
> +        start =3D ntohl(inp.s_addr);
> +        mask =3D ~(0xffffffff >> 24);
> +
> +        start =3D start & mask;
> +
> +        gateway =3D ip;
> +        broadcast =3D get_ip(start + 255);
> +        subnet_mask =3D SUBNET_MASK_24;
> +        start_ip =3D get_ip(start + 2);
> +        end_ip =3D get_ip(start + 254);
> +
> +        err =3D __connman_bridge_enable(BRIDGE_NAME, gateway,
> +                        connman_ipaddress_calc_netmask_len(subnet_mask),
> +                        broadcast);
> +        if (err < 0 && err !=3D -EALREADY) {
> +                __connman_ippool_free(dhcp_ippool);
> +                __connman_ippool_deladdr(index, ip, 24);
> +                __connman_bridge_remove(BRIDGE_NAME);
> +                __sync_fetch_and_sub(&tethering_enabled, 1);
> +                err =3D -EADDRNOTAVAIL;
> +                goto clean;
> +        }
> +
> +        ns =3D connman_setting_get_string_list("FallbackNameservers");
> +        if (ns) {
> +                if (ns[0]) {
> +                        g_free(private_network_primary_dns);
> +                        private_network_primary_dns =3D g_strdup(ns[0]);
> +                }
> +                if (ns[1]) {
> +                        g_free(private_network_secondary_dns);
> +                        private_network_secondary_dns =3D g_strdup(ns[1]=
);
> +                }
> +
> +                DBG("Fallback ns primary %s secondary %s",
> +                        private_network_primary_dns,
> +                        private_network_secondary_dns);
> +        }
> +
> +        dns =3D gateway;
> +        if (__connman_dnsproxy_add_listener(index) < 0) {
> +                connman_error("Can't add listener %s to DNS proxy",
> +                                                                BRIDGE_N=
AME);
> +                dns =3D private_network_primary_dns;
> +                DBG("Serving %s nameserver to clients", dns);
> +        }
> +
> +        tethering_dhcp_server =3D dhcp_server_start(BRIDGE_NAME,
> +                                                gateway, subnet_mask,
> +                                                start_ip, end_ip,
> +                                                24 * 3600, dns);
> +        if (!tethering_dhcp_server) {
> +                __connman_bridge_disable(BRIDGE_NAME);
> +                __connman_ippool_free(dhcp_ippool);
> +                __connman_ippool_deladdr(index, ip, 24);
> +                __connman_bridge_remove(BRIDGE_NAME);
> +                __sync_fetch_and_sub(&tethering_enabled, 1);
> +                err =3D -EOPNOTSUPP;
> +                goto clean;
> +        }
> +
> +        prefixlen =3D connman_ipaddress_calc_netmask_len(subnet_mask);
> +        err =3D __connman_nat_enable(BRIDGE_NAME, start_ip, prefixlen);
> +        if (err < 0) {
> +                connman_error("Cannot enable NAT %d/%s", err, strerror(-=
err));
> +                dhcp_server_stop(tethering_dhcp_server);
> +                __connman_bridge_disable(BRIDGE_NAME);
> +                __connman_ippool_free(dhcp_ippool);
> +                __connman_ippool_deladdr(index, ip, 24);
> +                __connman_bridge_remove(BRIDGE_NAME);
> +                __sync_fetch_and_sub(&tethering_enabled, 1);
> +                err =3D -EOPNOTSUPP;
> +                goto clean;
> +        }
> +
> +        err =3D __connman_ipv6pd_setup(BRIDGE_NAME);
> +        if (err < 0 && err !=3D -EINPROGRESS)
> +                DBG("Cannot setup IPv6 prefix delegation %d/%s", err,
> +                        strerror(-err));
> +clean:
> +        g_free(broadcast);
> +        g_free(start_ip);
> +        g_free(end_ip);
> +        if ((err =3D=3D -EOPNOTSUPP) || (err =3D=3D -EADDRNOTAVAIL)){
> +                return err;
> +        } else {
> +                DBG("tethering started");
> +                return 0;
> +        }
> +}
> +
>  static void setup_tun_interface(unsigned int flags, unsigned change,
>                 void *data)
>  {
>
>


--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
