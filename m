Received: from mx1.kistler.com (mx1.kistler.com [91.223.79.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12311C29
	for <connman@lists.linux.dev>; Wed, 25 Jan 2023 11:08:20 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.97,245,1669071600"; 
   d="scan'208";a="56289732"
Received: from kihagsepp01.int.kistler.com (HELO sl-win-seppm-1.int.kistler.com) ([192.168.52.67])
  by mx1.kistler.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:07:09 +0100
Received: from mx1.kistler.com (kihagciip01.int.kistler.com [192.168.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sl-win-seppm-1.int.kistler.com (Postfix) with ESMTPS
	for <connman@lists.linux.dev>; Wed, 25 Jan 2023 12:07:08 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.97,245,1669071600"; 
   d="scan'208";a="56289731"
Received: from sw-win-exch-2.int.kistler.com ([192.168.100.96])
  by mx1.kistler.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2023 12:07:09 +0100
Received: from SW-WIN-EXCH-1.int.kistler.com (192.168.100.95) by
 SW-WIN-EXCH-2.int.kistler.com (192.168.100.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 25 Jan 2023 12:07:08 +0100
Received: from VL-BTS-Cvo-1.int.kistler.com (192.168.100.116) by
 SW-WIN-EXCH-1.int.kistler.com (192.168.100.95) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 25 Jan 2023 12:07:01 +0100
From: Miroslav Cuvar <miroslav.cuvar@kistler.com>
To: <miroslav.cuvar@kistler.com>
CC: <connman@lists.linux.dev>
Subject: [PATCH 1/1] Added support for setting preferred IP for WiFi tethering
Date: Wed, 25 Jan 2023 12:06:59 +0100
Message-ID: <20230125110659.225550-1-miroslav.cuvar@kistler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108071820.14101-1-miroslav.cuvar@kistler.com>
References: <20221108071820.14101-1-miroslav.cuvar@kistler.com>
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

Have you had a chance to take a look at this?
Do you regard this as something that could be accepted?

With regards
Miro

Confidentiality Notice: This e-mail is privileged and confidential and for =
the use of the addressee only. Should you have received this e-mail in erro=
r please notify us by replying directly to the sender or by sending a messa=
ge to info@kistler.com. Unauthorised dissemination, disclosure or copying o=
f the contents of this e-mail, or any similar action, is prohibited. =0A=
