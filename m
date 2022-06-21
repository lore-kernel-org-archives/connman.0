Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAD1858
	for <connman@lists.linux.dev>; Tue, 21 Jun 2022 16:06:06 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.92,209,1650960000"; 
   d="scan'208";a="77623545"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 21 Jun 2022 08:04:58 -0800
IronPort-SDR: NJ4po5xYl/SnLVC6K2wjqDFe+Qsrb0fnxupJlwgZzJmuFMa37mg1vFoqQPtpApQc2RDW2IezdJ
 s1qH+p5JawUVzAR0KCx3Jwi2i0QraHXE9D1lp20GMzYX3Dy4tjfoJToz2v8aJ8uX71ALTJxFo6
 sClpudyDWLriDNM8KfpW/CvnlYZkEJYJoFZ9j8+xDRYnCaDSAIguSd0wOKgWX898wL9ZzevB+N
 hls/PHPEMPb00+d12A3leVZjLpgzSQrHsBqrmoowzN7j7Kvw6mDfy0GIyhx6yKeXZ6hq7P194w
 XUU=
From: Muhammad Hamza <muhammad_hamza@mentor.com>
To: <connman@lists.linux.dev>
CC: Muhammad Hamza <muhammad_hamza@mentor.com>
Subject: [PATCH] connman: implement network interface management techniques
Date: Tue, 21 Jun 2022 21:04:50 +0500
Message-ID: <20220621160450.3401289-1-muhammad_hamza@mentor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This is required to obtain a managed network interface before connman
tries to call cleanup_devices function, this will let connman
create new routing table without bringing down the ethernet interface.

Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com
Signed-off-by: Muhammad Hamza <muhammad_hamza@mentor.com>
---
 src/connman.service.in | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/connman.service.in b/src/connman.service.in
index 79e75d6..0e7275a 100644
--- a/src/connman.service.in
+++ b/src/connman.service.in
@@ -12,7 +12,10 @@ Conflicts=systemd-resolved.service
 Type=dbus
 BusName=net.connman
 Restart=on-failure
-ExecStart=@sbindir@/connmand -n
+EnvironmentFile=-/tmp/connman.env
+ExecStartPre=/bin/sh -c "if grep 'nfsroot\|ip=' /proc/cmdline; then ETH_IFACE=$(ip addr | grep 'eth[0-9]:' | grep 'UP' | sed -e 's,\(eth[0-9]\)\(.*\),\1,' -e 's,^.*: ,,' ); NET_ADDR=$(cat /proc/cmdline | sed -ne 's/^.*ip=\([^ :]*\).*$/\1/p'); echo -e 'OPT=-I '$ETH_IFACE'\nOPT2='$ETH_IFACE'\nNET_ADDR='$NET_ADDR' ' > /tmp/connman.env; fi "
+ExecStart=/bin/sh -c "if [ \"$NET_ADDR\" = \"off\" ] || [ \"$NET_ADDR\" = \"none\" ]; then /usr/sbin/connmand -n; else /usr/sbin/connmand -n $OPT; fi"
+ExecStartPost=/bin/sh -c "if [ ! -z \"$OPT\" ] && [ \"$NET_ADDR\" = \"dhcp\" ]; then /sbin/udhcpc -i $OPT2; fi"
 StandardOutput=null
 CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SYS_TIME CAP_SYS_MODULE CAP_SYS_ADMIN
 ProtectHome=true
-- 
2.25.1

