Received: from griffin.geeknet.cz (griffin.geeknet.cz [94.142.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BF7C
	for <connman@lists.linux.dev>; Thu,  9 Jun 2022 01:52:52 +0000 (UTC)
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTP id 970aa6da
	for <connman@lists.linux.dev>;
	Thu, 9 Jun 2022 03:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jirutka.cz; h=to:from
	:subject:message-id:date:mime-version:content-type
	:content-transfer-encoding; s=mail; bh=KYb6ttvEfN+4Br2E8Ufm2qm9J
	ZI=; b=rKm67ltvBoWDSN1HD1KpRNQCd6xRqCKxl9mbtlwuvqZlN29Ph09qBoOSv
	eHBQAIm+TK8NDyETlKDuLe7jflI+Vim30vZBgPsitd05gWAEi5z5BvQjSM3FjpdB
	MoHMMHYA1vpoRldounuJKGPCRkzeO9a7gqG9PEPzy1j5wkSIOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=jirutka.cz; h=to:from
	:subject:message-id:date:mime-version:content-type
	:content-transfer-encoding; q=dns; s=mail; b=sGSPLPV0zD2YZ08pu92
	TiF7vjtF4m6i6sB7S6jB99CxpoDdW1sMAfni2fBJ+6xHvldqnTn8fbY1OvZSGClx
	o0d0pT2zbQGwyfp/DH7XxgC7GbswB5n22JyS9zCGzk43JNeIe0pi4VizByHz3nZH
	mxRqkOpsXSrxRZR9t9fsQ3Bw=
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTPSA id e1f96a65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <connman@lists.linux.dev>;
	Thu, 9 Jun 2022 03:46:09 +0200 (CEST)
To: connman@lists.linux.dev
From: Jakub Jirutka <jakub@jirutka.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jakub@jirutka.cz; keydata=
 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
Subject: Service state change is not emitted on net.connman.Service
Message-ID: <4df95b51-0da9-6bf1-967f-17bfe8cbf782@jirutka.cz>
Date: Thu, 9 Jun 2022 03:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi,

I wrote a daemon [1] that integrates ConnMan with resolvconf(9) using the DBus API. It monitors the PropertyChanged signal on the net.connman.Service interface and acts when the state of a service changes to ready, online or disconnect.

This works correctly with WiFi (iwd) and VPN (openvpn), but not with Ethernet. If I disconnect the cable, the status change to "disconnect" is emitted for /net/connman/service/ethernet_*, but after I connect it back, nothing is emitted (only the transition to the "online" state, unless I was already "online" via another device). I does emit the ServiceChanged signal on the net.connman.Manager interface, but this one is unsuitable for my purpose (for example, doesn’t work well for WiFi).

A few relevant lines from the debug log:

    src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags 0x0400 seq 0 pid 0
    ...
    src/service.c:__connman_service_create_from_network() network 0x7fe43db0a260
    ...
    src/service.c:__connman_service_ipconfig_indicate_state() service 0x7fe43daf9d70 (ethernet_482ae3a31df2_cable) old state 1 (idle) new state 3 (configuration) type 1 (IPv4)
    src/service.c:service_indicate_state() service 0x7fe43daf9d70 old idle - new configuration/idle => configuration
    ...
    src/service.c:service_indicate_state() service 0x7fe43daf9d70 old configuration - new ready/configuration => ready

Function `service_indicate_state()` (service.c:5976) calls `state_changed()` (service.c:1657 [2]) where the DBus signal should be emitted… but it’s not, due to `allow_property_changed()`:

    1657 | static void state_changed(struct connman_service *service)
    ...  | ...
    1667 |     if (!allow_property_changed(service))  <--- HERE
    1668 |         return;
    1669 |
    1670 |     connman_dbus_property_changed_basic(service->path,
    1671 |             CONNMAN_SERVICE_INTERFACE, "State",
    1672 |             DBUS_TYPE_STRING, &str);

Function `allow_property_changed()` performs a lookup in the `services_notify->add` hash table and returns false if the service path is found there. The service is added there in `service_schedule_added()` (service.c:4998) which is called near the end of the `__connman_service_create_from_network()` function (service.c:7531).
Function `service_schedule_added()` also calls `service_schedule_changed()` (service.c:4829) which schedules `service_send_changed()` (service.c:4802) to be called after 100 ms(?) timeout. This function then removes the service from the `services_notify->add` hash table.
Meanwhile, the service is connected and all the PropertyChanged messages are lost. 

This condition has been added by Patrik Flykt, ten years ago in 83cab654f1f78d49bd848b87cea645078f82f13e [3] with message:

    service: Send updated properties after ServicesChanged
    Updated service properties are not sent before the new service
    has been announced in a 'ServicesChanged' signal.

I don’t know the context and real intention of this change, but the described behaviour of the API seems to be wrong, or at least unexpected and inconsistent between various service types.


Can you please fix this problem or explain me how it can be fixed?

Thanks,
Jakub

[1]: https://github.com/jirutka/connman-resolvconf
[2]: https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/service.c?h=1.41&id=4a27c58ad8b1afd980ebe122ca178c7f659c025e#n1667
[3]: https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=83cab654f1f78d49bd848b87cea645078f82f13e
