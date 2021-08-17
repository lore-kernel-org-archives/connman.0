Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE52FB0
	for <connman@lists.linux.dev>; Tue, 17 Aug 2021 16:55:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C9E160A44;
	Tue, 17 Aug 2021 18:55:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1629219330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=frRKhbU+1Hlq7YrQ9EhcwWiwC30ZN1qbmsvuNRUsFDs=;
	b=Rb5/bzjjzIlIVEM31VcairXr3Mie/nuA/e2ECAPhqT6NS4wUuI922sEAB6fr77Fuon8JVn
	zv+fdfvXuBYLT6f7JBu6GnhxdpKKAabtQKDBfAJk/HE7/LLCK2cBWTHbIsrNVaYB3ckgtN
	QhC3Gk3esU6tSuPQNKR+/9ePlwiK4brsPGO+Omarkln45fPyYkO+0VtoeShrAMMjMlQYgq
	ochMDl/alSa4QzDZVUFCjJuDqz7jj9XrUOBHH1USrt0y8HswJ9DTKZYf89XUGk5aK2iI6O
	WvASe9fzscV746KOLIsx7+H3IJt9LKjNzgMWeDvAQ2XYJ/ffJ/ujLcyDpZZbXw==
Date: Tue, 17 Aug 2021 18:55:28 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 1/2] vpn-provider: Implement connmand online state
 checking
Message-ID: <20210817165528.amfp4fyf22ljaehz@carbon.lan>
References: <20210817151443.32305-1-jussi.laakkonen@jolla.com>
 <20210817151443.32305-2-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

Just a bunch of small nits.

On Tue, Aug 17, 2021 at 06:14:42PM +0300, Jussi Laakkonen wrote:
> +static gboolean do_connect_timeout_function(gpointer data)
> +{
> +	DBG("");
> +
> +	/*
> +	 * Keep in main loop if no agents are present yet or if connman is not
> +	 * yet online
> +	 */
> +	if (!connman_agent_get_info(NULL, NULL, NULL) || !connman_online) {
> +		return G_SOURCE_CONTINUE;

Doesn't this get the mainloop busy looping?

> +	} else {

As there is a return above, no need to do a else statement. Makes also
the indention one less :)

> +		struct vpn_provider_connect_data *cdata = data;
> +		struct vpn_provider *provider = cdata->provider;
> +		int err;
> +
> +		provider->do_connect_timeout = 0;
> +		err = __vpn_provider_connect(provider, cdata->msg);
> +
> +		if (err < 0 && err != -EINPROGRESS) {
> +			g_dbus_send_message(cdata->conn,
> +				__connman_error_failed(cdata->msg, -err));
> +			cdata->msg = NULL;
> +		}
> +
> +		return G_SOURCE_REMOVE;
> +	}
> +}

[...]

> +static void do_connect_later(struct vpn_provider *provider,
> +					DBusConnection *conn, DBusMessage *msg)
> +{
> +	struct vpn_provider_connect_data *cdata =
> +		g_try_new0(struct vpn_provider_connect_data, 1);

Do a g_new0() instead of a g_try_new0().

> +
> +	cdata->conn = dbus_connection_ref(conn);
> +	cdata->msg = dbus_message_ref(msg);
> +	cdata->provider = provider;
> +
> +	if (provider->do_connect_timeout)
> +		g_source_remove(provider->do_connect_timeout);
> +
> +	provider->do_connect_timeout =
> +		g_timeout_add_seconds_full(G_PRIORITY_DEFAULT, 1,
> +					do_connect_timeout_function, cdata,
> +					do_connect_timeout_free);
> +}
> +

[...]

> +static gboolean run_get_connman_state(gpointer user_data)
> +{
> +	const char *path = "/";
> +	const char *method = "GetProperties";
> +	gboolean rval = FALSE;
> +
> +	DBusMessage *msg = NULL;
> +	DBusPendingCall *call = NULL;
> +
> +	DBG("");
> +
> +	msg = dbus_message_new_method_call(CONNMAN_SERVICE, path,
> +		CONNMAN_MANAGER_INTERFACE, method);
> +
> +	if (!msg)
> +		goto out;
> +
> +	if (!(rval = g_dbus_send_message_with_reply(connection, msg,
> +		&call, -1))) {

Move the 'rval = ...' outside the if condition.

> +		connman_error("Cannot call %s on %s",
> +			method, CONNMAN_MANAGER_INTERFACE);
> +		goto out;
> +	}
> +
> +	if (!call) {
> +		connman_error("set pending call failed");
> +		goto error;
> +	}
> +
> +	if (!dbus_pending_call_set_notify(call, get_connman_state_reply,
> +		NULL, NULL)) {
> +		connman_error("set notify to pending call failed");
> +		goto error;
> +	}
> +
> +out:
> +	if (msg)
> +		dbus_message_unref(msg);
> +
> +	/* In case sending was success, unset timeout function id */
> +	if (rval) {
> +		DBG("unsetting get_connman_state_timeout id");
> +		get_connman_state_timeout = 0;
> +	}
> +
> +	/* Return FALSE in case of success to remove from main event loop */
> +	return !rval;
> +
> +error:
> +	if (call)
> +		dbus_pending_call_unref(call);
> +
> +	rval = G_SOURCE_REMOVE;

This looks wrong. Shouldn't this be either TRUE or FALSE?

> +	goto out;

Please try to avoid jumping up again. Forward goto's are easy to read
but the backwards one tend to be hard to grasp (at least for me).

Daniel
