Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83A2CA8
	for <connman@lists.linux.dev>; Tue, 26 Oct 2021 07:09:17 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id t184so13441457pfd.0
        for <connman@lists.linux.dev>; Tue, 26 Oct 2021 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wU5PCiRzh/SvZmE3h0OjFmioE6JZDAxvLEiM+tIjZLc=;
        b=EVO3MH0tUhP5JgpsOFvjmVPBYswL3RM/Cg+vZOSPZARRVgohKkrwXgJUzwk9+5zq6S
         LEF1SD39DqgekIXin3h349jz4YmhIKuu7osZM7iAgrg2+RpEScEo/1/8WtCXei7KgSd5
         eG1Bo+DtrqJliV2p9w980TaXbpHQ5MMGtHz5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wU5PCiRzh/SvZmE3h0OjFmioE6JZDAxvLEiM+tIjZLc=;
        b=HlNlb0Xgmvc/vEKAe3Qnb/Qq9Vu7CmA0T+ySbEkvWeU7dB5ua/O+V5sBAssBMOZ/bG
         MoPcC0US1oHQEkF8vQFpca1bDnll7gIjtDHQyVlaAer6MvBVYKbIykR6kebxMNbQUhh8
         A6RrIEkynhP8MNTEO8he/Onhe3trfRu+O+UZSj7tmoo2ZylPZMsreccw4BRUvSpi3tof
         +8p/voXCs5CsCXrfKsiBgvxsRxVcgQEHTTC+M16D2uT1NQ2oYyGM7fxORm7hi47P15Go
         NaADIKa+5kw4ZFQ89rOOm1tN99TlYm6isZUzOleEYdcKWYYgygxsZ3Sep6DsPpdyzrcp
         xNaQ==
X-Gm-Message-State: AOAM533rlKi3LSMnnS/syxwYoNRQnkeTtf8Sy0LQyjCGwVWPY8zjkS7j
	iKE06rkxxIdnx+Nu04iNIm8CgiO1uJVnyz+uLM4TLA==
X-Google-Smtp-Source: ABdhPJzwfh4Udf2VOiYNENc5JyF4YhrvZI3D9P3YxMXB/rd2k3cLuaHeDhCj3qlxgoocrSLz8YEC40q3Mk/J6o7hIf8=
X-Received: by 2002:a63:7405:: with SMTP id p5mr17564722pgc.426.1635232157184;
 Tue, 26 Oct 2021 00:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211025132643.4485-1-michael@amarulasolutions.com> <20211026070413.fv5bbuwpch3qelab@beryllium.lan>
In-Reply-To: <20211026070413.fv5bbuwpch3qelab@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 26 Oct 2021 09:09:06 +0200
Message-ID: <CAOf5uwk-7TNhtfqUY-7Pb_w1id3yq5=jyJdv0Gf9OE46Zp+DAg@mail.gmail.com>
Subject: Re: [PATCH] Add GetKnownServices api to connaman
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Oct 26, 2021 at 9:04 AM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Michael,
>
> On Mon, Oct 25, 2021 at 01:26:43PM +0000, Michael Trimarchi wrote:
> > Add a way to retrieve all the networks that were configured
> > using connman and not all the ones visible
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> We don't do the SoB in this project.
>
> > +void __connman_known_service_list_struct(DBusMessageIter *iter)
> > +{
> > +     gchar **services = NULL;
> > +     gchar **service_id_parts = NULL;
> > +     guint i = 0;
> > +     struct connman_service *service = NULL;
>
> All pre-initialization are not needed.

Right

>
> > +
> > +     DBG("listing known services");
>
> Please remove the DBG(). We have way to many these kind of tracing DBGs
> in the code which fill the log pretty unnecessary.
>

Ok

> > +
> > +     services = connman_storage_get_services();
> > +     if (services == NULL)
>
>         if (!service)
>
> > +             return;
> > +
> > +     for (i = 0; i < g_strv_length(services); i++) {
> > +             service = connman_service_create();
> > +             if (service == NULL) {
>
>         if (!service)

Ok

>
> > +                     connman_error("connman_service_create() allocation failed");
> > +                     return;
> > +             }
> > +
> > +             service->identifier = g_strdup(services[i]);
> > +             service_id_parts = g_strsplit(services[i], "_", -1);
> > +
> > +             if (service_id_parts == NULL) {
> > +                     g_free(service);
> > +                     continue;
> > +             }
>
> IIRC, this check will always be false, as g_strsplit() will return a
> valid array or call abort() if allocation fails.
>

I don't want an abort to be called, I will adjust it.

> > +
> > +             service->type = __connman_service_string2type(service_id_parts[0]);
> > +             service->path = g_strdup_printf("%s/service/%s", CONNMAN_PATH, service->identifier);
>
> Do we really have to do this kind of path/identifier string generation
> here. Prefixing the path I understand but for the rest I thought we had
> do this in config.c/storage.c.

Ok, I will take a look

>
> > +             if (service->type == CONNMAN_SERVICE_TYPE_WIFI)
> > +             service->security = __connman_service_string2security(service_id_parts[g_strv_length(service_id_parts) - 1]);
> > +
>
> This looks a bit wierd formatted. Maybe introduce a local variable for
> the (...) bit and get it correctly indented.

Ok

>
> > +             if (service->path == NULL) {
> > +                     g_strfreev(service_id_parts);
> > +                     continue;
> > +             }
>
> Same here, g_strdup_printf() will either succeed or call abort() in the
> ENOMEM case.

Ok

I will adjust the rest. I have the patch to remove entries already
tested and prepared. That one
will be an RFC because I have too much open questions

Michael

>
> > +
> > +             if (find_service(service->path) != NULL)
>
> Just do a
>
>         if (find_service())
>
> > +                     service->state = (find_service(service->path))->state;
> > +
> > +             if (service->type == CONNMAN_SERVICE_TYPE_ETHERNET &&
> > +                 find_service(service->path) != NULL)
>
> same here
>
> > +                     service->name = (find_service(service->path))->name;
> > +
> > +             if (0 != service_load(service)) {
>
> Please the other way around, we don't do Misra or whatever standard this
> recommends.
>
> > +                     connman_error("service_load() returned error");
> > +                     g_free(service);
> > +                     g_strfreev(service_id_parts);
> > +                     g_strfreev(services);
> > +                     return;
> > +             }
> > +
> > +             append_struct_service(iter, append_dict_properties, service);
> > +             g_strfreev(service_id_parts);
> > +             g_free(service);
> > +     }
> > +
> > +     g_strfreev(services);
> > +}
> > +
> >  void __connman_service_list_struct(DBusMessageIter *iter)
> >  {
> >       g_list_foreach(service_list, append_struct, iter);
> > diff --git a/tools/manager-api.c b/tools/manager-api.c
> > index e082962d..99035988 100644
> > --- a/tools/manager-api.c
> > +++ b/tools/manager-api.c
> > @@ -64,6 +64,39 @@ static DBusMessage *set_property(DBusConnection *connection,
> >       return reply;
> >  }
> >
> > +DBusMessage *manager_get_known_services(DBusConnection *connection)
> > +{
> > +     DBusMessage *message, *reply;
> > +     DBusError error;
> > +
> > +     message = dbus_message_new_method_call(CONNMAN_SERVICE,
> > +                                CONNMAN_MANAGER_PATH,
> > +                                CONNMAN_MANAGER_INTERFACE,
> > +                                "GetKnownServices");
> > +
> > +     if (!message)
> > +             return NULL;
> > +
> > +     dbus_error_init(&error);
> > +
> > +     reply = dbus_connection_send_with_reply_and_block(connection,
> > +                               message, -1, &error);
> > +     if (!reply) {
> > +             if (dbus_error_is_set(&error)) {
> > +                     LOG("%s", error.message);
> > +                     dbus_error_free(&error);
> > +             } else {
> > +                     LOG("Failed to get known services");
> > +             }
>
> Drop these LOG() entries.
>
> > +             dbus_message_unref(message);
> > +             return NULL;
> > +     }
> > +
> > +     dbus_message_unref(message);
> > +
> > +     return reply;
> > +}
> > +
>
> Please also update the documentation.
>
> Thanks,
> Daniel



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
