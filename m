Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D32F24
	for <connman@lists.linux.dev>; Tue, 14 Feb 2023 18:55:50 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id bx22so15972398pjb.3
        for <connman@lists.linux.dev>; Tue, 14 Feb 2023 10:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676400949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVxCj2UlL/3hCVb+Ifp2evq+TSr/aT87V0SVVet1ZPY=;
        b=nT0LGjjQCUuXwiz8HEPjH/IbsQ2M+s/v1V5aGCSOToiPQiXBnrdJZf3CBBo6S1j2Xg
         zpNsTZPkeQUmehKxdaw0Btt5fgdlTQ3Pyck46zAxCCSB8J3xpnvg5k1QtDtbhvIQa+4t
         4ZJ66yvyBcR8ddbL34Rq1x09jGwOxYSaomATQRGZ3IlOmiLvTxGrPlkuU5b7HhVsUHNv
         VlDHCBKOmNDPtRaSpCtudPbvW75g+cbBn7FdYwZEr5JSllttrQySVbo5iGPjdDEUZ1w2
         AygkaDBdybb59NiuZk2d+D3au+Ps0w/ySB8WeKeGTAYa7bVSe6HUQq3Xwj0lOSXcBDsE
         zeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676400949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVxCj2UlL/3hCVb+Ifp2evq+TSr/aT87V0SVVet1ZPY=;
        b=ZWv+uCNorQFIRTC3BKkaW/ox/QRPJu/A54MSUlTBaGedLtso7ej7cCZcfwIS5+OBXn
         xLbZkECuDOBYn85W30ygADF9ksJ0/DuVo/fwSHBj+7Q5ah3fochE+T98LNbL7OCIwICV
         f1076YaPLWVOzPytzOvKhgCpSchtY/WW9Xvkw4JMAlWmhmNQ+S7+Yf320M8gquB5AWcf
         0fIoo5+KgAbuTxt1UnanMln1Il+kTi/JUluaGD7lOJKq0A4268L37y09KCjDXqTFKFmy
         X0eVr0hc42ipQ7/QEaGDqDmH4hL+WkHBL4M607RnbroLFEXwD1hOdWkDMtafUrCLc9B0
         9H1g==
X-Gm-Message-State: AO0yUKXcXR6/Y5lpazX5E47IiKzKrwk3K52bnvtUUosUlLvK+F2bS84a
	3J4XYGGVvDzOqaAY9TMjIyBHRSwAduWNFp4hIuwclci9
X-Google-Smtp-Source: AK7set+3zM6keB3y0B1Q0dXpY9sNtPKP3+QJBY9/NAUvvO7gndQjXwhuaGNOVPxc0YOPCtHPskIWuVim8vTEC5bkwvY=
X-Received: by 2002:a17:903:22d1:b0:191:10b0:5fa5 with SMTP id
 y17-20020a17090322d100b0019110b05fa5mr975324plg.34.1676400949451; Tue, 14 Feb
 2023 10:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230116081624.12618-1-wagi@monom.org> <CAG17S_PHpxpWnkJrM-NC1J+MDqXzN0zeV-TZ97Euxhfgcj_mMg@mail.gmail.com>
In-Reply-To: <CAG17S_PHpxpWnkJrM-NC1J+MDqXzN0zeV-TZ97Euxhfgcj_mMg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 14 Feb 2023 12:55:37 -0600
Message-ID: <CAG17S_NzXYUOPkF1h0e056=jCBQaP3nUh2t0y0n9R5nzhe9yYA@mail.gmail.com>
Subject: Re: [PATCH] iwd: Add support to Scan in AP mode
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 16, 2023 at 5:00 PM KeithG <ys3al35l@gmail.com> wrote:
>
> On Mon, Jan 16, 2023 at 2:16 AM Daniel Wagner <wagi@monom.org> wrote:
> >
> > iwd support scanning in AccessPoint mode, thus forward scan requests
> > also when the device is in AccessPoint mode.
> >
> > Signed-off-by: Daniel Wagner <wagi@monom.org>
> > ---
> >
> > Only compile tested :)
> >
> >  plugins/iwd.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 49 insertions(+), 5 deletions(-)
> >
> > diff --git a/plugins/iwd.c b/plugins/iwd.c
> > index 2fe49a23316b..491a0e41da89 100644
> > --- a/plugins/iwd.c
> > +++ b/plugins/iwd.c
> > @@ -633,15 +633,28 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
> >         }
> >  }
> >
> > -static int cm_device_scan(struct connman_device *device,
> > -                               struct connman_device_scan_params *params)
> > +static void cm_ap_scan_cb(DBusMessage *message, void *user_data)
> > +{
> > +       const char *path = user_data;
> > +       struct iwd_ap *iwdap;
> > +
> > +       iwdap = g_hash_table_lookup(access_points, path);
> > +       if (!iwdap)
> > +               return;
> > +
> > +       if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_ERROR) {
> > +               const char *dbus_error = dbus_message_get_error_name(message);
> > +
> > +               DBG("%s scan failed: %s", path, dbus_error);
> > +       }
> > +}
> > +
> > +static int cm_station_scan(struct connman_device *device,
> > +                               struct connman_device_scan_params *param)
> >  {
> >         struct iwd_device *iwdd = connman_device_get_data(device);
> >         struct iwd_station *iwds;
> >
> > -       if (strcmp(iwdd->mode, "station"))
> > -               return -EINVAL;
> > -
> >         iwds = g_hash_table_lookup(stations, iwdd->path);
> >         if (!iwds)
> >                 return -EIO;
> > @@ -653,6 +666,37 @@ static int cm_device_scan(struct connman_device *device,
> >         return -EINPROGRESS;
> >  }
> >
> > +static int cm_ap_scan(struct connman_device *device,
> > +                               struct connman_device_scan_params *param)
> > +{
> > +       struct iwd_device *iwdd = connman_device_get_data(device);
> > +       struct iwd_ap *iwdap;
> > +
> > +       iwdap = g_hash_table_lookup(access_points, iwdd->path);
> > +       if (!iwdap)
> > +               return -EIO;
> > +
> > +       if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
> > +                       NULL, cm_ap_scan_cb, g_strdup(iwdap->path), g_free))
> > +               return -EIO;
> > +
> > +       return -EINPROGRESS;
> > +}
> > +
> > +static int cm_device_scan(struct connman_device *device,
> > +                               struct connman_device_scan_params *params)
> > +{
> > +       struct iwd_device *iwdd = connman_device_get_data(device);
> > +
> > +       if (!strcmp(iwdd->mode, "station"))
> > +               return cm_station_scan(device, params);
> > +
> > +       if (!strcmp(iwdd->mode, "ap"))
> > +               return cm_ap_scan(device, params);
> > +
> > +       return -EINVAL;
> > +}
> > +
> >  static struct connman_device_driver device_driver = {
> >         .name           = "iwd",
> >         .type           = CONNMAN_DEVICE_TYPE_WIFI,
> > --
> > 2.39.0
> >
> >
> Daniel,
>
> Thanks for making this patch. I can confirm that this patch compiles
> and I can run connman with it, but when I enable ap mode with iwd, I
> cannot get a scan:
>
> ~# iwctl device list
>                                     Devices
> --------------------------------------------------------------------------------
>   Name                  Address               Powered     Adapter     Mode
> --------------------------------------------------------------------------------
>   wlan0                 b8:27:eb:a4:6e:0f     on          phy0        ap
>
> ~# iwctl ap wlan0 scan
> ~# iwctl ap wlan0 get-networks
>                                     Networks
> --------------------------------------------------------------------------------
>             Property              Value
> --------------------------------------------------------------------------------
>             Name                  spg4
>             SignalStrength        -4400
>             Type                  psk
>
>             Name                  ATTcVY9ZWa
>             SignalStrength        -5100
>             Type                  psk
>
>             Name                  ATT3zFM5gH
>             SignalStrength        -5900
>             Type                  psk
>
>             Name                  2WIRE811
>             SignalStrength        -6900
>             Type                  psk
>
>             Name                  ATTU8Z3d7i
>             SignalStrength        -8400
>             Type                  psk
>
> So I am in AP mode and I am connected via WiFi to it.
>
> In connman, though, I do not get any wifi SSIDS:
>
> ~# connmanctl services
> *AO Wired                ethernet_b827ebf13b5a_cable
> ~# connmanctl enable wifi
> wifi is already enabled
> ~# connmanctl scan wifi
> Error /net/connman/technology/wifi: Did not receive a reply. Possible
> causes include: the remote application did not send a reply, the
> message bus security policy blocked the reply, the reply timeout
> expired, or the network connection was broken.
>
> Is this how it might work? This is how we do it when we use hostapd to
> connect instead of iwd.
>
> Keith

Is this still something that could be done? I can build and test any
patches pretty quickly (except for next week).

Keith
