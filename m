Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D413B58E
	for <connman@lists.linux.dev>; Fri, 10 May 2024 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385214; cv=fail; b=a392iizVYuKfbuOkK7LfmBUEAd66o05mai+ut8ejXVD3pqLNZc5Js9xC3cjMXmJ+2hrQUsyOqGcEPP3Zz5k2RxabiIqD1VIyOCJN2h0JJZ6CRUCQ3Tr/y6FB/eqq5lOgW3aibZW5ciDUDM49ZOSuggAdnzLlDDk6jun1CkMO91c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385214; c=relaxed/simple;
	bh=Y09seH6Uzov97GwtkOWZ/fFzcpNiwVtot7DE/NBFSs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CRp5jntR5cGURIgrx4ZnIYBw2Zs/etcCmIAcGvQfuo8VFacCPZOTDhOgA4rn316xg19REJOpfXoucE+lCylkmYS22wP4RY7jLS51w0TGCph2V8OzgsxXfV7EC4u6r09M+2FvvuRojI58AWL1VNrxegXcoZlm94CfKeI/qnyhmcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=X8fd6l3q; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="X8fd6l3q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l271WbhBrU+vO6+KZcifXiVPN9idV50XXA7hDgkWnTh0mBj0L+M3dX4GjQLvv8TrWOuDa00mAfHWKiRWcewjvRABKKcqvrLcrfEwQUCBXSz3coBF8YL8aA0iijMfy6OdbsftZjbq5+ZOIyT/Qcu9r/BI1e4oZzZrEenAg1mNSyh1I1ellB1PT+gwtQNNOi/+bOezLD747SD3hFZL1wDvX3lq3LigJrJoKoDZPFqoC7cKSH3lWamJp0GMZMo+nitmeQRRnR9ZM0WlpLNzS4+VvOefM/sUlrVXRMu9o966+213AldkSCADihyji2fht6qkcmWzl+O0uKHEkpkR9nJVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y09seH6Uzov97GwtkOWZ/fFzcpNiwVtot7DE/NBFSs4=;
 b=gL3E3/T438gUIOWf+4FOqETh/CFgkJws8+cBsZLvhH+TNVAv7EYoE5sFPqtDPkyeaPWCab9p3+Meg++Hc2Qy4cOtT4/clRP1pMjW4+K6OBnuTadnLS2GbkNU+yWUd7vzJMdSxnckrCw+aVcjE120B/nonFXT2L0v/e1ypLFML8oZVQDEuBdwdR/Du3zMt75zzri1K4cobQ3zV7Gnx8e9JHrPtfzy61Ouw/cLkuSQPG0lsuF6rGxz3fShLVJZeQqgNIURSrthSlCmm2noNUYwa46sikswREI+eA67rlrWkoezhHYa+99U+dBRO5zDq/yLQfxnPFtRQEKnTAx9cEtKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y09seH6Uzov97GwtkOWZ/fFzcpNiwVtot7DE/NBFSs4=;
 b=X8fd6l3qfRQdCzwZ5zhU+Eg4pab3j8jYjvCQ+z8TY6Uf8dt49tnZaKtCA4VzhTJ/MatX+E6y3E09P5yR0iCLI8ESXEHxrDupZVTrVAnNmpozyqg11S4T85sp4h9eU9OLheLIDuc74MsOX0oTdVxiFn0k9UPE+kb9AlrP3GQwPH8=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 DS0PR16MB5368.namprd16.prod.outlook.com (2603:10b6:8:167::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.47; Fri, 10 May 2024 23:53:30 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%5]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 23:53:30 +0000
From: Colin Wee <cwee@tesla.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject:
Thread-Index: AQHaozVC4DTBzVpAzUaX26jraTWGdg==
Date: Fri, 10 May 2024 23:53:30 +0000
Message-ID: <20240510235325.3625167-1-cwee@tesla.com>
References: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
In-Reply-To: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.45.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|DS0PR16MB5368:EE_
x-ms-office365-filtering-correlation-id: 42d8e6de-843a-4472-2ce3-08dc714c64d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/s1BgItQtu+PTQuOpqAwIEH13v0cHp17Dj3PiCtqijSdGkIjCRJhvXsNXd?=
 =?iso-8859-1?Q?clXd+jtYK9MbxOmLL4BbBR6Vf8ikAgJCMz/BM4v6wLhQxa0i9ipLkuJtpx?=
 =?iso-8859-1?Q?QFtnZslMqmXkfccHdjjs3gebhmjWPzs43qX3hbu/Ex4q5AiPswWq8PQazg?=
 =?iso-8859-1?Q?wlCHQL2n+AjVbmkUEeBul9ZC+almSK3CccPaA4PIToNCk18u2roeMoI0Vk?=
 =?iso-8859-1?Q?Lst8F8yYDCHw2Vw0I98KcBMB1LoKJ+3na1CHFt2LEidrQugCtOpl/HM//w?=
 =?iso-8859-1?Q?VW/b0UI1N+WwM0gmsdwbPm/1oHHWthUK3SQbdqH3L7yJxxVHYgw2qCl31b?=
 =?iso-8859-1?Q?6tuMkjzOJJUJod8VENoUWAun2e7HayJfz2K06bcozW4tpH8yB2gzWchhJP?=
 =?iso-8859-1?Q?KTVmocr+qer6Prw2H4/I/GAl14Tir+Qp84DFjRebVfrWGoguvPJqz2S5fI?=
 =?iso-8859-1?Q?XG2JOk9sXALftCXZRWI7TaTgPiuIt1pLpuBJKfx9G00GVVTYwUaDiywmmv?=
 =?iso-8859-1?Q?qMCRvBy1jWw/nf5JrCaKzxID0I5c4rYULnneQlZikkXJyq0J5ReIL6Gdrq?=
 =?iso-8859-1?Q?ED5I04hspYiJ6ZNwxHgTz76xHBK8azFhzqMIgFgnKIM0wt3ajI0/Ubb51s?=
 =?iso-8859-1?Q?EyNQoFIm9P4YR4sPEqU5zKDn1ptG+foWMq4WgIGJs/J30N8yu2h/Fq/GXE?=
 =?iso-8859-1?Q?T69abL2j4FumMx1onJXMaMLpi5QMW8YmjCdez9jKEEwEpvohs/fnZyM4PI?=
 =?iso-8859-1?Q?BAyt7T1ZioDPI92Z6Oqy8dxCm44/nxDpnMG3/ZUhA+zJOyci+sj+Q43vxQ?=
 =?iso-8859-1?Q?Trc7upvenHLWbvYN6TvOJcjBjZH8dnQW/i/SLuoEwhO7IUSJNTcStVvj4W?=
 =?iso-8859-1?Q?2KVtkz/1l82KCPyLqJpQ/AVslE59eFeIsDjnPEuJiVQO6PMw8sV8Vg3DkR?=
 =?iso-8859-1?Q?rPMG9XUAfoYIBYvcduqvBpcV+pjLQH5R1DDhjq4YcXjKao7FFxiokmt5BD?=
 =?iso-8859-1?Q?D/w62LbUF83ld34zQmq/e/f45urS0+lNKiAIaiHR3X4E2PUcPQbikt/7vI?=
 =?iso-8859-1?Q?ULIFob7r6Arm2eJnomGy85DpnvZHmC8FLKz/xuVxjNKZ9ExXUanZmZB4LW?=
 =?iso-8859-1?Q?FKXDLF4vsvRgJdHr8+e6zkC5Kivmi9TB81tX8QR0Wmg9FQefrtTdlLAJCo?=
 =?iso-8859-1?Q?BpMK+NvU/0Qoxo82/PssJmOG1IqX/nYNZj6BwwvDaFMKijLHi/k4IGatjU?=
 =?iso-8859-1?Q?O4ZKNShnDetMiRbVyCn+r9IeV2IGMvyk8vsmzHBktR1lJMS9H6g8/Tg0QX?=
 =?iso-8859-1?Q?TgPrCKlp35lPYhW6JMI/qWvJZmvCAmOMbbz8o0K3jX10ozwndkiWeYMcoL?=
 =?iso-8859-1?Q?5mS99sJ/HRF+HFpkPBpS1XB7zy0nlPHQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?A91F3IhWJ7SbD1nCNmbw0HYcXpb9J0C3ELLSEvRWUaWER1fXl2KJ8HdAs1?=
 =?iso-8859-1?Q?reZS2Bq5NOo+hn7BPG1XytHa0WMiWd4yY4HsO781Nfi9z0CPVPnVNSGDlm?=
 =?iso-8859-1?Q?ZSzfgI/aFK9uCH9kmz6ffwCPULku/xgILxGN5thLVIAzit8Mk03+1IkqrM?=
 =?iso-8859-1?Q?x6/tomO6y8p9HUfGsYaOpD4AL3DP+gL9sj/3s+QNUVrv+DW1E50JGo2g4t?=
 =?iso-8859-1?Q?h2iPrrG4+unBtSW7UFF0qSsvBXlt3PVBtJgZKG7hF/1KDSRP6Z3jXYlIvb?=
 =?iso-8859-1?Q?VKDPGhjWedzrQiQW1APj2laHUYVmkpkprZvpHStYfjtgfGktjss24vGmre?=
 =?iso-8859-1?Q?NhT42gwGQ6kyDCuLxqs1E1winQHIgKIQfs0RNKXpxInmk9YVUd7D7BmiVf?=
 =?iso-8859-1?Q?x/EsjY5OqKk2i14WbgHjap33wVrvUJscYbUpEYsMlmlCjnQHFQ+mLeO5Xn?=
 =?iso-8859-1?Q?Q7vIhqaaYsTtgjtM3aE4uYKtmqVac6DYbmihzW4WmLhoNGv2XuSKGuz0ui?=
 =?iso-8859-1?Q?1zn0PeHwhIiCwxH/q/OiJ/UXyvjsA5Q6nNzI1xvEDVDbm3J0IBSXL8BQAc?=
 =?iso-8859-1?Q?ZJBg54nY7sxGStwnNI4jUeWUwtlydqEtBSJyb2b0kePHXHfGpwsD24j4im?=
 =?iso-8859-1?Q?C2KHzfZMCkJu+ZygkBx9HQhm3SRzrfDuEjras0tpHKqDV3V+F8gcYMIvuu?=
 =?iso-8859-1?Q?cK30c9eKwojR6wPpGwf2i9vGcAzegVlzuhoEZHjoYsppppGwEaMsQyLho4?=
 =?iso-8859-1?Q?QVhnJZAncHTSSKlc2cgU9MglrpvZIONaj3vdRdTBfY5tIOoOSlXYyDR3JJ?=
 =?iso-8859-1?Q?exOQCsqkYX4J+0rouyfKYancwSuPyUCn8NBWRFcYGOBIbtCTtbiGuVjC8w?=
 =?iso-8859-1?Q?jbC57z3EMwE3Ck5Fe8aSQNWZece0cnzkHvty0lQVYYevt+NRg/M8waXdRg?=
 =?iso-8859-1?Q?XuqgxJnSqOdWYmuRUok6pv8aHkhZfChMucOmev1E9WX++Ywk8EKVRaz//C?=
 =?iso-8859-1?Q?ifyd+B85WwLdhikcNOUYl9Lxv4VmjZzudfeKhMZZyTwhWyzRzyIxYgYRs6?=
 =?iso-8859-1?Q?0P453doNv/RUZi3lU/t7PZ3FYcU5PyJrua4dyBu3gNVXjND3ztnalj4Zij?=
 =?iso-8859-1?Q?0WE9gPNcEQ/BXmOIOPd+It66Pz0jcwLUPex0Sy13Fxr5G+If0dq5mE2J68?=
 =?iso-8859-1?Q?0twhtFuAp4BWGU2DDifL+izmyzKqW7/WQXckHX6XmoxSme+Av0aALIlnoF?=
 =?iso-8859-1?Q?AqBNwx/w4QnlS4Z3Im/SH60mdnxca8e9myGpxU7rP4f7IlnlXZ9kMbFI9N?=
 =?iso-8859-1?Q?n2CuA+AHEC7EY5pLX+8MvAs77HaWzEwBAR+TkriJM/YpOOZcnA9zf7B87C?=
 =?iso-8859-1?Q?CWzqmqxyKR3zfuBKIBYmLQymcKR1kDdzK0I05IBUTLpbjMot44Ef+sB6d6?=
 =?iso-8859-1?Q?kGOMd+qR67OPgkoELd3EIfbC/uR17sBwh6ZXpagcAN56Xfk1jE6ZOZTOs5?=
 =?iso-8859-1?Q?e8Zi0ynNDXF8A20iQwlxzC4Zs4jOxIbAz+TD7EtVO4MRMJCwQOg8+DAv3Z?=
 =?iso-8859-1?Q?vQbTCBwD7XgbWnGcXZDQ/NgqHQN3qbSyM21bCxVLZg72Cktb/Pdn9Qf4VN?=
 =?iso-8859-1?Q?iFtnPCZUO6WAI6GXi1cMtkUIAnJX1sJY7e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d8e6de-843a-4472-2ce3-08dc714c64d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 23:53:30.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pych9iF/svuVyCv2tFi6lLallnnk2wMEZEC7AAZbfHGd1atMlDNufrTN5wNtdk1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5368

Sure thing! I've updated the patch, let me know how else I can help.

-Colin=
