Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90072.outbound.protection.outlook.com [40.107.9.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33072168
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 10:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMbXneU+goURJvB+UsqDIhZDxgmxy9ZnhJCp9dLjuR0k/Gb7g6Axv4dzJyyDr81sAigvc41G/nhQMqGz46ffWvVcYd25OwfDV0fUsL5VDO5kLWRdEda9lGWCd6wNWdqcdgsojDNrGHK8CEKd/lBhN9J+c6X0PqK1i0N++OQrdBPOlNqjdp19nNAApZnyj8gNFFov/6RxVbC+kBPk+KEUdpjWA+lhUllzJV/UjKH4Li/IggNu5HlhkRFx6wNLyw9Ew2kGvjbHfyaCmBmjO7gpowl/IfWwolwwjYdNuBM3Uoa8yt5bnevR2Qywxi3bkrS1g/eOGzJN/vlOBHU9NTxoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H7wgBK84DKR/YjMcAm6o73uNRbWyCiYCxTABpl3pxc=;
 b=mPNnvEceoSUrGsu26Lxk2a/sSRW3sWW9rW3yxBQAl4TxMBeMLGatg3H1K0dleYf9ic41qUF0gGFK0uzLiz0+7DKxvAL+gZ95PgMz4ThuWpRx+xTY24smxuGnOJ40O5NlE7R2hXRZcOOx9OClw2UjpMsQmFre9g/YHll402i8wzTUgAeI50SO9wa3CTjMUxnkJbGxk6YHrYzharG5tfLTbaDy0UrYLTatBRcBGHvm2RoHEPX3ytErxMPLvOpvCX7QYqLwbZt7qcB0A6E1EnCJbeD62SbWkzZkdvPMWsz2Jmz/HybLYT3U2TcuKCYpuyWq1jRFVOxrXDN2RgtB15LR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H7wgBK84DKR/YjMcAm6o73uNRbWyCiYCxTABpl3pxc=;
 b=v6yl3REj80dIgs2paFamXeI3Q6fzok0Df+8eKrshlyUtEPoOrZMGZ18IW3AbaOJIK5kNNCk+8iGGbk7RkmHX9Dko1m5veDvdwytHErFXdUWyPTC0HMFj5wIGMwpz++bOTIauiXFOJTJQncp3YwJ+zTbJgdhybb28rI7ax1A0pEg=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB3396.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:21::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Fri, 21 Jan 2022 10:50:22 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 10:50:22 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Always disconnect connection completely
Thread-Topic: [PATCH] iwd: Always disconnect connection completely
Thread-Index: AQHYDToIeiDoGCT3CUepeyAMsEYbTKxqWabqgALCOgCAADDRYA==
Date: Fri, 21 Jan 2022 10:50:22 +0000
Message-ID:
 <MRZP264MB154465E0619D397C2859ABA6935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220119133927.1245607-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15449D2CB5CB2656550C629A93599@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220121074740.axzlpaj55xtzeg5s@beryllium.lan>
In-Reply-To: <20220121074740.axzlpaj55xtzeg5s@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: f96d01f1-0047-f0c6-9be7-de86ef2fefc0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d40594a-4303-4909-80ca-08d9dccbd31b
x-ms-traffictypediagnostic: MR1P264MB3396:EE_
x-microsoft-antispam-prvs:
 <MR1P264MB3396BBBCE16A483D42C05D85935B9@MR1P264MB3396.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LHra4HpXnziTjOmQFBuOnbC5eRRziBCQrnnQTnddhRSo1Y/JaoAc15fR/uPQaXmRnaU2WoopK/dp2bcTkth0FduJZqs9JmdXRz0q0VHE06tTGtjuh9GOQTiIdciDUQu6JNK3h6WfIiX2X8s3C7wKBjc9Ery/N/ZlNcXJq/LLnhPn9TNud35LZVNn7Bx+fWrg8Q28d1qIYRKmzJwcw+fPP2wBeOlloMDGoSyat5zAdAipNozofPMrjR9+tEoorO7LBc9zgd+RtySF8H74Iexc7YLC9tWIzxA2c49Evn/aNuXlakREvb7sJ4WzFXJ3mLcDJkrUka0es3cuHlPFrSE087IwwubRBQ0263XCombxV6jLgUnyzz3LQfkB8qk9TN7eem7U/9ZMFtDcEsCOAPfegKLCoVBfHtiWQZa65aQR6Ev9FaJH/3ZivxzMXmNgS9ZZCBg/cFGJCHPE7dGmphKDIcmVRS+Mud6TCEM13QZoNK09MfwrBDzka4fi/8Y/fFfLxASffD1xVHJNd7fCydyh24K9PpsPBBIVDwtPhtME5qwFcDy+U+s3qAXVuxKaWn3prqW2rFnyld7fExCXRMbN3nIOYuEiZyjJC4zgpXehbi6ga3LSp5h9BhlsorLEvjdDHmY/JORybGEQkGg5VZsW0qSOq3vus8UnGVSoTMI7gMYaix5cTE1ky69usQYa2lq/JmjxAaABstYgZf0vUneHcQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(66946007)(2906002)(38100700002)(76116006)(66446008)(91956017)(71200400001)(8936002)(6506007)(7696005)(9686003)(316002)(8676002)(52536014)(186003)(55016003)(64756008)(66476007)(66556008)(86362001)(6916009)(38070700005)(4744005)(5660300002)(33656002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?RIsKmKftkmp9G+ziCHv+xg/KJ5nVrpWyTLnlQ/qaYj9p0xDK/qKlmyiQ?=
 =?Windows-1252?Q?6cOlKgo9gTuafGdufOox8i6tSNb7UEYMdk/xowKJDT+f5y+hyVhounMA?=
 =?Windows-1252?Q?/vwEnfRGqHpO6PB70CKpocL76LfFX/owgv/qdW8QDOX+6TOwGpYyBE4o?=
 =?Windows-1252?Q?FftfDtlbOxceqGn5JMvGgW2dW/S5cIwdw2wyaXeKxsHzowbAhSvWrOdD?=
 =?Windows-1252?Q?5rLDHUu/Ap0C1cEPhD2LjH+jeFWIhYkIc8K4Gsh7f3ypZ7TEsHrMA/3R?=
 =?Windows-1252?Q?v3Wpx5H1QYBaIZnPRUk0WQDAmVXmP6dBbj65MO4w5Se98OeZN+dijgcH?=
 =?Windows-1252?Q?w9avDN9VqbKsdKuUI4Gheg3vTGC8GvHqXzBQnDF+Spg82MAK1LH6mzOF?=
 =?Windows-1252?Q?ny4APk3hB6JV720gnG6bfejyBbTjqlU0+i5uzg6o3yuPhkwTck5xIiIj?=
 =?Windows-1252?Q?9AcwGZwj/W/wWiqoaTVY4jKNA5sstqR88nIr81y2TvDTIouVFu0NHEzH?=
 =?Windows-1252?Q?CfHDRsszfVpPkc4pISHdpuFTPWSCKwmawM713fWlTRtoOeIeePSyOQKC?=
 =?Windows-1252?Q?mPjzmziV5Pcpp7bb0ktfYGcyK/nSlxK0SbAgcKliqC30Q6suceeAfyML?=
 =?Windows-1252?Q?4N5wR+CCcefTt5f/9TA+LA13M70Amt2ia6WKYuxidPvXUt+d9k6BCPa0?=
 =?Windows-1252?Q?oWiVy6kfJNWY3RyoPQxmV5cLNZaRYzkPZ4Cr9ysvJbEoavVQFC3J4xCI?=
 =?Windows-1252?Q?ZCJr6Me8mCKu4vEFi+uAJpkBDJ/HogvOBPOoQTXmu6A0rwH8kEWb2wdJ?=
 =?Windows-1252?Q?FN2QFp3Im+uhsmpc9jAcxxuZSrz7xKPjFXAwPzMnlIyCcRo6g/+GIKNt?=
 =?Windows-1252?Q?gCBoXyVaTSr0Fb9aBoV6lR7kmCPEfb0KKEXDockt1H4Gmhe5mIKbGfxi?=
 =?Windows-1252?Q?As4700NaO/ChMzZp4brS3kOQjpI4VjQ3B4px8ll7LBC21uz3OndOjEWi?=
 =?Windows-1252?Q?5W3t0SSeXdp8fA1lbjvcHu9SBMuM0kbJeiWc5XSOmGc0Bh2Y4j3DHfBh?=
 =?Windows-1252?Q?C8h2f0TXZTLtTz+Bue3NciPh/VKuypFI/V+2EmYrx8UFcNSqqqbFLA10?=
 =?Windows-1252?Q?yYgdHMQWv9A9zd1BwedsfUQ0D0bT5Sh6/E07fu0EAfrWzL9eYnEZGOs7?=
 =?Windows-1252?Q?8eonUy2oaXCXA+TIXpUJwDAhMOIgOPSWPRLyzWhIFOmo4M17rIWKaUDf?=
 =?Windows-1252?Q?wUb9Y7okHaOVdF9NWtnjZtU8AlNln+x9bYkVvlfTe1k5SS2MK18gOakv?=
 =?Windows-1252?Q?7wy7ZBo8i8M06A8aFVOdaL8hvn9t55asjkz6m0ewSnVqhrmJAuymi6sq?=
 =?Windows-1252?Q?sdDBin0Ev0ZzkaEo96QXFjPeN3DfeWGd51I6Uivf9Q9L6xyoANKqAZ4a?=
 =?Windows-1252?Q?9g1nCvW2aO0KacFa3dcf82iehwr75UlHwAZlKpxLW7lgQyxK5OtGQADj?=
 =?Windows-1252?Q?6F1BdAAgD2bqGJJmG+01J1zVvDlVbj6L5O09fFIXkMCveWNxx7LHrMxw?=
 =?Windows-1252?Q?YYCWM6H0chBbOlRdh20hiLb2EPlnh+jfoJ6wc9exRSTOU/odlDxfObAr?=
 =?Windows-1252?Q?cV7rDc7kVK6aCcT74Iz3gdEKr//W1yKXpDFZ9FQG5Zkhea4uM9vNP/tG?=
 =?Windows-1252?Q?zb3k+0Of6gO/oU0oIF63mBkNrPxQt63BDYGG5OMhp6+8eSfVFfhACbeQ?=
 =?Windows-1252?Q?IshdwU/3emDHdHIOZipZJyINLAoLJ6973OUosUX9AS8NtsAia+dsqxLz?=
 =?Windows-1252?Q?zcl0DX4noSP716zLt8PpuHF0zVe5/d1KjpYEvRg4pkY30TNRNbjUPi/+?=
 =?Windows-1252?Q?6XUnhT52DtYikA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d40594a-4303-4909-80ca-08d9dccbd31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 10:50:22.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc2L8ZSJ5uILO8z71rk+Qyt78ZfSzbteKdN6pP6oEXdv+zJLS9i7gyjV2NQ1HPu/4xGkjDsWHDHX7y+j9SLks1K/ZSC+3o5WuURH9uCVIgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3396

> plugins/iwd.c:254:6: error: no previous declaration for =91abort_pending_=
network=92 [-Werror=3Dmissing-declarations]=0A=
>  254 | void abort_pending_network(struct iwd_device *iwdd,=0A=
>=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0 ^~~~~~~~~~~~~~~~~~~~~=0A=
=0A=
Hi Daniel.=0A=
=0A=
This is pretty strange, as line 254 corresponds to the declaration=0A=
itself, and as I am using  -Wall -Werror by my side.=0A=
I have tried to apply this patch again on the current master=0A=
and it applies well.=0A=
Can you check again with the well formated path that was=0A=
in attachment?=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
