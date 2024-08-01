Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF615AF6
	for <connman@lists.linux.dev>; Thu,  1 Aug 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544014; cv=none; b=LMUKh2ZDS6XpqpVfdKSRpOh0VIX3OxBCqfEW7LeHDZK0Pq4FCBAXbrUmVCvHx7fnzDthMl6lbUMBfAKM1+Yj516tSQbkR8HQuHV3xgppX2R75tEeiFcjeR0kZQp590mH/NHCryN8FKNvTJTWyKx4DVItik2JffkqW90fQDz+av8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544014; c=relaxed/simple;
	bh=s5IU5YgD/OcmJUudZcu8HtRrvVGuw5XSkVRn3H/ImhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSxXllz9YQLCFiApMXNccxU+TuPj54LUz7kcPC+/DuK1NLTnzQuUukCVhjVhnsHZ9/q7CrO9eHKGvrXvukaqgE5LcwXilp0DHfRq1stXOzT89C8yipz/76VsWEhNKF0Y6NJULmgT1ZXB5gV1UuHRNRQUwZZ5dLdUw97yBBlG2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=T8SSxQ/E; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="T8SSxQ/E"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so22402456d6.1
        for <connman@lists.linux.dev>; Thu, 01 Aug 2024 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1722544009; x=1723148809; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubf/j1IfiIKUMe3LdhHFTRiNnuORnrhAjqPoWmW3gM0=;
        b=T8SSxQ/EOcH8nyIDEz1CrXockvBHKR54UrJFNy7GVBKc/7cd+10fT1lJGk9KjpUn8y
         InDyTw5eMG6DCmQGxSE0x7+gL785SBSArlCj0swTYLVCvrX0ZgpEC6BZ720SMSRBXQwA
         amwvxUSijQ6o+Tl8hsFXMkSS/ZtkCV7NRZ7LLkIDktZXqT1AljsCXkmAp2oFZCTkIpH6
         qocCVipXLEQnYR2GMq9/HQbWUSQOy3G9lKWquy0KD3zK9hazOhk2/VFJ8hukTT8QzgKD
         nFVcv01wJKax5+sEv+YeQVg4JDDhWTRiXD/1VZFU0qQ9EtyLIGjtEv4oxfvytm0Go13z
         /FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722544009; x=1723148809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubf/j1IfiIKUMe3LdhHFTRiNnuORnrhAjqPoWmW3gM0=;
        b=sf3iBKpLtCRCCBelua46MRktDUv7T54VvI9LDqL+enJ4rj8czYHhUsFChskaoN9l6v
         0zg5Uky4c+kdPj6JXrzOGivQNQsFWFk8gh4W+wBCm6/6I58D99tlCmImu7XOVjKyUZPG
         xzbhZtodGrEfVtmVGbyvBjjpHPxUfSbGiVduCaK40uKTlXtxqmnEjkRH5/Wr8A5PRg1A
         FCwZos6yrs1dpr520eHIbYjVPp+JDND6Av02wWNCizm3bnXMiw3JK+iKnIU6p/Umb4/d
         vUqLj4AYVo63CkdVtPMtu5jPqP0IY0kjM7IepkuFRwyNHtD/g7R5cKsBy415wl5P0qFp
         l7Yg==
X-Gm-Message-State: AOJu0Yw//VYjrEhB0riREObZhV1POUBV87eQ0ImmN5gQEXdc1NEcJgo8
	OxBOrTujBgLXZYzZTc0o75x4ujuTF/gy1Jh1j08apnUQlTPSYGKtCt2tkAEm5MwBhpMdEBNxLpJ
	VsOCjSAETCz8t5Ch2h/s6tzch2SihIu5jKmCCYQ==
X-Google-Smtp-Source: AGHT+IGMXBrPaRsLn7IAi5y2PNWSP3Ixdmu9P9vuPY7YjTMqdgA2ZqBwo54QXIEwwcdk5qveQI1yOsIxG+0/QHRbZ2g=
X-Received: by 2002:a05:6214:4412:b0:6b7:4398:5953 with SMTP id
 6a1803df08f44-6bb986be964mr18059776d6.7.1722544009241; Thu, 01 Aug 2024
 13:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705040204.58337-1-alex@shruggie.ro> <58c3866d-60f1-47ec-b4c0-89be1c4fd9be@gmail.com>
In-Reply-To: <58c3866d-60f1-47ec-b4c0-89be1c4fd9be@gmail.com>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Thu, 1 Aug 2024 23:26:38 +0300
Message-ID: <CAH3L5QqeipEWGzgDoS4L8Syd_DeMjObWpWGcMxL2J+Bqkg=L0w@mail.gmail.com>
Subject: Re: [PATCH v2] manager: add support for changing 'PreferredTechnologies'
 over DBus
To: Denis Kenzior <denkenz@gmail.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 11:22=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> =
wrote:
>
> Hi Alexandru,
>
> On 7/4/24 11:02 PM, Alexandru Ardelean wrote:
> > This change adds support for reading/modifying the 'PreferredTechnologi=
es'
> > over DBus.
> > This can be extended to 'DefaultAutoConnectTechnologies',
> > 'DefaultFavoriteTechnologies' & 'AlwaysConnectedTechnologies' as well.
> > However the interest (so far) was in changing the 'PreferredTechnologie=
s'
> > order (at runtime) between cellular and wifi.
> > Also, 'PreferredTechnologies' was the only that was tested.
> >
> > Changing 'PreferredTechnologies' seems to yield the desired result, as =
the
> > switch between cellular/wifi does not need to be super-fast.
> > And it changes the routing table (as desired) when cellular is preferre=
d
> > over WiFi (and vice-versa).
> >
>
> Can you elaborate?  If setting the property doesn't trigger service re-or=
dering
> immediately, how does it happen?

Hello,

Apologies for the slow reply.
I got wrapped up in tons of work.

For the context (in which this was being run), just setting the
properties would be sufficient.
There would be various triggering/re-retriggering of services such
that cellular would be preferred over WiFi (and vice-versa).
(This is valid in our case).

In the meantime (since doing this patch), I also found (in the main
branch) the support for secondary gateways, which is actually what
we'd want.
In connman (up to 1.42), if a ppp0 interface would come up, it would
setup an interface (default) route, which would not allow something
like "ping -I wlan0 8.8.8.8"
We've been a implementing a "ping -I ppp0" & "ping -I wlan0" type of
logic, to be able to change the primary route (in this case via
PreferredTechnologies) in case WiFi is connected, but not able to
reach a certain address (via ping).

The secondary gateway stuff, makes this patch not-needed.
It's only for connman 1.42 (or older) that this is needed (to be order
to prioritize WiFi over GSM/LTE and vice-versa).

Thank you :)
And apologies for the noise
Alex

>
> > On some boxes that have both cellular & WiFi, it's often desired to pre=
fer
> > cellular (over WiFi) in case WiFi is not able to connect to the interne=
t.
> > The logic (for this switching) can be determined outside of connman.
> > Setting 'PreferredTechnologies' helps in this case.
> > ---
> >
> > Changelog v1 -> v2:
> > * v1: https://lore.kernel.org/connman/20240704204732.56553-1-alex@shrug=
gie.ro/
> > * removed 'tools/ip6tables-test'
> >    * added to .gitignore via https://lore.kernel.org/connman/2024070503=
5028.57697-1-alex@shruggie.ro/T/#u
> > * added a bit of documentation in 'src/main.conf' for the 'PreferredTec=
hnologies'
> >    property now also being accessible over DBus
> >
> >   doc/connman.conf.5.in |  2 ++
> >   doc/manager-api.txt   | 13 +++++++++
> >   include/setting.h     |  2 ++
> >   src/main.c            | 22 ++++++++++++++
> >   src/main.conf         |  4 +++
> >   src/manager.c         | 67 ++++++++++++++++++++++++++++++++++++++++++=
+
> >   6 files changed, 110 insertions(+)
> >
>
> <snip>
>
> > diff --git a/doc/manager-api.txt b/doc/manager-api.txt
> > index 6eaa0a38..3be9cffc 100644
> > --- a/doc/manager-api.txt
> > +++ b/doc/manager-api.txt
> > @@ -319,3 +319,16 @@ Properties       string State [readonly]
> >                       and does not affect ConnMan in any way.
> >
> >                       The default value is false.
> > +
> > +             array{string} PreferredTechnologies [readwrite] [expermin=
ental]
>
> Typo 'experminental'
>
> > +
> > +                     This property is the same one that is defined in
> > +                     /etc/connman/main.conf. It controls the order of
> > +                     preferred technologies (e.g. wifi, cellular) at
> > +                     runtime.
> > +                     Changing it here will not have an immediate effec=
t.
> > +                     It's only when connman gets triggered via service=
 changes
> > +                     that this gets taken into consideration. Or, when=
 it's
> > +                     triggered via manual connect/disconnect of servic=
es.
> > +
> > +                     The default value is defined in /etc/connman/main=
.conf.
>
> Have you considered looking into how the Online check is implemented?  Pe=
rhaps
> if the interface is not Online, it should not be prioritized ahead of one=
 that is?
>
> > diff --git a/src/main.c b/src/main.c
> > index f5da979b..7858b967 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -1122,6 +1122,28 @@ unsigned int *connman_setting_get_uint_list(cons=
t char *key)
> >       return NULL;
> >   }
> >
> > +int connman_setting_set_uint_list(const char *key, const unsigned int =
*lst,
> > +                               int len)
> > +{
> > +     unsigned int *new_list;
> > +
> > +     new_list =3D g_try_new0(unsigned int, len + 1);
>
> General advice is that for small allocations g_try_new0 is not necessary.
>
> > +     if (!new_list)
> > +             return -1;
> > +
> > +     memcpy(new_list, lst, sizeof(unsigned int) * len);
> > +
> > +     if (g_str_equal(key, CONF_PREFERRED_TECHS)) {
> > +             g_free(connman_settings.preferred_techs);
> > +             connman_settings.preferred_techs =3D new_list;
> > +             return 0;
> > +     }
> > +
> > +     g_free(new_list);
> > +
> > +     return -1;
> > +}
> > +
> >   unsigned int connman_timeout_input_request(void)
> >   {
> >       return connman_settings.timeout_inputreq;
>
> <snip>
>
> > diff --git a/src/manager.c b/src/manager.c
> > index 892d3a42..62f34c50 100644
> > --- a/src/manager.c
> > +++ b/src/manager.c
> > @@ -34,6 +34,27 @@
> >   static bool connman_state_idle;
> >   static dbus_bool_t sessionmode;
> >
> > +static const char *tech_property_names[] =3D {
> > +     "PreferredTechnologies",
> > +     NULL,
> > +};
>
> How would this be extended in the future?
>
>
> <snip>
>
> > @@ -64,6 +86,13 @@ static DBusMessage *get_properties(DBusConnection *c=
onn,
> >                                       DBUS_TYPE_BOOLEAN,
> >                                       &sessionmode);
> >
> > +     for (i =3D 0; tech_property_names[i]; i++) {
> > +             const char *name =3D tech_property_names[i];
> > +             unsigned int *lst =3D connman_setting_get_uint_list(name)=
;
> > +             connman_dbus_dict_append_array(&dict, name, DBUS_TYPE_STR=
ING,
> > +                                             append_tech_list, lst);
>
> This logic seems pretty specific to PreferredTechnologies?
>
> > +     }
> > +
> >       connman_dbus_dict_close(&array, &dict);
> >
> >       return reply;
> > @@ -110,6 +139,44 @@ static DBusMessage *set_property(DBusConnection *c=
onn,
> >
> >               dbus_message_iter_get_basic(&value, &sessionmode);
> >
> > +     } else if (g_str_equal(name, "PreferredTechnologies")) {
> > +             unsigned int techs[MAX_CONNMAN_SERVICE_TYPES] =3D {};
> > +             DBusMessageIter entry;
> > +             int cnt;
> > +
> > +             if (type !=3D DBUS_TYPE_ARRAY)
> > +                     return __connman_error_invalid_arguments(msg);
> > +
> > +             dbus_message_iter_recurse(&value, &entry);
> > +
> > +             cnt =3D 0;
> > +             while (dbus_message_iter_get_arg_type(&entry) =3D=3D DBUS=
_TYPE_STRING) {
> > +                     enum connman_service_type type;
> > +                     const char *val;
> > +                     dbus_message_iter_get_basic(&entry, &val);
> > +                     dbus_message_iter_next(&entry);
> > +                     int i;
> > +
> > +                     if (!val[0])
> > +                             continue;
> > +
> > +                     type =3D __connman_service_string2type(val);
> > +                     if (type =3D=3D CONNMAN_SERVICE_TYPE_UNKNOWN)
> > +                             return __connman_error_invalid_arguments(=
msg);
> > +
> > +                     if (cnt >=3D MAX_CONNMAN_SERVICE_TYPES)
> > +                             return __connman_error_invalid_arguments(=
msg);
> > +
> > +                     /* check for duplicates */
> > +                     for (i =3D 0; i < cnt; i++) {
> > +                             if (type =3D=3D techs[i])
> > +                                     return __connman_error_invalid_ar=
guments(msg);
> > +                     }
>
> There's a few lines > 80 chars.  Have you run this through checkpatch?
>
> > +
> > +                     techs[cnt++] =3D type;
> > +             }
> > +
> > +             connman_setting_set_uint_list(name, techs, cnt);
> >       } else
> >               return __connman_error_invalid_property(msg);
> >
>
> Regards,
> -Denis
