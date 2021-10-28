Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA532C83
	for <connman@lists.linux.dev>; Thu, 28 Oct 2021 06:16:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0285A616F2;
	Thu, 28 Oct 2021 08:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1635401780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=E4USXY0V9GJBj6UIxY8ROwkUPPDne8qcj/pSmVt5aG0=;
	b=MGqVWSJEMaUsMmBpxmo69nnm/P21FQZQNxRiLwgeVhaIchnyo5R7KmOFEePhrYLL7RfdQg
	zFytw9oT2aBbyWHHyIxNWs7uN+foq+AJu2ARk+La8Fy0DBOImht0x4zEydokdgTbpe3vbE
	1T/8EJP5PaKk+Zspy11c/jEjrPupnmnh8SXTjq/d6AaIr2ritaB55umQUWnBNTdSy5PrYG
	t3XyL7xmylY7RR8EUX0ait/H/igqzk3+30p+cljX629HbIhkPefkzwoVsf6Q5WgjJMOOrq
	fjTNdl7Dea/UwPImCxfSEKHdXHy3kae9rmnqWPYb5x/Z1WZkRmJ+lXak76CoxA==
Date: Thu, 28 Oct 2021 08:16:18 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev, Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Subject: Re: [PATCH V2] Add GetKnownServices api to connaman
Message-ID: <20211028061618.cgmgprc7fo2nlpf2@beryllium.lan>
References: <20211027140141.9267-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027140141.9267-1-michael@amarulasolutions.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Wed, Oct 27, 2021 at 02:01:41PM +0000, Michael Trimarchi wrote:
> Add a way to retrieve all the networks that were configured
> using connman and not all the ones visible
> 
> ---
> Changes V1->V2:
> 	- remove SoB
> 	- Add documentation
> 	- remove LOG print
> 	- Avoid check null on functions that assert
> 	- adjust the function the look for service
> 	- clean up a bit variable name
> 	- remove initialization of variables that are not needed
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
>  			object_properties, path, NULL, NULL);
>  }
>  
> +static int cmd_known_services(char *args[], int num, struct connman_option *options)
> +{
> +	if (num > 1)
> +		return -E2BIG;
> +
> +	return __connmanctl_dbus_method_call(connection,
> +			 CONNMAN_SERVICE, CONNMAN_PATH,
> +			 "net.connman.Manager",
> +			 "GetKnownServices",
> +			 services_list, NULL, NULL, NULL);
> +}
> +
>  static int cmd_peers(char *args[], int num, struct connman_option *options)
>  {
>  	char *peer_name = NULL;
> @@ -2808,6 +2820,8 @@ static const struct {
>  	  "Display tethering clients", NULL },
>  	{ "services",     "[<service>]",  service_options, cmd_services,
>  	  "Display services", lookup_service_arg },
> +	{ "known-services", NULL,  NULL, cmd_known_services,
> +	  "Display known services", NULL },
>  	{ "peers",        "[peer]",       NULL,            cmd_peers,
>  	  "Display peers", lookup_peer_arg },
>  	{ "scan",         "<technology>", NULL,            cmd_scan,
> diff --git a/doc/manager-api.txt b/doc/manager-api.txt
> index 6eaa0a38..093b25c1 100644
> --- a/doc/manager-api.txt
> +++ b/doc/manager-api.txt
> @@ -39,6 +39,18 @@ Methods		dict GetProperties()
>  
>  			Possible Errors: [service].Error.InvalidArguments
>  
> +		array{object,dict} GetKnownServices()
> +
> +			Returns a sorted list of tuples with service
> +			object path and dictionary of service propertiesa

... properties. But the text is wrong anyway. 'object path' is not
correct, it is the storage path of the dictionary containing the
associated resources with this known service.

About those properties, e.g.

[('/var/lib/connman/ethernet_2cf05d0a93f0_cable',
  {'AutoConnect': False,
   'Domains': [],
   'Domains.Configuration': [],
   'Ethernet': {},
   'Favorite': False,
   'IPv4': {},
   'IPv4.Configuration': {},
   'IPv6': {},
   'IPv6.Configuration': {},
   'Immutable': False,
   'Nameservers': [],
   'Nameservers.Configuration': [],
   'Provider': {},
   'Proxy': {},
   'Proxy.Configuration': {},
   'Security': [],
   'Timeservers': [],
   'Timeservers.Configuration': [],
   'Type': 'ethernet',
   'mDNS': False,
   'mDNS.Configuration': False}),

I don't think this makes sense, especially that all services return
empty properties. GetKnownServices() should just return the object path
and then the dictionary containing the storage path.

> +void __connman_known_service_list_struct(DBusMessageIter *iter)
> +{
> +	gchar **services;
> +	gchar **srv_id_parts;
> +	guint i;
> +	struct connman_service *service;

Reverse Christmas tree, no glib types when not needed,

	struct connman_service *service;
	char **srv_id_parts;
	char **services;
	unsigned int i;


> +
> +	services = connman_storage_get_services();
> +	if (!services)
> +		return;
> +
> +	for (i = 0; i < g_strv_length(services); i++) {
> +		struct connman_service *srv;
> +
> +		service = connman_service_create();
> +		if (!service) {
> +			connman_error("connman_service_create() allocation failed");
> +			return;
> +		}
> +
> +		service->identifier = g_strdup(services[i]);
> +		srv_id_parts = g_strsplit(services[i], "_", -1);
> +		if (srv_id_parts == NULL) {

Does not make sense srv_id_parts is never NULL. See glib documentation.

> +			g_free(service);
> +			continue;
> +		}
> +
> +		service->type = __connman_service_string2type(srv_id_parts[0]);
> +		service->path = g_strdup_printf("%s/%s", STORAGEDIR, service->identifier);
> +		if (service->type == CONNMAN_SERVICE_TYPE_WIFI)
> +			service->security = __connman_service_string2security(srv_id_parts[g_strv_length(srv_id_parts) - 1]);
> +

The line is way too long. Do something like

		if (service->type == CONNMAN_SERVICE_TYPE_WIFI) {
			char *id = srv_id_parts[g_strv_length(srv_id_parts) - 1];
			service->security = __connman_service_string2security(id);
		}


> +		srv = find_service(service->path);
> +		if (srv)
> +			service->state = srv->state;
> +
> +		if (service->type == CONNMAN_SERVICE_TYPE_ETHERNET && srv)
> +			service->name = srv->name;
> +
> +		if (service_load(service)) {
> +			connman_error("service_load() returned error");
> +			g_free(service);
> +			g_strfreev(srv_id_parts);
> +			g_strfreev(services);
> +			return;
> +		}
> +
> +		append_struct_service(iter, append_dict_properties, service);
> +		g_strfreev(srv_id_parts);
> +		g_free(service);
> +	}
> +
> +	g_strfreev(services);
> +}
> +

Thanks,
Daniel
