Received: from esa.hc1803-32.eu.iphmx.com (esa.hc1803-32.eu.iphmx.com [194.165.193.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3E1FA6
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kistler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kistler.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-CSE-ConnectionGUID: a7VzWEu9TfyIRttwHxRNsw==
X-CSE-MsgGUID: RW1OF7kESJ+voRzwOZNOgg==
Received: from unknown (HELO sl-win-seppm-1.int.kistler.com) ([91.223.79.46])
  by ob1.hc1803-32.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 12:39:22 +0100
Received: from esa.hc1803-32.eu.iphmx.com (esa.hc1803-32.eu.iphmx.com [194.165.193.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sl-win-seppm-1.int.kistler.com (Postfix) with ESMTPS
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 12:39:22 +0100 (CET)
X-CSE-ConnectionGUID: Wz4Vyr9lQjqDGL00iZ0OaA==
X-CSE-MsgGUID: SMVIvbDYTJS1SkEyD/CaJQ==
Received: from entrypointemea.kistler.com (HELO SW-WIN-EXCH-1.int.kistler.com) ([91.223.79.122])
  by ob1.hc1803-32.eu.iphmx.com with ESMTP; 07 Nov 2023 12:39:22 +0100
Received: from SW-WIN-EXCH-2.int.kistler.com (192.168.100.96) by
 SW-WIN-EXCH-1.int.kistler.com (192.168.100.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 7 Nov 2023 12:39:22 +0100
Received: from VL-BTS-Cvo-1.int.kistler.com (192.168.100.116) by
 SW-WIN-EXCH-2.int.kistler.com (192.168.100.96) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Tue, 7 Nov 2023 12:39:21 +0100
From: Cvo <miroslav.cuvar@kistler.com>
To: <connman@lists.linux.dev>
CC: <miroslav.cuvar@kistler.com>, <robby.zippel@kistler.com>
Subject: [PATCH 1/1] Added support for setting preferred IP for WiFi tethering
Date: Tue, 7 Nov 2023 12:39:21 +0100
Message-ID: <20231107113921.1617291-1-miroslav.cuvar@kistler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125110659.225550-1-miroslav.cuvar@kistler.com>
References: <20230125110659.225550-1-miroslav.cuvar@kistler.com>
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

Hello,
I just wanted to check one more time if this is something that's not accept=
ed or something that nobody looked at yet?
Could you please let us know?

Thanks.
Regards,
Miro

Confidentiality Notice: This e-mail is privileged and confidential and for =
the use of the addressee only. Should you have received this e-mail in erro=
r please notify us by replying directly to the sender or by sending a messa=
ge to info@kistler.com. Unauthorised dissemination, disclosure or copying o=
f the contents of this e-mail, or any similar action, is prohibited. =0A=
