Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479208;
	b=OlD5DrHSiSDLhTWA7Ohc2286MNdvR8t1QrJo9Mc0yLsphdwJ/s8Ac7z9NjXPa+7AUYLo
	 k3VH+6/cv8Um3e2L8Qoqdv8iS58fzd4VNJdXVPBR4J9kT0179hLumDVyg78sNKyFYqFGz
	 hj2A3d77CLCtP6c1y2lyGDb6l/wrYPiZyHNpzYgSIHu3mjcRILtcmEMOHEjWId8vQE0b/
	 SqbT3ye7YHbfquy+HIX4OVkCdvdba7mT9PHXMWSMD89yuh9S254SRuT9KWhmbHKeOHMdO
	 xEPf61qxaFmcq5sQVlvFzvT0PIqigFCGqAvr/3FC2Yna/i75lXp/FAH53orKgCGC4CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479208;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kq0e+hWBeLHV9W2KGOilZY3PhGiuQwobIUgYXO9SuYA=;
	b=Mu3KnQ5uSB8Bm6bx8wD3LTzlXmYQWrGciiRFhs8pK0ntmP16Ku6hXKBbpX2Ijo65uaBV
	 q9ugEXtFDFDe/qqPtQvC7H4ToN28Q0b+GqK9BHJswff3klruvAShggeSbEiWosfi4Oqwn
	 FDTEln2s4mSDU7RnbfvG4TCXLgVfA0o0F61fi0HmWhkd3995PqiK1S9J++6Y1oFVm+ikn
	 rhD1+S7y5BbBbWm8S3Ergnr6nIe8kULGxRkrSBzD+4BnXtS/q1b3W9oZcp5aK2qJw/u2F
	 AkOClweR4dssZXl18WdW79lRu5iWBvJYUXMIvOraHZ7wJAHMm/Eb+VfQ6b0BHyhFfFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=c8p5929R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDE606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFDE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=c8p5929R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8FyotbvgXH7f312V2g8tMZ2mrM6TtrLK6x9J7nUriw31tltjuPKErQZr8+63VvxL6xueQKMJpjtiPsr6eyC9pteemaUtn8hUYmlWhLuaoOvwRO/upUQrVR+L42nEDhUhLzrLnVPhNZTJx3rZIvFVHLSvcQEEa/JIndfKCElH/6Fak3sT6aiBtHcVpnqlzbhpvh1V9x91iC/tzYKB0srxa+2hwIhB4XAREMhtlr+q1RCbv58/h0YugTxpuNyd48Sf+zPmdRuj8OspjqS+OiySdmN99VzJZH3miqC8LZOQJsPzgQEsqeMGclfzgS1uAj4wfe+TzrTSqDT1HAFgFxxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq0e+hWBeLHV9W2KGOilZY3PhGiuQwobIUgYXO9SuYA=;
 b=R0CbDyVKEegNJjnhFqo1cxf43oQZxcujztvCEhbQvEGxkha7FOkUgS1mKDSq/TWJCPPPx8YYBbNLAFjLGPAMEDIAaJg7J9JZmeM4Tn4cOCMS3pb5t+FzQX7zJ+byqcSIi9wsR3422V+zsfS2r+1n6o8Goa5+UWyWiGc9hAugTx20oIqJ75zzUl/0/9HVL5M7b1NVwDpNr3eYGaE2CbepUBhYJWGND/2rtEFWjDH7DLNB43oXpY5iBuGC07CTTwWGE9KmsqnlrELwUPm+NKCzKfA02NYKL34Ygtr86iMHVP7honjPeLdEBA1EhN672569VCzSxSvNmSmFyXooQXEHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq0e+hWBeLHV9W2KGOilZY3PhGiuQwobIUgYXO9SuYA=;
 b=c8p5929RNwD7CK4OZk9A6BlauCkI0DhFQdrr3HRycMUsfJ4wg5oCUEllyf4g7k+5nCxbXRP91JR3zbJJor9XAHevqO2IlQq1/jo2nBqfCGdmCTImr4uzpi7wyy0kWbAXVwnXDw3XRmmkXmXIlG4v+76Tts/KcJ3FymjgWERI8Ms=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:25 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:25 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 06/15] gsupplicant: Add support for Certification signal
Date: Tue, 24 Nov 2026 01:13:02 +0100
Message-ID: <20261124001311.1161845-7-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:20b:493::9) To MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|VI1PR08MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: f67bf3e9-8a2d-4663-a1e9-08df49bfc225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	iphuaHgcVfmTX9M0gZ6mkGgkOcnA+fGVywB4oIFm73SRePOjJezpeVkVjX5YAq1KLx3E1zN6gZoZ8bbC2wKK1W0asX2N+915R4BgaapnYbXToikTNxN4f895lUHsavKy09tR+qf8iDNGhgwEvn4QIexoK068x02dgWkAzj31LzRiM8FTNbod53XukYqWYycGwHu95hijgnxpYgEF/yOINmr0b/d8MEYosusKU9Kg+viGgJk+yIeH6WJKQFlvqHDtr4/oZTjWXj9x015Hi6ce6RH/lBjY0BU5xfCWzWrbeVzPOUs1St88XZ+AAliu9pNEWHXxiAnUmzm3437y+xlS5bIa14+T34fByrQ3Gqj4AtpJw2mj2Ocu3nMzJ+ElwjASoTSlTDguWe8mUTaj+BQQSDA5b8cLOT4Fs61E/5zbNrPodYx3uboqDuurOhr90+IkjrO/yXqPdbz04DbxPE9TRFrK/wzHuK+18y6Sn/EwrJQNr/eVgI1p6+VZf3CsPjv3OBrbFlD6LVpCpzx+cuDzbfeniClzP9prNMRjt9zU322FJik9ZxGgouMDdKZ4UHYahv2H3LmtPr14oaRPpp6opGJfCJqn4Jmys116r6R8slAfiyFXDerQL3N2MR/7FHGIChqYJEWz96PHu03D76V228km8SMHH+c1kCkZ1yVSGLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4q3RIRnjAyhw/ugxwkF2tNTHE8imqwL1jekOnlYHi7lpBKDDLGKLpM/jo5jf?=
 =?us-ascii?Q?jDRWo+zqacaz4HL0+3DuS97Jbpr7f8Zpsj3nAXes1uD/uQv4PAZxIItfJI/M?=
 =?us-ascii?Q?n2Kjhis0Yg56CwmLH+RQkrZ9/P9S4dTWVE4kvFQmgXGZ/KSoFWRul+7F0AXF?=
 =?us-ascii?Q?rLCDT4lr4r8WzCUGf/tEtF3nD6QfC1NO6twVh59TDNqPjevgfgPJAEq/3mM3?=
 =?us-ascii?Q?O7pNhBrhVu9ovfhT1TgBwff0VX5tGIbmps3kraoGXtT0zbuBXeEVqnOEKxaN?=
 =?us-ascii?Q?4ieZv88mre3BtFlCzn6GGIFp/A+1hFxwsgoTw8NiMkdBcJICBQP16TEho+65?=
 =?us-ascii?Q?mQL1BWI0b2ffhS3cTfJuzOnhvAjM5/aW93QsIJeXNf4AZGIHo3e3tXRgXSWL?=
 =?us-ascii?Q?Y6H8DGH9qZjRN7CjixnCmMb0bIatRcT3dcv+bcTfMqOv6eo4NlMnuN0v0Rau?=
 =?us-ascii?Q?6Ioz+l/Vqu/5upKnrAcN6w8zIbq3D+cUT80RuXWHE71nVu6TnmM3HYKWYWHS?=
 =?us-ascii?Q?gtBQciIUhMjXpthXHrktRj+x/ZwKSo4P6bR6rPbnQLWLRwLs2P8wk0kHRi84?=
 =?us-ascii?Q?E2fNTKYJ3wo/X9l+zigpD+XrzilgNfIG1YSBo4wSTQpqydDNfyAtDo2xe130?=
 =?us-ascii?Q?U2Oh1A2Q/4Jq4VR39Jm3NL770zXOsoc9gLptFXd0eMAYbscrQ70d/AdLFDwo?=
 =?us-ascii?Q?k+MSCi81oZfzphTEi77ByABaB6EvbgdBA6u0Ykbvg/JWpFVhvvSGZvC/j0jg?=
 =?us-ascii?Q?9kxA20z9awyI+VdoanyN+Dd/5ltNve1YlyqHYCyTFheDSXmmUWAhqr7ZCPin?=
 =?us-ascii?Q?+e5sVYUfDmG/eHwYyuEJAVr0/PfmhEsBm1q7yMI+okO+yJlVOl90VL0pdSfs?=
 =?us-ascii?Q?mgcEAVurOzlJW7TyIjyUYh7aahW3RV5L8peva6JbMWUO9vHEWewIb8EfrLwE?=
 =?us-ascii?Q?ZGU3bbxb5XCBBW8dNEcNl28T2pb/c86KGVrdWC2vWT+CeaDMR8b/Gn14rS0h?=
 =?us-ascii?Q?I3WweCEA8h0EwUA2edj1g4+PIxBTxsV8wqg15zjJCDoHrgTUW43IMPcjSCMi?=
 =?us-ascii?Q?6IabV46giujJu+EzwtfRHsKLNNm9QGvtu88RjE1opPdRdCPlb6T4DgZBG2H/?=
 =?us-ascii?Q?f8xLC9vbnq52+UsKbkMqGp10xVZlRgUhPFhCPgXp1T2Ct2s6EnsMG8ESapt4?=
 =?us-ascii?Q?ZnKP4N2xoIlLRXsq27XrKXN3O1G6Q2cSuLqs6JCuZD3LPFPiiLs84fJH/6Xq?=
 =?us-ascii?Q?yYwDLIFxbdY7pY3HUR33WkYOSPBGcZOEMIL0vQRvc2prD8YtjgugdwL87LDb?=
 =?us-ascii?Q?dkfD7uPzU18mk9BpnWVQLwrTXWiIN0wALulSPwDJTFAmmQ3QRiwyOux5apkO?=
 =?us-ascii?Q?B8JYVAhxB3TXE8i0ORVazEUEVlCCEvqF0DB1a4BPuHTzG8OfaFFMarZYQArd?=
 =?us-ascii?Q?oXHHdoVEH8e7MVwBarsuSqTsFhJNPjCjw7B3kKEvIGsIQ1ZgpaHgGKFgXofO?=
 =?us-ascii?Q?lQDrIGXjSwIZnwD9WCvkbGyhPL3NqSJi/qfO/Ju9JOiGfS/Na/VyfoTIcMfD?=
 =?us-ascii?Q?dUgGemQu35+D/Bv9zaaE0KEBG012zUw/78pdGveJ61yMcjHKpvdGsu+mlGM6?=
 =?us-ascii?Q?Jfodf/8iY4gqjEuqTYOm/HKgqWARsAu1pUN3SglC2Nivfvp3iP0+f45jx5bn?=
 =?us-ascii?Q?4m6iZkRxT/DZCUNwms2PhzszaB0vgEpjxGTjDmjYh/wT6MVrnpROMWt+v4fc?=
 =?us-ascii?Q?zciLkwtdpQmK+1YDc++Mq9EuB+zh945qPEiDueChfs4tlDFKGJI6+4ZRHXnQ?=
X-MS-Exchange-AntiSpam-MessageData-1: m3371HfY4Q3SrPvWTKhTMLGUlfvASa2gCik=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: f67bf3e9-8a2d-4663-a1e9-08df49bfc225
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:25.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV5qRaTzGf03qxN89A3ixG30RU+9k143xPQrPyN4JqYSItv4/PhFmDI/fAjRCjM9ly8hWwWB5O2Md5g2UdmYVr1izfmBu91u3PCRmyZ6azo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

wpa_supplicant emits a Certification signal for every certificate of
the authentication server chain it sees during the EAP TLS handshake,
carrying the depth, subject, SHA-256 hash, DER encoding and subject
alternative names of the certificate. Pass these on through a new
certification callback.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 gsupplicant/gsupplicant.h | 18 ++++++++
 gsupplicant/supplicant.c  | 92 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/gsupplicant/gsupplicant.h b/gsupplicant/gsupplicant.h
index fe842696..f26ea8f1 100644
--- a/gsupplicant/gsupplicant.h
+++ b/gsupplicant/gsupplicant.h
@@ -351,6 +351,22 @@ bool g_supplicant_peer_is_client(GSupplicantPeer *peer);
 bool g_supplicant_peer_has_requested_connection(GSupplicantPeer *peer);
 unsigned int g_supplicant_network_get_keymgmt(GSupplicantNetwork *network);
 
+/*
+ * One certificate of the authentication server chain, as reported by
+ * wpa_supplicant during the TLS handshake. Certificates are reported
+ * from the highest depth down to the server certificate (depth 0).
+ */
+struct _GSupplicantCertification {
+	unsigned int depth;
+	const char *subject;
+	const char *cert_hash;
+	const unsigned char *cert;
+	int cert_len;
+	const char **altsubject;	/* NULL terminated, may be NULL */
+};
+
+typedef struct _GSupplicantCertification GSupplicantCertification;
+
 struct _GSupplicantCallbacks {
 	void (*system_ready) (void);
 	void (*system_killed) (void);
@@ -380,6 +396,8 @@ struct _GSupplicantCallbacks {
 				int reasoncode);
 	void (*assoc_status_code)(GSupplicantInterface *interface,
 				int reasoncode);
+	void (*certification)(GSupplicantInterface *interface,
+				const GSupplicantCertification *cert);
 };
 
 typedef struct _GSupplicantCallbacks GSupplicantCallbacks;
diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 4e096547..1f23c26d 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -2883,6 +2883,97 @@ static void signal_sta_deauthorized(const char *path, DBusMessageIter *iter)
 	callback_sta_deauthorized(interface, addr);
 }
 
+struct certification_data {
+	GSupplicantCertification cert;
+	GPtrArray *altsubject;
+};
+
+static void certification_property(const char *key, DBusMessageIter *iter,
+							void *user_data)
+{
+	struct certification_data *data = user_data;
+	DBusMessageIter array;
+
+	if (!key)
+		return;
+
+	if (g_strcmp0(key, "depth") == 0) {
+		dbus_uint32_t depth;
+
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+			return;
+
+		dbus_message_iter_get_basic(iter, &depth);
+		data->cert.depth = depth;
+	} else if (g_strcmp0(key, "subject") == 0) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+			return;
+
+		dbus_message_iter_get_basic(iter, &data->cert.subject);
+	} else if (g_strcmp0(key, "cert_hash") == 0) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+			return;
+
+		dbus_message_iter_get_basic(iter, &data->cert.cert_hash);
+	} else if (g_strcmp0(key, "cert") == 0) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+			return;
+
+		dbus_message_iter_recurse(iter, &array);
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
+			return;
+
+		dbus_message_iter_get_fixed_array(&array, &data->cert.cert,
+							&data->cert.cert_len);
+	} else if (g_strcmp0(key, "altsubject") == 0) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+			return;
+
+		if (!data->altsubject)
+			data->altsubject = g_ptr_array_new();
+
+		dbus_message_iter_recurse(iter, &array);
+		while (dbus_message_iter_get_arg_type(&array) ==
+							DBUS_TYPE_STRING) {
+			const char *entry;
+
+			dbus_message_iter_get_basic(&array, &entry);
+			g_ptr_array_add(data->altsubject, (gpointer) entry);
+			dbus_message_iter_next(&array);
+		}
+	}
+}
+
+static void signal_certification(const char *path, DBusMessageIter *iter)
+{
+	GSupplicantInterface *interface;
+	struct certification_data data = { };
+
+	SUPPLICANT_DBG("");
+
+	if (!callbacks_pointer || !callbacks_pointer->certification)
+		return;
+
+	interface = g_hash_table_lookup(interface_table, path);
+	if (!interface)
+		return;
+
+	supplicant_dbus_property_foreach(iter, certification_property, &data);
+
+	if (data.altsubject) {
+		g_ptr_array_add(data.altsubject, NULL);
+		data.cert.altsubject = (const char **) data.altsubject->pdata;
+	}
+
+	SUPPLICANT_DBG("depth %u subject %s hash %s", data.cert.depth,
+			data.cert.subject, data.cert.cert_hash);
+
+	callbacks_pointer->certification(interface, &data.cert);
+
+	if (data.altsubject)
+		g_ptr_array_free(data.altsubject, TRUE);
+}
+
 static void signal_bss_changed(const char *path, DBusMessageIter *iter)
 {
 	GSupplicantInterface *interface;
@@ -3659,6 +3750,7 @@ static struct {
 	{ SUPPLICANT_INTERFACE ".Interface", "NetworkRemoved",    signal_network_removed   },
 	{ SUPPLICANT_INTERFACE ".Interface", "StaAuthorized",     signal_sta_authorized    },
 	{ SUPPLICANT_INTERFACE ".Interface", "StaDeauthorized",   signal_sta_deauthorized  },
+	{ SUPPLICANT_INTERFACE ".Interface", "Certification",     signal_certification     },
 
 	{ SUPPLICANT_INTERFACE ".BSS", "PropertiesChanged", signal_bss_changed   },
 
-- 
2.56.1

