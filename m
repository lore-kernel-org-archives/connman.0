Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90053.outbound.protection.outlook.com [40.107.9.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D13FCC
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 12:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoMfIK372VJ0OSuVJY10Hv3WkArQPAvdsnTEnJGyiWrtQJkjIHJa7jNrnfXnDaFdOqa0M2qDvIBPcj8LQdLDfKXSCKg/FufKneJnSOvPgCoEGk/CE2lHk7p/DsK8C/kgcan/X8UpnWAXnRgwfGjSj7yxYy+Z2nYPaxnRija/1GvAwsn/9GZUYM30bXx9T/+ibatlV6XBN47K58ZUBqWcrM6gXr8zVfP/xEZmqc0qftInjQnpMssYEn6Cs9LiJtS5k1L3YX4oRRQZagsyyAOW7o4iPiVooZutWTrJghW4JwZxkmQ7UoT4Tq7UBfjcwnJni9MzR080iiu/t5x8flRZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUHbbXc68rd9jvp6yQ12N4pYCak8If23LOGo4wqzOIo=;
 b=EdU4l8bsnhmq6LeYTZ7CXHdT8xjyg75RYPYnIbOQvVcvfqeiOhqaA1786JrWqRItuHNouwPwvFBpKxAK+GOSOq14bBIjMJwu1Fcvjqm6vWtwSm6CBd3HpXX9NVTMLpPz5a/J88+4+AgPX0Op6E1iwN5X0VfynOaDVsrT/afouzlus10Avlttvus1qmgx32fDrLeW3hx3WHDrO+KbKMbGyYEHeS9+p+wHZbQpG1FLxjPaRYWMcgwdl7+GWFPnRKwsMfi/N9pWnKAoVOlgs9wHktVbUb040HJ/jwoTmjG5IGNe3NxQuiJIeXcZGcMORQGgKXIptaVAR3n/dAKhHNyOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUHbbXc68rd9jvp6yQ12N4pYCak8If23LOGo4wqzOIo=;
 b=Enj4myeXrMlxtPpyM+a+Ue8j1kuCxtO1TdxSpPPzXvhotBS6FaSaxgaZSY9ve7oeqtWEzYAFwgkH7hkwu+DqUAYsdBEraz9F9TfaQXxTnHR3X4WWXvbZL6grZZ1Ka52O4Um2oXhQ69h5RQRJepJmId6OGBEyr+x3oJEU6a9I1Ck=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2769.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:36::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13; Fri, 1 Oct 2021 12:18:32 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 12:18:32 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Fix timeout error on new connection
Thread-Topic: [PATCH] iwd: Fix timeout error on new connection
Thread-Index: AQHXtr5iaLg7SqSbJU26UnNZDOHuOw==
Date: Fri, 1 Oct 2021 12:18:32 +0000
Message-ID:
 <MRZP264MB1544D8BAECCC6E7436D85D4F93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 8570f19c-9f2e-14f3-a2a6-1b5997284114
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04ee526b-d913-411d-9a9b-08d984d595fb
x-ms-traffictypediagnostic: MR1P264MB2769:
x-microsoft-antispam-prvs:
 <MR1P264MB27690E4DFDF352F9185C8C8193AB9@MR1P264MB2769.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5MEbBH2VqbRSt6NKMRVnyFNs8J751siNjgTstxUq0bJafZxwdR2275wCdkM5TlFFjR4KBN25xQY1JLxCrsZo27l7qPcpSbs2qw+zFd5DrfDLwDYTTUYfMwdMUBOBjuP17fOM6yy5gn2k/J071SFxjr5M+OPk7zdymNf+jMisM36J+Thm5rMzK0L5/uDbxO4CJn/y80U/9L60ERsfRm98ueNrvzGONo+u4jQGIXzU/3u+O4Tyu5vRomXl/1yIJ2cJbmudEet83EI2+yfBW8YaI/a+5dWVgAsOylFFUkOFDiJEun8Ud1pF5QYL/zZu/pWYnZgxxT25PMViny1Gtnbl/c+7ghZEWkKPiP51A2IQi+HU+MG58F+MnA1/66PHM+GuGYE9dUEMJoRTL8lM3JisM2klPh9Fc2jpkrG+oktuY+bdL8WzQN6pkjnHmuoO0J5MIToh/oHykFKY3GvYFUOUoil8pNOdWLDmECbDhO7suPQqf0Z64i6vb3B9NK4HAkLOZkb2llRTQfgveWoOatIbv9XoYza8dQgCBOWPGh+emPhp764B4O/u/UrguzC38b5sMsFI0S37aFFdsJlnkw6YByhnmIo5doY1t6W3DjJU4gUtda8PIOSTn1R93D/lwlmWMMG+Dd8S/zDQ1+3FQzFVHR1Zyhn5Utq3PjuqNTmueTaC8RnvpcoMkqBwuWnd7afNhyzjz8AKaxKAV5x6bdES9Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(76116006)(8676002)(8936002)(33656002)(66556008)(66476007)(83380400001)(91956017)(55016002)(71200400001)(316002)(66446008)(5660300002)(186003)(2906002)(64756008)(122000001)(7696005)(26005)(86362001)(6916009)(38100700002)(508600001)(4744005)(38070700005)(6506007)(52536014)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7YNu7dYMOM8py5WCQgkQbaOJekBtLOptmGZEiDHODueOycYBbMjr4akZTw?=
 =?iso-8859-1?Q?nKSfvXA7nKMvcinhrmuiHAZBjdRRsgAJnR4DgNKlX/CTxqZVXzx5bAm47k?=
 =?iso-8859-1?Q?kWryiVuyJiVepJwuxw549cK+Tj4xX+1Bb+W/WfBi1wVBQXzLVPoIz5xkHZ?=
 =?iso-8859-1?Q?lF8Rwfn48+6j/gENeu8jZAZQTjoL2TnRXqR9HQoR2F7rcepdsPZplJXYYY?=
 =?iso-8859-1?Q?pug8LLuu3ZcZHKgv7Q0EKda+0ZfhYu9rYwvB5viBCs7Pcr4GWs+nlAw33T?=
 =?iso-8859-1?Q?VsvIKmfHH0wxk7oXfyehle4TpEOY0Tt/cVigsNPQctI+fPMFXet8RcEnbb?=
 =?iso-8859-1?Q?1t0Ok4vJvk2h2ct0qiIfJgTsaQk0OLSnIBFLpJEUFa+DJICVCBdCWRZYGH?=
 =?iso-8859-1?Q?JAWz6RRrlHVyz29T29fm0g5GUQMU+q/kDyocfFGOGZVA/Q0MNAg3KAuaDn?=
 =?iso-8859-1?Q?zddjicxZVfx556T5+w99YL7NBeBfAcz1gFUhhQlLa7cIToFOeh1zImYSbZ?=
 =?iso-8859-1?Q?9yJcrhst7uMF8WNEDpMoSezlYEcS9SV4yYejtLsCAkdpiuyH0/CJgcfqQC?=
 =?iso-8859-1?Q?eAQTDTFWPLf7dujfr76an02NzqxEROxe8R2a1AvC0u95Oy0M2mhK9NACL4?=
 =?iso-8859-1?Q?odDazcNia5Q4eoNau2gEdJoQA0O/yl/MCXTQfMO/ynFxjzL3M+JCilc8xH?=
 =?iso-8859-1?Q?rh46qNOkkOERT6cHUcEmdA6zM8fziLMRLx5Y5GpblNxoe/i31rirxuXSXX?=
 =?iso-8859-1?Q?K40XtrMz8OwoNuPaL2x8Nhyyf4ckiFpzjfp6KWJDag1jiUIuQwtmpzJcrg?=
 =?iso-8859-1?Q?hw+gduSRPlTw/j9pzQLDtn4OAPJxz52qL5eNdqxwenCxknIuQ60pz5JaiV?=
 =?iso-8859-1?Q?kB7v/QihZx9YQponkKkxLYAA/7s+DrWNgRjxELeC+sVcu5rbtVNSXEK2BP?=
 =?iso-8859-1?Q?3R9yrCsWCbBU+Ja80d++kXjH5V9JAQVD9xdJhCI9D0dM112+2o22c1+NEE?=
 =?iso-8859-1?Q?6LN4eCfezgGNSztcYlgri3hYnP+rG1KcwAEo+ac3XFueOvurjek8TcGz/r?=
 =?iso-8859-1?Q?B/0mEfya75OxIx37/WlBDqkj+T6VVhxG7md0/ilvDIJ/Jz74tszzsiT/kh?=
 =?iso-8859-1?Q?/VngbVFFh5UuaBe7J/iJfJ+lYJc5XvyB4Y2hNoZOJkD8lJ65fQVpo6bhYm?=
 =?iso-8859-1?Q?LQtWNEDKDa1m+pKy71TYHPc1Nr8kXimmLuvqPL6wiJ7FozwnFQLVP7sNvl?=
 =?iso-8859-1?Q?+O2R6gEo0WD0tSNjCiiZPz5ionmH3+c2HO5nY60K63kIiB7uVx8Jhal9zz?=
 =?iso-8859-1?Q?JmPFIDIwVG07ZEUK453Kolcwk4IWMhbYcwenl4GuKdJ67xM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ee526b-d913-411d-9a9b-08d984d595fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 12:18:32.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olhcZIfuKOX9JQtAVQbUhPTfOqjXyP0SSCqvUI4IKhAlfWoW2gN66I/XnDx/nNZJ6yecV05Ij49GqSjd0nB5qNsuZsFdxPEJ8vyALGzVgLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2769

Before connecting to a new network, the currenty connected one shall be=0A=
disconnected, what always failed with "Operation timeout" error, as=0A=
the disconnection seemed not completed, cm_network_disconnect=0A=
returning -EINPROGRESS on success.=0A=
---=0A=
=A0plugins/iwd.c | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index c1c273ef4b3a..ec9a4574cf2d 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -317,7 +317,7 @@ static int cm_network_disconnect(struct connman_network=
 *network)=0A=
=A0			NULL, cm_network_disconnect_cb, g_strdup(iwdn->path), g_free))=0A=
=A0		return -EIO;=0A=
=A0=0A=
-	return -EINPROGRESS;=0A=
+	return 0;=0A=
=A0}=0A=
=A0=0A=
=A0struct auto_connect_cb_data {=0A=
-- =0A=
2.25.1=0A=
