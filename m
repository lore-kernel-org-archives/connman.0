Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521640;
	b=ypAvnGlk57OsuiRicm6t4GXtuXeMySyV6Qj8+eoyc9mn3F4Kxz6X8e7o1Y8FYvqBBM+L
	 qgWpWR1BdHjIXar/rfeeZj9GDjK5DSvQ4C6nFNDkj8DXg61gqPTIcPlBCRONaV6fLABoZ
	 mMqf8xJW2CTQ+DC74W+xtSpNGzoje4M87xHMwu5nI8s4VyovojUntH5WBIhGDo9H3xIKY
	 KHjhY9FuXtWSaYMq8U6tIZr92qLdQeQyfaKXoKhPATYM8cCckfNtUiQw9Gd2XJvRyl02v
	 aRaE9RNn4H29mwnCM/Fk/qdnrrHYZnbqoS09K4542UveU7lgdvkt2IwFHQF+D8MM23g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521640;
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
	bh=Ne4bfvJTQH+tPZqRtSXQHUWRwoCvUOH1lUS1Ab4l7og=;
	b=VhiqCW32WhSGNDcEp5GCPYZNgadRpTCx6i1ygIijU8IkWVFS1CL+WOtqF1LWNdyPrFQV
	 0SN2D4KMDSI6MmC2M2fl2/Wyp8nmfqfr2OElFWTj3szV2nAfvmWvpIovZ3Iz+IJ2Q0n35
	 AXwXnq0TuMqnm2ezLWT64S4Epc4mdeToet7KIA35u8YWCQ4ied+ejmkU29dO3xjlTd/E6
	 3ai/nGTJEmLoEIrbsi5v9DKSUhmd84xksP5rbZlcZdXX9JeSKxRvN/Kx8mRflB9s8U/8T
	 X9I/88JqlmweJN46VahaiZ4aJ1GhlAcEMratH6BtAdQdBDceiCnS2EiIIxgwKpkNCEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b="KXTXl/GT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.108
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023108.outbound.protection.outlook.com [52.101.72.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60842606A322
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 12:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60842606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=KXTXl/GT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i90baEW9B3meNVj0XywlW0xGHW/Z5Lu7XnaKE9APcCkxC2bE1XZdpTmegu+yehUrgiIxCaDhYHT50Cyb8ux+o/h/n3Oc4fbWo2K+pXdmBZIHy8dCWUUnsgGqu2HKsj9LVE5tNSG5pWzF211XVhTxzSWJErZa2pASXIraDlYYLIubAH89Goa55t7Sl2C1PDadEB27jS88ouqFuPjTD341PfZjGGwkS+PnY+ZPQFFwwZNSoZVjuYyJ+MEGVbs/RQysNQmBrvF2Gdl82IgdHzP0xc+N/4xb9uGqlRWwAB9I1QyVsfE2QPU+PFvd1YdnInz3ewz1W7wkOZlz3GCfikqBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne4bfvJTQH+tPZqRtSXQHUWRwoCvUOH1lUS1Ab4l7og=;
 b=MyeW3tfvlOVb6qAE2VGU6odEbBWA9FALRYKcypliyZGi5nhacP1WtOrFxZ2UkkhPEa0g0iTZZcHXaXsnv9bFbSWT2p4sDHtLzwozuh1gn7nzAwxzA33FwDz1GyeEvqopGVynKCq83Ugy2+x6fm/m9U00Kle8eO9Kc9cup6j1ZGjbLEQeHG0R0Zlv1EkcNqoD6A/yTXNyVF7Ix7fYwqP0YhUDDz9A11E35Hl2CT8oMscFLjFSDyOTIlGLlyLuUqths755iesHR/GkmidXkQnDAHkeBw/4lYvEJDQpPsnOfS9/UpYMCLiQVDRoEv9C4s/0VaDcwY8O9ZWB1hxN4z4rFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne4bfvJTQH+tPZqRtSXQHUWRwoCvUOH1lUS1Ab4l7og=;
 b=KXTXl/GTDFLjUj91TAzxzB9r5bsKhRDTG+LN26VNMNnIW7qFTWPupBsJW8cYT+kTIorPJ0xv5E3E42xgvSJ7xYSMjj22I7qvp72ztsKd42WrF+sQ1JmSkpE8jZuRWdDLWq0UTmA0UhOvXVNgSDC4bKClWscjArqZbFfPnLCBvR0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by PAXPR08MB6416.eurprd08.prod.outlook.com
 (2603:10a6:102:152::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 12:00:36 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:00:36 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 4/5] iwd: Only pass ServerCertHash to an iwd that supports it
Date: Tue, 24 Nov 2026 13:00:28 +0100
Message-ID: <20261124120029.1288258-5-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0051.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::16) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: cee563bc-1f31-4e7c-bb21-08df4a228cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|786006|10070799003|23010399003|10067099003|261021123027099003|261009223027099003|11063799006|56012099006|261021121427099003|261022075727099003|261028144727099003|261102123227099003|261022105027099003|261026121527099003|261026140227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SHWNj5Gn/TDv8zNkC6g6UPewgIPKJffnt9bfiatL6olEFCXPV01UdLy/2SAkkG8l6o5K2FQFLQOQCH1iaBoERsvoCmrnG4fjlb9tuEd7Gza/comivFH8O8f0F+Y582RVvol0yb1ELTG/kIjH7znLKLxMoFQUH55rIbAPtSfAONZXOjhzvxydbuE6WP0Cif/bdesj9BoKV2tiN3Hv9FZ5+c6wGKL6HseegikxPGFjN3pVVaTY8Xcoy11UCxnTCGY6/WOikETJmlgTxdykO4muLMP+4uwrTonyaMK5eP7ACD4MuDGcwRULEyMF+0GduxIdP4mgD44YSp/aNRDXBMApdUkk8FnHrJvv6CPBjf4QeEoi3CeKvOjXq9NCv1Tpfc0Tgm+zcp1lh6cSwV1YDmEMQcgv+QQUtemD4TmrvBRIN4OG3jPiOX6TDqF0MAzDcQuWIHg7zAmo0Cra9G6pYl5OdVdQ84xVvgBviGwSTc1Ea/aHELIpAcPVeh2Vjmk2R4sbM0J0Cyi6/ecHRrvoRZ0rSAy+dkLML3dX6OiYz2qswfP2dxwyafmKYm7WTdWAdLxqi4ZuDnpEQZ0FIzbDunKU+rdcMbL8DpGFL+7vrssfp6/6W76EBf/QEFCU0r2JZGa33upIZDm3mtaj2Ab5F+qFhAgp9Zspqtj5fSblIzy/LMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(786006)(10070799003)(23010399003)(10067099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(261022105027099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CY7bTgoEsiVl5AcYuPWiTu8yYWcsx0+F35jIXZU9HCLz4ge0WGxoM+l9Xjp2?=
 =?us-ascii?Q?/KfyKHjNBDB0+rdP1813ZTszbiEXSNI6qeOzNv4TnUaJYWxDkIYxqzbApAKN?=
 =?us-ascii?Q?xOEVuYttf1tVAY+NHatx/uFR1mwUqhgVoqBK4uRx8IKlr/BGjx9Q45u7nfM5?=
 =?us-ascii?Q?23Jy+bslkiIxGwDtjZM0EcLPsEzr2HLQ9yIX7Hv9ol0DeBJh5FaamxriojCW?=
 =?us-ascii?Q?Wluab4Vb2tQw/Q+WfpSbRUBovpdSDkQLp6hhRTHUuE4NpABS45ML6pOLClJK?=
 =?us-ascii?Q?MrCfLgAgd4MMmWXp9RQ9RbqST3ZLlWBul2Bu4KQtRPoM/IODmuSFmy8rgA+h?=
 =?us-ascii?Q?j7RBC2sK2P8eqW0hB9YNpHU83C/bnt2oWg8IniHlc87SrypZyGD8cJmhy0Dr?=
 =?us-ascii?Q?2R1ICw2rrfiKBnPVbGo250mQOb04CUwpBIoL9JN/6QrHWLAAfEkCRrUVmyLZ?=
 =?us-ascii?Q?7nM10AdKQWV17fM8n5ArAaB8zKB6yKaQLdcPPBnKWZ1GHCNg0R9DiDz45uCj?=
 =?us-ascii?Q?kCsQWbEnhHU/8ytw5ZTnroXljKpg3+BrtGzrAwIeWJjMNLRb5lxRqun8e4qc?=
 =?us-ascii?Q?R1WlUKUWQuAhP6TTxvhvWJtwtczujF76cDiheUweyr0leVV0tq2fSK31GcwD?=
 =?us-ascii?Q?z0ZVohtYfSsBc32qWqSEmQVwlZfuHIp9wPA5fwdyUlofy7DtqsR8miFVlONF?=
 =?us-ascii?Q?xGKkPU19+F6xqn7JbDXJDKNg5bY3oyON38dnBWaUJ2iWHdYhXzCDUps/lV+j?=
 =?us-ascii?Q?ah9fiz05+uWEOwG7KVZv2FtsBEbgwsPig5FukN06o1ls8GJ6G07f9nyg5hfK?=
 =?us-ascii?Q?D3Sdhi/0G79A+JhzlvEyJOGirZeXZ4BkNrzT77maowjapdjM9oyK+DQCc29/?=
 =?us-ascii?Q?K8+XYmVBXxVdKwdLjoXetBDAmrZhDEBQ1SNu0XBQkZEIVZRN2s6Hz12a6RqK?=
 =?us-ascii?Q?Fnm8aRiHfeRdCXX3nPzGmtV6WUXCE1VVjT5s35/y6DqWLyWBVsOc48czS9Fp?=
 =?us-ascii?Q?HNRNHhm43PJJwLZ0h8DqF4NFgC7AT9PDuTyOxhdt5d9Ydyqsqvw7TU+dxOv7?=
 =?us-ascii?Q?4kxN6oYdfyHUZBElVPaRBV7UEBWIjTqGH7OW3IdIvDvbadwrlTM7q2txJKJ2?=
 =?us-ascii?Q?2a3ciZVtXLjVLdrD1QN47+FZo2/pDMYdQqW1plR/KoinF7qJslMbjRmKYuJc?=
 =?us-ascii?Q?2KDQrcBtC2lFGT+YmnuwFt+4y/lUQZezsLOxJrDtIQG5PEn1RgdUo1CxuIAy?=
 =?us-ascii?Q?6n3HiyzvQ/7Fiin86e75ujJ0mbjgthTPB5TTahDAMgIoXOxMQnUqlVzFv50S?=
 =?us-ascii?Q?2Vnx4JIjby+EcF/mlTJBmfjG5vy+YoaqZUv52Jd/YM1mroXiJLJ6aowPSCY3?=
 =?us-ascii?Q?hV+tnJ2bVB10XnVwx/yvxUcfs/9ijGE+RWO7KuU75/1YrQhoqA/S8xQf3+Th?=
 =?us-ascii?Q?Wx00mgLl0anM4GhpaLMIawC3ZnGjjyjLQqwR7h8yYOrY15KgkV5XRj/K7Guf?=
 =?us-ascii?Q?pidAhMeCQ58Pnc5T3AVMooKmhKoEdGXviOlQkgwEJdjrQwKATiKdimGjIw4b?=
 =?us-ascii?Q?CGQDqQoOcEQGT4CzMpcP3zly2LLVcefajkP5fxAOzHQ3YkyX8UulhdGrhMpx?=
 =?us-ascii?Q?mG5WgY0ZRIflbPq9mKn0LpGhy79YregZRc4vrC7RTVHOUdaFZ0LI40lJLpB2?=
 =?us-ascii?Q?63G+0P77DTYiYmI4OOZsrmU+Gkutxzpx/b9nC8jf09UuHraYF5Bwyblbj2ok?=
 =?us-ascii?Q?8ekVD9+R0lebgeW+NRPar0sqfb7wV6wbtjaG1VcKtowjsyC80IbI?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: cee563bc-1f31-4e7c-bb21-08df4a228cc9
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:00:36.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TABT1RqGM76mTuD4XOAiDMaWsdy0/mpB2Lv/eEzg2Qt+uxeintfzdlCxM1jwezxIq/LC/w++8WE5+35D8UavJE/MSRYm6TO1K++xa94FKmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6416

EAP-*-ServerCertHash is only supported by iwd versions that also
report the server certificate chain with the Station.Certification
signal. Other versions ignore the setting, and would then connect to any
server and send it the password.

Check whether iwd has this signal by introspecting the first station
object. Connecting to a network with ServerCertHash waits for the
result, and fails if iwd does not support it. The settings file is then
written without the password and with autoconnect disabled, so that iwd
cannot connect to the network on its own either.
---
 plugins/iwd.c | 220 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 199 insertions(+), 21 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index b857c2ea..16488bb2 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -384,6 +384,49 @@ static void set_8021x_string(GKeyFile *keyfile, const char *prefix,
 	g_free(name);
 }
 
+static int sync_auto_connect(struct iwd_network *iwdn);
+
+/*
+ * EAP-*-ServerCertHash is only supported by an iwd that also reports the
+ * server certificate chain with the Station.Certification signal. Other
+ * versions ignore it, and would accept any server certificate. Whether iwd
+ * has the signal is found out by introspecting the first station object,
+ * if that fails it is assumed not to.
+ */
+enum cert_support {
+	CERT_SUPPORT_UNKNOWN,
+	CERT_SUPPORT_YES,
+	CERT_SUPPORT_NO,
+};
+
+static enum cert_support cert_support;
+static DBusPendingCall *cert_support_call;
+
+static bool needs_cert_support(struct iwd_network *iwdn)
+{
+	return connman_network_get_string(iwdn->network,
+						"WiFi.ServerCertHash");
+}
+
+/*
+ * Whether iwd connects without verifying the server: when the server
+ * certificate hash is pinned but iwd cannot check it.
+ */
+static bool server_unverified(struct iwd_network *iwdn)
+{
+	return needs_cert_support(iwdn) && cert_support != CERT_SUPPORT_YES;
+}
+
+/*
+ * As long as iwd would not verify the server, it must not connect to the
+ * network on its own. ConnMan's autoconnect setting applies again once it
+ * does.
+ */
+static bool iwd_auto_connect_allowed(struct iwd_network *iwdn)
+{
+	return iwdn->cm_autoconnect && !server_unverified(iwdn);
+}
+
 /*
  * Writes the iwd settings file for an 802.1X network from the service's
  * WiFi.* settings, so connman's own service config is the only one needed.
@@ -395,6 +438,7 @@ static int provision_8021x(struct iwd_network *iwdn)
 	struct connman_network *network = iwdn->network;
 	const char *eap = connman_network_get_string(network, "WiFi.EAP");
 	const char *identity, *anonymous_identity, *phase2, *hash;
+	bool unverified;
 	GKeyFile *keyfile;
 	char *path, *prefix, *method, *data = NULL, *old = NULL;
 	int err = 0;
@@ -418,6 +462,12 @@ static int provision_8021x(struct iwd_network *iwdn)
 				"DomainSuffixMatch are not supported with "
 				"iwd, ignoring them", iwdn->name);
 
+	/* provisioned once known, see cert_support_reply() */
+	if (needs_cert_support(iwdn) && cert_support == CERT_SUPPORT_UNKNOWN)
+		return 0;
+
+	unverified = server_unverified(iwdn);
+
 	path = iwd_8021x_file_path(iwdn->name);
 	method = g_ascii_strup(eap, -1);
 	prefix = g_strdup_printf("EAP-%s-", method);
@@ -427,9 +477,9 @@ static int provision_8021x(struct iwd_network *iwdn)
 					NULL);
 	g_key_file_remove_group(keyfile, "Security", NULL);
 
-	if (!g_key_file_has_group(keyfile, "Settings"))
+	if (unverified || !g_key_file_has_group(keyfile, "Settings"))
 		g_key_file_set_boolean(keyfile, "Settings", "AutoConnect",
-					iwdn->cm_autoconnect);
+					iwd_auto_connect_allowed(iwdn));
 
 	identity = connman_network_get_string(network, "WiFi.Identity");
 	anonymous_identity = connman_network_get_string(network,
@@ -473,9 +523,15 @@ static int provision_8021x(struct iwd_network *iwdn)
 		}
 
 		set_8021x_string(keyfile, prefix, "Phase2-Identity", identity);
-		set_8021x_string(keyfile, prefix, "Phase2-Password",
-				connman_network_get_string(network,
-						"WiFi.Passphrase"));
+
+		/*
+		 * Without verifying the server the password is left out, so
+		 * that iwd cannot send it.
+		 */
+		if (!unverified)
+			set_8021x_string(keyfile, prefix, "Phase2-Password",
+					connman_network_get_string(network,
+							"WiFi.Passphrase"));
 	}
 
 	data = g_key_file_to_data(keyfile, NULL, NULL);
@@ -499,6 +555,9 @@ static int provision_8021x(struct iwd_network *iwdn)
 	g_free(method);
 	g_free(path);
 
+	if (!err)
+		sync_auto_connect(iwdn);
+
 	return err;
 }
 
@@ -546,6 +605,23 @@ static int cm_network_connect(struct connman_network *network)
 	}
 
 	if (!g_strcmp0(iwdn->type, "8021x")) {
+		if (needs_cert_support(iwdn)) {
+			if (cert_support == CERT_SUPPORT_UNKNOWN) {
+				DBG("%s checking iwd's support",
+								iwdn->path);
+				iwdn->connect_pending = true;
+				connman_network_set_associating(network, true);
+				return -EINPROGRESS;
+			}
+
+			if (cert_support == CERT_SUPPORT_NO) {
+				connman_warn("%s: ServerCertHash needs "
+					"an iwd with the Station.Certification "
+					"signal", iwdn->name);
+				return -EOPNOTSUPP;
+			}
+		}
+
 		err = provision_8021x(iwdn);
 		if (err < 0)
 			return err;
@@ -586,6 +662,92 @@ static int cm_network_provision(struct connman_network *network)
 	return provision_8021x(iwdn);
 }
 
+static bool has_certification_signal(const char *xml)
+{
+	const char *iface, *end, *signal;
+
+	iface = strstr(xml, "<interface name=\"" IWD_STATION_INTERFACE "\"");
+	if (!iface)
+		return false;
+
+	end = strstr(iface, "</interface>");
+	signal = strstr(iface, "<signal name=\"Certification\"");
+
+	return signal && (!end || signal < end);
+}
+
+static void cert_support_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	struct iwd_network *iwdn;
+	GHashTableIter iter;
+	gpointer value;
+	const char *xml;
+
+	dbus_pending_call_unref(cert_support_call);
+	cert_support_call = NULL;
+
+	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR ||
+			!dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &xml,
+					DBUS_TYPE_INVALID)) {
+		connman_warn("Failed to introspect iwd station %s",
+						(const char *) user_data);
+		cert_support = CERT_SUPPORT_NO;
+	} else if (has_certification_signal(xml)) {
+		cert_support = CERT_SUPPORT_YES;
+	} else {
+		connman_info("iwd has no Station.Certification signal, "
+				"ServerCertHash is not available");
+		cert_support = CERT_SUPPORT_NO;
+	}
+
+	dbus_message_unref(reply);
+
+	g_hash_table_iter_init(&iter, networks);
+	while (g_hash_table_iter_next(&iter, NULL, &value)) {
+		iwdn = value;
+
+		if (!iwdn->network || g_strcmp0(iwdn->type, "8021x") ||
+				!needs_cert_support(iwdn))
+			continue;
+
+		provision_8021x(iwdn);
+
+		if (!iwdn->connect_pending)
+			continue;
+
+		iwdn->connect_pending = false;
+		if (cm_network_connect(iwdn->network) != -EINPROGRESS)
+			connman_network_set_error(iwdn->network,
+					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);
+	}
+}
+
+static void check_cert_support(const char *station_path)
+{
+	DBusMessage *msg;
+
+	if (cert_support != CERT_SUPPORT_UNKNOWN || cert_support_call)
+		return;
+
+	msg = dbus_message_new_method_call(IWD_SERVICE, station_path,
+				DBUS_INTERFACE_INTROSPECTABLE, "Introspect");
+	if (!msg)
+		return;
+
+	if (!dbus_connection_send_with_reply(connection, msg,
+					&cert_support_call, -1) ||
+			!cert_support_call) {
+		dbus_message_unref(msg);
+		return;
+	}
+
+	dbus_pending_call_set_notify(cert_support_call, cert_support_reply,
+					g_strdup(station_path), g_free);
+	dbus_message_unref(msg);
+}
+
 static void cm_network_forget_cb(DBusMessage *message, void *user_data)
 {
 	struct iwd_known_network *iwdkn;
@@ -854,16 +1016,10 @@ static int update_auto_connect(struct iwd_known_network *iwdkn)
 	return disable_auto_connect(iwdkn);
 }
 
-static int cm_network_set_autoconnect(struct connman_network *network,
-				bool cm_autoconnect)
+static int sync_auto_connect(struct iwd_network *iwdn)
 {
-	struct iwd_network *iwdn = connman_network_get_data(network);
 	struct iwd_known_network *iwdkn;
 
-	DBG("cm_autoconnect %d", cm_autoconnect);
-
-	iwdn->cm_autoconnect = cm_autoconnect;
-
 	if (!iwdn->known_network)
 		return -ENOENT;
 
@@ -871,11 +1027,23 @@ static int cm_network_set_autoconnect(struct connman_network *network,
 	if (!iwdkn)
 		return -ENOENT;
 
-	iwdkn->cm_autoconnect = cm_autoconnect;
+	iwdkn->cm_autoconnect = iwd_auto_connect_allowed(iwdn);
 
 	return update_auto_connect(iwdkn);
 }
 
+static int cm_network_set_autoconnect(struct connman_network *network,
+				bool cm_autoconnect)
+{
+	struct iwd_network *iwdn = connman_network_get_data(network);
+
+	DBG("cm_autoconnect %d", cm_autoconnect);
+
+	iwdn->cm_autoconnect = cm_autoconnect;
+
+	return sync_auto_connect(iwdn);
+}
+
 static struct connman_network_driver network_driver = {
 	.name			= "iwd",
 	.type			= CONNMAN_NETWORK_TYPE_WIFI,
@@ -1501,7 +1669,6 @@ static void network_property_change(GDBusProxy *proxy, const char *name,
 		DBusMessageIter *iter, void *user_data)
 {
 	struct iwd_network *iwdn;
-	struct iwd_known_network *iwdkn;
 	const char *path;
 
 	path = g_dbus_proxy_get_path(proxy);
@@ -1528,13 +1695,8 @@ static void network_property_change(GDBusProxy *proxy, const char *name,
 		if (!iwdn->known_network)
 			return;
 
-		iwdkn = g_hash_table_lookup(known_networks,
-					iwdn->known_network);
-		if (iwdkn) {
-			/* See Note [Managing autoconnect state] */
-			iwdkn->cm_autoconnect = iwdn->cm_autoconnect;
-			update_auto_connect(iwdkn);
-		}
+		/* See Note [Managing autoconnect state] */
+		sync_auto_connect(iwdn);
 
 		if (iwdn->connect_pending) {
 			iwdn->connect_pending = false;
@@ -2069,8 +2231,21 @@ static void iwd_is_present(DBusConnection *conn, void *user_data)
 	agent_registered = true;
 }
 
+static void reset_cert_support(void)
+{
+	if (cert_support_call) {
+		dbus_pending_call_cancel(cert_support_call);
+		dbus_pending_call_unref(cert_support_call);
+		cert_support_call = NULL;
+	}
+
+	cert_support = CERT_SUPPORT_UNKNOWN;
+}
+
 static void iwd_is_out(DBusConnection *conn, void *user_data)
 {
+	reset_cert_support();
+
 	if (agent_registered) {
 		g_dbus_unregister_interface(connection,
 					AGENT_PATH, IWD_AGENT_INTERFACE);
@@ -2239,6 +2414,8 @@ static void create_station(GDBusProxy *proxy)
 
 	g_dbus_proxy_set_property_watch(iwds->proxy,
 			station_property_change, NULL);
+
+	check_cert_support(iwds->path);
 }
 
 static void create_ap(GDBusProxy *proxy)
@@ -2415,6 +2592,7 @@ static void iwd_exit(void)
 	connman_technology_driver_unregister(&tech_driver);
 
 	g_dbus_client_unref(client);
+	reset_cert_support();
 
 	g_hash_table_destroy(access_points);
 	g_hash_table_destroy(stations);
-- 
2.53.0

