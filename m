Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023BC7C
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 15:22:41 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id k22-20020a9d4b96000000b005ad5211bd5aso7699400otf.8
        for <connman@lists.linux.dev>; Fri, 04 Mar 2022 07:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXfmoa48pksAbRzxcMosYfxWeQGUpphzeu8Yc2+dB6Y=;
        b=fDm/EPvD5vDgBXfETkqx7S60cNR1uoMUCVJg4t/cO6CaK2muaJPGqDRUV1+20nN4hR
         ym9ukltEOlxAEPVEj1xn8KqIIpQpRIguysEyUvxF43C5TXJ/rJvq5b6diErfn9uJsWVg
         CCdUyaKbZGdplN25c7GeRg30S8aV5jjmjK8p86FTsyrH0e8oh20paj9qZjd4z/9BOdf4
         1xmGFyVJUsTKRhpKyWcoPzjH7/PAXAyvEZsGtTOe/0FOZw9Jg8q48ABtW7IzKW8D/l9+
         PA52TONGw69F07yZtKUPqsrvDThlUf35p101bTW9Mpm7BUVthszwfQDtYwvlUO+2BoH2
         GOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXfmoa48pksAbRzxcMosYfxWeQGUpphzeu8Yc2+dB6Y=;
        b=63RMI1InD86dFYl0TaiEVqu/+T7FqBuFsOPWSLfWjdbAYuEHobI9zz6OB3Z4MbUIDd
         RH1f0we6CNcHFzKD21FAuKzA9oDJZl7nivBo//OXXyUR9uHNNm7jfTYGuxEaAZK7qR4K
         ab76ONRSv4A9/Tgb62bghsxWX4l+64SCUB/QRQ+Wg0PKt8r7m5LvAVlC/1saQ3bjDNRj
         D1dacMMI8MBWUcZuZCzDbBRAaDjqC6oVAKUgzvTxKcTbjgLwQa3uYBtGSAU+7CNTn5ja
         WlabP8sd1oVQylXxwZzvj/ogLA68pXxRZGgtqbcwPCnihUFjefS/+48f48qMYUFc2P+b
         30tA==
X-Gm-Message-State: AOAM533zwlAc98Pc9hW17lZuN2ACTpBKCVqJuls8iEUtfWM1KKvjqkq2
	n1/MtB/GH+4ASJPBABr3mdMxItmifEIU/oVdpUw=
X-Google-Smtp-Source: ABdhPJzez+tXPo5pJpMtKPrhg712l32Rns5jY5lqZBPsYBqdu903ZDYulBiQ3GXoYClB6isKndYo8IQnh8EMyrxtl40=
X-Received: by 2002:a05:6830:1bf6:b0:5af:155e:af2f with SMTP id
 k22-20020a0568301bf600b005af155eaf2fmr22931050otb.207.1646407360609; Fri, 04
 Mar 2022 07:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
 <20220304091104.g5lbeu55z4oubyej@beryllium.lan> <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
In-Reply-To: <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 4 Mar 2022 09:22:29 -0600
Message-ID: <CAG17S_N34PXuAdcpMRKhNXo4Cmz89f8JaJa__GFEXrxO+FgsgQ@mail.gmail.com>
Subject: Re: request for feature
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Made those 2 edits, built a package and will test it tonight.

Thanks!

Keith
On Fri, Mar 4, 2022 at 3:13 AM Daniel Wagner <wagi@monom.org> wrote:
>
> On Fri, Mar 04, 2022 at 10:11:07AM +0100, Daniel Wagner wrote:
> >  static int cm_device_scan(struct connman_device *device,
> >                               struct connman_device_scan_params *params)
> >  {
> >       struct iwd_device *iwdd = connman_device_get_data(device);
> > -     struct iwd_station *iwds;
> >
> > -     if (strcmp(iwdd->mode, "station"))
> > -             return -EINVAL;
> > +     if (strcmp(iwdd->mode, "station")) {
>
> obviously !strcmp()
>
> > +             struct iwd_station *iwds;
> >
> > -     iwds = g_hash_table_lookup(stations, iwdd->path);
> > -     if (!iwds)
> > -             return -EIO;
> > +             iwds =  g_hash_table_lookup(stations, iwdd->path);
> > +             if (!iwds)
> > +                     return -EIO;
> >
> > -     if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
> > -                     NULL, cm_device_scan_cb, g_strdup(iwds->path), g_free))
> > -             return -EIO;
> > +             if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
> > +                             NULL, cm_device_scan_station_cb,
> > +                             g_strdup(iwds->path), g_free))
> > +                     return -EIO;
> > +     } else if (strcmp(iwdd->mode, "AP")) {
>
> and here too
>
> > +             struct iwd_ap *iwdap;
> > +
> > +             iwdap = g_hash_table_lookup(access_points, iwdd->path);
> > +             if (!iwdap)
> > +                     return -EIO;
> > +
> > +             if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
> > +                             NULL, cm_device_scan_ap_cb,
> > +                             g_strdup(iwdap->path), g_free))
> > +                     return -EIO;
> > +     } else {
> > +             return -EINVAL;
> > +     }
> >
> >       return -EINPROGRESS;
> >  }
