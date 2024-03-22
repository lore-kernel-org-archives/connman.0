Received: from esa.hc1803-32.eu.iphmx.com (esa.hc1803-32.eu.iphmx.com [194.165.193.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BF46453
	for <connman@lists.linux.dev>; Fri, 22 Mar 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.165.193.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114002; cv=none; b=D6KY28M+hf9yRMcSVEnLR5EbnO2kG9jqp13mBoXhDKYIy2gYwQSUJSQrSMc/ZoLrzB89nICt8h1JynQ+vC+pDDvXBXWVozLIDF6KYzr2DkmcBCXMiAkyDtqDbHvakboRJwizW5VzygcHF3NFRjghEixfBfdc/2/ua8DTIJaDlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114002; c=relaxed/simple;
	bh=cd6nCirFyO0FzIKkPDGzLjVwm/D4C0QRqZanXLVc5Kk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OxRyeoyr2wQImHGYmTyBUHRbC5wnFbGCOSrAk+COPPTARuLObyF6bWWv1AEyEORcxIApZipJvR5zgpEdBzIP/eNj6ccHay13inKQXFHU9Nd8Ts0Q5iNo2harr+2VRQQXko/7IsJeX1ypcuYLQH53hvJTrsVZJm67ZI/2tG20P9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kistler.com; spf=pass smtp.mailfrom=kistler.com; dkim=pass (2048-bit key) header.d=kistler.com header.i=@kistler.com header.b=A2nmyxUN; arc=none smtp.client-ip=194.165.193.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kistler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kistler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kistler.com header.i=@kistler.com header.b="A2nmyxUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=kistler.com; i=@kistler.com; l=1193; q=dns/txt;
  s=selector1; t=1711113996; x=1742649996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qxrUXm/LazSsJ0MO7YRYeuOafZNSJY0oGFdAw8u7EaY=;
  b=A2nmyxUNhpbV3pvZ2NECJbc6LC95uQXw5OzMVx6KbcS+6P8S1n/SB3nl
   081w5iVE23q41j6/o2yzqZk+gx9qHULircSA7hhj99lzhTJnzIQ1Zs8Fu
   Re1ozWlXcIUZtPpkmx+rbp3C53kZDqdm22FGIayCIA9JUmWKA0Y9N9mhL
   7xP+zndZWgVEhJk3ZgLxLVTJtPp9UwKxdzixCqnr4Cu3Gu5tmEhpODOeh
   PURDPdCTGENNFKJcDW+El5+HJHSjAqojQhU+CoXMaaclDswCVmgy3eAEE
   TeHngF5lj15EKm+4JvtLDbAfD+r7UlsLgYnTI/nAjd7LGHGDLSWdah/6R
   A==;
X-CSE-ConnectionGUID: 3GazdlwrSaSrEdjTU8VsXQ==
X-CSE-MsgGUID: Js6MsZn8QOGHVQ8L5b0+Eg==
Received: from unknown (HELO sl-win-seppm-1.int.kistler.com) ([91.223.79.46])
  by ob1.hc1803-32.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 14:25:25 +0100
Received: from esa.hc1803-32.eu.iphmx.com (esa.hc1803-32.eu.iphmx.com [194.165.205.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sl-win-seppm-1.int.kistler.com (Postfix) with ESMTPS
	for <connman@lists.linux.dev>; Fri, 22 Mar 2024 14:25:24 +0100 (CET)
X-CSE-ConnectionGUID: AA/iJd3oS1yGHE5cjHLO1g==
X-CSE-MsgGUID: zpBwpt7JQKq+7RgbDwPEtw==
Received: from static-108-17-0-30.bflony.fios.verizon.net (HELO SW-BUF-EXCH-1.int.kistler.com) ([108.17.0.30])
  by ob1.hc1803-32.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2024 14:25:24 +0100
Received: from SW-WIN-EXCH-1.int.kistler.com (192.168.100.95) by
 SW-BUF-EXCH-1.int.kistler.com (192.168.120.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 22 Mar 2024 09:25:23 -0400
Received: from pc-buf-mah-3.us.int.kistler.com (192.168.100.116) by
 SW-WIN-EXCH-1.int.kistler.com (192.168.100.95) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Fri, 22 Mar 2024 14:25:22 +0100
From: John Mark <john.mark@kistler.com>
To: <connman@lists.linux.dev>
CC: John Mark <john.mark@kistler.com>
Subject: [PATCH] set pkt_len when packet is received using L3 listening mode so that the ACK can be processed correctly
Date: Fri, 22 Mar 2024 09:24:55 -0400
Message-ID: <20240322132455.833-1-john.mark@kistler.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-C2ProcessedOrg: 78a97207-3cfa-406d-a777-069c09c1300a
X-SM-outgoing: yes

The packet length is not set correctly when an IPv4 L3 ACK is received from=
 a
DHCP server.  This causes the packet to be rejected for having no
MESSAGE_TYPE option and the lease is not renewed at the T1 point (or any
subsequent retry).  Instead, the lease gets re-bound at the T2 point.

---
 gdhcp/client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index 82017692..c58c7be9 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -2316,6 +2316,7 @@ static gboolean listener_event(GIOChannel *channel, G=
IOCondition condition,
 		} else {
 			re =3D dhcp_recv_l3_packet(&packet,
 						dhcp_client->listener_sockfd);
+			pkt_len =3D (uint16_t)(unsigned int)re;
 			xid =3D packet.xid;
 		}
 	} else if (dhcp_client->listen_mode =3D=3D L_ARP) {
--=20
2.34.1


Confidentiality Notice: This e-mail is privileged and confidential and for =
the use of the addressee only. Should you have received this e-mail in erro=
r please notify us by replying directly to the sender or by sending a messa=
ge to info@kistler.com. Unauthorised dissemination, disclosure or copying o=
f the contents of this e-mail, or any similar action, is prohibited. =0A=
