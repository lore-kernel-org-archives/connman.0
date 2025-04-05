Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3BEED8
	for <connman@lists.linux.dev>; Sat,  5 Apr 2025 02:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743818999; cv=fail; b=sa0sUhEZ4Sx570iWXK+ScDt2ba5PXHloXkPBfrcunqj/VHev8Qu6Paq0ZbMm8RjHF1rlOTJ81ZFZJ/nEprK4wD2VskQ5M0Vj9GjMJn6U772Rp/tWQWAqyPwI7fBHz5d60QEosUsBWKuaHGpaxEyl0Tc8mMnrUieQtJ1NsLpBqtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743818999; c=relaxed/simple;
	bh=P/95o1p+D7hRmpHlMpOs0oys+JsasYz1miLco13S7Aw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tHk93QElbGsq1gxjx5ja3NbHmpkAXDj+YknmOXgYHqAahCtzl8Qq6EX1Ctsq3Mgx51SO0VxGMdIPK24+yNHgz5XZgZqQVn9ZvAyfwabeBqiCZY2COyrW2TMv8V4DQ4vW9itnNwsnva0AqvYSx7/G88GTx189UIAO3ZkB5tlNbB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=PxOPfn6v; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="PxOPfn6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHeQ93R1Vx8lmdb6Elg/Sp80x9ueReCCfm7ELcQX/c7qhTU5b8gIq3q4AprDyGczfEF8K6fDZPRWvVV+09yxythWp6yqx0+JwZaMua9kFIlWW5EQXeLhJ0Mzk3MunDCkXbUL7eazOsjkUdk2hBbXe8Vz8caloQFaryxhGG+3yu6toWZu/ZnNebOr21osHFZVT9xyaX0Idw7/VBMG8Qcm9RpJjvCZ9vvY4JQaCgqNWRf6S0+djZCB0VyeAz94vVEjFq5PS/kmPmF/FFgDZU71Y/xUENjRGhEus00qlQUADOWw4P6NHxULLHz7v433Qxalff80OZ0WoeBO2xJTpcJ2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/95o1p+D7hRmpHlMpOs0oys+JsasYz1miLco13S7Aw=;
 b=xNSIZIf+UfYZuH6q9bsKKewtyfTde5Unin+bPpEgwZk2ONejNezedyQb0Azmnox0p9TAmxc1SJHZVZZQNfIOdXct+5yZHCbEdywmFQjSYx25LhorScZW96fsSZFIDV+c0UFwS+q1fDnaDkU8f9b73Hg4C64AuVoA5loPefIjsSqHhht21N4Z1aRZZ9v832xx4z7W8PBwpokj0KuxlqtphtHJuS65VS0b7GHCHdcupj9DXvhuo+kJutqb2GjBv6Z1Gj9SPihP6qvT16tUabSC3/GZnRgW7mbNBjekOVZleWTI2Eb5Y3iNQTQ/xxY97bViwxwOaMFVT1BacXfyHRqauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/95o1p+D7hRmpHlMpOs0oys+JsasYz1miLco13S7Aw=;
 b=PxOPfn6vvYg+2dBWp7qMKsCbQTKuB3LJWaMq/1n2BoiUot2JwjImlV1xe02tdgDYssM4Pcb9T6zD4zqOM5N0ZEy7XMCgjIal9wQXRFMaVr0hcmMSdIpAY0wDUiHOzot3BirD9BnsMZO5apAnFopkbBBiqZVh9fJ2UhbFmVNSPN4=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 LV8PR16MB6029.namprd16.prod.outlook.com (2603:10b6:408:1f3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Sat, 5 Apr 2025 02:09:55 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%4]) with mapi id 15.20.8606.027; Sat, 5 Apr 2025
 02:09:55 +0000
From: Colin Wee <cwee@tesla.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] gdbus: fix double free
Thread-Topic: [PATCH] gdbus: fix double free
Thread-Index: AQHbpc/SapYaCo1QX0SIw2qy7vvNVw==
Date: Sat, 5 Apr 2025 02:09:54 +0000
Message-ID: <20250405020929.754988-1-cwee@tesla.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|LV8PR16MB6029:EE_
x-ms-office365-filtering-correlation-id: fcc09733-b367-4506-5a77-08dd73e6f532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dNE1H6EBtp5ATDUKVzF6pUFq76tNefF+WfqSwk5D0Y4pLUbW60EoaGI5Fr?=
 =?iso-8859-1?Q?FgLjq/CjnV4LxXbRhLgQqvRSr0a5CMqVqtFEQzXG6wTSrwjRkjOxEYyCQ8?=
 =?iso-8859-1?Q?fEBfJCsPFfpiiObWFVkeCJaAylVJhUwNqj4SIUO4X6nF3uD1qrB+MACm8F?=
 =?iso-8859-1?Q?VkiVJF1r3pJr5NgoZdnL4I3Rp/uK7eukOQNrQz1Z+uCASdwLMQFHf1Mdc4?=
 =?iso-8859-1?Q?ph7RW6iB3oUS1JsaBIw9TDo94JvcX6d3EEGJhgyvE12bX7yQOE1pqC7Add?=
 =?iso-8859-1?Q?x9iGTQLERN3qEPhIMwEBD3JA3oawzo3zca48tGCUH3QPYghXLzWaNT2r+G?=
 =?iso-8859-1?Q?khASfIHrmOIhKOMifZKLdYLFQ7i43vbhYLKZirIHJJ2O8OVghQ8IkYxNe6?=
 =?iso-8859-1?Q?ajGDPq6mn5W0oh9usJEwf2HiBaX29FFK9HWmYgykhflZHJPnGCW0KC6Z8M?=
 =?iso-8859-1?Q?xxN9SyjRwKJtoI3bP1PZ3XG9eC3UTY+s9OjiXhTJULuopeDLSl1q84WjbW?=
 =?iso-8859-1?Q?8Po/Al3hDggLJMXNas/N5ZOKFkKPmcO43/dvnBgU1EiwvOTzrzx7bUQEqV?=
 =?iso-8859-1?Q?MeVaGSgihtWt6VlZbAEBCLA49uEDac4C//ozKST1N8hPI6DxVZRSo3R8+9?=
 =?iso-8859-1?Q?lF3WTAtqp3YlTA2vL+CB0AtQZmlVnHSJRC+cCwXnO7xiolUUfygTP8mrL4?=
 =?iso-8859-1?Q?qlGgZsV790TaGdDEJueKp2bkSxL18LNKcwghm5qIdmBIIjboYudfVnI8yV?=
 =?iso-8859-1?Q?6MfqrpJ3wyfUjcVlyd6m5zXfZOzyEKVRBRO5WHqYPPPgUcBD7qitztPAe1?=
 =?iso-8859-1?Q?56MG8S0SThkJ0Yd/1g+YNGNMkUnPygDBZ05g4kcd7BEsODarZHCOVfupON?=
 =?iso-8859-1?Q?YxnB9a2zGGYP48EnmAxZlanZoV9Oogse/CD2SLG1lHsLd/VISHmtjxWXwx?=
 =?iso-8859-1?Q?czfYMhIHB/fcu72O8dk7srAa1yNcJUPLOQ6SIZfdvRDTjC4qqr9MhHzlxt?=
 =?iso-8859-1?Q?tMGqJVHzFUFA7KYVN7l/CsSpY2cSLRKiEMNZxGOkqZYJBmv7WAB6LgbdWl?=
 =?iso-8859-1?Q?OygT6e8WamRKL9MXlKJjHqMnNxGn6Lcjwhxv4PLb09R/RUoAt+7LcN9uEo?=
 =?iso-8859-1?Q?MDMk/O34bt+NZbDa/Hnkilnh0pV5ILfqY8qV6SMDB/76FfVeSJTlep9VIs?=
 =?iso-8859-1?Q?+esLHp720janxR1mnzQCph6XqH32yoTcYL2wPu6WGQNzL/eCyWhp8Rt/BZ?=
 =?iso-8859-1?Q?p3ArQdOkNZyPxgfMzcoqqf/sjVlHaoEcnpFvRsY5IOErgtWlVfk5D6akZM?=
 =?iso-8859-1?Q?i9SbRTdb/2RJXSV6rnw+nlHKwpVuFUIdvXfCee1aW4aApmd7OzZfLqskSm?=
 =?iso-8859-1?Q?Z47ga36Yt41GrZS2GWAEqN5MONO/OHmkH1lv/J36XESKzLBwFOGw7eNJZ7?=
 =?iso-8859-1?Q?MAKJ0lebmDCZpKA7TYxEADLQOgzARbL6qeU97uMLlAJTMVm1luM3Ss6/uw?=
 =?iso-8859-1?Q?5kC9htfrfrRyW3E2u2/CHd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/247HJ5g0SdHm5jcNabuxKjsV7UeHaAh3fkjTvK94irLxwBIXbLNNclseO?=
 =?iso-8859-1?Q?Hg47DNDgRep+lCCW818WJN4SuF9a5XA+2HFSC7NXPNAV/GKqc/stXD//nJ?=
 =?iso-8859-1?Q?eqwdE/C5zc/vn0/7VVRC/qtMDuBt9EKvcKRvfOBhCqDSgprNYdGzcIPCNU?=
 =?iso-8859-1?Q?GhoNP2VPCpV0f7x1xJ0LTOz9kHiBHKWM/euuxcuh5wzyJKIrYfC6dOSvOA?=
 =?iso-8859-1?Q?4TrXgR1O95D7SXVuU/rjr64arjty32AZKYrjESyl8cRSBh+HaiowgR9Tbk?=
 =?iso-8859-1?Q?RxGVMp6kRzxC4uPRjA2a98w8XDKHtahQr2Oq8xEzLWLZCK389aaQib6hT0?=
 =?iso-8859-1?Q?/Y1/Myz6CqnukswhXfQsqP9TLiILKNDuuzbMkuHdbkIoQ89CSju++kl4u8?=
 =?iso-8859-1?Q?h6V+74aL/r7WyzbReYB7du0Aj54UN/PPvY+AwiIPeGf+pNHxofHMWyOoQN?=
 =?iso-8859-1?Q?/gRTXOc1Wm7EavwJdO5jrr1jXQWMVZ/SlIQHRDtJa0STKb50DRg2fTdmaR?=
 =?iso-8859-1?Q?o4e9ac0ZMWQlZfeH38S8BA2259PvkyqNeV6dgdsK3q8ifBwHjaworiFzTa?=
 =?iso-8859-1?Q?GA35RBTUPICDK38L6yToe682hXx8jBy8nQeyMImjNkudbZ1VvagWZcbqI8?=
 =?iso-8859-1?Q?YuXyxxcpq/pAc1n8lr/2uxM146HlQ7Q0GX0FiQHCmD2qBSHR9dpOVR6mOd?=
 =?iso-8859-1?Q?LsLMH7jL867lAope8FFC/FT1Dl6ib021nurKbG5wlXAYK2I83gODFE0ho6?=
 =?iso-8859-1?Q?OkLq5AAg8hQA7ssslfgL2cL/13k1TCdQfKjIj9FlW/G1Ibpz9PHRoSn5Kz?=
 =?iso-8859-1?Q?titwZE3z0jMMaf7TS+dD3RSw+jdq4jqwqctz/ui3MAV+62Y6PbmqVQqB2X?=
 =?iso-8859-1?Q?QNHWqqwS6sjK0SbY4kD4QTI8ZJEQm7R7dWTOHpXZMKCySEiXo/obgsBuXi?=
 =?iso-8859-1?Q?zu9+7vJugH/eqzEWuNjEQA3wGyIjzF5lnI9hYBWkmMN1r85rZXwzu05b/P?=
 =?iso-8859-1?Q?hVNei/2UUmpC7Vi8KcNet0+2/6wzYh5fN3I7ccWegVS8c0agPW+qkU7Dqs?=
 =?iso-8859-1?Q?+khYqvtchqv5ibqPRdO7YjoQtvG9Lup+UiIk/NcSdvJBDkn6wb4LIciVpd?=
 =?iso-8859-1?Q?cEdtqXIjBeApKyiFVckN7FBaYYL9dVcDzxd/6enBooxvequrIOYOI72JSW?=
 =?iso-8859-1?Q?TckORCV+1N5xUqGmllUBeUSiSimZ9+wWDEqf4yz4in1FtAGDKKygltELHk?=
 =?iso-8859-1?Q?7vNzLdkmvIGN4g9X19/4E1omsYtUjeTB3sXNlJfAPdYVau7R6cVyrVtSUg?=
 =?iso-8859-1?Q?UP/ugeHi7Svkia4tHNsHErBRQzI662E0uB/qBVh5iJDFfGf1/jZrGABg/x?=
 =?iso-8859-1?Q?bKkKVXg+qCmNnk07+Zxur/J+ZeZXb+8n3yBqEHD/nFoRJuacsSlDoAmVGN?=
 =?iso-8859-1?Q?JldS46D9a6Rce6uSlAwyTVxr5bZYHc+Wv269/k92fmsW1BV+gNNe2frRcl?=
 =?iso-8859-1?Q?HBgoF7OGjeOFwjifPYLIYwM38RiBb6EJ6dtp4709pC/bmHAsQVtUsZiXM4?=
 =?iso-8859-1?Q?Ze5hy93lJd9izgG76XOxH2FBj86dow9WfiVy5AFbsMnj01Zzk3rcw2Nu3S?=
 =?iso-8859-1?Q?PDNLAN+ts5CCBg6qPSwVytrCm4QZICR2Ke?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: tesla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR16MB4504.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc09733-b367-4506-5a77-08dd73e6f532
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2025 02:09:54.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPF2/L+oMvRLmAmsi2upR3UPMBFHv7W/mUtoNw0XlcEY72lnj1rZrOOzVBJc/q3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6029

Hey Connman Maintainers,

I'd like to submit a patch to avoid potential memory corruption in
connman. I've attached it for review, please let me know what you think!

-Colin
