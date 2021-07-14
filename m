Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27770
	for <connman@lists.linux.dev>; Wed, 14 Jul 2021 09:08:07 +0000 (UTC)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210714090800epoutp01eea2c05ce4870b7977d9aa3fe946897c~RnRsYMyIt0496204962epoutp01T
	for <connman@lists.linux.dev>; Wed, 14 Jul 2021 09:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210714090800epoutp01eea2c05ce4870b7977d9aa3fe946897c~RnRsYMyIt0496204962epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1626253680;
	bh=sS3ban9qfHUQAz98jdxaezik5IiXcYuKDT5fKcfmFy0=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=DFe27MIYoXXyYeLf/3Gpv/anCtqHn/SprTSz7+fPThfhXXY1kIUnTkwt4Zr6Yh5iM
	 e+cuMOwvjVhLpw8ZMZXXk/fZ5cqp3V+sV+1kweeoZVhYjNa8RxasTcVHyKaVyh5zt4
	 B4XuXeAqRQtWAq+RPv7ozQS765DOmuKFBNTE1Olw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20210714090759epcas5p3ce6c6fad3cfb690ca6197d9aa1a76bba~RnRr_V1DZ1875418754epcas5p3m;
	Wed, 14 Jul 2021 09:07:59 +0000 (GMT)
X-AuditID: b6c32a49-6b7ff70000002504-a6-60eea96f2a67
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.FF.09476.F69AEE06; Wed, 14 Jul 2021 18:07:59 +0900 (KST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: main: Fix a memory leak for str_list in parse_config
Reply-To: rahul.jain@samsung.com
Sender: Rahul Jain <rahul.jain@samsung.com>
From: Rahul Jain <rahul.jain@samsung.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210714090411epcms5p810fc79bcbc4f7a7d48028cb1f4d3ab27@epcms5p8>
Date: Wed, 14 Jul 2021 14:34:11 +0530
X-CMS-MailID: 20210714090411epcms5p810fc79bcbc4f7a7d48028cb1f4d3ab27
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmpm7+yncJBhNeiFi865rOZvFhS5wD
	k8eLzTMZPfq2rGIMYIrisklJzcksSy3St0vgyjhwZgJTwUzWigf/etkaGNtZuhg5OSQETCSO
	H//BDGILCexmlJg4VbmLkYODV0BQ4u8OYZCwsICtxJuzB5kgShQkbm3fwAwR15bY+/kf2Bg2
	AU2JZZcngtWICJhLPP07hRFkDLOAocTnJVIQm3glZrQ/hdoqLbF9+VZGCFtU4ubqt+ww9vtj
	86HiIhKt984yQ9iCEg9+7maE6b0waz2QzQVkdzNKzHm6kxXCmcIo8fnXOjaIKnOJ/91vwTp4
	BXwlOjZcAouzCKhKnLjwDWqSi8TM3lNgFzELyEtsfzuHGeJoTYn1u/QhSmQlpp5axwRRwifR
	+/sJE8wzO+bB2CoSC+behbKlJNo33oAa7yFxteEzNNwCJS5OvsM8gVF+FiJ0ZyFZPAth8QJG
	5lWMkqkFxbnpqcWmBYZ5qeV6xYm5xaV56XrJ+bmbGMHRr+W5g/Hugw96hxiZOBgPMUpwMCuJ
	8C41epsgxJuSWFmVWpQfX1Sak1p8iFGag0VJnHcp+6EEIYH0xJLU7NTUgtQimCwTB6dUA1PN
	ol1a36SXLPtcwxV88Vflip99zMWau42i3+xYxzDjcNj5m5kRHzxu1gSdmGVjyL6o00j/4PTp
	T9LPb7Q6o/e/0/Lotr/Blz847Oc4+Xr2RGGh8FXMYge5Mu+8W2f8Tit+7rcevq0/5jJ+uFFf
	5xAsvv15xx9R4w0Hb4fr2bA/v2Kfceitcbnl9m9s/vt2pKwtS/r7oefJDcnZNd8YzLxfGKud
	v7S992266XIDtce6m1pZ59526VBbt9zXWeH7TffA1zN2K3O4FDqZxl5otNAqelVcLpga/nj/
	8SsMrv/X1izjqddIkovtemphu/afl6BQY+VdhfQl5Wc3PdqQY+6wbMHHfo29HjebEz7/e75B
	iaU4I9FQi7moOBEAAEXbb20DAAA=
X-CMS-RootMailID: 20210714090411epcms5p810fc79bcbc4f7a7d48028cb1f4d3ab27
References: <CGME20210714090411epcms5p810fc79bcbc4f7a7d48028cb1f4d3ab27@epcms5p8>

commit 6e7844d37588612aa52722da6fa17468bd677b8c
Author: Rahul Jain <rahul.jain@samsung.com>
Date:   Wed Jul 14 14:30:48 2021 +0530

    main: Fix a memory leak for str_list in parse_config

diff --git a/src/main.c b/src/main.c
index 6480caa..25854e8 100644
--- a/src/main.c
+++ b/src/main.c
@@ -341,6 +341,8 @@ static void parse_config(GKeyFile *config)
                connman_settings.auto_connect =
                        parse_service_types(default_auto_connect, CONF_ARRAY_SIZE(default_auto_connect));
 
+       g_strfreev(str_list);
+
        g_clear_error(&error);
 
        str_list = __connman_config_get_string_list(config, "General",
