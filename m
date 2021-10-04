Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC73FE6
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 19:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMjyR+E5j7qK5CZhavBgDPBSeUMdhdDOF+1/qVbkikff1xNvzM3n25KDBxl9MdFOIhjguH3mqTPnF+t9fiRzfWH0rOz1UYY7mdbqu5xEyiGwJDv/vjIkn5ZUDtlMjAAbhZK+x8si5z4mmN8msrnSv0mzPVErCNAkW5NmzIB7fQMoSOvZs48Y8VPfdUbRXUFWCNWOSX454IZCGy/o9MTUqcLFHaE3qxwYtYLJJc7czYfzMUSCaf4Y8cZEOytietYaRgIo6l5VCqaiG7ixgeGZ88jFGbTLRTp7cT9vbOxCm8Ff5plRJCIFFcCmvNL8IoMmqmGcAK/wmuVnC4NvezJALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=He69erPWQYUiFffBRSZJELKPzpt/2VRGWcUZWKKXN0s=;
 b=duYyc4TxLqpiGQqpQJRWHAGjrYX6VDQRkpYe5gAkt7UyrQUaAAhLJpgwabMDtBPBz//qYTqTxhlNE2V96Z4qG5ZfkzAH9oLe2iIHUaMRpfvr71abfQ7ENoqD2Kx+L/7dkR9Va3SufOmw4JfQ3m6MLoVzwIkR5maxRAZyx8SZyC/Cx4gNV7d20Vme197FZZXm8+EmlKNQJVKMvq0D8HRz8VOAiBngdCKLhDPdecnK+RLMwil2gneWupfRc/wxMcFQ2nlC/FbDRSMv1WIEASGnBnls1eK6xFO96WMp+5eDfb1zGQvTm4LNRb+ioXnmVVvEX7YdRrmwHtJl74ectdhacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=He69erPWQYUiFffBRSZJELKPzpt/2VRGWcUZWKKXN0s=;
 b=QqvWpLILLVqGsd8I2GF354RLEQ895ZVdcgbHUKtT+w0wn4wID/Kwo8GIb/foqR5xJlP48uaHZt6rnE3gKi0assreotKP9dPQc2qN/nmQXfhlTU8fIsL5RFjWpAJQwKtjOJNbghw8vU8XGmLvuGLw0fjh7FBLfVZCfhL7etfyW5ozy+zaNh0ylv+mOE3F4ptb/uDxmK1BSnppgaakGtinjpl/A1283xZbHOPeyEtJmziZCX2O99NrXYy95FOt5uGmD9nMpDooUV/8cKQofIudG9h+hDem7bk4DrcG/O9HiRSVc7ltpa+bLRu5iQlDiSD8ZNA1J3hXlE46Ci3tvUohdQ==
From: Thomas Green <TGreen2@Sorenson.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Removing old service directories
Thread-Topic: Removing old service directories
Thread-Index: Ade5WQam3u0k8Z6ISO2Ff9MvCRAmkQ==
Date: Mon, 4 Oct 2021 19:50:11 +0000
Message-ID:
 <DM6PR04MB700338BA0F2EBF84D07EF5759FAE9@DM6PR04MB7003.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07a3d241-a39b-45bb-fab3-08d987702d84
x-ms-traffictypediagnostic: DM5PR04MB0972:
x-microsoft-antispam-prvs:
 <DM5PR04MB0972163F157C380C67DD9CA69FAE9@DM5PR04MB0972.namprd04.prod.outlook.com>
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7003.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(316002)(71200400001)(5660300002)(6916009)(38100700002)(2906002)(4744005)(122000001)(42186006)(3480700007)(186003)(33656002)(8936002)(83380400001)(9686003)(26005)(52536014)(66946007)(66446008)(66556008)(508600001)(86362001)(76116006)(64756008)(8676002)(66476007);DIR:OUT;SFP:1101;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 krhwP6xUkqd9oLb487RTtwKhJwWigViNFf0YyOLY1smdz7JE+bkf0zaiw7soTnizFzYBzvBPyeW0aLiGJH0WULRRMXcHcqCPYqmKEGoey0FSFfbMAuLf0ccZpSXOcrGenoHeEjp4glxF8qr/hKsKLS9FE/saX/Jtnec98eCWS3g28c4KXjlGj3jPXa81gHO+gbEWt3Ip/BDSwg2M4Skq4LLLy/w+jW4lDgbR0z2U1aEzLsuSkHk+aD69npOUAtYfNyx/lHX29tuyIgsnwh+ENrdnauzunctrigdTWUrLSvgQbNu5g3RpWUfX/WLB6Zt4QRxj8uSEn2JvkxxuQovACE2p58AfFgBfkLtImxd19vGEbwoQF+AdhIhRSB2HxXHNKcMF2yjCTxv8TbO/h3VpYC2bLSSnNywSFq4WEfm6vV+/zBkKRGL7cGFBU5aobesH7hPjz90U16OMIgVrqeFXjPIIbfXh/oHVp6EjkCUFNak/l6/JD7bvySyqvGpqsc/XahdoddKLgIleM112nbtonpAs/r9XVUqZ/jIj9bfoAVRrgngwupPIhnlKodS7MYlozLHZ2jZI3aqCCsQhRvChT8GTw+3dxpZOr/XE7OWtg4XSsrzaL5aIeKoGdpzie6O94WGgEVS0/Wk/vucvhLWSsIAMNQVz7KH20Xkv36E/kzB6YcFIboGL48Vu1grnT2rx4vJU2/EWg0NypDZafwYKag==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4wFM5V354l65yqVJhkZZb20c+2unTjNYL7xWGHdL4g38eGaUomtzllKrudSv?=
 =?us-ascii?Q?azB/hYAJ1ztQO/QzXL6s1+EjKLxzPmIkSYvjjAcqs7r45E0rCVWCTjYX1lMP?=
 =?us-ascii?Q?+HO/0w8WlOod30Oydaxwu6hkNzQ9vaKqQHYggkK/1j7YefOJzbLaxMQ/37ws?=
 =?us-ascii?Q?KBtnueX+ZEHaKbNUjrbr9jfjR3/yk52IzSO4SibJbLWjdqRG5e00+N3oXQCF?=
 =?us-ascii?Q?SH1y6RE3t7xzeOmbsfEP3RKq10ZqI7az0DHGHipSe8Q9jmXIEfmh2oFS4aCm?=
 =?us-ascii?Q?ynFf6s4DcnkisdBGVuIUmU5HXEByDuhmbii46GZ0uGRg/mjkl2kY6t7RjlW1?=
 =?us-ascii?Q?YKLObFeyEjOExWid35c1GtVZSD04JxnWvPbaInNd7uNijEEItJKG4ev2JE2s?=
 =?us-ascii?Q?erPYC0rOmjYq63DdwgTeXMFSBOCGhXEfOqAn0QovbWk14Jbjx7anu91+8Kh2?=
 =?us-ascii?Q?QMPWpm7UKnp5sdYbgQhodu+2BTegGvdiUDyXvx7gX1h9kHJeh6TsECV63o6y?=
 =?us-ascii?Q?ENBayj9eGSImWDKy2gqZt6whRdGFNsZ5Vbv0CbyhPd8XjZtYs1UFIZ3FM88g?=
 =?us-ascii?Q?3JjPChnf+yTP3KNhJJIRl3o5TshRVhtyKorgbYZfzS1BbnnG9VfloLMpi1zR?=
 =?us-ascii?Q?K4LfcUcB4ca2dkH3TGEE4YYwRzAeFwF3P0VfxeQNjjjFW/leXatuJpFMrOpU?=
 =?us-ascii?Q?hsEr4jn6hHzrg60XagimM4Ti4MfiiNxYio1zsOMs12fP5nzn4Enj2lZgq1NE?=
 =?us-ascii?Q?es4mp4WXTn5vpgxhJ8xrLm1i+BeH3uhSFky5CJ9hvyUfPqc7eIBdeonj6LQ9?=
 =?us-ascii?Q?3baPXp5xRbKFmFGaWUnO5XxhuW0kbLPIdBMgURaF1HEZsccfWoluz2I6Oytg?=
 =?us-ascii?Q?bMNPmSeYVExzkn+vCHvc1DH6P5ljDMpXL1Yz+BCs0unsAS8RVOhelCkfOPEC?=
 =?us-ascii?Q?jPYF73IZpddvS/7YxJIgp07PLAGA1r14HjN4xHKAdIdnI7fw9ObURACIYIUC?=
 =?us-ascii?Q?R4W/1KS+xwNI/Amd7QUi3OJn7ayL7Ik11DeGUQ8In0UKdQomFJg50QUvciYa?=
 =?us-ascii?Q?TThYNzkCgV8nMA0SC74rorGS3ed3mAfsskwb8mfMDOUGAXm3DtV17J56wo+W?=
 =?us-ascii?Q?5lEPkxTum/I8QaOpMyDiDp1cIWD8aoePlRUeZoyQfDdrS3uuvUBe+iGJFa/D?=
 =?us-ascii?Q?aF4w3gbWR7UyX88Svn/M/rc2u9lls4pyp87Iz5DQ/+3/6OkbLjzsjCTfy/ce?=
 =?us-ascii?Q?+79pO6Gbg7MHRmXvtSpuoGQms6rR1BSufcoBmFAq9lgqmsHlVDnF1pi7fsFv?=
 =?us-ascii?Q?fCnsBAHDOccymhH7LALrbXOL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7003.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a3d241-a39b-45bb-fab3-08d987702d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 19:50:11.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2z60lpmQWrxqexDtRZB329TQQl+g3v+Rsdx/7ZxkeubJUPBs7baIAs7R+evaCKlvdDkslb42EtB8lRQE8EvYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0972

In connman I would like to be able to get a list of all wireless services t=
hat have been previously connected, whether or not they are currently in ra=
nge, and be able to optionally remove or 'forget' that service.  I've tried=
 to manually remove the the directory /var/lib/connman/wifi_xxxxxxxx but wh=
en I shutdown and restart my system, that service and related information h=
as been restored.  How, at this point can I do this?

Tom
