Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479223;
	b=5SggVCVxvxJADLlxswLU09F1e7UFoaAfkFAM4skTBBvRhi8+JbKA38PYELT0+Ma2SkqB
	 +unUc8RZu5M43eDCo81JGksRESPb5M/8j9v/m5m26C/Iu6B44NSh9QPsBpfdzPOofPhp2
	 +pvHbJrGl5DI+z1IRYK4y4aWF7kyyytS3sCnQ9kF3aOFTZrIVLpeqpsMuBfaCZYVCFCO+
	 2y4L161oXAYBTBf/PX6xHQcnKff0mGnnWGAfoyg916FMwW5tp2Gmsq71Zhbg1u2JRcp+t
	 GAYeZL93YawOoR9GQWvptIXW1riHiBbsfuE4G1SNRKip+NqU3JCrxULK1DnfrdIDDGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479223;
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
	bh=UtTZFZ6SknBo68L5QfiwiAwVXoA3k5dtob2uGP7fAhY=;
	b=Rc17mmkXdFOLbG329Sj7xiUGEcQE5eOcYC9J1tdY32PTKEGNY5AOu/s5373Wl/BvP85a
	 PDvVoRa8zy6p0YR5k9toB0xMlN+yTQBD05FV6hZq2F8hIO1F/bm4BEjVJLI/a9fJSPGyg
	 XaVrmOx2DM5Z6KPXT1+AaHaJGObojkNpKmuZQ/Kh+paVnad7bUK2+xm7TY7V4SEOiJ5BZ
	 TdtH6smrBBBl48yWTm3kbMvqJuEvhShHpjWJb7GQ6Z1kIkh0B+s34m13El3cnIQ4zSD4c
	 K0aF+YJBnD7PbhOJ6QecWfAXDVEgOCKpJdcBrvtMgnT6qsg+QbdJkCC8QC0edoGZ2MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=QTKwwPRt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.80
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023080.outbound.protection.outlook.com [40.107.162.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D737606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D737606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=QTKwwPRt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMJCvK2Cjtz+Mct+qJ0xxg3QZGzNZddcVqcQeE6H4tXEXyJm/C4esefFFA1A0iBrBf4om59KXOepKObRn/wYIp7ETGky+U9cqz4RdLvZTAW5VFbeMfbyijYHqlZArrLAVXTNp5Ta15x5rx8ZMxTbLOxO0vec7UR5qWMjLsZBHDi5HRK3CBxZJzKM3vcK3yjyH0HOBLNd81xIpcluR9axF/DBgst+ZlVfKVsg5kir9Av2tJVssYaWh3FnsbYsnsaCGjEvvOkHvjnDzBanEskraPDvrJmGFq3IB2oBytmMmgXXZ3WQu8rS8wZuXVFwwEX/2Eh8rYBrzSYQaB2mMrAd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtTZFZ6SknBo68L5QfiwiAwVXoA3k5dtob2uGP7fAhY=;
 b=AzTkrvToEjFcqePVB6Mw9cNqF+MpRjyKd4wkhV4sGQWXNjRoLOYnqjbtcaWkhno3aAIPamLAitdnZAmW7aPJXUcVbsDe09rNugaqXCU24L1vaN1Q8xC79GLhGqVXnzANlgCyvFlz2f0XMPb+xWj8e0BbxBc1AiyDA8/52341sEux6tjQTl7yG7TjFToCksRJU+B34oi93mi7a+arIbvX1F0hpJSOe9SshCEjHlgVNa3YiZdz1Ds2QpZwzXqw8CRpX5R6eiIKg+QgdPg+LReqIxNUqAzkNefKcBX5Zatn7Zo39kqYs2eOOVqk4r5x+gtjBDA5TIe+J6Ns9JYWVHDUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtTZFZ6SknBo68L5QfiwiAwVXoA3k5dtob2uGP7fAhY=;
 b=QTKwwPRtMNXILzUXM+k7ztCvqe1jzAptNQB/T7K8xSb4/lFZKUvUVkzg41L3t6d66EYh+fS65fj4gx0k0gy3BU08tbTzpwodBvxWG6Ssg9/d59aBe48WPFdJl09dpuPYdEaa9Mo0CvOqUHutSIYf354dvR4Q9pxzYbpLEcQd9Fs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by PA4PR08MB6063.eurprd08.prod.outlook.com
 (2603:10a6:102:ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 00:13:35 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:35 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 15/15] client: Add support for RequestCertificateAuthorization
Date: Tue, 24 Nov 2026 01:13:11 +0100
Message-ID: <20261124001311.1161845-16-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0748.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::15) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|PA4PR08MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed7f629-d599-43ee-b908-08df49bfc82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|786006|366016|376014|1800799024|22082099003|18002099003|261009223027099003|10067099003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	sR9bJCRlisyC7ND9sVB0CRiukQQriogReFC30XH6y3CBwYzyvt8uQ+a0pdma2SAxCMvKqS3E3nUlzNG2se1CnH0p3fNhsNSdv0f5msLh/lJga7+/Wg1yuuBXqqDsn87Qv8ftk0dYvqJlzH4bg1mluYGPrV+l6vaiBnV4k/Gnu4ps+oNMW8mB4s+6f+nIMFLRg8gsdNj8dfY41SXjO19kGPIMO/OLV8tD1aVT++Dg6zITK2z7w2JpJGzwvg96htZz0ZSpvaYh2z0ErH37jO2LAbdRW+jxhmVoiN5BS80LM9Fok2gTVhWy+UVsWHTXZrKeqx4PwqkZD9A/XOw/K5L5MGO28ZG/mRxCnNXvgyscg5s/9CRdMqNfx3ahIo7Vu3gq5Lx5JYDT7WvG6Tdrvol82zXsvSmyF0hEG7I6w7bSgYkNYocNO/+P/bBZksTZK1U3ZB2WZkyjJBCyIacN1OSk3S9q6v7rxuE2hCCrqgvRAaSUOqjScgn/5vJ1RvytrTaP3NKaAB36pqj6O3lQE9OvaTlLoAGhPWRXIXMNqfoTDVhTlmLE7ubwJTndyjJlXw5kRGLAk0y7Jot3KnNsrZ1N2k6SDqm8lHvTwyqPwqdB5GJk45Bqxc6LbYwuL4pA8fPV03UrEmedc+4yr+kSNVcd/hUC3GxKL0GsiJnRW6VaO2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(786006)(366016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OO/4owCztaVw2pMf8vVFxcf2KIVUGjzj+y4/TRchU58vpjxm9K1JDllr71or?=
 =?us-ascii?Q?FKgoLhQ0GfVhsInsNTeB3bhAol7NeKTDyIldNbLXD/uybRNxXpFJRQUcj0GG?=
 =?us-ascii?Q?jGlqSfX7oDUymXNBFWhtEqYC6aaIMltwI3LnmRbDKk0HV1gTHwI0oQ1q6Jnb?=
 =?us-ascii?Q?M0A0ROTYLL/fyHhT3JQjtov3e1Jm2yj16NTHHFbopcUFey3aRD5yEkfIwXW2?=
 =?us-ascii?Q?hRrKng112U1G1UdB9IHVEJzdOnfVpkz20xGVuKJOj+X7olwmkGMwVi2oMusy?=
 =?us-ascii?Q?4Wo+Uclp2BSCeYahAO09hrRQcAsP8CHL+l9WDFKQyv8+mHxkUfCmzkNtgBIV?=
 =?us-ascii?Q?hqgwzrJzTm4tstd55tgJbeizdRQgUXdxvgaj0nXkFFkSpGiKpQG9CE0/d5mj?=
 =?us-ascii?Q?WGigSMct4RR+h5xPKBG07FZbVqqSovGzb36P3p+M9zgz7EEe1TmDtNZdZ20H?=
 =?us-ascii?Q?/dUw/QgEp/8KKLo2Mai41bmU0OCB2XpHOCAOt5Ir7f1lGvf8rQAdNh62UyeY?=
 =?us-ascii?Q?af/oVke5YAfSRFJGgtJ+J9W9q7Qm1Z4i340a2dJWQZIZ1K1WwnSbqMmlZFl4?=
 =?us-ascii?Q?5EmXdtY7T50O7Fs9GZFkf15CtiCi7Hp5s4btJSGADv+0x+jlQ2qAXnvkgF4Z?=
 =?us-ascii?Q?WG5vzh5Vmu1U9hV1ULWlcRj950j6lsQ9z1cV6DfvPl21C26tw7cNAql3ofv9?=
 =?us-ascii?Q?+N6NBRsh60KSZeeBhBaosYUl9frEV8yFrzipguYcvpXkWHRdwRJMAe7seLM1?=
 =?us-ascii?Q?z6bZWhUxXN7Btbm3cDXPT6fKepQCBl28Ypx4vnr96+0MmBP01pFeCT2p6KfO?=
 =?us-ascii?Q?FW7frTxVZ19emS3IeCxNwzZ9WYhrhaxkJpskEU/AyVpczgqStHrUBHxstZQr?=
 =?us-ascii?Q?zfhCMLKmf3MzpvJEhHO83YYFMPv9E8YVk6GZDVkxkpL7//vXfx3Mk9eNNFXD?=
 =?us-ascii?Q?B+0tTHk3cPvrTKwFdgTknWPX6we/Sv/XOYV2My91TjOh3CDVdgUF2f1luk/y?=
 =?us-ascii?Q?NS+P3apN+Vs3YfiEs+vnnE5x+Zvh+mtHAYTAhxM245icJ0dGGfUxNooPV8Ox?=
 =?us-ascii?Q?fo6hzQyaato86TZOr5mFOWacmHG9yoSnPBs0hPKg1BRdEzWfaEw4RX+6V3KI?=
 =?us-ascii?Q?BGl9G0EyKNvQmQQRBmNaX5MZ5LuRJDZGxsVkNOjPovX+aIBCV2eEHZojnxrr?=
 =?us-ascii?Q?S+1H9hvxbQJiuNFcGSgNK4B9U+kmVOuYk6pR4Nawil0sneRaFfhQlk8lrR2V?=
 =?us-ascii?Q?SGzFRoXk4bTslhZunhBvCRuGRJHxPU+erT0Yap2Hb403SJJjBWbz+N/KE3ij?=
 =?us-ascii?Q?8WYYFNTvitqojwTDmeIqC85OYzwZ+GAHvEn4SzRqG/ZPDBpG2rZp+qCOFaR6?=
 =?us-ascii?Q?tpXY72+kKIyhr8uPgZYFklQ8ZbfNC0GjpjGr2ePp9oP2hpysTCD6zjdf/uRu?=
 =?us-ascii?Q?5gg1m9gx3e5iWSNFfnACN50DA48lQOo52cMQuY27mk8npIjr/Iv2POE5p8+N?=
 =?us-ascii?Q?FAXHJHvDVMc6CBLVC5p4+ykLIjBmzg3lLNzzmXY1QjSO5KgXXPae3pMTDtel?=
 =?us-ascii?Q?obOHMcOZu4xWS6J2HTN3FdZy52NVK+aSMUZbEhFR+chc22G25dIOfQ8ELjuG?=
 =?us-ascii?Q?hiuF/8ueiMWE6chejui6g/fpKWQIkzGevnm8rDrmb0QPQc5/iJzHS9vCmr2N?=
 =?us-ascii?Q?HR82hnUq04Op8/EKZASvez66btEz02hWYmyf+D4voo2J+FL0yde7diDK6Uyd?=
 =?us-ascii?Q?C63zqPp02YvPLwdba732ueCJEtOQ8buCwY29PlOxIZDvDvJflsyFwXeonpb4?=
X-MS-Exchange-AntiSpam-MessageData-1: c6CGyQP0bRI4PFAvoD1XFE2bGVoSZeOyOsY=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed7f629-d599-43ee-b908-08df49bfc82a
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:35.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACFQuVSPP/3ddaQjWn4BEkmRNJrjpTaCNAE4k5ixrBR3W3bOdfN1YTFYo0MfODm79AVLcGFENWtXvjB3zE3HXWJzBScZCvVlC7jxnWeTOUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6063

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 client/agent.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/client/agent.c b/client/agent.c
index 94ace7cd..23e9752e 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -684,6 +684,39 @@ agent_request_peer_authorization(DBusConnection *connection,
 	return NULL;
 }
 
+static DBusMessage *
+agent_request_certificate_authorization(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct agent_data *request = user_data;
+	DBusMessageIter iter, dict;
+	char *service, *str;
+
+	if (handle_message(message, request,
+			agent_request_certificate_authorization) == false)
+		return NULL;
+
+	dbus_message_iter_init(message, &iter);
+
+	dbus_message_iter_get_basic(&iter, &str);
+	service = strip_path(str);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &dict);
+
+	__connmanctl_save_rl();
+	fprintf(stdout, "Agent RequestCertificateAuthorization %s\n",
+								service);
+	__connmanctl_dbus_print(&dict, "  ", " = ", "\n");
+	fprintf(stdout, "\n");
+
+	request->message = dbus_message_ref(message);
+	__connmanctl_agent_mode("Trust certificate (yes/no)? ",
+				request_authorization_return, request);
+
+	return NULL;
+}
+
 static const GDBusMethodTable agent_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, agent_release) },
 	{ GDBUS_ASYNC_METHOD("Cancel", NULL, NULL, agent_cancel) },
@@ -709,6 +742,11 @@ static const GDBusMethodTable agent_methods[] = {
 					{ "fields", "a{sv}" }),
 				GDBUS_ARGS({ "fields", "a{sv}" }),
 				agent_request_peer_authorization) },
+	{ GDBUS_ASYNC_METHOD("RequestCertificateAuthorization",
+				GDBUS_ARGS({ "service", "o" },
+					{ "fields", "a{sv}" }),
+				GDBUS_ARGS({ "fields", "a{sv}" }),
+				agent_request_certificate_authorization) },
 	{ },
 };
 
-- 
2.56.1

