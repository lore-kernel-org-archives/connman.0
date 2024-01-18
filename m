Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA32E3F8
	for <connman@lists.linux.dev>; Thu, 18 Jan 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604176; cv=none; b=kL5/qNhXwCR3N0u2Cw4tO2+Zx7AMVTnd6/79scs+ZSMYhQ+41ae+Cgi7XvdX7ssmBhUfng+Agcim3zeRD1dGpvldswdDg6pQ//6QwBbcfj0l2iFUX0Bno04/4xfDm8aJMjacv97QYHWM3SC+jBX04Bjc2d5Sxr0dQ2sJ447ACk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604176; c=relaxed/simple;
	bh=7Gygx62y0ZLIoN6RmZg+TZt3sIyAonrMjwlmrf3epGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uxUBIdck7VavkxIhluFJ9UeHUF0MRn2QcnqMz4PkgOBQO4HSwz5dWJhPW+LmRhS73a2aArWWhIakHt/ZnmvGPF73SAkpKD/jWilLu62jq3GTz/5cb665z9wwFRAk/Q7OSquArulZcE5XqDsDD07DjMta7CT+bf9zhFlJOkDzpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ+Q0dzx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ+Q0dzx"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9bec20980so15084b3a.2
        for <connman@lists.linux.dev>; Thu, 18 Jan 2024 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705604174; x=1706208974; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjTbWF5t+kBS3KEHu4RUruuAUuVeX9u6VNKjTrSAU8s=;
        b=IZ+Q0dzxBBk0YyDbTZcFAuDZnNcDrbVI1jssXTmPXuwYfBFWKhHP0mJhPo7TRMKVW6
         /t7Cze/ixb9vP8TMHfMpcFpmQKfNgtCZ/k3u6A65qn4Rqnzg39wD7ZMcbZyWPAudPf8g
         klwNyqYZH2L0ggvo2Zi9EskGrgeBtAcnB4dWIUiZL91N1o5/mnNzCHgXEQAjt1sph2t8
         cQFT6qXQ2KbNB4K3fbllxNcq5827dKOLqrxxvP9R3bDTIWWjdBQ6VJhE35S1dpk/pHaj
         4+pY2B9Wrw2d59l5ff2yVRrtD0HDWMAgGmyBxufRrksgyOzmCHktujCMjiT9kU9LnARM
         aPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705604174; x=1706208974;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjTbWF5t+kBS3KEHu4RUruuAUuVeX9u6VNKjTrSAU8s=;
        b=Yphd9Ikqbr9iW5KwTrCtcZn/1r19Tpb4AoK7ImVVKVjTDDfQ5GSGNrGBQ5GE5jQx3i
         t604csnXtMXe1w7IUyF2LSSuDTdjhaIlhY4eOny2kxxHfrHfPSWOgyMwMOG/ga0gYvni
         NaUJQhOXSoTT7UGDj7RuZimY8VxhXjjFM88+t/PMpKN0reqa/7xthuCCJsvl1b01niBR
         DMHmMYmmT5VzNt1rWKjSQWGGr2apJ2xjIPHYQxS/q/oQ6L5jOCTtEB7OzFlbQOX4a4Gi
         ZxUl83L/fcklL2y8ZmvSq1CjVSn0P9wJqb8SbYBqSDnCfq6urxKa8kCJhLnxgOgrQwsc
         Lg/w==
X-Gm-Message-State: AOJu0Yw88Q6GmKRG6ccnkmooKIhlKZxYne0xsACiTkKq9ZY93SW3tSIt
	bj05QQagqfx2FcBcvxzsk6zCFRBh9RziFij8/Pp6NVnpsboS8iVOPOeekD8yGHGiJvWosFKNdzr
	v0/a7IzGfE33uudYCKCBTQ3sVD528AR6Q
X-Google-Smtp-Source: AGHT+IGIWYFD5AT8hLZbBK76LD+iUjEK5QEdzrzT/rfMeVBl/EaSdoZxYO2gT1UkCDzGwcCw9W79iPMXxK8IeXX/aVU=
X-Received: by 2002:a05:6a00:3992:b0:6d9:bf50:1c71 with SMTP id
 fi18-20020a056a00399200b006d9bf501c71mr1236252pfb.48.1705604173984; Thu, 18
 Jan 2024 10:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_MPuJ9ehB-3Ki0MKhbyz4VRM=u_VQRzem4N4mq4mEsJVg@mail.gmail.com>
In-Reply-To: <CAG17S_MPuJ9ehB-3Ki0MKhbyz4VRM=u_VQRzem4N4mq4mEsJVg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 18 Jan 2024 12:56:03 -0600
Message-ID: <CAG17S_PGfwy6T36gBUNBUnQfd4ObR8fkLXwj7WJP-H3LG3_2DQ@mail.gmail.com>
Subject: Re: Request for help integrating iwd ap mode scan
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard this request. The dbus messages are substantially
different. Implementation would be a headache and it is definitely a
corner case. In the end I figured out a better way.

Keith

On Fri, Dec 22, 2023 at 4:07=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> I am back on the project. I feel it would be a great add to connman.
> What it is: Feature to allow connman to scan for ssids while iwd is in ap=
 mode
> Background: I know connman can tether and we have done that, but this
> has 2 issues. 1) it creates another interface called tether which is
> confusing to some users as we are using conman in a headless audio
> player 2) tether will not allow us to set a preferred IP address.
>
> The iwd team added this functionality a while back where if iwd is in
> ap mode, it can still scan for networks. iwd allows us to set the wlan
> adapter into ap mode with a preferred IP and keeps the same adapter
> listed (wlan0 in our case). I would love to see connman be able to do
> this as well. With this functionality, we could use iwd/connman for
> 'wireless setup' of our audio player. We are currently using hostapd
> and it is balky, disconnects and is slow.
>
> Daniel Wagner created this patch to iwd.c back in January 2023 which I
> incorporated and built into a current (git from head, source built)
> connman package. The resulting binary works fine in station mode with
> iwd, but it still will not allow 'connmanctl scan wifi' when iwd is in
> ap mode though iwd can do it.
>
> When iwd is in ap mode, if you issue a command 'iwctl ap wlan0 scan'
> then 'iwctl ap wlan0 get-networks' it returns the available networks
> similarly as it does in station mode.
>
> if iwd is in ap mode and 'connmanctl scan wifi' is sent, connman takes
> a long time and finally returns. The log of the iwd plugin when I did
> this is:
>
> https://pastebin.com/AHq2XkUs
>
> The patch from Daniel Wagner is here:
> ---
>
> Only compile tested :)
>
>  plugins/iwd.c | 54 ++++++++++++++++++++++++++++++
> ++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index 2fe49a23316b..491a0e41da89 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -633,15 +633,28 @@ static void cm_device_scan_cb(DBusMessage
> *message, void *user_data)
>         }
>  }
>
> -static int cm_device_scan(struct connman_device *device,
> -                               struct connman_device_scan_params *params=
)
> +static void cm_ap_scan_cb(DBusMessage *message, void *user_data)
> +{
> +       const char *path =3D user_data;
> +       struct iwd_ap *iwdap;
> +
> +       iwdap =3D g_hash_table_lookup(access_points, path);
> +       if (!iwdap)
> +               return;
> +
> +       if (dbus_message_get_type(message) =3D=3D DBUS_MESSAGE_TYPE_ERROR=
) {
> +               const char *dbus_error =3D dbus_message_get_error_name(me=
ssage);
> +
> +               DBG("%s scan failed: %s", path, dbus_error);
> +       }
> +}
> +
> +static int cm_station_scan(struct connman_device *device,
> +                               struct connman_device_scan_params *param)
>  {
>         struct iwd_device *iwdd =3D connman_device_get_data(device);
>         struct iwd_station *iwds;
>
> -       if (strcmp(iwdd->mode, "station"))
> -               return -EINVAL;
> -
>         iwds =3D g_hash_table_lookup(stations, iwdd->path);
>         if (!iwds)
>                 return -EIO;
> @@ -653,6 +666,37 @@ static int cm_device_scan(struct connman_device *dev=
ice,
>         return -EINPROGRESS;
>  }
>
> +static int cm_ap_scan(struct connman_device *device,
> +                               struct connman_device_scan_params *param)
> +{
> +       struct iwd_device *iwdd =3D connman_device_get_data(device);
> +       struct iwd_ap *iwdap;
> +
> +       iwdap =3D g_hash_table_lookup(access_points, iwdd->path);
> +       if (!iwdap)
> +               return -EIO;
> +
> +       if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
> +                       NULL, cm_ap_scan_cb, g_strdup(iwdap->path), g_fre=
e))
> +               return -EIO;
> +
> +       return -EINPROGRESS;
> +}
> +
> +static int cm_device_scan(struct connman_device *device,
> +                               struct connman_device_scan_params *params=
)
> +{
> +       struct iwd_device *iwdd =3D connman_device_get_data(device);
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
>  static struct connman_device_driver device_driver =3D {
>         .name           =3D "iwd",
>         .type           =3D CONNMAN_DEVICE_TYPE_WIFI,
> --
> 2.39.0
