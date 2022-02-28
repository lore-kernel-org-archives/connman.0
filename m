Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59253A4
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 11:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3Dvw2otTr0Am7pWtj/uZigO3cAzZ8d5KrVMR3GvyeDDk1JFuA+xG3gifWL077mJYGKjNMnJBgyfCelalZDrJCI+La7Tfg0eWdFX8wvMfloktNSLqxejymM2exDijn29oV2kq3fBf7hlQQAlhUkRApXEtlfbSf3jXl73w3VRtM7IaJRQvShw5z7UyibSCgvPvEycR2x2NYmhmm3RA3Dm01OU+KNPf6OrNd06h7duJ2LW5BRvYLAdrOpxDVdg2ZnLS35u4MoNIsvd05bbQ+Bz6cUSk/p7T9h6p86P5EQP2dV3sZ54DOrqmfkQKWTkpH3nLY1uraLabtBfjiUTU2boGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38HWcBgnqq8xDSVi1HYmBOqYOxIqJex21KOPeBHge/c=;
 b=ETdHGz5LomLPMQLU9li/KoasoCMU36tRx665LL3NjILnP/+6gs6dnNGRIb0TulkRdZZRR1/RvvyBgGKZffJEORi6f/PPtxBZ+Iy6zPn5FHSAqBKzsehKXuL9ZEllrR458OzQrJFli15cd+usVP3Y6YrZ+m7i1JRqRv6Dxi66wfB4PzxZosA0va51HW2qyaKlfu4PtXkZo8pJeQfwsz5lyhEngmM24XU7LB0R8G7jQzddPvbphkcUiEPjmcZ4/vTCiVxSGy7T+c0W8LXv7sb+YYOemy2BX7bx5NwHgsxp04DZBIPEIxxsEtEhcQ281OEOEjt2pF5wg+xaxS+NB42oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38HWcBgnqq8xDSVi1HYmBOqYOxIqJex21KOPeBHge/c=;
 b=m7cCLBZFJhLl9WJYEf/m0RN63HXfVMJKYGlhafoKPD3VE5ZM6jVloRNSURMlDQFXf1+1S2qVvDdYhC0PFu7b7l/OYGaSFgFvgZeiaG6Dki8Mqo7sAUkM1II/m9Ulu+XagMktuFi9+JckEcN0yPgJos98Dl81d7ZI32isWuQcpus=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PAZP264MB2896.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Mon, 28 Feb 2022 11:21:44 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 11:21:44 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: Denis Kenzior <denkenz@gmail.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH v2] iwd: Always disconnect connection completely
Thread-Topic: [PATCH v2] iwd: Always disconnect connection completely
Thread-Index:
 AQHYEP/731R9+FXajUGI5zk313sJNKxx3h9IgAGhxwCAAAOvMoAADyEAgABbfgCAFH1RHIAVdbNZgACBbQCAAADlkIAJhMoAgABT1IU=
Date: Mon, 28 Feb 2022 11:21:44 +0000
Message-ID:
 <MRZP264MB154417BCA30F1C47EDE6DAC793009@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220221164442.gsg6krtdalemte62@carbon.lan>
 <MRZP264MB1544515AF83263F7E4DDC918933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220227180930.ruqnmsgtei26zq4n@beryllium.lan>
In-Reply-To: <20220227180930.ruqnmsgtei26zq4n@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 088de0d3-1408-34eb-58c9-8e44ac5320d7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcd5600d-8db2-419c-4f6e-08d9faac805f
x-ms-traffictypediagnostic: PAZP264MB2896:EE_
x-microsoft-antispam-prvs:
 <PAZP264MB28965F85526907E5582C67BC93019@PAZP264MB2896.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 giLAHrhruva2/7Ib37q4I015/0mggzQOlcV5kpt7DZId/IwGZcPOlueZ5LyRuXnwsgve2a7emEVI7OCcTZWyZuFopxiuYgIwa/byEDttvWAUzeI1bgZ2Tw67emMswUeO0Gnj+9M0charZBLCIjMiW0SgCgi4nfUF1OSy0l/uGcmuRpyRv6Rq+68b4naMsEyPUA8q7d2I7qsuVCQ1WqoOPKq0pDcYmDWFaZyWzlo8vOFZUkSnGB+mdSV647aQ6lO2ZDZbllDqP3Pl2RnjBgg/a2AATIdI+pRNhGX9lU+uYDv1Gbb14qeNQLYCfbXGBkC9rowohPsEYFVZXzq0ux2MvKBGmoDEsbR16ZjdF6QtyxPxXRid3TElWxXcoLJLhyb6HPiGFgZnXWNr08QaGbEZYlfmuC2XeHDAHyfBjO/UTb4urn4RbeLLp3oJcDbjdpOgZ73v0H9JTzSQgrLNraFJWR1alU7cgL5DCtYr6jZvmaTqevSfB55Oypzyw916BuhxUUZAFW+Br+5RMBq+mit22/tSB9yuofknJAQtypshG72MpmHWpJY/l4KRV8pPSRm1rGk/W4f8DqAhuAXwdiQeh1XCmyBrZeT69aUKDm4x/hV4eyZ5mh7vBfWGxEGezVYjHL4QM4ctpJQyLDAhrUmg5BKkwjSM8AmUGOwoKBFYciS3Vko0Lwra1D0LBHeTAyMJX5TSFRo9SE9qd91MJnFzOw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(508600001)(71200400001)(9686003)(91956017)(66946007)(66476007)(66556008)(76116006)(55016003)(64756008)(4326008)(8676002)(66446008)(38070700005)(122000001)(2906002)(38100700002)(86362001)(186003)(4744005)(33656002)(7696005)(6916009)(6506007)(54906003)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5HE904boBIVxV3UQMrvGzCYzrwSHuRw5dM5MrVIKz9NO0ee59/oRvr50s1?=
 =?iso-8859-1?Q?6ZocZK3UbIDIapcaqRF0FhVU7WNh7ybzQ6FcRmv8hEADHk0gi12rcxIOEQ?=
 =?iso-8859-1?Q?g6UgS6GxLEAp7OZ70Zm3CDmsJneJpNj7pGmdPAWY0Nlxe5BybEbKqsnH5V?=
 =?iso-8859-1?Q?1FsoPApv/QNqHFFrQ+JYbVLc2Q7R8wTHJxtVGtniUueAXmRj/Db2GBsz8n?=
 =?iso-8859-1?Q?EFmwZFuJOWJzcCWGZ7YzRf1asn+310WYlPyav2JljHwP/7/igKd4whgj41?=
 =?iso-8859-1?Q?eq4rpD1yM9xhMOCh+zSTA4vZ/N2Lc0oiy/uihDAyxzJJKvEaFrFcNF39em?=
 =?iso-8859-1?Q?EEWZ1nFzys9C8cTcPmTbr8XOSNuCVI9DXaRSWvDpUh+lyc2YxbCDtg2nHx?=
 =?iso-8859-1?Q?sCiehpqY1ErMoM2P6/BX1H0rbh4DZZRZAdh/kFy/2pYOiMn1ZSNXW9cLBv?=
 =?iso-8859-1?Q?h/S5kSQ2EBc4i5wXpZskBNIifKDpb37h/BhUpvd+UO1M9ucGL3aXylR3Io?=
 =?iso-8859-1?Q?8CET2mnhgC9yQZK6qH3+VKlkWVcD2Hnrfj3N1YhdRPj85kowUIJEldW0sQ?=
 =?iso-8859-1?Q?bFr7i2BxK4Fy3Ffa8ODtsTF7y1OfFELaRInj+oxtLaeTnSB98eG+B4tcJ3?=
 =?iso-8859-1?Q?8W+jN9XtzgfX/tB3gI+YRwA9u1e5Y/QKloCD/asAVenXy5p97gdJqO9LL9?=
 =?iso-8859-1?Q?RboRehqzqMJ8th3XXZEts5qMYeZEWqB1tG15f1NkTxnp7JIONFYSTVSv4N?=
 =?iso-8859-1?Q?7jAD+tlr2z58kNHoAQsFhFCiQdNNTet0X77BQ81Rn35YBfznZPMHHnU1Zk?=
 =?iso-8859-1?Q?lnJwpzP9R/3diTFpfcIIju7Tr8C91QFjasTuPmjostknxTzZaMdv3Ts2qa?=
 =?iso-8859-1?Q?DF/XlADAtKQ6XIuzCPLz6sa2aKVfcFVLSRnsyMr1AP+U/U7PFNufVfnQsd?=
 =?iso-8859-1?Q?dfHCAtN3JrVXd8747frby34d+DmiDDiJxIYROKsjSLJkFEBKT0cQj2shhX?=
 =?iso-8859-1?Q?z7LtIxRKZVc9vJCOnpX6T0CL3g1IIkdyF6fTtcMLb2HroVdlo4B8IPYeko?=
 =?iso-8859-1?Q?xU4+ynmHL8Ll0VXqVVBv+2tdlMMotbGGyXNGkWc4scbH6wK+JMTgdLEh2c?=
 =?iso-8859-1?Q?/nGgwHz7REVD5AFN7O+90D5yPPc/QvEHiV7iDoSldvu9PEWc5OBK/Eo8Nu?=
 =?iso-8859-1?Q?T/5TsnGEkJTq9tk6lmVbUrNZURv7zEfxW7njUKhgzj/5y2l0yAfAcy2oKZ?=
 =?iso-8859-1?Q?57PzvLX0PSczjy7pgxZlOSUTrFqZiXXsP13M3btcW71dmc23Qymyb/8Bmm?=
 =?iso-8859-1?Q?ZJ0yUmiYlgd8r1PSA0KdHeLuq8scbsWup1HS5dWPGglHA3LTGak/hm2ajn?=
 =?iso-8859-1?Q?0jnBkpqQb6TrtZZOcv+rQMd5dqffmzN7ps9RcpW9z2MsBP/8EBuPAbRgtD?=
 =?iso-8859-1?Q?RZowPPjnQv3G0fqbL8MQpWZgnTF+nPs8F+TAZqUkU3VcCpSSujh/S2qHAA?=
 =?iso-8859-1?Q?DSBpgnIqQcKcPpISEXN2fjB5zNgKTvpntfW7aSQaNoB6RpAEITtjlY+vOT?=
 =?iso-8859-1?Q?8lWjphKq1Zw7XFZ18SZyIwzns8lsB0hjbsC5m6D9/HY4t4UlLd74gc8Yc7?=
 =?iso-8859-1?Q?QsG3DsdWMkFDcHy9PHhMVG71mhYBkgCcTZV8Iwzr/Q9YvQchARaVVgGXjN?=
 =?iso-8859-1?Q?fJVJN2KEBWT5PZbl0lIVSf36HC5Ovi17lAOZhQmN9K6gZoqEL+9j3HzW0t?=
 =?iso-8859-1?Q?glYKGO8CpRq0Azw81zTFZUd6SYKKKyqsTNUtHm96J6asa+GRPmGS3mzeP3?=
 =?iso-8859-1?Q?bxov24VX9Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd5600d-8db2-419c-4f6e-08d9faac805f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 11:21:44.4059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QVOd4o73oN15QziCSGcqwQJbThw1O6spLoJWO6H9fJjB5unTlCtAaJXp69128JnxoBiznd+GM1z1MC0WFV1qVytnrDgT6+ghVMAfJCoEhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2896

Hi Daniel,=0A=
> If I understood it correctly, you are saying ConnMan receives a=0A=
> Disconnect call via D-Bus, it is forwarded to iwd and wait for iwd to=0A=
> respond that the network is disconnected. Then ConnMan replies the=0A=
> initial posted Disconnect call to the user back. The user posts then=0A=
> Connect() which is too fast?=0A=
I switch between 2 known secure networks.=0A=
I have retried this morning with the following sequence:=0A=
gdbus call --system -d net.connman -o $PATH1 -m net.connman.Service.Disconn=
ect=0A=
()=0A=
gdbus call --system -d net.connman -o $PATH2 -m  net.connman.Service.Connec=
t=0A=
()=0A=
gdbus call --system -d net.connman -o $PATH1 -m net.connman.Service.Connect=
=0A=
Error: GDBus.Error:net.connman.Error.Failed: Input/output error=0A=
=0A=
I think that the D-Bus reply of the Disconnect is immediate and does not wa=
it for=0A=
the network to be really disconnected or on error, contrary to the Connect,=
 which=0A=
really waits for the connection to be effective before replying.=0A=
I thought it was on purpose.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
