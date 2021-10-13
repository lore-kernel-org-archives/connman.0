Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C72C81
	for <connman@lists.linux.dev>; Wed, 13 Oct 2021 22:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXD7veLyQY5J3g09oynhjxeA93gE2zVInwq/8gMG8CSib9J5rZSqN/jf+uswBqf+WowcIn4c0OKJXuweIgsLUV5hp+PVdQ8pJWIWBfgeSjza02PpTxtNoUiV+Omqa3hTFRWM5KunRy9dF0dak8Z+K54E44JDlx2qJhNSyMO+M93Y+v6G9WbLBYhWZxbai/3dDVoy1lgP7RIGRmFEiJbK0k7HOM4pxJJUyiKB4hHaWdjkd4aJMx4DuottgngGwVnZenjcQyUOv0CHFioNf0TsqpwRGwluyUzmVmOfsotpP7rhkAn96leBz3oqXm1xCYZQ0+vjNabcGOyJYuN5YLQ9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqOQgeh4HORyTV7tPG5W0NSxg3IxhmEfnO3qDJOXhbo=;
 b=L5iaraVpJOVtH2mQc6fVPncnSrcocPxv2z02Vm6XvMT3B0zIJQse+tTUIRTyZHla23qr/RAf0zKvRprsgvzDG/yGMjTH00DDrpKxh6eXR+S6bcge8t1vq+wTAh/BFGbBZTyXHpGNVqZG7sEuM02gswA5F0tU0Hh5WnHPhEqxem/8GOAbdJSGulZ6C46so6JDShqR1o1lSYBcN8jwwuy4QhXrjcLe+zUSVHJdG8LBxk7AZD7dfebQyMmFLxxshQUl3W9zD5LGFXqZYYggLOfbjGuNshl+ItIsTPCVTEx02qv0t7KyX6gsBFTeCAzl1qBtNE11Py+PCJZLa43x7AnNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqOQgeh4HORyTV7tPG5W0NSxg3IxhmEfnO3qDJOXhbo=;
 b=jx8oj5FHEoGQzUR2QUkFBg0OeNAT0+dgsE9RHiYBDTJvIcboLoiZvVotRjfiz1N+vliWIkm43z24KMdlLnwNgaPzc4RNfrcjW8aqXIJzJO9vuVNErpCMR46MB/ePY9O3a5CCD5MXK2HRl7rxjquMkNX07rUHN8NB9/EblZlf0DSkEpjZC/fHqOZZexQh3bz6hRRSiCLUBVz/kFUlQu7+QlZDTFxUDJs4+9BfnP2RoS+178B9dWuVACkRCLwbyKLiCtHGLl7O7dYkrMfdevxDUhkUbGq1E11yYLGrRx8OP+vWLtOH1H1HcoPmTZahBStmYsbTeTAt3LK0zT9j1PCiRA==
From: Thomas Green <TGreen2@Sorenson.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: origin of the settings file
Thread-Topic: origin of the settings file
Thread-Index: AQHXwIHSpj+zfHJTxkCCSCnWnTvlgQ==
Date: Wed, 13 Oct 2021 22:33:39 +0000
Message-ID:
 <DM6PR04MB7003B851E2E4CD0BEDAAA5BE9FB79@DM6PR04MB7003.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 1914b546-0227-d4a9-f47d-3683de29c545
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3365cce-4694-41cb-8753-08d98e998119
x-ms-traffictypediagnostic: DM5PR04MB0410:
x-microsoft-antispam-prvs:
 <DM5PR04MB041041C44A489C140AFC93EC9FB79@DM5PR04MB0410.namprd04.prod.outlook.com>
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7003.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(33656002)(76116006)(26005)(91956017)(4744005)(186003)(8936002)(2906002)(52536014)(42186006)(66946007)(8676002)(6916009)(38070700005)(64756008)(66446008)(66556008)(5660300002)(9686003)(86362001)(508600001)(71200400001)(66476007)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Mik+COdlpGS3ncu5/59ltY0YYLhXEzfwmZ22ZA0Bde1yr2Xs+27N61q2YtdooXhgbapOEM00iM3DF47QYk8DZiucPpaB4lXatDiwDTvYREnwTu4yw0TobZXPmNYy687KA+q/EupXMU2qh2HF+l4FW1uc6uJzEpSoPQPm+5DaAlFFcjkdu9ZZTlhNEczbLlhZmcsqAMXPwLGPaaN2UT4FCyUx+qNNTY3b+3odxl5WvDUbxoqzaYz56PFHvfu4oJr7HMeE+wy6gKY8EKvxPUDi+rpeVb3CDWWUIgWE+n97A3UdZDMKnyfTzJQChVmr+rv0yTAXsMy3n6g59xh83V35liVyuGCfOjYhYW1XsQGjMCQpQnnUXqGyeCcB8Re0/rgyXOsnwcquWo+G6N28BgEhvZLW2K20s0gIwDcgRL+TT4s8mINGoTz1rUx70GhPp4cuKOGSHSwLIYMziHcqaGlFQRwW/pDJNc1IMndSvJzOEX359WjEv8GgoKeiQFJnviowKhBGrFTEseZKCVbaBTxqabNgD/rYVsJl+BAFdNrR8XAi8wu32qkXWQ6uP2ushCwQlSuQ1PjCDilnyY/KJnAk7OgJvNcuqwufmR0vtCDONEgMPYjsjTnQU2T9blgiUxW2zgkwyYwDA3b6a0Dc/3tPWDQjSJ9lfnJ9l3tx2y1NrlGhyYFb/unveOxmGyhmGR+e1PE5V21mSTn+I9iJ0bvK7w==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?M1tBnvsaPp8QIBZiF8855u/G+8Rzwy/vdxvumV0JdFIXbAfGJl3mP16rh/?=
 =?iso-8859-1?Q?f/pp6nOrKrnrLe+JOhWT2XwkZW16GQk+5Pg69Gu4MgvFm7gWGalIVx19HH?=
 =?iso-8859-1?Q?Yd+XsNT9vl6exJGHegtnaDtfc59WEP41hOMiKMVy3Ov4u7MI/DhSnsqsvv?=
 =?iso-8859-1?Q?48n5N1VxDpTPkvK+ThXZYRY2qztE1etUUdSGIP8USWAchWzgDjsps6EvU1?=
 =?iso-8859-1?Q?TeU9A2saVTFnuzJ/xoYlPytRbEZVrRy+mOS8whn3uabYbDRA2lwkZnh8Ms?=
 =?iso-8859-1?Q?HEXxz2iNbrs0X+upovDgdxZw/7/qJq+fMiosclImIRdTxMwdNntKnhnD1A?=
 =?iso-8859-1?Q?UYX+jVsrpgDwGLLt209IvlrpD9zDx3zbnLjCtfKgsW/VnreZ1/twO3wTbo?=
 =?iso-8859-1?Q?ZuuMZE76wEtU/yDgAn1TybWkw8Bk1yeSYV5UCtbTYqVlzXCN/GiNa2eydI?=
 =?iso-8859-1?Q?B+0SSY9obIT48gi+hIiGI1akhLPyxovWKuf4UHa0pTEEHD0VJatIre3LUO?=
 =?iso-8859-1?Q?Oo2BSGXb3mGoYSu6+2olUu3XkMZPCmN7aoUKhmOokfm34aoCf9kNX8ov8Z?=
 =?iso-8859-1?Q?Lws5QLw43zsXYcIm0RP2cU2uZiP8rTrChgWDJDIFeqiPTG15DmxG+6TlZa?=
 =?iso-8859-1?Q?QL1YrYA8tVCUnN5VaIL5wyti+mI14/FC5ORxA/5ku2f2A4QyYmpFoPKwM+?=
 =?iso-8859-1?Q?dd1QJJU3DyrL0thAgz1POn6F4uZlGSg8iBYchkGEwMTAmW/vnTH4WnNNWq?=
 =?iso-8859-1?Q?wSB0giHGG2lcNnFTezJrcQ/eXI9Z0BG9fuH/7bMZhoQFDhrLohKyoE9g9B?=
 =?iso-8859-1?Q?FMyQfm0E4bTMN6RQpo+tvYhiCL01W8ehzKRWNEQrN3WeBAqHg+bmrXL5bK?=
 =?iso-8859-1?Q?bzAp/jx/e+A7GVDsKNum1Oo21v3CdAC4JxhWmKnQsF9Al7YZaOW/9s/bVz?=
 =?iso-8859-1?Q?t0VpKUkUvCDx8AMJzJ9n8rSyihUN3RvCDfsbMoTA/LnYF2XY1fZaJ+/0om?=
 =?iso-8859-1?Q?196yd5jV7ItqbGbgZ1bKGI1LPCh0nrwRqADjuzH6WvBgBWsDbjzdBj9y3H?=
 =?iso-8859-1?Q?Pj8kYdWdLFhvp3oI7fEOYi4Eaw3oN0JWfRfJ2gv3rnTIzFDkjRuDqpluXA?=
 =?iso-8859-1?Q?V0EsVKFUkOXXdyCAJpcpXT2Ndn0ESWnWb4OWPq27zOBAdJxl/22Kmv88c1?=
 =?iso-8859-1?Q?OMAmVE0hHulSRXjBT3cfIm6i5r5ntjsDMDvDJ2qNmke1tbhxqWS3K801X4?=
 =?iso-8859-1?Q?c0z7YfSvmpCxkfbn2kP2FfoyGqBK9/66nuCBBtsdZWty0yz7b3RGmtP4MQ?=
 =?iso-8859-1?Q?iy1DEomsNvbL37hkEGICSuA620h+vM0e/2iiRsHMBybPXds=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3365cce-4694-41cb-8753-08d98e998119
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 22:33:39.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug12dKxT4sVmAPpHJlD8jOtpGMn0uPy22UNamEm8BnOKsTPzUEkroe669xjOr+xhCamiZAUojTVdXOkt9u7B4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0410

I'm looking at the file ${LIBDIR}/connman/settings, and trying to figure ou=
t where it is coming from.=A0 I look in the recipe and don't see it, and in=
 the install portion of the .bb file, and don't see it.=A0 Where does it co=
me from, when is it created, and how do I make it default to Enable=3Dtrue?=
=0A=
=0A=
Thanks=0A=
Tom=
