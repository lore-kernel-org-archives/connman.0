Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3402C81
	for <connman@lists.linux.dev>; Wed, 13 Oct 2021 22:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAT7WKWQwIj50liVmTzg5fBYAQTpDmXW6PO3QRHtqmTA3TZHooxyZzfx+INSShRXf4V7ixos3WQajmAh5nG7EeFm3cNl+r3d84HTE1ByYmodtYR1Ppxwf19/s/ndJyyJNNAbDXlfoNM3AqilZ3L5aPlz7J4vxRdHyOyTtoU2KVGhYxH6to8xIfb+XSChP4Ij5s49pDeBtRH2bnzv41o+90BY4W/GeGWpiHuhDV2l2GpGC5NHt88p/9bfUu+D7yXe/cxuCD8yNAp3T+Z/2MXVSaa/GvxzmYmgHlTmoL+NEOwiCx3bhV56gg6BueHJIHMIXeB/e3ghmDwvfJ/fpYp+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnxyACZGX+UdRsx0S3EhDIpr1NVQhCf42JjnFWadbsU=;
 b=e733jZ1YlaNK/N5tv9DglU35PW4z5AuzIP5c+nl1hb4uTGy51tC8gBc6YVXaCdUkOlPF/O11tpmYGihfkeVtfQ+14h+vXmnz5dFK+4OGs0R2zk+xmvtAL2q4jaJJ1wc39f7Y7cBrsLQkOH0Efwm1pgaz9431cKFqZ16B3rjFstLievEMncn6c/LRc7LYUfusDcmgGFpVNlqnbfIWikHrbXEL3MSplHYSsgOUFTOm4/mtCpukpc4HijgMt02TelowXxI2nDBJSINple4pqe1eQHGdOlZSJJEfQnHsMnyr0y1wQa8+gFEZm58tJLcmw5jMkOF6TVEswByviHe5GIDCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnxyACZGX+UdRsx0S3EhDIpr1NVQhCf42JjnFWadbsU=;
 b=S7Otkt2HfRkUsUqM0yQ4AKdmIIxv7q2vm8Z7aiv+SLlnAfbHkqCXSAqibWOzS+IWPat8PProe88CbI1QgBvfxo4iJx6mwltjhiPVs3G5G4TSfwoQ6knllSUCZCHl1BFwIefwNj2XTbYEmM37h+kgaCPBT7kudIFSrsxSwJxgI6JhLu5bMAL7z3RiTBJj/QBajmvQQI+TWTvXRBv1LoVXocCpmblEkrCY5SE2jUC1mxp75TgoxNi3QIUIOj/HMhSqo4D+emaOZwdMKk2aq7yejjMI07umlZnyvPLpqWUBGpbycCYtkp4vBt7Dc8HnfmcZXLy8Y9Tp0sixYEZ9PCAfsg==
From: Thomas Green <TGreen2@Sorenson.com>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Removing old service directories
Thread-Topic: Removing old service directories
Thread-Index: Ade5WQam3u0k8Z6ISO2Ff9MvCRAmkQBVcqyAAXU6UEY=
Date: Wed, 13 Oct 2021 22:47:42 +0000
Message-ID:
 <DM6PR04MB7003F49568682041E308855A9FB79@DM6PR04MB7003.namprd04.prod.outlook.com>
References:
 <DM6PR04MB700338BA0F2EBF84D07EF5759FAE9@DM6PR04MB7003.namprd04.prod.outlook.com>
 <20211006123643.txym4njkm7pqnken@carbon.fritz.box>
In-Reply-To: <20211006123643.txym4njkm7pqnken@carbon.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 2350df2e-1239-a08e-da56-41290e350ffd
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2db7d096-3fa6-49ce-d876-08d98e9b7761
x-ms-traffictypediagnostic: DM6PR04MB6923:
x-microsoft-antispam-prvs:
 <DM6PR04MB692327CC539005A1CCE12ECB9FB79@DM6PR04MB6923.namprd04.prod.outlook.com>
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7003.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(508600001)(2906002)(33656002)(42186006)(83380400001)(966005)(6916009)(316002)(64756008)(52536014)(76116006)(66476007)(38070700005)(66446008)(4326008)(8676002)(9686003)(38100700002)(71200400001)(91956017)(53546011)(66946007)(5660300002)(86362001)(186003)(3480700007)(66556008)(8936002)(26005);DIR:OUT;SFP:1101;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pc8dnrg3YUH9XTPO6WZQC2hEM5ODLgJbiILt6ARZJD7Tz+TePcfIM4it+OQk8Pha+K12sNveBhoNkZ4b0ZUhoPhERXq71dWtb0Ebd5+XTuyq61TNEtZLXAPUdZfkXgNxmnObFclXmHEk0OjoxM+nHHkutpEi2JOXBIgN4MKfo0E9XTvkuPpJOBnijtb/iR3bS16IDUpIo54RobtxZgOlzeDxRW7AxkDIOHIB0LQ6JOtFbt5PRLnn37hoLtfrkRS65GHWXwVTOz3rffxQRMwDIo4kAlVN8b9jgg0xhC+6/KnXWwwwoBPs6sp9MCsKG17mjgkRiiM7NUGoehvEVIS20M2AGx/2sr7Dy/BmmIaZSmM9epbJvp4MrSh12WBURBSPVxbbVQo2u30qHr7p+ZzadWliyrGssyhFCKSvttP0WoSzKhiMfP/m+HNkBzl2cvqUsl0STofIAqBX5cWe8p9xl1SYS97tjyzas+IX3yZUEQanQKUZv1lHnWdDt1g9YZpoOuEyykHwLK538LAL7afI9bsHmM9+fGynOYKnZmizZF7TmqKnhgH3FXFADyz7FSC4XLsDtdwJtsB8RbYORRnMMxT7Nu00aUYm41S0ODdX0KcNsnLOHLEqANnM5JYW9eoFWJ59mrXhYlRbEiwzZDSwE74pL/Gmy8119ZaB5qe7qXAtiFbJXAQJPDkSAFL91lEXyepuHnmOCK/9Qpyv05Uym9GlEhq/wLaMC8uz/JWCWr+rb1qIIr9dRZriYSuWksG5x5OsO/g0x+YZevW4kIkNp2qZgQb84nANLVj9fR47Ebk=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HlbJ8H4NhRd19Uobji9u2VJ7Z5QKJ2K9gbfMUfiVSzGK3FIczrlk3DWrhp?=
 =?iso-8859-1?Q?iJ7IZepHUMhZZEnZ3x2Imdwu/3dkEN+RuNYH6F8gdsagUu+Ut6LXgCdqT6?=
 =?iso-8859-1?Q?K0LvLXLHbTWAgksvBqlXlRJBmb0c3bB+En3d2atgS+AVZhIbNIpmtJK0kH?=
 =?iso-8859-1?Q?Fa62bQphGLM8n288eN1eh9s9BGZEiRKqN+BsVLfW4H8850xza4TbX7lTRI?=
 =?iso-8859-1?Q?8X4EPdx4rr33o627DBygu39Z1fmOrZtN82m7WENU2Sf0AcxlIT6lS3+wr+?=
 =?iso-8859-1?Q?f3EU6CyCArIqxg1GnzTr7ckoIQuHXN9rDyJva1X6Rh+uVE3FikD5t3JUER?=
 =?iso-8859-1?Q?D5XN03yGjHvxZQzTnCfzsCEffANTzxeS5V2RkB+WQuw/AWl0RBi55OCydA?=
 =?iso-8859-1?Q?SKZxlnM2oCelaMF783qyFIxcO1LUXXzZImVOGplosr8HijmmWbqYGp98zO?=
 =?iso-8859-1?Q?TWfgJVK8NOjjof2lEzjru6n3eR/6PpB6dv7nBoJa2wg7FGgbO+uWznxVR4?=
 =?iso-8859-1?Q?ua2quN2QR/IEP7KAYuZP6Oa/mwlWM2FI8lpAPEEWsu4Dhd/jMO1qYQ+qdi?=
 =?iso-8859-1?Q?FWjObRCrqWCbQ59Hhoeoh4rYmWYZXL1ENvSaMUP1PUioDOmpAmIBArQ+4x?=
 =?iso-8859-1?Q?Boa4xBRexMhMRAo4fKnvGkvXlfoVXLcz4SppHqiMjhEh1C44+AxBGx6mN8?=
 =?iso-8859-1?Q?uLrAGNXRgeDRcP1xV35DHpRgfJLf8PTSqgdvWI8wWWkTykFnUMUesvHHXS?=
 =?iso-8859-1?Q?NrSvysBnQlhj0VMAuWQzg92dTagjDYEvlREkei1PbcEUXNB2JK3dFQZgZS?=
 =?iso-8859-1?Q?YT5gInBfFveBhBL+jAhvPGIr4NNScs2UhhD1mz39V4gINq/I/q8fvoQc/l?=
 =?iso-8859-1?Q?BDUNamFk1pUGL/2NGFZg/kJQRiVgB/XP3VgK9qF3lXgRSuSXUCvGhvainu?=
 =?iso-8859-1?Q?JLptLlbD2cRdwTLamU7KGAJ9Q8+zjSKqSrVwQh36rMkclcJJ3osupGs+/L?=
 =?iso-8859-1?Q?jOjpZnFdqa1o4aezFC6C2XzoEbmytwBmBxaKCOCAarNcQWsutVmvF+c388?=
 =?iso-8859-1?Q?vGwjPpKDiIhx0up3d6sC/LeBh7kiekHCKjvSbnpYessgzoeN6v1GddxG8L?=
 =?iso-8859-1?Q?HLW1ixWhfMTZKbYmG3kA2WWMck84TPY3BTbXOhd7Akrvf3LO2yPVVw0Fqs?=
 =?iso-8859-1?Q?7YHhgJx1T4JR9NTMmNfwNWPGU2pjIhyO//MbZ9rLSPVBd0bhbzS2UdBCTk?=
 =?iso-8859-1?Q?jznqy4087vLUM00RN7SCVzNv/tXdgI3sQEXIEl/uaMJegL0dmDvnVFTqgP?=
 =?iso-8859-1?Q?FvXdJEQqrmjgM8NY/XdG5M72wFpOvb6DbYRzX6C5Tmb33DqDQYBmcCeI/R?=
 =?iso-8859-1?Q?wVFRY/722a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db7d096-3fa6-49ce-d876-08d98e9b7761
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 22:47:42.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e41rin2n/lHtv4hfKwq8CMa77DPe2GqR0xFireodYQP9enHDGf4zFmWYRXOK4gQAOrACJ7wei9p224cAPRV+qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6923

Thank you=A0so=A0much for this information.=A0 Is there any plan to take th=
is up again?=A0 Is it something that would be better for me to take up, or =
for your group?=A0 Currently the only work around I can think of is to shut=
down connman, remove the files, then restart connman.=A0 This is really not=
 the option I was hoping for.=0A=
=0A=
Tom=0A=
=0A=
=0A=
From: Daniel Wagner <wagi@monom.org>=0A=
Sent: Wednesday, October 6, 2021 6:36 AM=0A=
To: Thomas Green <TGreen2@Sorenson.com>=0A=
Cc: connman@lists.linux.dev <connman@lists.linux.dev>=0A=
Subject: Re: Removing old service directories =0A=
=A0=0A=
[EXTERNAL] =0A=
=0A=
On Mon, Oct 04, 2021 at 07:50:11PM +0000, Thomas Green wrote:=0A=
> In connman I would like to be able to get a list of all wireless services=
=0A=
> that have been previously connected, whether or not they are currently=0A=
> in range, and be able to optionally remove or 'forget' that service.=0A=
> I've tried to manually remove the the directory=0A=
> /var/lib/connman/wifi_xxxxxxxx but when I shutdown and restart my=0A=
> system, that service and related information has been restored.=A0 How,=
=0A=
> at this point can I do this?=0A=
=0A=
There were a couple of attempts to add a D-Bus interface to expose the=0A=
known services and allow them to be removed. I gave some feedback=0A=
on those patches but never got any new version. I didn't find the latest=0A=
attempt, but IIRC it was based on this one here:=0A=
=0A=
https://lists.01.org/hyperkitty/list/connman@lists.01.org/message/4RJBOEEVY=
DAWFDT4PJ64FJ3PSAQ2SBMM/=0A=
=0A=
Daniel=0A=
