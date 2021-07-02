Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50052.outbound.protection.outlook.com [40.107.5.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A770
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 10:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcL+/f7+UzXbNHIjM6sjlxljoI80ti60QdrgcuL4+7Id9RQCgS8mJfzSagRly0hEUJOgz7aucxNVC5usnp/dSvMSwLNAlFB5G164TBzZzqY7BXleeH36T2BMcs5yXVe6E0S9mOfPon/lE9+nJtzku1qNjmzC7Ua/1vskGHw6BjAoPkhLAJtlVPzD6D6zMACVhkfaq05xOQ60KNYQKM4u52fuRfL8b224lTlldT7vLZdNET93Hs24Y47+I5HweVaStBusm1/PDKG7ed5BVemjzRmWS9bdMxZTsVqJf+OLS3olewUmDecpUkELkzp/dxRTOvz53LvqELZyVb1Rm1FXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHb9n8erM/du0S3JrD9VAKyW1szc9kw2Ltu9mq2vldw=;
 b=mRlrVdIvz/SDrsDS9zTxjMuO+7UhYg9Zqbo2Cv5xPFBWAc+AprAdl0jn5JahwSg6ZMe/EmxyaEzhg3kpqd3vC8kNymyAm6B1z1FsLAIhdln92KHOR+kQtUksyeKKzv6k7Pvn56Qb1Itf4l9iN4mNST+wvuDDXlkwXMu+j+0SpPQ0i1srXjZeKH7ngu2SO2t+UDeQYLThQ+24JL7vyaNpZoJRFKqDnVyDnTA4EjuROTsmbRZ1N8mLGL7F8J9jbnEiK2jKkEvM8VYWELvkeP265Agzu05Iel7e8Z+Nvho0BRSGepKRSsNjCHiPuYdSFC6hu8jH8KRFz0O5VbRLtH7ZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=monom.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHb9n8erM/du0S3JrD9VAKyW1szc9kw2Ltu9mq2vldw=;
 b=D6fq7mE3qt5xm//kSpcpwqGJ6BRs7q1yUN9cX27utL9cGkVS3py1+FntpJXudS3QvoQIq0GcofVdTLsiEp/mGsmGqh2WEouUP5ExYLuLlpxVotft79ravhSJQlBqSt3/q5ZZJav/41xktDIuRNiYHWFC//2jOymYolkgu6mHsss=
Received: from DB6PR0301CA0039.eurprd03.prod.outlook.com (2603:10a6:4:3e::49)
 by DB8PR10MB2716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:aa::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 2 Jul
 2021 10:16:41 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::b) by DB6PR0301CA0039.outlook.office365.com
 (2603:10a6:4:3e::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Fri, 2 Jul 2021 10:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 10:16:40 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.14; Fri, 2 Jul
 2021 12:16:25 +0200
Received: from SI-MBX2014.de.bosch.com (10.3.230.137) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.14; Fri, 2 Jul 2021 12:16:25 +0200
Received: from SI-MBX2015.de.bosch.com (10.3.230.138) by
 SI-MBX2014.de.bosch.com (10.3.230.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.14; Fri, 2 Jul 2021 12:16:24 +0200
Received: from SI-MBX2015.de.bosch.com ([fe80::f028:9fbd:9f44:9bd]) by
 SI-MBX2015.de.bosch.com ([fe80::f028:9fbd:9f44:9bd%5]) with mapi id
 15.01.2176.014; Fri, 2 Jul 2021 12:16:24 +0200
From: "Athimoolam Rajkumar (XC-CI1/ECP1)" <Rajkumar.A2@in.bosch.com>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: multiple APN contexts activation failure
Thread-Topic: multiple APN contexts activation failure
Thread-Index: Addo+CgUnfaWBia7QTyQ0+MK4aLzGwGD8JkAAAgoXgA=
Date: Fri, 2 Jul 2021 10:16:24 +0000
Message-ID: <514b0b8a2acd48c8b1df03436ce2ceca@in.bosch.com>
References: <d718d3f0a1914197944ab05cc43a3b90@in.bosch.com>
 <20210702080302.aw432py4fycmitld@beryllium.lan>
In-Reply-To: <20210702080302.aw432py4fycmitld@beryllium.lan>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.34.199.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13de16db-018a-4107-b877-08d93d427c1d
X-MS-TrafficTypeDiagnostic: DB8PR10MB2716:
X-Microsoft-Antispam-PRVS:
	<DB8PR10MB27162E98DB271867178EB6428D1F9@DB8PR10MB2716.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HfX4gwW7LbRlK+nddBYD49NpBM6Y1OiDiAKFmR5QN+JU2nIslTzAFXX/p7Aio/9mR0nASxp1yBYOu6D2QNi3jk+JfWeFf9eCT9P97Q14M5rcO8xrPgNMO1HWwqSwGJEWeLL/HWBTBg64w8GZIww0eMAfoKkZgkb0GjSyZXu3muxrXTPfpeS6IdBGnWDOBIZu+V69VwqO/dNzUPU1OdQju4/f1Y+iBUyQKh48A0siPSKvShNbmrO0g7M+1eO/Dr4cEkTtJ789fsFozMKEf6dXL8TlMKQy1LDcNzitPrf2BbshjAF4jhIL4r7u0e8Mh7nfogjPlrLyLOfjC2w1KGMnwkUDcibjS93pdXnzrUWDaFzLfeVz0W6E8U9P8Ov5w1TSfSjfRbrVz5M64l5tPytCwzf6i2JScKLON9Y3mY4H7ZLYQyFjitXlobV/k3fgJCE9E016wLopFVmXlsup3sbuTVk5Xc+10SJ5+/aC37baeeFNQougS+NuTSwHjPKihBT5FgnxjZDFSwo13hRo6oAxKxatVtER3/fwqjfMDlltP7KVnWNB5e5ihlKhw+SdXTtNU5GIV7oGRBJkq3qQSgoAYn3seUn7ks21PN2Vl4HvOgOhmfCToxV4RZZWV3rEWPGlHGCqmYZ+bPDZNSr+N7dX43AduJjzCQ+KuHfH2RHCAnc2NvJuL0jaMoLZCNAxP8EDgcs04kOM3v2FPoIt9Y1w85xRqmgP1o1SGNBbDAMINWk=
X-Forefront-Antispam-Report:
	CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(316002)(2906002)(86362001)(70586007)(4326008)(36860700001)(47076005)(81166007)(108616005)(70206006)(24736004)(8676002)(356005)(5660300002)(82740400003)(186003)(478600001)(82310400003)(4744005)(2616005)(336012)(26005)(6916009)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 10:16:40.6065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13de16db-018a-4107-b877-08d93d427c1d
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2716

Hi Daniel,

> It's been a while since I looked at the ofono plugin, but this sounds lik=
e a bug to
> me. I didn't see any special logic in the plugin from a quick glance. The=
 plugin
> should expose per context a new network object which is independent from =
the
> core's perspective.
>=20
> Hmm, what are you main.conf settings? Do you happen to do have
>=20
>   SingleConnectedTechnology =3D true
>=20
> set?

SingleConnectedTechnology is set to False in main.conf.
I don't see a problem with ofono plugin as like you explained, new network =
object is created per context.
All the network object belongs to same modem device and hence while connect=
ing to second APN/network the previous one is disconnected via call to __co=
nnman_device_disconnect(network->device);

May be separate setting needed to allow multiple networks of same device to=
 be connected at the same time=20


Regards,
Raj
