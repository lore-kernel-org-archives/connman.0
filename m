Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90054.outbound.protection.outlook.com [40.107.9.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E53FCA
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 13:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFR+ZKAXKJBEQLNogOAJBS+nxThqXDvbThhSblH3TVr4wBC7BFxnbhQajJLtoeGVUBpoNJvRXnd4dtsB7FXJVp6Tizp2cISOF6rszKuNhOApH0ZJ6Ig337W8+xKsAXWcFUaZ3Fq9PEzs/hwSVu3qC8DRDRW7u6MA3uhzwZuDfaq9qjiLRjUh7YGTNmqN2iyBHSQCwpIvPXX2wZGR7e2prQPrap4QM1NglhE+R1NJMpp0B8sBPE2duUiXdAdYrnXrj9vtTzLX2fT1q0crEpA333V04uPy3zb2BXDqwugjymRaZdqUx/31LfGt8ggkw7WYR8/OiLm2kbIOnXPf4kSI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlvIFJUH4hSBl/P+MyL77PwfdakL3/+GrHr6ZPa9cS0=;
 b=d/9+aVnjwgqyDrSA2PN+AzzQ2w5ZTfEoFK/RbkbkqtmIhcThGwtYjlv0hs/jFDg08S/kZglnt0hX104jUu+k239XXE5ht0PwDNBVRIq+FCdA0rrSeYJDK4nYTh+UFvZguRIrisG4qabkJBc7IIJZwvU3/LXTKkyZMyk35KM/JkJsbUNUFaznkF9370dMQ1Zqx+TLllCTstb5mN0mw4ljGb+ql0OGfuCC1cGOQH+/5iC8MU8UzUOLLM1ARHeR7GYx5J+cLnw6iyltl0TXCVetuG/E9LRl9cGLIxcCyTf1JVL2tgkdiyBhj+pzeuvcPE3F6lXq3QAVXXEFo7TQPSn5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlvIFJUH4hSBl/P+MyL77PwfdakL3/+GrHr6ZPa9cS0=;
 b=DxBhHrr7JBSJvRM8fCxcFzeqCjCQavj9gE5wqgYvwZNakYd1KxBJQPFW5FD0Lh7fEWiYfdETmb0+ZIRF1NCef9LAPSQLQgoheNEbjCbbouPxaiP/8DdrEyQt7vDusVtRSPFjZ+Dgk8qCTcn73ihU9sfQKwu6syYfCfJPP+YoY/c=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB1910.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Fri, 1 Oct 2021 13:48:41 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 13:48:41 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Fix missing Ethernet attributes
Thread-Topic: [PATCH] iwd: Fix missing Ethernet attributes
Thread-Index: AQHXtr0zj4eFWvbcdUqNbSuyQwaOlau+IvAAgAAB5g4=
Date: Fri, 1 Oct 2021 13:48:41 +0000
Message-ID:
 <MRZP264MB1544DC6779714C03B90848E993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uwnCvrffN6go_BwM0oOMGM+OZ=EucuV_OnifnmGQ+XE3kQ@mail.gmail.com>
In-Reply-To:
 <CAOf5uwnCvrffN6go_BwM0oOMGM+OZ=EucuV_OnifnmGQ+XE3kQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 49004668-d13a-83f1-cc56-17ad19737819
authentication-results: amarulasolutions.com; dkim=none (message not signed)
 header.d=none;amarulasolutions.com; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2c674ec-9b39-4f22-8696-08d984e22df8
x-ms-traffictypediagnostic: MRZP264MB1910:
x-microsoft-antispam-prvs:
 <MRZP264MB191090E51EBF7C105B2AB50093AB9@MRZP264MB1910.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R0x5dC4tH9DlD9BX/Uo/G8rgrAhOxBDbyiGnBsnDU1pGcu1eTKfbxU+7y9Sj6nVAwVXLcjYJQVgV7mDNJflRbWZRK9hicRMlOoxpuXnsy+SiWiwFYe3b5QFJald6XB2vkGTX/KeL6pGyNWgEL6hh4kO7hoMWFWkT1DUq7LH7Nbdmr9v/u8gjr4XH4xzP9A5oxCfVENQtZdlOkIMBgyyH32L8I4yRYSMRKpimY4u1i3HLOTZ5ZgsAWZeRa5NMZOPeQ4W8sVpnXoetSvgQRmJ22CsdbGdzEJWPa3KaH1fqThXOeJ6RFIqClrq0YZIidt6CU0sQhaG7xGohV1MDvV/plsqRig4mfDsAzqCFEZkoZtzDeFQUw41O+vtlGRFiyRg+iNWI0lTPRV+I8ibFyT7hRg522t2OlhOQ6G7bc5OdwXeTJBNIPChJcGtyIYPo2amgDppc8N7o89riqiAQTKXkthL4nK01pt2owjNAWM6J8qboWMVEIoLEn37XV3YhQPx0X446irQRWWtcCm/wvOruEiAWMfcHHbhTJ15tCXzwMuQUrYAKX4ilIPmcBhRVijGmrX7j0/e5if8HFXMpgKWPFxkfPfzmvdQQe32ynOW9143klhXGPXiGnfIkDaBldljXO8CYv6tdUPEA9brdxJidqMJyE4S6nDtBZLHHVwNr6X6X5m1tj4NRNA5nJPtkLURHvY/zLV1sqJ8P2EHXBlcuTA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(2906002)(76116006)(91956017)(6506007)(66946007)(71200400001)(38070700005)(66476007)(66556008)(66446008)(64756008)(86362001)(7696005)(4326008)(8936002)(508600001)(9686003)(5660300002)(26005)(38100700002)(122000001)(316002)(33656002)(55016002)(52536014)(8676002)(83380400001)(6916009)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wtTwKtfCEeACF2s4dkEmzOW2da0YsOXSbRDhGVS08lsLiwQ86azgWRIy7a?=
 =?iso-8859-1?Q?O62AiI6s1W2UH3DElyFla5qXbpP+pSl5awt5pnEY0wGO1/6pbJdBfw0TJp?=
 =?iso-8859-1?Q?ch2vvxEdm6Itj/R81sO811Pu3/UCj+0cxGzxyaPvW8BX07d8uSZwboZvwi?=
 =?iso-8859-1?Q?Nl4M/9pJ5J83bovK7l6MSw8yc35NDiUkMpfZwJeAOyN1Id4QUlhms7+xR7?=
 =?iso-8859-1?Q?Sse6m3fGdesBeeZ37Ad0qg4EHWdcpmtNPrjBxsdHI9mxGZqIvIlFKPDDa7?=
 =?iso-8859-1?Q?AyGUB+d5jhfwwqx3mzB2d10I3XKfmBghcH/QsuBZlS4CrXYvIAV6Cd86yB?=
 =?iso-8859-1?Q?+63er8a4uRhWppuB4MVnB+eIkzGPPqeVbNKOXRXwi6G+uiUg58BPFAfE6n?=
 =?iso-8859-1?Q?sais6246EBkcYXO4W7wHgpmNbyz5Zh0KK0HlaAFauW1zLWzVR+SI8V+3ke?=
 =?iso-8859-1?Q?9B0hcESVGPY1AJoDQHW0YCfaikKfsuXgsdO93nr8wuPech8yR3zn1Hw4bE?=
 =?iso-8859-1?Q?tj+o967j2+Pqw2Ql1m52zM5vHHx+iqcdFX2nggErtUeBjfze2DfWjC7SPI?=
 =?iso-8859-1?Q?GeowBaWr1Aq84Nt8RgesQLWWEei4vSzn+KsINpoMCcUVwZ412pferRa5Xj?=
 =?iso-8859-1?Q?6667IeOjIf4uYV3vEa/Vu1d8swMSdReZ6SOBYL1P8Y00sdilmm2KTwcKU8?=
 =?iso-8859-1?Q?OG9tmmWEfsYGFk4j0PKbEvyw29O5+nGbxYgrKUdRL//moT97UefKVtZOQ7?=
 =?iso-8859-1?Q?8yhg8OvCL0L0d0j90LWqGuFIFIEinQ3IE6XN54BHWCNIbyrwTfZOGP2Apy?=
 =?iso-8859-1?Q?BZS0k7rBgc08uzCVbvjkfxcH81BV6MBmm0c2tOaBKHuS8268aMIOcEhaUH?=
 =?iso-8859-1?Q?jpfO1gogpTqrrsqtkf5agS3garu+In7xAYHexlQ7+WkLkDUwAIqfzKl4GS?=
 =?iso-8859-1?Q?qxEd/xhy6D1OHICq4ACQ6usisYEJIOPW2dPvmDscI4bKB4uiTCzkJHhdWu?=
 =?iso-8859-1?Q?+BUFC1Ho1x6y2DCQ8WxMW1HFuzGh8aZY94iCPmIbKCie27tJyUDVHoISxi?=
 =?iso-8859-1?Q?/TTVDtjc5HsbQQLA/EsZyeWn3/zBJZMp0g5POd/+gt548PmQMQ/7H+vV4T?=
 =?iso-8859-1?Q?LmS3KtNixXWEnpDVy266oDq0lfkm0CcY3l74Ddaid0DA1xYa81mZFyqX1c?=
 =?iso-8859-1?Q?6A9t0u1Px4qsDlC3nswmdkPTgccXGXjQGi61AXUfAagg2SZMhyo05u09pE?=
 =?iso-8859-1?Q?m+q+zw13pWG+NTaJdNoj2LVkQ0b6H/9Z9XyYdf5P517o3QLKhTMjz2iltt?=
 =?iso-8859-1?Q?fy2hosFe9pLEBJMXGdlC+cbKzPoglzDf5rNd/D6jw4mD+wo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c674ec-9b39-4f22-8696-08d984e22df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 13:48:41.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7s0E8ahMsYcVIP0ymSMmS2/cnvb/ia2rN0Zwk1sfrM1E43tAgKMUtMuZSbqkQsdtL4Pz0rR6BMvUO64fUw99eA2rTEgwhUBqvR5ARMbO4fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1910

Hello Michael,=0A=
=0A=
> I have sent a similar patch 6 minutes after you. Anyway nice we get=0A=
> the same conclusion.=0A=
=0A=
Indeed, what I have noticed.=0A=
=0A=
In fact, I have just integrated iwd in my projects (set-top-boxes),=0A=
which where previously based on wpa-supplicant.=0A=
When I ran my network test campaign, I have faced some issues I have fixed,=
=0A=
to keep the same behavior as previously, with wpa-supplicant.=0A=
Today, I am proposing  the corresponding patches.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
