Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90079.outbound.protection.outlook.com [40.107.9.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC5168
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 10:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROmQCQGDMia2OZqHAzVJhzulEFNyTpxSlbvZs0I5W/JT4YOVwA1dweLZy5fbBjglbkBSYxV+yoqcYJ1RHVIuekHAiwaA6FK44uRywljGDmS2NiUCvYvP07yZ51/6U+qH/d2aZQIwIuaU3eVy4IExlCxoglrXZJEF2Y68umIl7g7EJHe43fkFffxiu+2MTFVxB+1PVc5PQfTH+nme7qBrpuYzFzU8001vjWCj2cUuICd0LphEAPbgg9GksRRJUcM+8xj78H0VyneUkJpi25Bp/WDpbWcIZHq304ADOmPRFdeovaI3qbmKBfefxUrt+Dx4Xg5w47wLn6woDvF7kFWexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRmlbnmXGrb+Gka1F+iUOWF6bNOBUdt4kHyI79XF6KI=;
 b=VSwZmJfvtlZU2YoxoRDhZoP8+uDYmZNUCtE4flwX8/F3YWNV8uwtcK674kF6w50d49Dhd4iHirUcVIyTRy6X2TTtFREczHESgIj0CBOi6i1L547qG2tP4bqlcBXw13shKqfCgF4a50tTR3fHk5L2DqBh7JLEAO2xMEeN+W3oAGGlI05JMa9nsrmn1T/L1O16Uv5wcuY4l9lLPmRnfEX4faL0MBPKw+Ci8MsfLAohpWTgrawlJxJOgMMp/KsmRn+JQTsolnE1cVLN7tvfjzAm6Gie0Pce7ZpUk1twc4+t4G99TGiECnKPkT9Nbtrp0+zRghjZ8YrVWl+QPJsrIvDcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRmlbnmXGrb+Gka1F+iUOWF6bNOBUdt4kHyI79XF6KI=;
 b=ZMzSOpIMZEgtQb0uGgNG6aWRaWbdA9FH0BqhuAOQ55hwQRumgj1KnIlCIYn43T4KOrXp+1c1E35xSJQ+cGk4oO/7gsR26W73Hjf04UIGVTRvEnA9wWq8Un7hWOt0FxmQ+jS5rOb6DZwzioi7QpSAX18A96IQ1g/h6K9BtZz27H4=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB1727.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:193::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Tue, 25 Jan 2022 10:43:22 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 10:43:22 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH v2] iwd: Always disconnect connection completely
Thread-Topic: [PATCH v2] iwd: Always disconnect connection completely
Thread-Index: AQHYEP/731R9+FXajUGI5zk313sJNKxx3h9IgAGhxwCAAAOvMg==
Date: Tue, 25 Jan 2022 10:43:22 +0000
Message-ID:
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
In-Reply-To: <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: df2c3dcf-14f0-f647-6482-ef3bbc1588c8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4369a1f4-eca9-4bb6-d464-08d9dfef8221
x-ms-traffictypediagnostic: PR1P264MB1727:EE_
x-microsoft-antispam-prvs:
 <PR1P264MB17273B757ED64D8672696DE8935F9@PR1P264MB1727.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G1gPMYn1KBQkkyuHo+wRdOnpMEMSWH6oyIj2L4x57g/kbcZgZhjKD0OfqER9KolVpkUSA0/jgBx6pxe8g1HijP0Tqe/bjukrHMlNEzLLprCSV+06/Gl8tvGy+mTSLdX8G3IXV+izqdporYeLdZM4/BKuD2+qZ81YYTmfYqsgYkDJPegEMW+U7XcqeG40qAgFf9IfYC01eKRYbUporEnhEfjKkmKsq8POKLryILLJU6WJlZ1ylzbsEVUfJw2n1IoSH1xUvipmes32QOmr1YSAjGsU7xPk8bINy0QQSh8eQ/8WAD6LWEWvcYgX9BJLcMD+CRjh+YVn1hgZKj+LZL+sZ6nPAwjlf0UCRPvLUXaAGQqxGGLcATjcu6Hzfoqv7Bmh6JA/g6bGcwSKa2ngh0l/IV+UsQFbvbDsExqdwMAM2dSMXblVhQeAN9RMaUDXgRd5/3J93kVaWWbC3EBGTPmzp+dO+FUAi1O93BU/7Ctyfyrs6CNH2ORe7NHXm45F14kwOADHVHfe/xNpyPBnHmPPe3eIGr0sRNyFv3gFZOQJLqVuIuJ17bOy4O4vJb77LzcdqdAjC47ffjf0+5YAdgAqn3MToYTIx1gFn8Dx4NRUh58p4B4dxBkufncAgnOmxkNd5Wd+KcnrqWwyqeysegyL3xg4nUIBqhZcYvK9jAu7yiUQf1sXVEe9+oYaMphL3u23O+q07LsVP0tiEIRo++qTkQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(91956017)(122000001)(4744005)(86362001)(9686003)(38070700005)(71200400001)(2906002)(7696005)(5660300002)(55016003)(66446008)(186003)(66556008)(66476007)(64756008)(66946007)(508600001)(83380400001)(8676002)(6916009)(6506007)(52536014)(8936002)(4326008)(33656002)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GxclyhnTGGwhLTn/wRGqHntoK7z4EBgm5P7DLKFUuumxWp5ieIofjYuLRm?=
 =?iso-8859-1?Q?47YBBAryfR/i6+icC8D7+ig0Ll5XU9fVyvnR5RCrnZgdyuQnVj8QYYYuF7?=
 =?iso-8859-1?Q?CGHdwIp0Ct4AtGDhakx/vHFswAF7kMv/5J7joMLu4QqlFXxjOhyooigfWr?=
 =?iso-8859-1?Q?UmJeCZ/IuHpzfcyQL4bGJ9+y43Pu34GEHA/nQ1DQToyS/2xYr67+k9xvYx?=
 =?iso-8859-1?Q?4THeqbYXqMBJNToejFKWf3WcqgvikXDVtpeFglXRknY4WNF/VysfgSeDSe?=
 =?iso-8859-1?Q?Pnx+5QXrKfr9K+Bi/5matE/0l27X9XtJrsx9xxphkh0eKCjiprtXl6tsQ9?=
 =?iso-8859-1?Q?wTKl9IQI4iHLii4wtbZ09rtknmPPh6eAr8PrU023T8gcx/7wABz9DVCrw6?=
 =?iso-8859-1?Q?9CIh22DT5woCsBXptE6fHbYJyT356cZ2eJRnW9YscU5kG+BHie9l9Lx8jS?=
 =?iso-8859-1?Q?SJD7I2zDqusbS7p1D36fnoRqkf7h5xBZ6WIgbEajwhHjNVg5QJdpt9PS5X?=
 =?iso-8859-1?Q?+hsITHtLOaJFRal2yQdfE4xLd1P9Z1q36Iug67o2wifqEbBiVDJUmnH7kK?=
 =?iso-8859-1?Q?YKjakURvPxGwvukNgNfEWOxSaGqfPxfejVE72G/SeZiAgtfQDDC+d8OspV?=
 =?iso-8859-1?Q?se7zQXbaydgIwkQICNVfFWEiYCh7nXAnVjTjeg1n2ISWz1G3mhItgRS5Gj?=
 =?iso-8859-1?Q?luJqzhgEJwZAQ9KNs7B27c/64tQ54wM1I1uu+YhVbhzy+BuGbWUU+Lc3tN?=
 =?iso-8859-1?Q?RJp93ym2I3IW3DmV+VUCruvViK2fVnFupUfWqhHoYEyeiMMFK4e4gumD2d?=
 =?iso-8859-1?Q?m0lSHGIyi1bQSX+U3X+hkEuTl9w1emw8v2M4VlA0un332fQpSnVRjBNJni?=
 =?iso-8859-1?Q?NulKERVuIbuL9bxDwrpkSN1jcS7UTzx12e5DD/Em1P4zpYFe9VYz4ZscbW?=
 =?iso-8859-1?Q?iIW54qin8p799DNai1fjCdQ1aizkgL8GyqssVKKVJuEu1NPegmTYZv79No?=
 =?iso-8859-1?Q?V3TbaOQO8BY7MiFAbEGJd6nb2WvfIL/mAvZkpcusKi3tquo37eqM5iAxnh?=
 =?iso-8859-1?Q?CMdns5XXIL8PHYNTkM0OgcDtmqYrIXUhLC/+T2ROYlyt5Qbk9KTsqHW0TN?=
 =?iso-8859-1?Q?BDPaCHTk2YggoOLhKde0FNQSf+/Ko3FdBxiyUBCPyollkXNzkam4SBN810?=
 =?iso-8859-1?Q?PaJVmSvd9zaR462hmkd7nsLVSWjtAwv2TkMa3BD2s5zrznh+sLj+kaiGUF?=
 =?iso-8859-1?Q?3Z/YFYH7NcfpPw3GJoENSqsQhY7avUXwf99D1lXSoepEJSsTE96P0SPkSt?=
 =?iso-8859-1?Q?9U5viCK080Xp9hJOGlDH6P957Dp4sVOS+nv1cNl4CYFq5ERoJ1XI5/4L/j?=
 =?iso-8859-1?Q?JS0o6KOiyU66z3U4NI4BmeKqCjIipBWZGLPtzenFHNfrm2FIm3WRIujJPp?=
 =?iso-8859-1?Q?6UBYks0U96zqwM52zia3SsOc6Umceos5JE6iH/0JrxjSdJEsm4fshXvew9?=
 =?iso-8859-1?Q?S2oAl63Yq3O9afNRdJIVzoUxH+BV7ttrIxEoBeJBHlOmCoW7sr5IbqBPYT?=
 =?iso-8859-1?Q?O4XPelrI9leeibtPVwDbYkR/MnXMMC6T23eazUJPAmPv858C7z1uE7cZ15?=
 =?iso-8859-1?Q?5tJR58IVJJh7D8YeOeAovXVy6t/ORaI6WO9rfVrDbkpc8Ni+swtkN3yiza?=
 =?iso-8859-1?Q?kOmfd9yAtW+JrA4Xi7C95b6C/Eylbp6voDUYXf8MWMqByDkBaUnHFZZxUd?=
 =?iso-8859-1?Q?9Ag4HdqnctSyKWj+GwN/WHquQ8MeITyZmwGOj5acixabGOb12LKkZEQEKH?=
 =?iso-8859-1?Q?HnqAgphjIQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4369a1f4-eca9-4bb6-d464-08d9dfef8221
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 10:43:22.2286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I53lqTI1sHMGS/Qy+zCMjCdYUkwKezDkW9VVJp4ggDcTezL42TlxBXxpD08ZyXirlZSsFlMSds46NotThLXLdpdGk7niNR66Tzi1pHqzPsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1727

> I haven't made my mind up yet on this one. The problem I see with this=0A=
> is that we start add glue logic which is hard to follow and I am not=0A=
> sure if this is the right place for it. If you have some more info=0A=
> what's happening I would love to hear.=0A=
Indeed, Daniel it is a tricky subject.=0A=
=0A=
The similar patch has already been applied for wpa_supplicant=0A=
(cf commits referenced in the commit message), after a long discussion=0A=
if I remember well.=0A=
It is still necessary to manage the transitions between 3 known Wifi networ=
ks:=0A=
 - formerly connected,=0A=
 - currently connected,=0A=
 - to be connected.=0A=
In this case, they are 2 disconnections to take into account:=0A=
 - of the currently connected=0A=
 - of the formerly connected,  auto-connecting at the disconnection of=0A=
the currently connected.=0A=
=0A=
In fact, I was waiting for the integration of this patch to provide another=
=0A=
major one, managing the networks removal on iwd.=0A=
Do you prefer I provide this one first?=0A=
=0A=
Best Regards=0A=
=0A=
Emmanuel=
