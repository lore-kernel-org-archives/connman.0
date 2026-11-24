Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521641;
	b=mQyWl1agBPoeVY17Z+EmABzX6oh/KcwddZgkIRTa+xXvgyCf7xmW9y6H2ZpELUKK5tbV
	 ORzoSJFw6BX9bqX2UAxpfcqCBcLwsHaqvBdMfiYhE6vDLNF+S2OEKlSG2OuIgmcJ8nkNx
	 sL/s7VSvdifIlgqq3RUFtvKDj2zMzQPVYSGKDz+iQPgKJGFWq1GgI8OAfsmQdcfnvgYe5
	 veJAXzftXjpoGoINPz9g1hGbwJQGxi9srqAne77iJFpgMJzH9IWaXJbAu5C5WgoRNbQ2F
	 M7MK9ilgv4TJAbY22Qv8OzGPOJRpZvwjrUeBG0RwVQWIktCpZPlhvU1OK45/980QIYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521641;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JC67rzKy/xDNijsAJ0wV7ggcIryZ5OeoyRjKW7aMiu8=;
	b=5ZmZG/qJTIozSTIxrTPY6FtPgtwXgkQ8D8onZwbvxDpajK1MAgF9TIzY5al8TAmr6QCh
	 IXny+5nsWA4Yt/gF63fSSJq2quqktxQ/ptj8G/jIDAervIpeBSncby+DKCxcv3zPVGY0H
	 39HjhzvjyiQEHVwzWFGjVHrGz+BBV31OpWqn5qLqU55z/EakrCbt7/rvCcNM4Omvs0fLz
	 NcgIoniTLTKrZZQ313i6YWgk0y69CC9eY9oOKLHtByVrLBk4rtvQEo0LFJsNKgJxRWHWM
	 UXvjcbkO71DgIEXxNGsyBhtDBZgQ6XOcEeUNunQ9vhM82icOd6odT1eR40CWNcqq8tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=fKf+kHhV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.108
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023108.outbound.protection.outlook.com [52.101.72.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EB606A322
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 12:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D11EB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=fKf+kHhV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3NzdESY32rT57olkFP9EZtXoFSUlALeH1QtnQ9WucgGx/cZg2/TXts3/6TuW2GMaWnZpe6H3Za8WjhO5Hsp9SzUTY34G9+sK+yQb7SLrUyseHR0FslLbdPkQOhuKBFwJ1Q2md5RIHX+30zArXZQNMzSeTsuKTipPH9d8bTjcW/R0xwshb6NYS1S/8s/MPKml3fJP048qlobZIxX1oVlEZ0fCHi7PzBHVsRRg1q2lWnojTuNsujDjyy+qsFYR2dKX3TwLyVe2sz1SPa2rczs9tq6RCcJ5j01vod6zJR3Kpjq+nUEZhScjvZsQ8cyW4RFdE2PtdW5dSa6RkS1rBC8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC67rzKy/xDNijsAJ0wV7ggcIryZ5OeoyRjKW7aMiu8=;
 b=Lk2QGP7BxkAtlO4bj7Nto2qvVq0wM2eqaot4EK6dGsZODrJUTyDC6L7CiUIqNSKX+iHF/IjBz9Ug78FkanFegEJYciGRNpidqwKTUcNp4AB0iaEsrq3bS0EXhIELDMM9vBLYLJ0zUBwBU9XqxYGltLyPwteb+5LYxZ+58TRDuMXpKXA9B3sNvp6qmFzDnMGksgEKl0vNfF/cnMp7d4cbA1aITyPLI2isE7Ru/gD0+4K7oPrII1m50/RElvSnMjfAe5IUZITpNvNeL5FrQCZSniN0fPmfD02svekSDfqLYKPRvr/AqqCyzc1qniPgbG51hvzmzNyDGGRtRsy1/AafOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC67rzKy/xDNijsAJ0wV7ggcIryZ5OeoyRjKW7aMiu8=;
 b=fKf+kHhVfnZQokW6gpTMzo8bIT+Q/xBdeSnhughiAD640PXwrPXTEETrNzafuQhZgCc8KFZPfa1mZTUtyOOK6ZW2mfC8jrXGKyeVfXoL8T9V/NWeAZAVB8bQwzhc4nGhqKkKLFoIFjLGcTIjU6ZAAljaijCHh4z6sCXW1DYqBPY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by PAXPR08MB6416.eurprd08.prod.outlook.com
 (2603:10a6:102:152::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 12:00:37 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:00:37 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 5/5] iwd: Add support for TOFU probe connections
Date: Tue, 24 Nov 2026 13:00:29 +0100
Message-ID: <20261124120029.1288258-6-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::16) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|PAXPR08MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: a50e4762-a3e8-49b0-1002-08df4a228d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|786006|10070799003|23010399003|10067099003|261021123027099003|261009223027099003|11063799006|56012099006|261021121427099003|261009221227099003|261028144727099003|261102123227099003|261022105027099003|261026121527099003|261026140227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7efV1pdj6lJukHSXGCXsMYlv83PPXUShojdo1PNbJF7uc9K3rQQXogCBXSsEiOy1O477nkgdMc7OZHeN7qAbE/2QuVyKHNcWPtrpAD0vboUoH14ptTRznQlwAiNF7aizf6W04IFSN8SpVwsTQFiEdtBX9nBd9u88KMOd7saS/KTra+8neWrlT15xLdd++5eiwzL7cFZX0Juij2O8WUeB0xwDVDHCCuIwfIYdLGzkD8FkRpl39/NH2iTPCqqdQDg0BBOA+Jis8vKcUQ9sNnGcy0lK90Y9HQpyP2sLpJyMXp4dsiEADZFxm+7niJLeZXK3gO/Nb+ZYuQrQgEuJ7bIFLFVi9RCcZHXh3yPu2icQ+7o+aDrNmQRK/FMS6FCc8k9CLkdMiMgHEotWXBlhSx6B7Z8jQHgTc6oIX0Ba2GFz6Yv9G5aXmGaR5dksuyeSivysLsxawDfHaxWcTjjB0TQH06/FPGr1afutnLjoJ+8QhSt5ckUFp98/vO2zAX0/txa0hGzWA2WLxwAZepMC4E0DA1MVPqGqTeQDHhSPVs2qbF5UDyjS1C61UDZiAKsghoAnEL/kCka94QErmSE16I3rU2C4yf9RjWQj8d15Zmyr3TOu7z51VQKFM1BsGRNAzzNtsu1mjypa+5imzokgx9293NQnHY5fXJdW0yHsBbTGD+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(786006)(10070799003)(23010399003)(10067099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006)(261021121427099003)(261009221227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wxkNbO0/us1YWkqBbW9450rYMw1su3FkPsnMVvuCbSR32crH8R+g7YABOXF?=
 =?us-ascii?Q?D2iX7GYw47QjAGl1MUNy8IWUjeKMWBGa6ww0rMIzG4wvpZmJInlrYtlL7vx3?=
 =?us-ascii?Q?OcFeGhNv/1kn12y7n0hpQLQCnx0dHqR5hKIwkBVpT2dSwppy7+m0Kxo75e7N?=
 =?us-ascii?Q?tbhTZjpR/MQZgy9Slrx/aW7B9gmch1MOW8be0+wijHng2vlO6sR7Zb202DU+?=
 =?us-ascii?Q?SvQaPh1h3H4nrdRUHhy+4i9ss6AH4uo/clFWw/J9+7ORpRKXHRPhaDwzsxwK?=
 =?us-ascii?Q?gEC+c+1unbf5RhYXA3jJYtSgBz5yg85d2Q/6pcBQHmnKRcKc9N5gYaS/fVYZ?=
 =?us-ascii?Q?NnM3//NsXeHrBIg25B0tJLBJ3GCSYKxcld8XIS3G4YS/k/XVll43dRa254+u?=
 =?us-ascii?Q?N5Q8KhNHh6p9YHpQd41cX4vtux1kc/2XXjSWpAHwgxpDuZqfFFb7amww+0wi?=
 =?us-ascii?Q?tn1ycLpZSfHP5agiU9cAW/PXB5+5g2SUHj0WKeQVVAM7wnlbRfCiTLrh+e6D?=
 =?us-ascii?Q?yWrHD4nIXDVGNDNYsmNd3d84PNWgJJoBlHqJX4tY6PZxhc7shzb1Q8CAYyhK?=
 =?us-ascii?Q?kpSGlBd8/JO3T6/CJYvsMlnA+u25Z5YCGTqmXuwcYTlYzQ+X/K5q4VaPQjlg?=
 =?us-ascii?Q?11+XsY8ARO/uxzidZkvW/NO0+S48n6BssWNpTnsp830Up7VJYe9LN2/SMXsO?=
 =?us-ascii?Q?DV1x2GdW7NY4HZPJln2dq9obem2Vnb+L9t9i31baqBAtY4tR3IDwji1THfjS?=
 =?us-ascii?Q?KGrrxu7kABmqyMPSA9UwHNL0bSbfos+/f/8D2emaPjkA+vpvOo9h3ccm4yZr?=
 =?us-ascii?Q?IUnGzwdYDPC9UF/ZhKKH3jnPugg0/5TCo7TWD3/4cQg7xY9HtdEhlD96vYmb?=
 =?us-ascii?Q?NlhnI7m6WVCunjw/7M4KNIdrLTmwpNJQaOt9vzzbFs0fQ/jDwBCs3iAP/j/d?=
 =?us-ascii?Q?2UorPekToiwhsVN1XtaZF4QMapsD3QXtAAPqdwW+/49mr/k1fcLsAUlwkYwm?=
 =?us-ascii?Q?SlJW7os1ks+VMsXy2v8I8g9raZsiVEo8wgiA/dKi9dD11xOURovyckjZcYur?=
 =?us-ascii?Q?wGyZ9TnM4B1V/l/46LD/eGpchiIo2IMNNtfVXinhcMRnIuHvTBnBZuRXS2w7?=
 =?us-ascii?Q?+qhvWULfAvY6sQ/WOArwvhNlmHG0pG0wuWUxqaKx0y6UKSJyH2m38+fHsNR/?=
 =?us-ascii?Q?S1qMDunMVNgDyP6UBQdePbGTI+EOLJ7mJTN6YdLgyWKg8s6cGQfcvKFRoyUS?=
 =?us-ascii?Q?IQLW0z2rifcKz7RPUoqTrbJUQySDlA7H3RoT3REa57vG8MmMVAOT/6bVSg8i?=
 =?us-ascii?Q?H/Z2icMg6s8MX7LBbo7XmiAMXdMcbT+jK4kPmw+OnlPq+DgWYGg168vNFQrR?=
 =?us-ascii?Q?mJHOJdMRcAJhiuqFCMsQNwW4BZph8BRhV64hJ0WFBajNUy+yOQG+QrQ4T+7j?=
 =?us-ascii?Q?xwp0dGPB+bM7XpVC1dyykd3+2ZioGSnbA3w8RJ3j9tvrUzNIyHCo+0xH64Y1?=
 =?us-ascii?Q?bQf4sqrb9idLUawR7PzTvgXiNfroo3h2B2Evrb8aNyYL/gdrrTGBzoOokWfK?=
 =?us-ascii?Q?zKWta+YP77hCtrGdycA3msGvAvowyCNDaRRWPDjFKNz4Dzy8yia/zKjGRCgL?=
 =?us-ascii?Q?zoJAMsswgveFfQyOzNq1FkYUqkQ5nqYzpWkeAuClKkJtqvBOChAYpJubKq6w?=
 =?us-ascii?Q?W82Oy4mzgbMgWBszW88EXC38N9XY6aqMt51toBpKoC0tPrnMXyow0v+n55n8?=
 =?us-ascii?Q?D42krNZH12dG01RB5nZ1X/nwEenldaEbm/V0yb1yh3Kkva396bht?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: a50e4762-a3e8-49b0-1002-08df4a228d96
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:00:37.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIv4Pjr9qhXqkwc/uNYXyPr4gCIuQVgf2/Wu9oCg0nfC6DrJYXE25gWCQ8EnQUyg8GMiXDeLGsWSmf9+skPL4++zUrp9Mcxned6ih9q1cJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6416

iwd reports the server's certificate chain with the Certification signal
of its Station interface, with the same fields and in the same order as
the Certification signal of wpa_supplicant. Hand these certificates to
the core, so that TOFU works with iwd as well.

The probe connection must not send the password, as the server has not
been verified yet. The password is therefore left out of iwd's settings
file, so that iwd asks the agent for it, which answers with an empty
password. As long as the next connection is a probe, iwd's autoconnect
is disabled, so that iwd does not connect to the network on its own. A
failed probe is reported as a connection failure, rather than as an
invalid password.

As with ServerCertHash, an iwd without the Certification signal cannot
be used: connecting with a probe then fails right away.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 plugins/iwd.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 204 insertions(+), 14 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 16488bb2..1a81255c 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -283,7 +283,15 @@ static void cm_network_connect_cb(DBusMessage *message, void *user_data)
 			return;
 
 		DBG("%s connect failed: %s", path, dbus_error);
-		if (!strcmp(dbus_error, "net.connman.iwd.Failed") ||
+
+		/*
+		 * The TOFU probe is expected to fail, as an empty password is
+		 * sent, which does not mean that the password is wrong.
+		 */
+		if (connman_network_get_bool(iwdn->network, "WiFi.TOFUProbe"))
+			connman_network_set_error(iwdn->network,
+					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);
+		else if (!strcmp(dbus_error, "net.connman.iwd.Failed") ||
 				!strcmp(dbus_error,
 					"net.connman.iwd.InvalidFormat"))
 			connman_network_set_error(iwdn->network,
@@ -387,11 +395,11 @@ static void set_8021x_string(GKeyFile *keyfile, const char *prefix,
 static int sync_auto_connect(struct iwd_network *iwdn);
 
 /*
- * EAP-*-ServerCertHash is only supported by an iwd that also reports the
- * server certificate chain with the Station.Certification signal. Other
- * versions ignore it, and would accept any server certificate. Whether iwd
- * has the signal is found out by introspecting the first station object,
- * if that fails it is assumed not to.
+ * TOFU probes and EAP-*-ServerCertHash need an iwd that reports the server
+ * certificate chain with the Station.Certification signal. An iwd without
+ * that support also ignores ServerCertHash, and would accept any server
+ * certificate. Whether iwd has the signal is found out by introspecting the
+ * first station object, if that fails it is assumed not to.
  */
 enum cert_support {
 	CERT_SUPPORT_UNKNOWN,
@@ -402,19 +410,25 @@ enum cert_support {
 static enum cert_support cert_support;
 static DBusPendingCall *cert_support_call;
 
+static bool tofu_probe(struct iwd_network *iwdn)
+{
+	return connman_network_get_bool(iwdn->network, "WiFi.TOFUProbe");
+}
+
 static bool needs_cert_support(struct iwd_network *iwdn)
 {
-	return connman_network_get_string(iwdn->network,
+	return tofu_probe(iwdn) || connman_network_get_string(iwdn->network,
 						"WiFi.ServerCertHash");
 }
 
 /*
- * Whether iwd connects without verifying the server: when the server
- * certificate hash is pinned but iwd cannot check it.
+ * Whether iwd connects without verifying the server: on a TOFU probe, and
+ * when the server certificate hash is pinned but iwd cannot check it.
  */
 static bool server_unverified(struct iwd_network *iwdn)
 {
-	return needs_cert_support(iwdn) && cert_support != CERT_SUPPORT_YES;
+	return tofu_probe(iwdn) || (needs_cert_support(iwdn) &&
+					cert_support != CERT_SUPPORT_YES);
 }
 
 /*
@@ -525,8 +539,9 @@ static int provision_8021x(struct iwd_network *iwdn)
 		set_8021x_string(keyfile, prefix, "Phase2-Identity", identity);
 
 		/*
-		 * Without verifying the server the password is left out, so
-		 * that iwd cannot send it.
+		 * Without verifying the server the password is left out: iwd
+		 * then asks our agent for it, which answers with an empty
+		 * one, see agent_password().
 		 */
 		if (!unverified)
 			set_8021x_string(keyfile, prefix, "Phase2-Password",
@@ -615,7 +630,7 @@ static int cm_network_connect(struct connman_network *network)
 			}
 
 			if (cert_support == CERT_SUPPORT_NO) {
-				connman_warn("%s: ServerCertHash needs "
+				connman_warn("%s: TOFU and ServerCertHash need "
 					"an iwd with the Station.Certification "
 					"signal", iwdn->name);
 				return -EOPNOTSUPP;
@@ -698,7 +713,7 @@ static void cert_support_reply(DBusPendingCall *call, void *user_data)
 		cert_support = CERT_SUPPORT_YES;
 	} else {
 		connman_info("iwd has no Station.Certification signal, "
-				"ServerCertHash is not available");
+				"TOFU and ServerCertHash are not available");
 		cert_support = CERT_SUPPORT_NO;
 	}
 
@@ -2148,6 +2163,76 @@ static DBusMessage *agent_request_passphrase(DBusConnection *dbus_conn,
 					DBUS_TYPE_INVALID);
 }
 
+static struct iwd_network *agent_network(DBusMessage *message)
+{
+	const char *path;
+
+	if (!dbus_message_get_args(message, NULL,
+					DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return NULL;
+
+	return g_hash_table_lookup(networks, path);
+}
+
+/*
+ * EAP password for iwd. With the settings file written by provision_8021x()
+ * iwd only asks for it when it does not verify the server, e.g. on a TOFU
+ * probe connection: an empty password is sent then, so that the
+ * authentication fails after the server certificate has been seen.
+ */
+static const char *agent_password(struct iwd_network *iwdn)
+{
+	if (server_unverified(iwdn))
+		return "";
+
+	return connman_network_get_string(iwdn->network, "WiFi.Passphrase");
+}
+
+static DBusMessage *agent_request_user_password(DBusConnection *dbus_conn,
+						DBusMessage *message,
+						void *user_data)
+{
+	struct iwd_network *iwdn;
+	const char *passwd;
+
+	DBG("");
+
+	iwdn = agent_network(message);
+	if (!iwdn)
+		return get_reply_on_error(message, EINVAL);
+
+	passwd = agent_password(iwdn);
+	if (!passwd)
+		return get_reply_on_error(message, ENOKEY);
+
+	return g_dbus_create_reply(message, DBUS_TYPE_STRING, &passwd,
+					DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *agent_request_user_name_password(DBusConnection *dbus_conn,
+						DBusMessage *message,
+						void *user_data)
+{
+	struct iwd_network *iwdn;
+	const char *user, *passwd;
+
+	DBG("");
+
+	iwdn = agent_network(message);
+	if (!iwdn)
+		return get_reply_on_error(message, EINVAL);
+
+	user = connman_network_get_string(iwdn->network, "WiFi.Identity");
+	passwd = agent_password(iwdn);
+	if (!user || !passwd)
+		return get_reply_on_error(message, ENOKEY);
+
+	return g_dbus_create_reply(message, DBUS_TYPE_STRING, &user,
+					DBUS_TYPE_STRING, &passwd,
+					DBUS_TYPE_INVALID);
+}
+
 static DBusMessage *agent_cancel(DBusConnection *dbus_conn,
 					DBusMessage *message, void *user_data)
 {
@@ -2179,6 +2264,14 @@ static const GDBusMethodTable agent_methods[] = {
 			GDBUS_ARGS({ "path", "o" }),
 			GDBUS_ARGS({ "passphrase", "s" }),
 			agent_request_passphrase)},
+	{ GDBUS_METHOD("RequestUserPassword",
+			GDBUS_ARGS({ "path", "o" }, { "user", "s" }),
+			GDBUS_ARGS({ "password", "s" }),
+			agent_request_user_password)},
+	{ GDBUS_METHOD("RequestUserNameAndPassword",
+			GDBUS_ARGS({ "path", "o" }),
+			GDBUS_ARGS({ "user", "s" }, { "password", "s" }),
+			agent_request_user_name_password)},
 	{ GDBUS_METHOD("Cancel",
 			GDBUS_ARGS({ "reason", "s" }),
 			NULL, agent_cancel) },
@@ -2504,6 +2597,102 @@ static void object_removed(GDBusProxy *proxy, void *user_data)
 		g_hash_table_remove(access_points, path);
 }
 
+/*
+ * Station.Certification: one signal per certificate of the server's chain,
+ * with the same fields and in the same order as wpa_supplicant's
+ * Certification signal.
+ */
+static void certification_signal(const char *path, DBusMessageIter *dict)
+{
+	struct iwd_device *iwdd;
+	struct iwd_network *iwdn;
+	DBusMessageIter entry, value, array;
+	dbus_uint32_t depth = 0;
+	const char *subject = NULL, *cert_hash = NULL;
+	const unsigned char *cert = NULL;
+	int cert_len = 0;
+	GPtrArray *altsubject = g_ptr_array_new();
+
+	while (dbus_message_iter_get_arg_type(dict) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		int type;
+
+		dbus_message_iter_recurse(dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+		type = dbus_message_iter_get_arg_type(&value);
+
+		if (!strcmp(key, "depth") && type == DBUS_TYPE_UINT32) {
+			dbus_message_iter_get_basic(&value, &depth);
+		} else if (!strcmp(key, "subject") &&
+				type == DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&value, &subject);
+		} else if (!strcmp(key, "cert_hash") &&
+				type == DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&value, &cert_hash);
+		} else if (!strcmp(key, "cert") && type == DBUS_TYPE_ARRAY &&
+				dbus_message_iter_get_element_type(&value) ==
+							DBUS_TYPE_BYTE) {
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array, &cert,
+								&cert_len);
+		} else if (!strcmp(key, "altsubject") &&
+				type == DBUS_TYPE_ARRAY &&
+				dbus_message_iter_get_element_type(&value) ==
+							DBUS_TYPE_STRING) {
+			dbus_message_iter_recurse(&value, &array);
+			while (dbus_message_iter_get_arg_type(&array) ==
+							DBUS_TYPE_STRING) {
+				const char *str;
+
+				dbus_message_iter_get_basic(&array, &str);
+				g_ptr_array_add(altsubject, (gpointer) str);
+				dbus_message_iter_next(&array);
+			}
+		}
+
+		dbus_message_iter_next(dict);
+	}
+
+	DBG("depth %u subject %s hash %s", depth, subject, cert_hash);
+
+	iwdd = g_hash_table_lookup(devices, path);
+	if (!iwdd || !iwdd->network)
+		goto out;
+
+	iwdn = g_hash_table_lookup(networks, iwdd->network);
+	if (!iwdn)
+		goto out;
+
+	g_ptr_array_add(altsubject, NULL);
+
+	connman_network_tofu_certificate(iwdn->network, depth, subject,
+				(const char **) altsubject->pdata, cert_hash,
+				cert, cert_len);
+
+out:
+	g_ptr_array_free(altsubject, TRUE);
+}
+
+static void iwd_signal(DBusConnection *conn, DBusMessage *message,
+							void *user_data)
+{
+	DBusMessageIter iter, dict;
+
+	if (!dbus_message_is_signal(message, IWD_STATION_INTERFACE,
+							"Certification"))
+		return;
+
+	if (!dbus_message_iter_init(message, &iter) ||
+			dbus_message_iter_get_arg_type(&iter) !=
+							DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(&iter, &dict);
+	certification_signal(dbus_message_get_path(message), &dict);
+}
+
 static int iwd_init(void)
 {
 	connection = connman_dbus_get_connection();
@@ -2557,6 +2746,7 @@ static int iwd_init(void)
 	g_dbus_client_set_disconnect_watch(client, iwd_is_out, NULL);
 	g_dbus_client_set_proxy_handlers(client, object_added, object_removed,
 			NULL, NULL);
+	g_dbus_client_set_signal_watch(client, iwd_signal, NULL);
 
 	return 0;
 
-- 
2.53.0

