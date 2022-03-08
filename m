Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC02F35
	for <connman@lists.linux.dev>; Tue,  8 Mar 2022 22:37:59 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id z8so844858oix.3
        for <connman@lists.linux.dev>; Tue, 08 Mar 2022 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsKDXwCE0UgS8/CBM4CXKo4qlTVg0bqVkGY0xcKtDrs=;
        b=Pg++a3Mvm5CR0ARcL3VSC5g6pA4JZbk17KhNOo47NXkq0w2ot0xkG+mW+jG9xOC5of
         i5nvCjnBFPN3IwjDKHrVrqSj0d+oZ5ovPM6Y6PK3WsGobSAEHrxHfkIn+zB6IM2I8xyJ
         dkQN2IPH29W88iXTIMnlGch+kP1AWC1h4oeCYVhvhngLDrNPCESDUUfV0UpCrZg7/Mkg
         XgSRUFLzeOHS8R93c1m06TnT5qxsakQiZu+NllQEc2ZT9ODi2vpaRqdIDaAXPg/rN5wQ
         xqwAD0kBqybIK3ARKq/bVyA67MiB81SWseZLksrAFVDHkLCEkeuWs1mlnIqM/Uja1vbM
         E5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsKDXwCE0UgS8/CBM4CXKo4qlTVg0bqVkGY0xcKtDrs=;
        b=yvXGzSmOYY/o21VRIqZB0f2QQPPCplNrmOzT7siGFyCksBYnRXCPaNMepEVHOC2PZr
         zQX8GBeoQyFBztwwhS4gSX9kBv/uxAqhbYCMPE6T76kwXty3rA2C7flHMChidy8dAVt0
         QkWr1OA71zBrjSAKZu76F1vw9bSqhu7pUyBraduMXazwqlmC0X/ADpHxk7XdxFGCDU5f
         I5Gdv2Ea39LlPVFm+jhvoKi4lXkabEJ9qVXU0fEbwGSiQEA/Re3jesxEM1wNeeDJ1E8e
         T1zv7gxMM3YNr/NPYqvSVKocoBXEdqp23lY09437mK9Y42bVwuj6aHvh3QBfZtFn0MFY
         /bYw==
X-Gm-Message-State: AOAM533sLZGeSVbdKssvgUmxx8vHUHwnDg1ykRIBmnpsa0RJEd1DIMvB
	iO/c+vgV8977nCAHBm4ty2PG7pbvxvAmdmg6MJIRUq2J4lY=
X-Google-Smtp-Source: ABdhPJwcrjUr4KmmQE0bz/QD1VM0pDtYZoEnwZCdZ3T8K3GbSFaFXuswPiTjs2nBmMkUdocLBHccUp2JlGnw8G0XyXE=
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id
 j13-20020a056808118d00b002d4be7e6748mr4029141oil.123.1646779078604; Tue, 08
 Mar 2022 14:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220307090321.27204-1-wagi@monom.org>
In-Reply-To: <20220307090321.27204-1-wagi@monom.org>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 8 Mar 2022 16:37:47 -0600
Message-ID: <CAG17S_MqNzp1n8qHmWkLS918uSUYdEqWS-CHrHMg6uC0Xr-auw@mail.gmail.com>
Subject: Re: [PATCH] iwd: Add scan support in access point mode
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Daniel,

I tried this patch and still do not get the Pi to scan from connman. I
get this error after I first made sure that iwd was connected and
could scan for networks.

# connmanctl scan wifi
Error /net/connman/technology/wifi: Did not receive a reply. Possible
causes include: the remote application did not send a reply, the
message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.

These lines show up in the journal when In initiate a scan:
Mar 08 16:32:25 rune64 connmand[423]: src/technology.c:scan()
technology 0x55adeadf30 request from :1.87
Mar 08 16:32:25 rune64 connmand[423]:
src/device.c:connman_device_request_scan() device 0x55adeae070 err -95
Mar 08 16:32:27 rune64 connmand[423]: src/rtnl.c:rtnl_message()
NEWLINK len 64 type 16 flags 0x0000 seq 0 pid 0

Keith

On Mon, Mar 7, 2022 at 3:03 AM Daniel Wagner <wagi@monom.org> wrote:
>
> ---
>  plugins/iwd.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index 8974e6645295..5b3ebd3bfee8 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -550,7 +550,7 @@ static int cm_device_disable(struct connman_device *device)
>         return set_device_powered(device, false);
>  }
>
> -static void cm_device_scan_cb(DBusMessage *message, void *user_data)
> +static void cm_device_scan_station_cb(DBusMessage *message, void *user_data)
>  {
>         const char *path = user_data;
>         struct iwd_station *iwds;
> @@ -566,22 +566,52 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
>         }
>  }
>
> +static void cm_device_scan_ap_cb(DBusMessage *message, void *user_data)
> +{
> +       const char *path = user_data;
> +       struct iwd_ap *iwdap;
> +
> +       iwdap = g_hash_table_lookup(access_points, path);
> +       if (!iwdap)
> +               return;
> +
> +       if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_ERROR) {
> +               const char *dbus_error = dbus_message_get_error_name(message);
> +
> +               DBG("%s scan failed: %s", path, dbus_error);
> +       }
> +}
> +
>  static int cm_device_scan(struct connman_device *device,
>                                 struct connman_device_scan_params *params)
>  {
>         struct iwd_device *iwdd = connman_device_get_data(device);
> -       struct iwd_station *iwds;
>
> -       if (strcmp(iwdd->mode, "station"))
> -               return -EINVAL;
> +       if (!strcmp(iwdd->mode, "station")) {
> +               struct iwd_station *iwds;
>
> -       iwds = g_hash_table_lookup(stations, iwdd->path);
> -       if (!iwds)
> -               return -EIO;
> +               iwds =  g_hash_table_lookup(stations, iwdd->path);
> +               if (!iwds)
> +                       return -EIO;
>
> -       if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
> -                       NULL, cm_device_scan_cb, g_strdup(iwds->path), g_free))
> -               return -EIO;
> +               if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
> +                               NULL, cm_device_scan_station_cb,
> +                               g_strdup(iwds->path), g_free))
> +                       return -EIO;
> +       } else if (!strcmp(iwdd->mode, "ap")) {
> +               struct iwd_ap *iwdap;
> +
> +               iwdap = g_hash_table_lookup(access_points, iwdd->path);
> +               if (!iwdap)
> +                       return -EIO;
> +
> +               if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
> +                               NULL, cm_device_scan_ap_cb,
> +                               g_strdup(iwdap->path), g_free))
> +                       return -EIO;
> +       } else {
> +               return -EINVAL;
> +       }
>
>         return -EINPROGRESS;
>  }
> --
> 2.35.1
>
>
