Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A5168
	for <connman@lists.linux.dev>; Thu,  1 Jul 2021 06:57:02 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 22968500587;
	Thu,  1 Jul 2021 08:47:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id E4888500195;
	Thu,  1 Jul 2021 08:47:39 +0200 (CEST)
Date: Thu, 1 Jul 2021 08:47:39 +0200
From: Daniel Wagner <wagi@monom.org>
To: Andrei Datcu <datcuandrei@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Clearing service error from invalid-key will not invoke the
 agent anymore
Message-ID: <20210701064739.oilpty5pd43z4cyc@beryllium.lan>
References: <CAAmFs7=AcOmoNWVaGEoi_9FPgh3NBS1LiceWOVQgL0xS=hnKYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmFs7=AcOmoNWVaGEoi_9FPgh3NBS1LiceWOVQgL0xS=hnKYw@mail.gmail.com>

Hi Andrei,

On Tue, Jun 22, 2021 at 09:10:05PM +0300, Andrei Datcu wrote:
> Using version 1.40, I'm trying to connect to a basic psk wifi hotspot.
> If I input a wrong key to the agent request, the service will
> correctly get Error == "invalid-key" (and State == "idle"). Invoking
> Service::ClearProperty("Error") will put the service in a weird state:
> every subsequent Service::Connect() call will fail without ever
> requesting any agent input. To leave this state, one has to call
> `Service::Remove()`.
> Is this expected or is this a bug?

Sounds like a bug to me. I think it could be that we set the error state
but don't update the ipconfig/service state accordingly. Although you
are saying the service is in a error state.

So this here is probably not helping:

--- a/src/service.c
+++ b/src/service.c
@@ -3999,6 +3999,13 @@ static DBusMessage *clear_property(DBusConnection *conn,
        if (g_str_equal(name, "Error")) {
                set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
 
+               __connman_service_ipconfig_indicate_state(service,
+                                               CONNMAN_SERVICE_STATE_FAILURE,
+                                               CONNMAN_IPCONFIG_TYPE_IPV4);
+               __connman_service_ipconfig_indicate_state(service,
+                                               CONNMAN_SERVICE_STATE_FAILURE,
+                                               CONNMAN_IPCONFIG_TYPE_IPV6);
+
                __connman_service_clear_error(service);
                service_complete(service);
        } else

If possible could you check what the service state is when we hit the
__connman_service_clear_error?

@@ -6183,7 +6190,7 @@ int __connman_service_clear_error(struct connman_service *service)
 {
        DBusMessage *pending, *provider_pending;
 
-       DBG("service %p", service);
+       DBG("service %p state %d", service, service->state);
 
        if (!service)
                return -EINVAL;


TBH, the 'set_error' thing looks a bit strange. The commit message says

  service: Signal error property changes

  In order to allow clients to update the property in a manner similar to
  other service properties, signal changes in the service "Error" property
  key/value pair.

  The value "" is used when no error is asserted because D-Bus property
  changed convention has no semantics for indicating a key/value pair was
  removed.

Thanks,
Daniel
