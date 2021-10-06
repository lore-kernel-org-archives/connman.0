Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90081.outbound.protection.outlook.com [40.107.9.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374422C87
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 13:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm+5tNtbctqR+vh+9OtyPhzHC+xvAB8BIGj+Nd6lLOUgHfcLL8l55uRUnxMGPCS3lmhledtzYh8ptBSR1CeWUC2UFOtUFdpmsc3vI9VuxvtX/lwHRSI/p3dsokzRZr2KylOcGSGEZKnGRUR2T/MDWDWLGgnKDF63JpDwh594v8l7HCGe0zcPzrWHDNF4+AZSgms31ZCk44WJdOFw7vPTiBsPukBrXOzKztdMGD9u7qmVjUruhzQSql3dnLkeZECsV+4y7nqKoJHyvY1pWx9qY2vRSGa1PXD0/5WHf7Knjc6HbmBKb2oBJnAofk3FdZN+oYNsXl0yEMolpPm2YGrP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bh0tyXTk5aiOv3lsi+gynu0udHUM27NqSSwuyegl4w=;
 b=YXCJOU8877tEyvo326Hsb/mPJ43sdYeaYSWel6LaprI1Yxm/B57r92EaRm6qSwRra0HUkMuEDIAUpwHqVQw3CRgu6FBfIjHcFmouiIGPkiOcphB3Hc1WuSMab2yfg7ZsWoOHI12xp1n2BcNmOBSfbsxrAkMh9EviCqAL+P+o8+yKLlPKNun+fLwq1HJBcROQlnysfipGgdwB/D1Mbc+gxvGmv85GN7V182zql5nQKTISV0/Jzsw5ElpXbnpA5XPLNDwjRGctlDBADnzQnJCke1RQH5kdY4AEgp6jCPUOXRNaF7kbFGNsdC5fT4DdqK16//JwFID9kNOAkf5JfLht4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bh0tyXTk5aiOv3lsi+gynu0udHUM27NqSSwuyegl4w=;
 b=R9q6I5dVlyjxPxfQHLxAJEMxnBSwHRC+ZbOK7x7X5W3pyTSu07W5qPJaxG2z84P+n2dbDI0JF+POWVtpnKVoAo82g2IHrcY4zQBz2S2pcubbhSEvjRcTLrsK5nQmJQ7VQRNlPF6fykjpu/C3NlXYOp+ON8E+YSZz7TD85nMVUCY=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1843.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17; Wed, 6 Oct 2021 13:41:15 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 13:41:14 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Topic: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Index:
 AQHXtti10gxY7PlzJkSp8WEWjZ8UV6vCbhsAgAAYHcyAA19PgIAAAnbngAANlICAAAMAMg==
Date: Wed, 6 Oct 2021 13:41:14 +0000
Message-ID:
 <MRZP264MB15443D07BC2A1B57CFC9155593B09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211004070314.ehj6a5wjkhexu4xb@beryllium.lan>
 <MRZP264MB1544E27898924DAB6CBBF9E793AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211006115927.lfqei7bai5slvyup@carbon.fritz.box>
 <MRZP264MB154456BC4444DD80E9F399BE93B09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211006125651.tgnfrbqh4fjgyuku@carbon.fritz.box>
In-Reply-To: <20211006125651.tgnfrbqh4fjgyuku@carbon.fritz.box>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: e4010f15-0677-6bbf-3f3f-01e360019530
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1943f7f-e002-4db9-8524-08d988cef7b2
x-ms-traffictypediagnostic: MR1P264MB1843:
x-microsoft-antispam-prvs:
 <MR1P264MB1843292169290B678D66FA1C93B09@MR1P264MB1843.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jhkcjQPP2lPna2N7PJohoBAvupLwjNcoEPLn/l5gQeAxni+qJbX/wJVAHUDfnVQC5ZkCZ9eOoSTyk9iiPRm6J+gW7ONO0x0MGbTbAhXEC84b/KHMnSJqU7UrTiZad8L/FSTFxDVPf0cvqKtefLJ0eHaMhq51F/8L7xkF6saBALBHWL7fccAfaARr+NhZDBLPCGM0BKI0zKD2+DZbtVEiCoKt9LzrUyLtCbGEWB/TGtQvn1mWBNNjPxNP4byqMozj3dhgtq21rqwG63MKmpZvA9lglJnIySBLZmNgpxHaVMRpmRuN5Xl7BAl0Xt8eXx3bhzc5m1GAXqlzxLVDoyaWrkya8XP+VSBlggAh8HbPlL84XrhOgpe1yOyD+00bJGd4jXIchnRx4XYXqnd1HTPfbf8W+XD/dvtAfgPA3Osy1jouyaYZ8dRBpvHaCaALc9skmglp6rzHBFeBcK0lIu0BRrsEDHyd7qfTzq9Q4aBIuPEoLPM7e8IsVe0+XGUI0G8ivIUqWeiDfkdmeJfif6jqm8ugUf4dEJ7R3IDW+MK/LDLAKogQYIVLg+9QulNtP6eTY3fvrxxtJ950NzSUPCrz/bwNyKvmyGIzIYQyAUTBMvfslymNplPNB/FxOCkk8U6lYVZN3G0ULbCpD6ou+nmPk/DysnUgbmMORnSVmBeYzNRStmrsoF84Es38aumTzvag8mC0o80dpT3gSPP2aYECzQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(8936002)(91956017)(66446008)(66946007)(33656002)(6916009)(508600001)(2906002)(64756008)(55016002)(4326008)(6506007)(66476007)(4744005)(122000001)(26005)(52536014)(71200400001)(7696005)(38100700002)(66556008)(316002)(8676002)(186003)(9686003)(86362001)(38070700005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+NahgvWJKNpHHkIEybgzU27hxR7MQfP2KdaTmLr2Ey1SUQZCw5iRA80ET9?=
 =?iso-8859-1?Q?4xqP3JJMAFAVZJEx0/QxR2aY9cpgmw7+WX+lARcV4gmbi2sA1VYxnCEa+S?=
 =?iso-8859-1?Q?uRmY3KM9xKklrz07RxUhd5WljY2lqSNiplsKWkyAt9hMfkdFcTHu+lG3Ks?=
 =?iso-8859-1?Q?UAcyzFFRxYtSoe3EUqw1Dl3XQ+SuEdJrq56YfFcXKiLdoFrDJ1N2vxHshe?=
 =?iso-8859-1?Q?u1jM7XiNK3J3jDXfmJ5O+SxGJOb1coU4K21CvBr847oNi4LjoWj69VrPgP?=
 =?iso-8859-1?Q?Cy0fgktsV468lS+5IH6ZKwTjhD7ipJHSz+mAzrzk8+l8iejJIpx8bWhcu3?=
 =?iso-8859-1?Q?HSTnxOZqYvD+T4qN1JIEBPy+vglepIXb2tlC0RIGRGax4AwfJAJUr4pRNs?=
 =?iso-8859-1?Q?RS+qdhQQSxxyTfWXdBpugX7FioGZ5ED8DBUEgxJSUNUehkPxAxMqc/0b0p?=
 =?iso-8859-1?Q?PUeqJRwMDxsW1VSe2mB0BhleoZfMNjZNPhei7gWBoJik3lWRDwLnc+Glg6?=
 =?iso-8859-1?Q?baM/VVqBRC5x0NZobMAqx/ns+nw9okTVtnt86mNVca3OYoAveVyQAyhUBC?=
 =?iso-8859-1?Q?yQfLiVPJBJb9ZAQnVKM8fs7k9Go1Y6cBKyS0UMZ6maniFu+FOJloN5fAPD?=
 =?iso-8859-1?Q?HPZoY8C0jXh4iRTLnCi+msCxPf/nGaKnNWfJKPHVsh/nOSaJaT51ZW6Gjv?=
 =?iso-8859-1?Q?SpjTQZ+fLVn1fifD7hRXjXchRBfYV04pdaxh3yeHGdpBj7eFh1XrTjBxg7?=
 =?iso-8859-1?Q?CfGgNe7sca3i7aSwNwGQB0nmYQHCH5Nx0H2pFUc3iipY7LplNchrlOHj6Z?=
 =?iso-8859-1?Q?ZvNFrcuK/svGV5EzjmGTgCzQUEU6zoIPJ7vDSJ+1Pa0kytaVQed/sPJ+KH?=
 =?iso-8859-1?Q?At2xicyhTpbzufRA960fRIcZY3B+sIGN7Pkco5aMpBzi+WAFK8GajrGQd8?=
 =?iso-8859-1?Q?Xp9kC3jMPF+qsgCkDS+ATnZJU0d3f9CavQ2ohp4q4deRIl7MxCbQmbjkF9?=
 =?iso-8859-1?Q?/JkNrfr0aRCPhZeaWibSMlNelfmi+pKDdVcvT783SIjXGP2y6An2YpqpFq?=
 =?iso-8859-1?Q?SAu5bS8U5eHLcpTrhiN6k7imjhbVrp2qgAri1RhuyiLlokXitvTYBgF3jw?=
 =?iso-8859-1?Q?Ofi3uGRJiAnmjF1oh2vKZGSoe498/oRkByjBjSmaEHvp7SnzydSfZHtsxg?=
 =?iso-8859-1?Q?okTVwWAvxfQU7sF885BZIAxcuXblMkdad9/aNbncB4HpsReMkJ/797E0qb?=
 =?iso-8859-1?Q?AGpFpl5FmGpoUc6i/1yHqdr1nOjfr5+rVBdZXW/5CWlRFaNrKSmdDZtwBY?=
 =?iso-8859-1?Q?XJRnVFB4Y1nqxERa4moC4H0ZL4IJJMhMUeMtgCls4TREqV8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e1943f7f-e002-4db9-8524-08d988cef7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 13:41:14.9241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6ozptM+gmMCYYmqToeeV/2xhUprNP+Vi7fnYEVqfGdiFMzItkkytwv/oei4ZLnZ1bXU8hBytytTpXwMS6e4acwPrnxzgaZdIKMSK71y8GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1843

> I would really appreciate if you could send your patches following the=0A=
> normal Linux kernel patch submission work flow. That is send the patch=0A=
> directly with 'git send-email'. git send-email gets the threading etc=0A=
> all right. Please check the kernel docs on how to setup your git=0A=
> environment. Doing so I can pick them directly from the mailing list and=
=0A=
> don't have to manually copy&past stuff around.=0A=
Really? I thought you did not have anymore to copy and paste manually.=0A=
Sorry for the inconvenience!=0A=
Maybe you do not remember, but, unfortunately, my professional e-mail,=0A=
used to generate my git patches, does not allow SMTP, so I can not use=0A=
git send-email with it.=0A=
I will check if I can use a new external e-mail, maybe it will be easier fo=
r=0A=
everyone.=0A=
=0A=
> In this case it would be better to set the pointer to NULL right after=0A=
> the resource is freed.=0A=
I don't think so, the resource is automatically freed by the GDBusDestroyFu=
nction=0A=
argument function.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
=0A=
