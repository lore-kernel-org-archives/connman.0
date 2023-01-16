Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECB290B
	for <connman@lists.linux.dev>; Mon, 16 Jan 2023 23:01:07 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id y1so31729202plb.2
        for <connman@lists.linux.dev>; Mon, 16 Jan 2023 15:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oD34+g6P7jgspADFn2mFwlMyy2ZzQtLY3/9ip+S1ru4=;
        b=NbIHhxGfrPHqw/ZbIIiiKdwd49qvjXjeYNwNJB+QKcGMDyP1MSgyTfE3oRhmhZqfZk
         FeLTSZIAo2dcC1O18ABdj3TvoNdx1FkAPP/bkv+BIpZ72qGOK+TFNEBU6NT8NdXeqZAd
         2B0rEejMMCQkjuSc8glEy8HSGP4oIFYfO5AiEx3s1/ZQc+WSV0S6loX8MSiRMm2z7eKt
         Mh606rA/Jdn97oKxlP/pvSJ81HrTXIyaQps4T1j6/f1esNv0I8jWrtpi/vIQKeohSC0k
         7/Fzxlo0foC5tBzE3OiR3pYBir6lg/c4Mu/SRmDe8g1TsgX5+HjFIgjFbfqBWTH9BKzA
         bsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD34+g6P7jgspADFn2mFwlMyy2ZzQtLY3/9ip+S1ru4=;
        b=w40gpfj8sXP8P21kq4qoUVPIJIJ202DmDx5qhbyVH05V2a/VEnpVS87pe6bsT2EVCM
         iXydfR6E8b5AfCK2bT3sk3tE8XeYVV8kkduYFE5wefCmMi7sdYE7dPKSjwLve1sfT0FY
         veVNwYsIOu+ut5X9JsqYebDKNLGyMhUlNIUtATEA7pZNSF+tJPnHiKD+CCI/8p+2mW7f
         G2T5TKj0unGNWabILGeB86/5DtNi7EyMdkMAOLhIUIXcZT3yfXl68/km0HA5RqqBYkfn
         vX6dvan4z+xvLlAWUWH8GQd4XkRuIFTcia20U9FH3qckor52/yCHm+6ZCvdvTPF4BBiz
         TCuw==
X-Gm-Message-State: AFqh2koz6cKgmu+OSCRyP0uWhwfwFV0cueN8Qb6oASzEjv0PVdJjIGbr
	sBjOKS61+1YT/KiWBzcUwjxE+6dk2L8bMDQqmv4=
X-Google-Smtp-Source: AMrXdXukcmio5PqwUP1h9oLyEisKE7f77ViNytCqlU1atC5uS6TqoCKGq3QcdaAHHf7XRJ4o2mzmOxakLW1p+HzOPqs=
X-Received: by 2002:a17:90a:e617:b0:21a:2090:84ab with SMTP id
 j23-20020a17090ae61700b0021a209084abmr86508pjy.234.1673910066749; Mon, 16 Jan
 2023 15:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230116081624.12618-1-wagi@monom.org>
In-Reply-To: <20230116081624.12618-1-wagi@monom.org>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 16 Jan 2023 17:00:55 -0600
Message-ID: <CAG17S_PHpxpWnkJrM-NC1J+MDqXzN0zeV-TZ97Euxhfgcj_mMg@mail.gmail.com>
Subject: Re: [PATCH] iwd: Add support to Scan in AP mode
To: 20230116073300.hy6spqhqitohj3eu@beryllium.lan
Cc: connman@lists.linux.dev, Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 16, 2023 at 2:16 AM Daniel Wagner <wagi@monom.org> wrote:
>
> iwd support scanning in AccessPoint mode, thus forward scan requests
> also when the device is in AccessPoint mode.
>
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>
> Only compile tested :)
>
>  plugins/iwd.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index 2fe49a23316b..491a0e41da89 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -633,15 +633,28 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
>         }
>  }
>
> -static int cm_device_scan(struct connman_device *device,
> -                               struct connman_device_scan_params *params)
> +static void cm_ap_scan_cb(DBusMessage *message, void *user_data)
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
> +static int cm_station_scan(struct connman_device *device,
> +                               struct connman_device_scan_params *param)
>  {
>         struct iwd_device *iwdd = connman_device_get_data(device);
>         struct iwd_station *iwds;
>
> -       if (strcmp(iwdd->mode, "station"))
> -               return -EINVAL;
> -
>         iwds = g_hash_table_lookup(stations, iwdd->path);
>         if (!iwds)
>                 return -EIO;
> @@ -653,6 +666,37 @@ static int cm_device_scan(struct connman_device *device,
>         return -EINPROGRESS;
>  }
>
> +static int cm_ap_scan(struct connman_device *device,
> +                               struct connman_device_scan_params *param)
> +{
> +       struct iwd_device *iwdd = connman_device_get_data(device);
> +       struct iwd_ap *iwdap;
> +
> +       iwdap = g_hash_table_lookup(access_points, iwdd->path);
> +       if (!iwdap)
> +               return -EIO;
> +
> +       if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
> +                       NULL, cm_ap_scan_cb, g_strdup(iwdap->path), g_free))
> +               return -EIO;
> +
> +       return -EINPROGRESS;
> +}
> +
> +static int cm_device_scan(struct connman_device *device,
> +                               struct connman_device_scan_params *params)
> +{
> +       struct iwd_device *iwdd = connman_device_get_data(device);
> +
> +       if (!strcmp(iwdd->mode, "station"))
> +               return cm_station_scan(device, params);
> +
> +       if (!strcmp(iwdd->mode, "ap"))
> +               return cm_ap_scan(device, params);
> +
> +       return -EINVAL;
> +}
> +
>  static struct connman_device_driver device_driver = {
>         .name           = "iwd",
>         .type           = CONNMAN_DEVICE_TYPE_WIFI,
> --
> 2.39.0
>
>
Daniel,

Thanks for making this patch. I can confirm that this patch compiles
and I can run connman with it, but when I enable ap mode with iwd, I
cannot get a scan:

~# iwctl device list
                                    Devices
--------------------------------------------------------------------------------
  Name                  Address               Powered     Adapter     Mode
--------------------------------------------------------------------------------
  wlan0                 b8:27:eb:a4:6e:0f     on          phy0        ap

~# iwctl ap wlan0 scan
~# iwctl ap wlan0 get-networks
                                    Networks
--------------------------------------------------------------------------------
            Property              Value
--------------------------------------------------------------------------------
            Name                  spg4
            SignalStrength        -4400
            Type                  psk

            Name                  ATTcVY9ZWa
            SignalStrength        -5100
            Type                  psk

            Name                  ATT3zFM5gH
            SignalStrength        -5900
            Type                  psk

            Name                  2WIRE811
            SignalStrength        -6900
            Type                  psk

            Name                  ATTU8Z3d7i
            SignalStrength        -8400
            Type                  psk

So I am in AP mode and I am connected via WiFi to it.

In connman, though, I do not get any wifi SSIDS:

~# connmanctl services
*AO Wired                ethernet_b827ebf13b5a_cable
~# connmanctl enable wifi
wifi is already enabled
~# connmanctl scan wifi
Error /net/connman/technology/wifi: Did not receive a reply. Possible
causes include: the remote application did not send a reply, the
message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.

Is this how it might work? This is how we do it when we use hostapd to
connect instead of iwd.

Keith
