Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8842CA8
	for <connman@lists.linux.dev>; Tue, 26 Oct 2021 07:04:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7546F616F2;
	Tue, 26 Oct 2021 09:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1635231857; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TYsAuLgQWMenAj6ko5SgbsZaMp4X9MIcdOGYnFz6udU=;
	b=PNaoO0pr+7LdrSZG7L7EJDZn2D7oRqZC4XDsrZ/1pmnrTcHIfbcJWxkdMIiCOS9qczg6Qc
	Vj2PsJYB/qmHyug+hhgDF7SdrD9WdHQg/wXaWvfslYphfsPXWACKSYxi4TR86+oeeBE49L
	7K9LVAiV15R0rD4Wi9LXDsCPwHzxZv/mUh5sXpgGQE0CSk6JpDyycSAkLhhKI5m4yBO/nF
	axEMPcqLrFo/5xugt1KDJJ6pLMXImsmIKYpJ1DM4Ow60c+ro77HDYtZ1NhFMNCqX+ece8y
	NwEUmPTm4hiC2QkWuMWIph6TUhM8KRWGimo2Z4kUit39TkM7YOgPi3IWUY1/QA==
Date: Tue, 26 Oct 2021 09:04:13 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev, Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Subject: Re: [PATCH] Add GetKnownServices api to connaman
Message-ID: <20211026070413.fv5bbuwpch3qelab@beryllium.lan>
References: <20211025132643.4485-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025132643.4485-1-michael@amarulasolutions.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Mon, Oct 25, 2021 at 01:26:43PM +0000, Michael Trimarchi wrote:
> Add a way to retrieve all the networks that were configured
> using connman and not all the ones visible
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

We don't do the SoB in this project.

> +void __connman_known_service_list_struct(DBusMessageIter *iter)
> +{
> +	gchar **services = NULL;
> +	gchar **service_id_parts = NULL;
> +	guint i = 0;
> +	struct connman_service *service = NULL;

All pre-initialization are not needed.

> +
> +	DBG("listing known services");

Please remove the DBG(). We have way to many these kind of tracing DBGs
in the code which fill the log pretty unnecessary.

> +
> +	services = connman_storage_get_services();
> +	if (services == NULL)

	if (!service)

> +		return;
> +
> +	for (i = 0; i < g_strv_length(services); i++) {
> +		service = connman_service_create();
> +		if (service == NULL) {

	if (!service)

> +			connman_error("connman_service_create() allocation failed");
> +			return;
> +		}
> +
> +		service->identifier = g_strdup(services[i]);
> +		service_id_parts = g_strsplit(services[i], "_", -1);
> +
> +		if (service_id_parts == NULL) {
> +			g_free(service);
> +			continue;
> +		}

IIRC, this check will always be false, as g_strsplit() will return a
valid array or call abort() if allocation fails.

> +
> +		service->type = __connman_service_string2type(service_id_parts[0]);
> +		service->path = g_strdup_printf("%s/service/%s", CONNMAN_PATH, service->identifier);

Do we really have to do this kind of path/identifier string generation
here. Prefixing the path I understand but for the rest I thought we had
do this in config.c/storage.c.

> +		if (service->type == CONNMAN_SERVICE_TYPE_WIFI)
> +		service->security = __connman_service_string2security(service_id_parts[g_strv_length(service_id_parts) - 1]);
> +

This looks a bit wierd formatted. Maybe introduce a local variable for
the (...) bit and get it correctly indented.

> +		if (service->path == NULL) {
> +			g_strfreev(service_id_parts);
> +			continue;
> +		}

Same here, g_strdup_printf() will either succeed or call abort() in the
ENOMEM case.

> +
> +		if (find_service(service->path) != NULL)

Just do a

	if (find_service())

> +			service->state = (find_service(service->path))->state;
> +
> +		if (service->type == CONNMAN_SERVICE_TYPE_ETHERNET &&
> +		    find_service(service->path) != NULL)

same here

> +			service->name = (find_service(service->path))->name;
> +
> +		if (0 != service_load(service)) {

Please the other way around, we don't do Misra or whatever standard this
recommends.

> +			connman_error("service_load() returned error");
> +			g_free(service);
> +			g_strfreev(service_id_parts);
> +			g_strfreev(services);
> +			return;
> +		}
> +
> +		append_struct_service(iter, append_dict_properties, service);
> +		g_strfreev(service_id_parts);
> +		g_free(service);
> +	}
> +
> +	g_strfreev(services);
> +}
> +
>  void __connman_service_list_struct(DBusMessageIter *iter)
>  {
>  	g_list_foreach(service_list, append_struct, iter);
> diff --git a/tools/manager-api.c b/tools/manager-api.c
> index e082962d..99035988 100644
> --- a/tools/manager-api.c
> +++ b/tools/manager-api.c
> @@ -64,6 +64,39 @@ static DBusMessage *set_property(DBusConnection *connection,
>  	return reply;
>  }
>  
> +DBusMessage *manager_get_known_services(DBusConnection *connection)
> +{
> +	DBusMessage *message, *reply;
> +	DBusError error;
> +
> +	message = dbus_message_new_method_call(CONNMAN_SERVICE,
> +				   CONNMAN_MANAGER_PATH,
> +				   CONNMAN_MANAGER_INTERFACE,
> +				   "GetKnownServices");
> +
> +	if (!message)
> +		return NULL;
> +
> +	dbus_error_init(&error);
> +
> +	reply = dbus_connection_send_with_reply_and_block(connection,
> +				  message, -1, &error);
> +	if (!reply) {
> +		if (dbus_error_is_set(&error)) {
> +			LOG("%s", error.message);
> +			dbus_error_free(&error);
> +		} else {
> +			LOG("Failed to get known services");
> +		}

Drop these LOG() entries.

> +		dbus_message_unref(message);
> +		return NULL;
> +	}
> +
> +	dbus_message_unref(message);
> +
> +	return reply;
> +}
> +

Please also update the documentation.

Thanks,
Daniel
