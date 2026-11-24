Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479218;
	b=iUV3jx4dGnbxuc/5f7TAMhb1aiXFWIka6JiSO7OwQfNya5GJZB55MlYBqvyeSVlFc6vG
	 53xpWRe4sFpGR7fsfrz6PY8OgE+AYrkuOzvCQcH14KQ9s530AoI+bShW1lZ1gsvlAF26e
	 N5+yJUOMzLldxwja7mKptJaqAGxR//bulEwpuvgUSXhfTKhKj+rAtRbqmEmggqtakBHxa
	 E/1dKIFsK2DEx2ZWfR35u8wYKCRJW6uYvdCxALCzIe/c5ADzzxsVFVVtyS3WuE8v1loAe
	 bmCCW5tq6R3zvvqYTtNcsb5Cjj6gFEaCML94J5lNc8dw4jUefJ0kDGSSjoLTjBzt/Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479218;
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
	bh=QG0MftIquPfCJLvdYiGl1QL/xcOOmy/VHtr3OLBIPCA=;
	b=xs9K2FbXXcWa52RwqTjUJWzVA19UejKyqIowIpVqIdHctqWx24ugquiYKDxjZin8Qqak
	 j1TOchiPA6BYiqKKD8gUCHjgUHO++kP7Yhd2F31k2S3Jwx8/2arRrrkPHJJ8HM8Ud0MPS
	 KTMAuUrZMCs3U5JqKOwl+pcqVvyv9DKHtNt4ly9y7H5BcNmVlmYnRRB1aUpOLoEKaGddM
	 Zr3XhSMjWKaOsLn0RpCmxwTE4JX37jVnRzaCw73rqXlcFXpPTwnVOeQtOZjHEtK0YjO5P
	 TD0PibY3zt2GH5ab6Ud9Azqut0HXv5v++fDuuuKBof8EJPZosgbOu0rnQDSW8rI9JZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=FhUes68k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.108
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021108.outbound.protection.outlook.com [52.101.70.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10D606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B10D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=FhUes68k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDc0WLKlrGDDbAuW2Mzv9NGWzxCq16Bo3VjCT/CdcvZhM5nus2OAepFG+mPrSS9HbhOX1WKYXs3craMzlRlMDSnxjYj9oDyQUTnPP6rQnJZGZAXNODR+IvmQVxk4PiDWCVSHVEfOR3miCc3HXnGpyNPfEC6wk6NER3MtDsR6fRCDY7d362+ptDFImiMXxAOSTgv59s9VwlRf5Y1upJwPFX2noE/1kpYA/kifGDNd+WIz1KWahUDnHrMofo7izfbWrkm/WIJjoIyyjE68NcoesMfsfIwsq0nJdC7UDze5c57MpuKc7VupjxiPVBhQ7Zux69tqpuwFHD/1/Y9i7ZMGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG0MftIquPfCJLvdYiGl1QL/xcOOmy/VHtr3OLBIPCA=;
 b=nBNy2b3kkZVnDClAqBA1X40xkEouVnIf1uiGrdRHqZkFuU5H8QDSujD7RRbDcif2CDQrmmPEYqYUMMEDKTjZd3g0PTMCLUPUmdb3uTsSTciW87f35B/fUDIy778iwGPl8WFAFUjA3g/e0X3fXnJ3fOG7a0uqKZWDnapYp/vhkF3DxFrQCxRqwNqDbANEcPvsQUgdMQ/C6GN0Zg4ks7H/4CC32TgpMnWiTvpaUydvIVCGPiy/0GnENGJjqCw7/OoMLTS+ACWXaQ+LTU6gImSb7/dzcRRIMC3xgsF147yWfJ0jt3NIzFMXCGvvMQrO9l035ok9XxMXgI/fpjCJ6dq2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG0MftIquPfCJLvdYiGl1QL/xcOOmy/VHtr3OLBIPCA=;
 b=FhUes68kvqVjLASOaDjCbqk+T4jFXEIkT8wKBuDovKnpYuNSi/QpcgYUJWUur0Y5bliVmIP9OWU4vWe5e+gelMO3RIqzPybOyF8ERoJVvTCh/CB2UbZC/HAhd1YVlhOI0xNsTB4IXw9/awzPm6l3XS5k181fQDTwabv5oysAC3E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:33 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:32 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 12/15] agent: Add RequestCertificateAuthorization method
Date: Tue, 24 Nov 2026 01:13:08 +0100
Message-ID: <20261124001311.1161845-13-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0016.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::34) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e37d904e-5281-4c82-fc9d-08df49bfc60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261026135527099003|261022115727099003|261022105027099003|261021133027099003|261021130227099003|261022113327099003|261021135927099003|261021123027099003|261026130827099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QOvXAHmJe54oqIw62jglwXzrTWu1nqROpUC8p7CdEtLYZ9c/rvqTXLwg5DSwfKycQ4vr7t8MtBF+Ifmn/AjK7IyqetimQIUo5nSA6GHPA02e9nQRcSdyTmnnOeQT6y1JeD4hbuGImCsWLqjTteGVoyTtC02YWq5D3jAnBIFK7KvwHaBzQos1l/iaZUWvLrlOlXLO5/V4LXu3m3LO9KJmNJi7jX81D36FYkl88X/PALXoscz2lHSj74v+ltcTu6LBVrQA5yrStsPwnWzGP4Ci3+G6w2a3kB1CRfmVv95LDYoEohSIPPv/9B+oJKX7q/OTU2qByowFgKaS0k8Qceae2K3Tq+CF3LlpzuULNFzj38zYknCds+AhSCU7R1e/v0mTik+shyUpaEZbl9zGx/zlLpR2CB2drPKEXmIW9HKMQiBguQ/ue4aXIZhN43a6XamT5Bqg0OqzCHn4ILukfu9Ahet6DozPm6iqVoJpc99hS4R1h4qa43Wjwk5jgajzkZ/B1on0tGQ7xFNwmMngW+OuTKTrtkbS39RpmcJr+xA4LJZVzmgyK6vRjNt3ff7rbr6iDFKiIUhK6hOtT2G+tZZ/jgoTXSozq+B71MS/uwJ3SRcCcfF8r1Wo3VWEQiqEeqDZi3ZBrhrNwwuvudOTqtuCJLhSyjxLdBtXH1QeMC3UK5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261026135527099003)(261022115727099003)(261022105027099003)(261021133027099003)(261021130227099003)(261022113327099003)(261021135927099003)(261021123027099003)(261026130827099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQsH0aEm768BMxNEHo4Lit59PoyUYe3pqMtuXu18PBRj6safFf2eRuqrd83Z?=
 =?us-ascii?Q?V7KHQgSLYEkEfEve0cdCMiVrZDb8K1IjAiQKGnTWnOX8sDjHmvC5Kn6wYQ7i?=
 =?us-ascii?Q?/R2V2ZSuZo+Sx+RJyQgn8GFKqF133FgOrNYBr133ACEXQWYBJqR9gqvUZvA0?=
 =?us-ascii?Q?7Jxt++4+4JlmYX4lqJHM6Kq4uFix3agRd0V+n7bvkZNBqtsGhKDOnoQ1VpwK?=
 =?us-ascii?Q?YXhBEm+d9t87WujAjQYWgsoLBCOrSbYdlzpIhanzK4FgXBBQ81g4R8afA8Iq?=
 =?us-ascii?Q?KAO/s8Cu6mOC4T+8zgJ7g4Xb47a7LNpQ6aefU66/gsP+9mvvD4pFIu0f8SzV?=
 =?us-ascii?Q?mescruZA00KTG0kefKp9G+48vi76izqreHezd074k1JbQjC6LvWM3a0GPQA+?=
 =?us-ascii?Q?Mzy8I/ShwVTJctNkRLjsdBGEIwh6uA3OQbpvfGHz/BRAp5gTQehHyEx/kfZ9?=
 =?us-ascii?Q?CF+1S7kWNf5AkAPWxaIsW05gBeV70aCFOalRZJuaYczqINGKfQMetW3hZz+q?=
 =?us-ascii?Q?EUGCyWMgq30g0DgHGl3yWOAE5JGQZsmlIGQR/q5ifCqE7n9a+TfSy9O4Gi1u?=
 =?us-ascii?Q?zI8hEP7nkhQ1yzSmcQBKkiQzYEnezoiyjPwoqRIP6oickm7uW0xUr6cRLt/6?=
 =?us-ascii?Q?62T0rme3JYlDGQigx3AVALM0ZPpShnicZo0f7hsHCTX7STH+dWlvBUWm2c9g?=
 =?us-ascii?Q?lC3MZMA5sfcGS+uCeM3UIBCYuA6Nk2b1+IsIyj/Tu5zvvH/K75hEjhKOuCmD?=
 =?us-ascii?Q?KXAE3eB7Rzm7+f+7vpeSynJqyHMIbZS4Tf8oziUY5tqdztAj9K7r08xSDa46?=
 =?us-ascii?Q?dP/s9/unTRpqNbSd4+aCHGMgwJ9uMz0QaD2MEkzgKuBfiaYBJl6ctGMrlBIm?=
 =?us-ascii?Q?kgx8pS+kHonpb+nIpxBTe9+IJFzoBNJVBklJLgpOLmz2VxQbG2AptnI4VFpS?=
 =?us-ascii?Q?jPJ7dWnU0mqabqLzoGM365JSBfwp4Hi5A5dpffrEOZ5lTw84atiqB4N1L0G0?=
 =?us-ascii?Q?yLt/bTS0OEocx24i4xknzOlcNtvhzTQw1PZ+Oa0q7uPfbRktP6i2BqAW3Wzo?=
 =?us-ascii?Q?vq49dI7sWtfpheatOzFv/hCX8IYaIv7e4TBP1swbciMP4zLS02EJWpnkMzzK?=
 =?us-ascii?Q?cuHPHiKnROP5nzxkcw28vxNA2/D5UivGVsBARgccaNxCF6w6PziMcqYhLFdo?=
 =?us-ascii?Q?2ayc5uTstegJ8fi35LaK9F7sRf2R+TbSSZn932hYsLI/x3NzXUqG8gv5z+ty?=
 =?us-ascii?Q?12XqHfChXQAM+LzI7+9nTkx8qs8Td68+Xa1DuY5g6sLwjiq3kph4Fh4Ip/+f?=
 =?us-ascii?Q?sCE57dg+G6ssXmE/QiPSSyWQXauNwM347PrDuK9rj9VybG/IC8HBjct4mZRW?=
 =?us-ascii?Q?hn1cjGZ2xyEuvsr5TngwuyQiw7WCo9BxfZghFQQ4XTWMEeBvolnUxIER4+wW?=
 =?us-ascii?Q?lYIaZru7mFAgqyVPv81FO3iBHyxbXfZde7emPH6T4+nvypDJSq1CyvSSFNcz?=
 =?us-ascii?Q?Oj/M302ZekkmsK34bccXC5wwn2MDHA9O2q9852jk2IGyhb4O6K0u644lRHEp?=
 =?us-ascii?Q?itt8WsoGXlOaT6HO5msDYQbfODbyspMJZ6Sh+ZiPw4WGCbeX9/H6tTOLHEce?=
 =?us-ascii?Q?ZhhBsM/TSk1JhzhRRbOrU271ijuOM1m3QnwOSX/HXMr7Q2tkZgDiCRluYH1z?=
 =?us-ascii?Q?i1ncchP/Cta9B3AwuDD/G7NMwJaJWlhy9HUCAeDmEmu5soCZT9nNrbjReaFR?=
 =?us-ascii?Q?irBJoHLbSYkCNq+ADzjB6vSxFFcu+SThR/SkiR1/M3jxd80s0iyOxqU2fK1u?=
X-MS-Exchange-AntiSpam-MessageData-1: 2Sj/y2XGEtW8orkuSSYB0A+EV/VXgb6A5XU=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: e37d904e-5281-4c82-fc9d-08df49bfc60d
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:32.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEM0VXV9eYHc5fOZFy0/GWqoLbXc4DfujekpDuuSTmYogVkNZWoY9kCYmrnPYNlwvj3c4r/1JdqU9mhCjDMbCeNf/KuBF590qN3UDnXhVeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Add a request asking the agent whether to trust a certificate seen on
a TOFU probe connection. The certificate is described by informational
fields only; an empty reply accepts it and an error rejects it.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/agent-connman.c | 112 ++++++++++++++++++++++++++++++++++++++++++++
 src/connman.h       |   9 ++++
 2 files changed, 121 insertions(+)

diff --git a/src/agent-connman.c b/src/agent-connman.c
index 2bd33e04..61f43605 100644
--- a/src/agent-connman.c
+++ b/src/agent-connman.c
@@ -722,6 +722,118 @@ int __connman_agent_request_browser(struct connman_service *service,
 	return -EINPROGRESS;
 }
 
+struct request_certificate_reply_data {
+	struct connman_service *service;
+	certificate_authorization_cb_t callback;
+	void *user_data;
+};
+
+static void request_certificate_reply(DBusMessage *reply, void *user_data)
+{
+	struct request_certificate_reply_data *reply_data = user_data;
+	bool accepted = false;
+
+	if (reply && dbus_message_get_type(reply) != DBUS_MESSAGE_TYPE_ERROR)
+		accepted = true;
+
+	reply_data->callback(reply_data->service, accepted,
+						reply_data->user_data);
+	g_free(reply_data);
+}
+
+static void request_certificate_append_field(DBusMessageIter *iter,
+							void *user_data)
+{
+	const char *value = user_data;
+	const char *str = "string";
+
+	connman_dbus_dict_append_basic(iter, "Type", DBUS_TYPE_STRING, &str);
+	str = "informational";
+	connman_dbus_dict_append_basic(iter, "Requirement",
+						DBUS_TYPE_STRING, &str);
+	connman_dbus_dict_append_basic(iter, "Value",
+						DBUS_TYPE_STRING, &value);
+}
+
+int __connman_agent_request_certificate_authorization(
+				struct connman_service *service,
+				certificate_authorization_cb_t callback,
+				bool is_ca, const char *subject,
+				const char *hash, const char *domain,
+				const char *dbus_sender, void *user_data)
+{
+	struct request_certificate_reply_data *reply_data;
+	DBusMessage *message;
+	DBusMessageIter iter, dict;
+	const char *path, *agent_sender, *agent_path;
+	const char *type = is_ca ? "CACertificate" : "ServerCertificate";
+	void *agent;
+	int err;
+
+	agent = connman_agent_get_info(dbus_sender, &agent_sender,
+							&agent_path);
+	if (!service || !agent || !agent_path || !callback || !hash)
+		return -ESRCH;
+
+	message = dbus_message_new_method_call(agent_sender, agent_path,
+					CONNMAN_AGENT_INTERFACE,
+					"RequestCertificateAuthorization");
+	if (!message)
+		return -ENOMEM;
+
+	dbus_message_iter_init_append(message, &iter);
+
+	path = __connman_service_get_path(service);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	connman_dbus_dict_open(&iter, &dict);
+
+	connman_dbus_dict_append_dict(&dict, "CertificateType",
+				request_certificate_append_field,
+				(void *) type);
+
+	if (subject)
+		connman_dbus_dict_append_dict(&dict, "Subject",
+				request_certificate_append_field,
+				(void *) subject);
+
+	connman_dbus_dict_append_dict(&dict, "Hash",
+				request_certificate_append_field,
+				(void *) hash);
+
+	if (domain)
+		connman_dbus_dict_append_dict(&dict, "Domain",
+				request_certificate_append_field,
+				(void *) domain);
+
+	connman_dbus_dict_close(&iter, &dict);
+
+	reply_data = g_try_new0(struct request_certificate_reply_data, 1);
+	if (!reply_data) {
+		dbus_message_unref(message);
+		return -ENOMEM;
+	}
+
+	reply_data->service = service;
+	reply_data->callback = callback;
+	reply_data->user_data = user_data;
+
+	err = connman_agent_queue_message(service, message,
+				connman_timeout_input_request(),
+				request_certificate_reply, reply_data, agent);
+
+	if (err < 0 && err != -EBUSY) {
+		DBG("error %d sending certificate authorization request", err);
+		dbus_message_unref(message);
+		g_free(reply_data);
+		return err;
+	}
+
+	dbus_message_unref(message);
+
+	return -EINPROGRESS;
+}
+
 int __connman_agent_report_peer_error(struct connman_peer *peer,
 					const char *path, const char *error,
 					report_error_cb_t callback,
diff --git a/src/connman.h b/src/connman.h
index d86ceb02..1eb24ae6 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -123,6 +123,15 @@ int __connman_agent_request_login_input(struct connman_service *service,
 int __connman_agent_request_browser(struct connman_service *service,
 				browser_authentication_cb_t callback,
 				const char *url, void *user_data);
+typedef void (* certificate_authorization_cb_t) (
+				struct connman_service *service,
+				bool accepted, void *user_data);
+int __connman_agent_request_certificate_authorization(
+				struct connman_service *service,
+				certificate_authorization_cb_t callback,
+				bool is_ca, const char *subject,
+				const char *hash, const char *domain,
+				const char *dbus_sender, void *user_data);
 int __connman_agent_report_peer_error(struct connman_peer *peer,
 					const char *path, const char *error,
 					report_error_cb_t callback,
-- 
2.56.1

