Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90055.outbound.protection.outlook.com [40.107.9.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65305173
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 09:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCveLOHxz5I8sfGyxC77vXxcH6f6+cVAV42TUuCXcuI60JzyjwGwJoqq/ibmPbwm3lSMR3wblKZou2RIbI9yEYYg+BxFKpOUWRzGX90LTRReb5Deu3BhbkeZOHH5axTlFRIQHhpGGvNtf9Oj/qVi2TNmVGW+CxcvkUM0CUm/b6fwU4VRgO2NGK+9JYzrkGAhu/WI79fLZXXQCjfuALW2NBvgo4E7WiQe2S+ITvJd/MkXkzhlYmaz+YO2ixUhGiyQbwcJWomJVaABbZ9l6j/9+FG4b65jRdu4ucjIs22q+cAkcSRe3BkkFOppUBhOjGfFhovN7a/uY7wMhYUhPhoUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8OTrTacd1SeC/cLD9S93hwjYFtA8tbtfPwaevzrAb8=;
 b=dYxG+lw0MR4HBXJ/Cyn/n3lISek6OapWsjNiipQ5HON9SYotGwhF1pFrjygcUlFyVkMamKl1iUWE+8jaxFkJuSSdVKjR9ye3mXGEuQNq/mqwMJY75mZwDJTQ4/Qd/+fC6fltxUnL6px16vdCsNcBkFOINhLZzSYywD/J5qrdVGTxOzLC89NdhJgIKXbly8nxwxxK8syLJYHdUk91qwCBdDtT198j9y8wDaF9hx2FqTmgjATzZsTSO+W5MMAMoWUV17qWM1IuExgyLBbxMUk/nv+XIuq5CXCOoB4d8vWmDdeYuFroazPz3fS9NgX+k3LmgUkxFV7pdFSiH+bsh4w9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8OTrTacd1SeC/cLD9S93hwjYFtA8tbtfPwaevzrAb8=;
 b=dEv6OBoEozGXhpGGOeCz4Q615xfl+9XUIgliomdOIzDVHJvh+Oo5fmT6zDAUCCrATPaj83kjFzi3I6hkPXGGRPyRaPb3kKYF/JJ2Jfq5sV6KIzShKpxLL0OZOyz/XoNt0VJSXz0IPt8Ed7MVkYUNY63KJv1ejgpx+j8DOs9ugMs=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2434.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:33::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Fri, 21 Jan 2022 09:46:08 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 09:46:08 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Fix connection with no passphrase
Thread-Topic: [PATCH] iwd: Fix connection with no passphrase
Thread-Index: AQHYDFmAlYvDnLQE7UaxuG0/i8mtL6xomxM4gAACMQCABIIQgIAAHwg4
Date: Fri, 21 Jan 2022 09:46:08 +0000
Message-ID:
 <MRZP264MB15445B020FFAC97DD9D86595935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118105214.1201110-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154494E627C59DCFE5854FC593589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uwmgupp-oHt2a9jahxE9V9pYgw2VbNfsHa7g8o32WiPBqg@mail.gmail.com>
 <20220121075345.pab7lvyb2hfrfsos@beryllium.lan>
In-Reply-To: <20220121075345.pab7lvyb2hfrfsos@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 33604b69-155a-500f-b3ef-8cbf1efc3a1b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed700c73-fa20-4f72-82f3-08d9dcc2d9e8
x-ms-traffictypediagnostic: MR1P264MB2434:EE_
x-microsoft-antispam-prvs:
 <MR1P264MB2434941AC55F712EFD323A41935B9@MR1P264MB2434.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rIxYFPUBf/QS+24BEO5wnuunj92Nu8ktNGl/KfcSUx52E2l+4Y2+B3k4wfK8/FbP3LPXdwut2k2XWmMPCMUpzFhMmrta2j6A8MP/qFxIhe5nzPBCneVuW+5GUTIiyMPqokfeOSnm05TlJEI1m7ED373HJNW3QrsGaoORdmnS5G3wGg4SwA8p6KTxmr36gvcAp2mAjA26G3t5HLFogGGi8Bp15omk2Z+cvpAKQHKYcprsyc9X5XhDqNR4iLUhTD0GOPVJhRZm2kR8EGxpZ3jU1eXCUVkvt3iBl/Ek6SZQPSntW90k9SdRjAGiLNRmfx8yWfpKf+LKQBu9IIKiE2LbAfZKPGSqJgfEMNyszZXMkoMI1+wAvgLbi9sQqXhahe7y3R6qGJRtac4VUQQhduYuCaQXjC02QU8WrwwWnAQppDyBn52weu/0/6KFIjUhQNWzcgU6EfVZex/7cdqnmG4J4w+BarNb2zu7SwQ0oY3l/4sDj+ueeB0kqASRltJwj4MXLXQaHN7zvMUCwnHWHLmvAOthcb88Aq1wHnZeaHvRYadRj1h2fPvF886XcOrGpFGQ/r0SdBDhA4hEYc+5k+vhWkjcB1yZ4dxfSijj/ATEsbacZT1itrkS2RNGDZa0QarmUeC4n5tQLDmiyTKYG91jg9wCKfq8E65eTHT0cdJZqXaikJ2S5Dh43dopV+KR8y24hfxYWEOB5y0rhLAQo2LWZg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(33656002)(66446008)(66476007)(6506007)(38100700002)(5660300002)(55016003)(186003)(7696005)(9686003)(52536014)(122000001)(8676002)(6916009)(91956017)(66946007)(76116006)(66556008)(71200400001)(2906002)(86362001)(8936002)(38070700005)(558084003)(508600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mXgwqlkyxZ+KC/ecavH/icW8fDke4cH1MqM+zOjLuq1eGZsL6LRMq+KCW9?=
 =?iso-8859-1?Q?fU3jX8Hw7M0IiVyuWV2n7qGGsU+tTW7cDrk9ELERVs3KFRJ7xRwWd93C3u?=
 =?iso-8859-1?Q?UKsv22Fp+cCFU5xx8LqoYF7W+O9rQsLKvst/aVy14/ngeVzabvQtpzGZlQ?=
 =?iso-8859-1?Q?RNgw5NHbA0hrN5DwI7jFEFwmz8y/5lpvslrDmJa0NO+gadZEuQJtHUwW0J?=
 =?iso-8859-1?Q?bYf0ZmTE4UmbgmLYylQIy3XjTNifs3hrDtSZnftdg/MfgJGjQLA6RdYXrl?=
 =?iso-8859-1?Q?LMdIH8HJF9ON8OVzW6eHuNbZJf5LSHfEMpdHNbKtfBuG2lphhl0nyq+abX?=
 =?iso-8859-1?Q?QW57D+i4F0Un6ijtpQclWa7CtiGQzTNMeofJAcpd/fd1MdN1K9dsPA9WrQ?=
 =?iso-8859-1?Q?htwxUgs5tmvnGKD98myreXWqX89VeVcVHnI077n7n35vaFyrHnQ5VU7JU7?=
 =?iso-8859-1?Q?mhqQvXL1hJYQoo+dEB6BGRDTZcPRicZKzTDC2oOCo9kkmAuFl2rrWeXMlf?=
 =?iso-8859-1?Q?R7FIo5zHIjwPt1UuIpMQRfM9WwUHbGoaGu0wKqksrrJNAgx2CtZUgj4bP/?=
 =?iso-8859-1?Q?rYHgzY2q8YZv4zjXEZFMJDHQf3wK/rv3bXlV0bjrDhOCOAEJzCdh35Z3Iq?=
 =?iso-8859-1?Q?DfE8gfwGiS+QZuocjc0JFmFJ2XXjRi5ZBwIrguDGhimP4nSGYVy/WObQu1?=
 =?iso-8859-1?Q?M6QnEv6dAaMlcG/HFp6YXSyRa7AUkCv9iRMvdmGEzT3+8wuvCYzjpp856m?=
 =?iso-8859-1?Q?TWzzmGfam3Psq+NMBpvogOr77HDWfDoKiZ+ne0zVbWvzFhNLC9xjtcHHSp?=
 =?iso-8859-1?Q?mxEVawJJnsUrYuLEKR0oHKP6PBBHWGpThu0H7AO/bzn7U0sykCf7jbW3sr?=
 =?iso-8859-1?Q?ap7DxcZO0Wqx4c30hZ4pWhR+4K0QCvKwyuwbMmIDn5JfNXsAopWJDTzvTu?=
 =?iso-8859-1?Q?djy5Q6yEEVlGRTqpA1oYxUkdO87x9lDVH82M14slaWEf3VPDqozk0p0KoA?=
 =?iso-8859-1?Q?2CwjtwHtRRB95STJBlfq4ZPR9a3l2BRCtajhStBpO5MJZAnPvz3XbtWoOP?=
 =?iso-8859-1?Q?C0mf9TEEOcPJhXOGPV9Rg1SCxg1+b94FLE6AE4iNWfvbUWmQX37srBFuTf?=
 =?iso-8859-1?Q?19xVh740b3qiIthl9mX4aDQCSCOwMXpZW3WgsyxbfrZ5fDJGk9wYQyT9yf?=
 =?iso-8859-1?Q?/NUIHNpRwrQ01W+LNCvz6OV6ff7iIDjhz16MgonJCFAy966Freba6Ti1/F?=
 =?iso-8859-1?Q?4NjBI8k3x2B/ckr6JhHU2YWQLce1rfZ1HlXFoeHFYtOiZD2mdS0EBjxSK5?=
 =?iso-8859-1?Q?Xh73IFjNhxWqcMfEpCacqIB8gG3mouV5dHUA7Lpf3Qi2ewS7mKDBwYCknJ?=
 =?iso-8859-1?Q?mx61Vp8uibv48ZSXosDzY99fcGZ9C6+WkLke6bhZbOswq+iscPN1l35mtH?=
 =?iso-8859-1?Q?SYRhRCVhs097S484SJKHqmRok79oEgfbvEa4gGER1IPJAex7SbXGMsMGUu?=
 =?iso-8859-1?Q?B7RsdL6XpSV+epQ4RVpDAMytPp+91OBckwD53neF7h+iKSKHeunCAp/j9s?=
 =?iso-8859-1?Q?HvrpngEKguNIyTIjMak9vzCrc2FTJc/70z3DBA1i5HU1xEWB34eEzIP2E9?=
 =?iso-8859-1?Q?pSiVyL+jGVUH6D5zufZsMlFb1r2n27b+RHgZVK49TrFLJ9iFQl565/0RdQ?=
 =?iso-8859-1?Q?4d5RArsc2YTl663C9HdXPSonFslQ1cgA/s1JtzIT6510K4xbSlsH6lB7ov?=
 =?iso-8859-1?Q?MiNZhfqeCpvTi9FiVz1fZA9Mk5cke66d1WVzwFgcgVdOu3I5VGXzs6vA0W?=
 =?iso-8859-1?Q?jw247N/pIQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed700c73-fa20-4f72-82f3-08d9dcc2d9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 09:46:08.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xg4YBClXUDSRAg1rS0BS0IXb4gCmKxNyY9cdxEiuIt0UtRL+bOpU6ZeoHbb3kKwtTta3W2dhzS6d3RUTSmpb0rxKVLmtwC1/FgrrTwt7M3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2434

> Patch applied.=0A=
Great, thank you Daniel!=
