Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3B2C9F
	for <connman@lists.linux.dev>; Wed, 27 Oct 2021 17:25:45 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id 127so3388524pfu.1
        for <connman@lists.linux.dev>; Wed, 27 Oct 2021 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfD2k6e7/JTHOvP1wvT2RbTI1fdY4L/C6rqcXa9SaC0=;
        b=X/BVUlDQ3PXngtixCMWG2Hwq9O3ijWmbWhQcXKqJFeFnCvo1oydUHFtbd8H2ayjkI5
         vAHZChQ1bPXIGKSHKFaTVf9NO7qmIAO/qt7G5jQtrFxnDeUOCo0Q7QZRLZ5atTXXe6tg
         F7HA3vtkh4Az7adbCCN9d6NKb+FqgIafL/7dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfD2k6e7/JTHOvP1wvT2RbTI1fdY4L/C6rqcXa9SaC0=;
        b=P1UnE+ykgPjLo/tmQQ0wLPlKdIwotbJNCCY18YyvN/9RXUsh6tKD6urLRf5Pje4a/9
         3or4ATFn8xEoYtv2Yum5yCEt6Hci+piugle+YkcgrHCj/PkdQhiH9Uvm/dZ0D3FTTsqw
         yQ1qkoPvMw+1gInjBVUgcYMlDx3V6fWfwrFRoWI4+Rt+FS3D0hfoCDP1Tmly3iOERt0l
         UJMDjkGLL4QlbOyUABlO5ne7/Ouu7VzC1mJ87SkRvRVbzKTR7h0vR6+0ydiUWkniBlji
         4ldWnm3I8pGUM106sC/y4vpt0OWtSL6W4e8tHf6rN4Jzua+kp/4wxzBDkIKGqrIlwE/B
         20Vw==
X-Gm-Message-State: AOAM533MXOC8IhqJKNC2JHl0j6IaXh/8/3Qr/5tULLN0CHm1svVXiKi9
	0j0kYlno5XHSL7kFO0YNB6RbY02A+XofzopD6cTzV4J4kz+33Q==
X-Google-Smtp-Source: ABdhPJyIJcYtJmOXS/FsfwY1He6XKEdz4uSTlRK80ihKGleylP1nA6CsYqYnZos5jZOVSpIg+kyT9/ksp/DHar5jW88=
X-Received: by 2002:a63:7405:: with SMTP id p5mr24970407pgc.426.1635355544582;
 Wed, 27 Oct 2021 10:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211027140141.9267-1-michael@amarulasolutions.com>
In-Reply-To: <20211027140141.9267-1-michael@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 27 Oct 2021 17:25:32 +0000
Message-ID: <CAOf5uwmcmkUNO0P3mZOC94bWRpodqLeJ4kmBTSu2N0j9xw_WQQ@mail.gmail.com>
Subject: Re: [PATCH V2] Add GetKnownServices api to connaman
To: connman@lists.linux.dev, Daniel Wagner <wagi@monom.org>
Cc: Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

I even have the patch to remove known-networks. I have few question:

- what should be the behavior for an ethernet on?
- for wifi, it's removed and if you are connected it's disconnected is
that correct?

Apart of that:

I'm working on a patch that allow to store network configuration using
the config storage
but I have few questions:

- I have added autoconnect as a configuration option. I would like to
store networks but not have them
in auto connect mode. This should allow me to connect when they are
visible. (ethernet??)
- I have add an option to store if I want it immutable or not. The
stored configuration should be applied
if it's valid but I would like to connect using a different way from
connect call

--- a/src/config.c
+++ b/src/config.c
@@ -61,6 +61,8 @@ struct connman_config_service {
        GSList *service_identifiers;
        char *config_ident; /* file prefix */
        char *config_entry; /* entry name */
+       bool autoconnect;
+       bool immutable;
        bool hidden;
        bool virtual;
        char *virtual_file;
@@ -115,6 +117,8 @@ static bool cleanup = false;
 #define SERVICE_KEY_SECURITY           "Security"
 #define SERVICE_KEY_HIDDEN             "Hidden"
 #define SERVICE_KEY_MDNS               "mDNS"
+#define SERVICE_KEY_AUTOCONNECT        "Autoconnect"
+#define SERVICE_KEY_IMMUTABLE          "Immutable"

 #define SERVICE_KEY_IPv4               "IPv4"
 #define SERVICE_KEY_IPv6               "IPv6"
@@ -162,6 +166,8 @@ static const char *service_possible_keys[] = {
        SERVICE_KEY_SEARCH_DOMAINS,
        SERVICE_KEY_TIMESERVERS,
        SERVICE_KEY_DOMAIN,
+       SERVICE_KEY_AUTOCONNECT,
+       SERVICE_KEY_IMMUTABLE,
        NULL,
 };

@@ -229,7 +235,7 @@ static void unregister_service(gpointer data)
                        }
                }

-               if (!__connman_storage_remove_service(service_id))
+               if (config_service->autoconnect &&
!__connman_storage_remove_service(service_id))
                        DBG("Could not remove all files for service %s",
                                                                service_id);
        }
@@ -599,6 +605,12 @@ static bool load_service(GKeyFile *keyfile, const
char *group,
                return true;
        }

+       service->autoconnect = __connman_config_get_bool(keyfile, group,
+                                               SERVICE_KEY_AUTOCONNECT, NULL);
+
+       service->immutable = __connman_config_get_bool(keyfile, group,
+                                               SERVICE_KEY_IMMUTABLE, NULL);
+
        str = __connman_config_get_string(keyfile, group,
SERVICE_KEY_NAME, NULL);
        if (str) {
                g_free(service->name);
@@ -1180,6 +1192,8 @@ static void provision_service_wifi(struct
connman_config_service *config,

        if (config->hidden)
                __connman_service_set_hidden(service);
+
+       __connman_service_set_auto_connect(service, config->autoconnect);

Michael

On Wed, Oct 27, 2021 at 2:01 PM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Add a way to retrieve all the networks that were configured
> using connman and not all the ones visible
>
> ---
> Changes V1->V2:
>         - remove SoB
>         - Add documentation
>         - remove LOG print
>         - Avoid check null on functions that assert
>         - adjust the function the look for service
>         - clean up a bit variable name
>         - remove initialization of variables that are not needed
> ---
>  client/commands.c    | 14 +++++++++++
>  doc/manager-api.txt  | 12 ++++++++++
>  src/connman.h        |  1 +
>  src/manager.c        | 23 ++++++++++++++++++
>  src/service.c        | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  tools/manager-api.c  | 30 ++++++++++++++++++++++++
>  tools/session-test.h |  1 +
>  7 files changed, 136 insertions(+)
>
> diff --git a/client/commands.c b/client/commands.c
> index 53cc14c8..f4366e8c 100644
> --- a/client/commands.c
> +++ b/client/commands.c
> @@ -420,6 +420,18 @@ static int cmd_services(char *args[], int num, struct connman_option *options)
>                         object_properties, path, NULL, NULL);
>  }
>
> +static int cmd_known_services(char *args[], int num, struct connman_option *options)
> +{
> +       if (num > 1)
> +               return -E2BIG;
> +
> +       return __connmanctl_dbus_method_call(connection,
> +                        CONNMAN_SERVICE, CONNMAN_PATH,
> +                        "net.connman.Manager",
> +                        "GetKnownServices",
> +                        services_list, NULL, NULL, NULL);
> +}
> +
>  static int cmd_peers(char *args[], int num, struct connman_option *options)
>  {
>         char *peer_name = NULL;
> @@ -2808,6 +2820,8 @@ static const struct {
>           "Display tethering clients", NULL },
>         { "services",     "[<service>]",  service_options, cmd_services,
>           "Display services", lookup_service_arg },
> +       { "known-services", NULL,  NULL, cmd_known_services,
> +         "Display known services", NULL },
>         { "peers",        "[peer]",       NULL,            cmd_peers,
>           "Display peers", lookup_peer_arg },
>         { "scan",         "<technology>", NULL,            cmd_scan,
> diff --git a/doc/manager-api.txt b/doc/manager-api.txt
> index 6eaa0a38..093b25c1 100644
> --- a/doc/manager-api.txt
> +++ b/doc/manager-api.txt
> @@ -39,6 +39,18 @@ Methods              dict GetProperties()
>
>                         Possible Errors: [service].Error.InvalidArguments
>
> +               array{object,dict} GetKnownServices()
> +
> +                       Returns a sorted list of tuples with service
> +                       object path and dictionary of service propertiesa
> +                       Those are all the services including the one that
> +                       are registered but not visible or not in use.
> +
> +                       This list will not contain sensitive information
> +                       like passphrases etc.
> +
> +                       Possible Errors: [service].Error.InvalidArguments
> +
>                 array{object,dict} GetPeers() [experimental]
>
>                         Returns a sorted list of tuples with peer object path
> diff --git a/src/connman.h b/src/connman.h
> index 68176086..cdc88532 100644
> --- a/src/connman.h
> +++ b/src/connman.h
> @@ -682,6 +682,7 @@ int __connman_service_move(struct connman_service *service,
>                                 struct connman_service *target, bool before);
>  int __connman_service_load_modifiable(struct connman_service *service);
>
> +void __connman_known_service_list_struct(DBusMessageIter *iter);
>  void __connman_service_list_struct(DBusMessageIter *iter);
>
>  int __connman_service_compare(const struct connman_service *a,
> diff --git a/src/manager.c b/src/manager.c
> index 892d3a42..b196109a 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -175,6 +175,11 @@ static const struct connman_notifier technology_notifier = {
>         .idle_state     = idle_state,
>  };
>
> +static void append_known_service_structs(DBusMessageIter *iter, void *user_data)
> +{
> +       __connman_known_service_list_struct(iter);
> +}
> +
>  static void append_service_structs(DBusMessageIter *iter, void *user_data)
>  {
>         __connman_service_list_struct(iter);
> @@ -195,6 +200,21 @@ static DBusMessage *get_services(DBusConnection *conn,
>         return reply;
>  }
>
> +static DBusMessage *get_known_services(DBusConnection *conn,
> +                                  DBusMessage *msg, void *data)
> +{
> +       DBusMessage *reply;
> +
> +       reply = dbus_message_new_method_return(msg);
> +       if (!reply)
> +               return NULL;
> +
> +       __connman_dbus_append_objpath_dict_array(reply,
> +                                append_known_service_structs, NULL);
> +
> +       return reply;
> +}
> +
>  static void append_peer_structs(DBusMessageIter *iter, void *user_data)
>  {
>         __connman_peer_list_struct(iter);
> @@ -534,6 +554,9 @@ static const GDBusMethodTable manager_methods[] = {
>         { GDBUS_DEPRECATED_METHOD("RemoveProvider",
>                         GDBUS_ARGS({ "provider", "o" }), NULL,
>                         remove_provider) },
> +       { GDBUS_METHOD("GetKnownServices",
> +                       NULL, GDBUS_ARGS({"knownServices", "a(oa{sv})" }),
> +                       get_known_services) },
>         { GDBUS_METHOD("GetServices",
>                         NULL, GDBUS_ARGS({ "services", "a(oa{sv})" }),
>                         get_services) },
> diff --git a/src/service.c b/src/service.c
> index 8d3c75a5..da8304cc 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -2705,6 +2705,61 @@ static void append_struct(gpointer value, gpointer user_data)
>         append_struct_service(iter, append_dict_properties, service);
>  }
>
> +void __connman_known_service_list_struct(DBusMessageIter *iter)
> +{
> +       gchar **services;
> +       gchar **srv_id_parts;
> +       guint i;
> +       struct connman_service *service;
> +
> +       services = connman_storage_get_services();
> +       if (!services)
> +               return;
> +
> +       for (i = 0; i < g_strv_length(services); i++) {
> +               struct connman_service *srv;
> +
> +               service = connman_service_create();
> +               if (!service) {
> +                       connman_error("connman_service_create() allocation failed");
> +                       return;
> +               }
> +
> +               service->identifier = g_strdup(services[i]);
> +               srv_id_parts = g_strsplit(services[i], "_", -1);
> +               if (srv_id_parts == NULL) {
> +                       g_free(service);
> +                       continue;
> +               }
> +
> +               service->type = __connman_service_string2type(srv_id_parts[0]);
> +               service->path = g_strdup_printf("%s/%s", STORAGEDIR, service->identifier);
> +               if (service->type == CONNMAN_SERVICE_TYPE_WIFI)
> +                       service->security = __connman_service_string2security(srv_id_parts[g_strv_length(srv_id_parts) - 1]);
> +
> +               srv = find_service(service->path);
> +               if (srv)
> +                       service->state = srv->state;
> +
> +               if (service->type == CONNMAN_SERVICE_TYPE_ETHERNET && srv)
> +                       service->name = srv->name;
> +
> +               if (service_load(service)) {
> +                       connman_error("service_load() returned error");
> +                       g_free(service);
> +                       g_strfreev(srv_id_parts);
> +                       g_strfreev(services);
> +                       return;
> +               }
> +
> +               append_struct_service(iter, append_dict_properties, service);
> +               g_strfreev(srv_id_parts);
> +               g_free(service);
> +       }
> +
> +       g_strfreev(services);
> +}
> +
>  void __connman_service_list_struct(DBusMessageIter *iter)
>  {
>         g_list_foreach(service_list, append_struct, iter);
> diff --git a/tools/manager-api.c b/tools/manager-api.c
> index e082962d..8668ca9e 100644
> --- a/tools/manager-api.c
> +++ b/tools/manager-api.c
> @@ -64,6 +64,36 @@ static DBusMessage *set_property(DBusConnection *connection,
>         return reply;
>  }
>
> +DBusMessage *manager_get_known_services(DBusConnection *connection)
> +{
> +       DBusMessage *message, *reply;
> +       DBusError error;
> +
> +       message = dbus_message_new_method_call(CONNMAN_SERVICE,
> +                                  CONNMAN_MANAGER_PATH,
> +                                  CONNMAN_MANAGER_INTERFACE,
> +                                  "GetKnownServices");
> +
> +       if (!message)
> +               return NULL;
> +
> +       dbus_error_init(&error);
> +
> +       reply = dbus_connection_send_with_reply_and_block(connection,
> +                                 message, -1, &error);
> +       if (!reply) {
> +               if (dbus_error_is_set(&error))
> +                       dbus_error_free(&error);
> +
> +               dbus_message_unref(message);
> +               return NULL;
> +       }
> +
> +       dbus_message_unref(message);
> +
> +       return reply;
> +}
> +
>  DBusMessage *manager_get_services(DBusConnection *connection)
>  {
>         DBusMessage *message, *reply;
> diff --git a/tools/session-test.h b/tools/session-test.h
> index 2c068bd7..ab89f8c5 100644
> --- a/tools/session-test.h
> +++ b/tools/session-test.h
> @@ -114,6 +114,7 @@ DBusMessage *session_disconnect(DBusConnection *connection,
>                                         struct test_session *session);
>
>  /* manager-api.c */
> +DBusMessage *manager_get_known_services(DBusConnection *connection);
>  DBusMessage *manager_get_services(DBusConnection *connection);
>  DBusMessage *manager_get_properties(DBusConnection *connection);
>  DBusMessage *manager_create_session(DBusConnection *connection,
> --
> 2.25.1
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
