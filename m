Received: from griffin.geeknet.cz (griffin.geeknet.cz [94.142.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969657E
	for <connman@lists.linux.dev>; Tue, 26 Apr 2022 19:55:56 +0000 (UTC)
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTP id 8444bcf7
	for <connman@lists.linux.dev>;
	Tue, 26 Apr 2022 21:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jirutka.cz; h=from:to:cc
	:subject:date:message-id; s=mail; bh=d8AZBURq5RO2lsqKDEKdKGCjEQ4
	=; b=FqMOYXZbX2QmmbfKhunWfSAqPS47b7lmoO3rJQKGMqV3T3RiMgm+t7E1ONa
	WWIE0H8inM/+vWuf+/MQrniv0MsNZYAfZX1nH4wl/pfRhxcgdEyDlRp1ihz7CWZ8
	hsaZlXM4A4fnwiL9fAL7IpUtMN9VANs/gtv2xJncCPBgeWD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=jirutka.cz; h=from:to:cc
	:subject:date:message-id; q=dns; s=mail; b=E8zpewwDy44ou5h5rpkNC
	/bHhJZtDk6qVnZw1GJEu2/0fcSFGigaoevd874rAV0btfH5AXNWvINwvW/AXU+/n
	mvw1CHinhQf2nlI4ZxPFzpGgF4Llu0spStWIEYEC1hV7tw6f7A4kuLFfLeTn2pU9
	iV6ay1g07ZyzYKPzDP/iXE=
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTPSA id f7c71bc5 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
	Tue, 26 Apr 2022 21:49:13 +0200 (CEST)
From: Jakub Jirutka <jakub@jirutka.cz>
To: connman@lists.linux.dev
Cc: Jakub Jirutka <jakub@jirutka.cz>
Subject: [PATCH] service: Add "Ethernet" property for VPN into n.c.Manager GetServices
Date: Tue, 26 Apr 2022 21:48:53 +0200
Message-Id: <20220426194853.13343-1-jakub@jirutka.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>

Scope:
This patch affects the Service properties exposed by D-Bus method
GetServices in interface net.connman.Manager.

Before (current state):
Services of type WIFI, ETHERNET, BLUETOOTH, and GADGET have property
"Ethernet" with a dictionary of "Method", "Interface", "Address", and
"MTU". Services of type VPN (and also P2P, GPS, and SYSTEM) don't include
this property, althrough VPNs are IP-based too and the data is available
(at least for some, e.g. OpenVPN, not sure if all).

After (proposed change):
Even services of type VPN includes property "Ethernet".

Motivation:
ConnMan integration with resolvconf(8) via D-Bus
(https://github.com/jirutka/connman-resolvconf) - I need to know
"Interface" even for VPN services.

Considerations:
Function append_ethernet in src/service.c checks if either
service->ipconfig_ipv4 or service->ipconfig_ipv6 is non-NULL and do
nothing if this condition is not satisfied. Otherwise,
__connman_ipconfig_append_ethernet from src/ipconfig.c is called.
This function checks if the index of passed service->ipconfig_ipv4
(or _ipv6) is present in ipdevice_hash. If it's not, it just sets
"Method" property with value "auto" and returns.
Thus I think this change shouldn't break anything, even if ipconfig
data is not available for some VPN types. I tested it myself with just
OpenVPN provider though.

This may introduce an asymmetry between Service properties returned by
GetServices and signal PropertyChanged in interface net.connman.Service
- change in "Ethernet" is currently not being announced for VPN
services. I originally wanted to implement this as well (actually, before
GetServices), but got lost in code duplication and unclear relation
between src/ and vpn/.
Anyway, I don't think this asymetry is a problem (and probably more
asymetries already exist there?).

I didn't consider method GetProperties in interface net.connman.Service
at all, because it's marked as deprecated. However, I hope that it
calls the same functions as the method GetServices.

The same change should be considered even for P2P services, but I don't
use this service type and didn't look into its specifics.
---
 src/service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 66ab99d8..988928e7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2593,7 +2593,6 @@ static void append_properties(DBusMessageIter *dict, dbus_bool_t limited,
 	case CONNMAN_SERVICE_TYPE_UNKNOWN:
 	case CONNMAN_SERVICE_TYPE_SYSTEM:
 	case CONNMAN_SERVICE_TYPE_GPS:
-	case CONNMAN_SERVICE_TYPE_VPN:
 	case CONNMAN_SERVICE_TYPE_P2P:
 		break;
 	case CONNMAN_SERVICE_TYPE_CELLULAR:
@@ -2604,6 +2603,7 @@ static void append_properties(DBusMessageIter *dict, dbus_bool_t limited,
 		connman_dbus_dict_append_dict(dict, "Ethernet",
 						append_ethernet, service);
 		break;
+	case CONNMAN_SERVICE_TYPE_VPN:
 	case CONNMAN_SERVICE_TYPE_WIFI:
 	case CONNMAN_SERVICE_TYPE_ETHERNET:
 	case CONNMAN_SERVICE_TYPE_BLUETOOTH:
-- 
2.16.4

