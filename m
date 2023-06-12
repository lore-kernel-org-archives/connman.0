Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2083.outbound.protection.outlook.com [40.107.9.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA91992D
	for <connman@lists.linux.dev>; Mon, 12 Jun 2023 13:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHkppAzGNFa6N104Dvp9p/Jk/DTNZ7ffPyIeLa9Dlpw9ZoAJ4YmwDYFQYhOYyV0BwKI2XLLDPQmU5HQga3Yr00dbrCvfV6gCnrZ0rVoEAGM8KeacRnw02Uvf/OyDKEV9cMYNXhtawJk6z5C9rZSxeOy9KScZbgB1D9Ea+lsoVN3uS1tcjuQNTfQR9ga7NfCWydiblfAd6ujrJm3oA51j6t9YNqFQPlAZ5c29/qsYV8nQYiHadZgrbRnVwKZC0mdH/KjpY33b+ZlH2cijnQcdV2z1hUKNF3HonfM7Mqhy2D3LQAmLJjeIjKBieDrwyyoLoERPFUTiWjRejOuAfnQefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EHp1n/H2hGz9XunKm1SsO+gLoEoK8T81fnSL4+ogE4=;
 b=G9N8jrq6Mm/S+eYZsmgUTohHn72oCjpF/BCDsI43I0VBdQ2+d0mXuMTqtQ/Sjo1NeVvjj5p3ADKxgmo1BSvMhGS7Oj/aglTU9j0me0oCRR5jYaL9uyeSKejjFd3vL4uFsXD3pWgVlDDBF6ARbkK1bU1A7W7lOo1rC2kTCQb50S1WdyvcvIOrrXyVOr0IXE5EInNKPaggisZiGv7/WNLNBlOgyzoxSxKwR5CIC4TkXnsJ2+dDvylreHJErshf8K9XvmdBOB6MTt4N9Wj0ozS/RlbvN3cFZAG8aEixwLaKG8Jma5IaPkhkDNmHY1c/NZuXusmwqw3Naj9OVMG7ymnCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EHp1n/H2hGz9XunKm1SsO+gLoEoK8T81fnSL4+ogE4=;
 b=uP5X0myP6+pso4j2CJDYTZDc/3GCOfNkWpp2OSBT4sk8vC81grvOz03prQLCQgNkJVw9ASpW1SxGKOgFFUDT3TM8MK2i7RBRqdxuTxEmqYzg8abAYflBSSmMAEuXpRGnyO7EDSp07m1/7vAW2Aqb6vdMNlKKcK1u5P7PmU+pUHY=
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::22)
 by MR1P264MB2370.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:17:28 +0000
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b]) by MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:17:28 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH 2/3] wifi: Fix Input/output error on user reconnection
Thread-Topic: [PATCH 2/3] wifi: Fix Input/output error on user reconnection
Thread-Index: AQHZnTAAGfsRV+XtHEilDja3TMBqQA==
Date: Mon, 12 Jun 2023 13:17:28 +0000
Message-ID:
 <MR1P264MB1540789E4DF1693EFD84922C9354A@MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB1540:EE_|MR1P264MB2370:EE_
x-ms-office365-filtering-correlation-id: 259e2079-7c34-4a6f-6932-08db6b475ee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mJLogavhD0ULuQcqisyDL5DwpwyXbQ9fL9xG1RfzE+aq3Gbek9X9hRvn5sog+5f53iYkChTZLC03pH8R7us6Jo3uejm3C6CM7gaX0c+laMmrCB4Nt/PevHCOD4VY8/dcU7NaZEov6/O7Ql5Irw1uMbxm/s2L02zmaE8Xa/vphD9x/Z9FPHES736R4um3kSVDliuGWTCfryVZ1rfP71Nm/XkO5ERmGNXL3DYOeczeTfQeDFxA9HMvCBDQOpP+PmwQICkA2iAINMlk2HQYFP0op7+TlBgcINkmrfmSn+bTJ4BLECaSxVvOv1dZEJK/vCRSH6uJC5V2obu43oLsz1J2GfmB0Y4vWG+mXoiYThayzlnBYgz4nCIxIpBk4IchLjMKicH+jr0yNyXk4Q3stRiHN9MtZl+AJFMUNvFKjbjk1iEfDnT4cIDpMQMEJfaZAblAdwrdrQuetEHuSR8oeqKZ4dWZS6ZzgtBHY7G5FL4B8Ngc/suBlG/otpK54DBBLqibclQgnVsKxFtCRxiAO1E/ezTeYzQztnoAAxBXYObY+9pSnujpYqDRyVeydNbYr/lO2jIkR8n1wHaBlGTI5KCUZh7ksVgcO7MWjgyCbvcR3LdxUuIeSxi79P4IUW9T1Gb7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6916009)(91956017)(64756008)(66476007)(66556008)(316002)(66446008)(41300700001)(76116006)(186003)(2906002)(4744005)(478600001)(66946007)(8676002)(8936002)(5660300002)(52536014)(71200400001)(7696005)(6506007)(99936003)(33656002)(122000001)(55016003)(83380400001)(9686003)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dji6qRuRInajiQ/qCOI//EmLwFze9ZlxLqYGVLsVgVmV3UNyHRiWsIYGuc?=
 =?iso-8859-1?Q?Tasvjg4UJDpk+rK3APLBqNl7Oan/ysH1nHpogGdZ7TVNLtFl+/BFKBiWsW?=
 =?iso-8859-1?Q?qbbOf2ljQsyWMWMAqGTr8wr/rnG6pmNHfSl5/il6sqnzoIAiyGyuAdoObX?=
 =?iso-8859-1?Q?cOLvGn2dqEPvxqF/Q7Kb4IzWVMRrR05gb/bMkcMTiyb6LVeh8uzv1eqifz?=
 =?iso-8859-1?Q?/1fe7pc5I9/3Wrfep2btI0MqGsB92vTQS3uab68ceCkEVTeFBIy0Pb34E1?=
 =?iso-8859-1?Q?E5vF1Cyk6dhb6IzTTn144nbwwGNAkQYItZDmEyQr6k3vC0eht5oNA1Q689?=
 =?iso-8859-1?Q?VEHX7P4r7S3p8SnA6so0mW8yRFjaslUYS7Flg7ymd7n/7nr7qI5vKff4/l?=
 =?iso-8859-1?Q?u2s8ydExcf0vgkVdqU+LysPoUgdZPLHKTIFSq0hH23iT/o5jcqK75vG4Af?=
 =?iso-8859-1?Q?dmn2mQ2PiHri5ASGHrvcJ6RN6sIeRWTIhKGd2czsMKsl7ai+Qz44uBO0Tv?=
 =?iso-8859-1?Q?hc0SWpuOqsRR0tE8O8HWObCeA2enQuWZysEothUN4RlMf9vq7kYBObGWjp?=
 =?iso-8859-1?Q?NubOzN8DsKcBUNdES+qV0QvTOle4Mcx9z68m3NtFVIwNhadda+JHhhfn0A?=
 =?iso-8859-1?Q?c+Z202I+xAbmO3g+Xf+JOqSdhy6eI04xPa/2K4Hv3KmIgTcw0sj7Ch+YaB?=
 =?iso-8859-1?Q?gsRrkKG69G1MCpjHqUkevucGtdEy/tqdVb4n2bc1Uk3NUBHrx95fxrh9jn?=
 =?iso-8859-1?Q?B2Aoqef14dELUyTHL9MFA+TDAT2rqNVSB8iB0jMpahALeYLnXhQJPbUSkQ?=
 =?iso-8859-1?Q?7CBnV4SAWWiUXvoelemDx03wVqpu4zNlMSqjG0YgsmIZqsPeuHvcucXD39?=
 =?iso-8859-1?Q?mVkaB8atf/w9b0fPjZxgUhJC2CD40zeQvRM+Wzk5i6SJLVFw15cZ7pUesO?=
 =?iso-8859-1?Q?vGlrqvcT9ni/ZQUYSz2z7qSLYJW6aB67qBWRr/mnNXZEs5q7CctHnWWr+m?=
 =?iso-8859-1?Q?1v4GQZa4Mal1zKkJ1KjETQ0c+JjY45ILwvWuvbJFcoTv4ziFZDzw1rJiI9?=
 =?iso-8859-1?Q?OUggQ29E4X9slaIH2QHx1LoPm8kYZ/aVHECsm77VavPkT0eYTp9qlf4G00?=
 =?iso-8859-1?Q?Zs401o086qoSOQpPsZledLoKb5KZpos4zNw/4NK0RSjWZ6S2K+y1/WuFV7?=
 =?iso-8859-1?Q?+QmrwsYwZ1xQgECA1vWgQOSR9fpTzvUs5D00uHAKrGnrsgXyMxcn2FwRI8?=
 =?iso-8859-1?Q?LOidsBUY1y2exFKydm+37cwdjkcjA0nVfYVdeRB97DlTGWt9RWtjl6FNIt?=
 =?iso-8859-1?Q?w0OwoZg6DbocLNkPwLnFi8HwsOq1ATmCxja7YSnumq60ne9cQIcwy6wP3I?=
 =?iso-8859-1?Q?bFlWDh6Ggpt6TXH8WQeKviu3Iu0AE7wq5rxBlEMUBaKbTDCioSrVokv99y?=
 =?iso-8859-1?Q?pHUgriDCimzRdbA8BFTMQHbIcnVQC807jL9PlH7+yl/UH0GwqHAo7lyg7c?=
 =?iso-8859-1?Q?qBi9235zUxz7fdG/3ymuRXxRjw5Z25EWux6FWBv2BebollHeQieA7oz0SM?=
 =?iso-8859-1?Q?KZwXMe8uj4WdW/JILLkso/4cvSr3MWzlYm+wcL/I4/+3VWkBv/bmaDBofi?=
 =?iso-8859-1?Q?9IfYXhKg3+YMIY4o7I+eXqhjT/x47HiXPNYXzDQh94DH7PAH8GUnpcRrwq?=
 =?iso-8859-1?Q?c4rkBkVmS0nmsv8EQT7cXgokkjOBJcauwvxl1XnyqWGciY64zqSjgZy/v6?=
 =?iso-8859-1?Q?rzdQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MR1P264MB1540789E4DF1693EFD84922C9354AMR1P264MB1540FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 259e2079-7c34-4a6f-6932-08db6b475ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 13:17:28.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AknXa4xIVVsSJFilBVRyTYtIC4ZP7jGZWimF87tT9W4z7nAlWPLQCXv+FIVpHziJn5bV4ukZO6LLfQH0zjHz5lh1U77BSvyfDc4DyfP3YrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2370

--_002_MR1P264MB1540789E4DF1693EFD84922C9354AMR1P264MB1540FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Connecting to a WiFi network under disconnection leads to an=0A=
"Input/output" error, when the disconnection callback tries to reset the=0A=
connected status and the network is still connecting or associating.=0A=
In this case, connman_network_set_connected() sets a=0A=
CONNMAN_NETWORK_ERROR_CONNECT_FAIL error, which shall be ignored.=0A=
---=0A=
 plugins/wifi.c | 3 ++-=0A=
 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/wifi.c b/plugins/wifi.c=0A=
index ed7437f50b40..865fe0ef1e55 100644=0A=
--- a/plugins/wifi.c=0A=
+++ b/plugins/wifi.c=0A=
@@ -2290,7 +2290,8 @@ static void disconnect_callback(int result, GSupplica=
ntInterface *interface,=0A=
 		return;=0A=
 	}=0A=
 =0A=
-	if (g_slist_find(wifi->networks, network))=0A=
+	if (g_slist_find(wifi->networks, network) &&=0A=
+			network !=3D wifi->pending_network)=0A=
 		connman_network_set_connected(network, false);=0A=
 =0A=
 	wifi->disconnecting =3D false;=0A=
-- =0A=
2.34.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=

--_002_MR1P264MB1540789E4DF1693EFD84922C9354AMR1P264MB1540FRAP_
Content-Type: text/x-patch;
	name="0002-wifi-Fix-Input-output-error-on-user-reconnection.patch"
Content-Description:
 0002-wifi-Fix-Input-output-error-on-user-reconnection.patch
Content-Disposition: attachment;
	filename="0002-wifi-Fix-Input-output-error-on-user-reconnection.patch";
	size=1104; creation-date="Mon, 12 Jun 2023 13:16:15 GMT";
	modification-date="Mon, 12 Jun 2023 13:16:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3M2ExOWNhYzA1OWZlMzFhNTZmYmU3MWIxNzg4YmFjN2Q3Y2VkODJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFN1biwgMTEgSnVuIDIwMjMgMjI6NTY6MzMgKzAyMDAKU3ViamVj
dDogW1BBVENIIDIvM10gd2lmaTogRml4IElucHV0L291dHB1dCBlcnJvciBvbiB1c2VyIHJlY29u
bmVjdGlvbgoKQ29ubmVjdGluZyB0byBhIFdpRmkgbmV0d29yayB1bmRlciBkaXNjb25uZWN0aW9u
IGxlYWRzIHRvIGFuCiJJbnB1dC9vdXRwdXQiIGVycm9yLCB3aGVuIHRoZSBkaXNjb25uZWN0aW9u
IGNhbGxiYWNrIHRyaWVzIHRvIHJlc2V0IHRoZQpjb25uZWN0ZWQgc3RhdHVzIGFuZCB0aGUgbmV0
d29yayBpcyBzdGlsbCBjb25uZWN0aW5nIG9yIGFzc29jaWF0aW5nLgpJbiB0aGlzIGNhc2UsIGNv
bm5tYW5fbmV0d29ya19zZXRfY29ubmVjdGVkKCkgc2V0cyBhCkNPTk5NQU5fTkVUV09SS19FUlJP
Ul9DT05ORUNUX0ZBSUwgZXJyb3IsIHdoaWNoIHNoYWxsIGJlIGlnbm9yZWQuCi0tLQogcGx1Z2lu
cy93aWZpLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL3BsdWdpbnMvd2lmaS5jIGIvcGx1Z2lucy93aWZpLmMKaW5k
ZXggZWQ3NDM3ZjUwYjQwLi44NjVmZTBlZjFlNTUgMTAwNjQ0Ci0tLSBhL3BsdWdpbnMvd2lmaS5j
CisrKyBiL3BsdWdpbnMvd2lmaS5jCkBAIC0yMjkwLDcgKzIyOTAsOCBAQCBzdGF0aWMgdm9pZCBk
aXNjb25uZWN0X2NhbGxiYWNrKGludCByZXN1bHQsIEdTdXBwbGljYW50SW50ZXJmYWNlICppbnRl
cmZhY2UsCiAJCXJldHVybjsKIAl9CiAKLQlpZiAoZ19zbGlzdF9maW5kKHdpZmktPm5ldHdvcmtz
LCBuZXR3b3JrKSkKKwlpZiAoZ19zbGlzdF9maW5kKHdpZmktPm5ldHdvcmtzLCBuZXR3b3JrKSAm
JgorCQkJbmV0d29yayAhPSB3aWZpLT5wZW5kaW5nX25ldHdvcmspCiAJCWNvbm5tYW5fbmV0d29y
a19zZXRfY29ubmVjdGVkKG5ldHdvcmssIGZhbHNlKTsKIAogCXdpZmktPmRpc2Nvbm5lY3Rpbmcg
PSBmYWxzZTsKLS0gCjIuMzQuMQoK

--_002_MR1P264MB1540789E4DF1693EFD84922C9354AMR1P264MB1540FRAP_--
