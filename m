Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521642;
	b=nJU1hlIQp/8dOnhFuXQlmbKOLusI3G3wobpKjqEY/DArAoEhbgL+ObQz/qN4h//k3YCG
	 wu9MXbTbF3W7GoJ/YFXPQsawImLvmWM0kdXI7M9i7SSfwQ0RhDKQRb1IVIS0aNntAvLda
	 sQoOnH5JF4BJyS6RO6xwgbT2djGmBej0fdFKXMw/lh3FZrGYMcPh3isUw4IvJQzFQDVow
	 SK7INqqtPvwdnXRyN7JlEagONNY3NuOmnRO3bu+KNgq9VNnVR0fxj1Q6v5o6lb+R4b6Gl
	 EoJJUjSc1L5ZBOySbV9CFdzAusov/OlVjqk+ZthzupMnxcwYrlzRxT1Sf1bgbusw9NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521642;
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
	bh=ZPN/190hkVwdQ34FM5ZdM4pVtbGAsTLZAifRoMswHfo=;
	b=e/GvodFbDwAuyZ3ISbl/UK01UoTAdZBZi7/yUk1ak8G/i9Xg/BnY49Kl0ttM7h3qrqoa
	 GQAmj4CosxU0f4p5mVwrJPxkPwSUcORvvySDsavsAjtPVInLQVJ7azOQRwM6hKcsjk4ZY
	 KbZ4EARXRcaq7EVlHKeDKqZq4bxXAeRwUMEjoS3XR75okeVml8N+OYzlRTnVbvOh2TZNS
	 XDN3sfw+whSzNh/5tDl63ymUC67lMp9auZVt7zJ5XhBJGxDyWeO5ctdsMCsoZkc7qp3un
	 D5Utf5N0eo8bq7Sjd4dtqpi7WVuKwsa+LbFjXhhw/gyX8g04TUOTaIFduIqJVeIim+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=FUoJ+4Gz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020120.outbound.protection.outlook.com [52.101.84.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDA606A321
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 12:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FEDA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=FUoJ+4Gz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quOWwn1fvJRTx/NpFGVIBPuwE5UzSxd46odHRGHHK09787PtItHbVxQLDy9R/0YH8svw5je4DQEDX6+aPtNBpk5tsbrqeUbKTiSEIEisf1aldOwex1+sPiPRRoJOoCIsZLUYnb/6EQG+EgjpxGxusjWM5vEZ4X7UyRbDiv3MuJ/eE5+crfUmNsBpDeK7DLrOvzkWAInXdaxFophkTbQWvEKrc0TX40WVLFl1Z/iojeBU2lvwkVgDB3CWOIoT1Xc+lSQaIPUgqYYsY5nNN55beKiZ4N/ZcGvbTYUsA5CG2IETbzXFiprtTSqaxsV+8OaOnozTPfLn91W0ORhjXfYfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPN/190hkVwdQ34FM5ZdM4pVtbGAsTLZAifRoMswHfo=;
 b=J/ji2csQAexFEgvNIW+8rZiRE1OiT2lSCSnrHXLyz5xibn4jPPfL9xDkaBPkVR7/d8cGAtb5AVvDUz2cKwKMhkKCBCG4VcVIfCWndTrTm1Nc0CNNKU7Uu+Iv7J8Ui5OisDcHQsxiXilqxJLIs9G/4RVtw1JaCEuPabz9mvqr9ivPgrf80k9LPppwbzmaV36GMLd3gv5HOCAnfvuSvKcSirE7beff5+X7LaiQ+dQ002nd4gpKEPoPDRY/zX/l5/rrhcQcKIgTiApIF+diE8Q6hI3ODQlYY84yPQlwtO1na22ONxDrEwxQpGjGCAIXDvwCZgUOLjTaTfhuUxsDdleBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPN/190hkVwdQ34FM5ZdM4pVtbGAsTLZAifRoMswHfo=;
 b=FUoJ+4GzfD5KLkTPo8vixyOXiBFbIKGpxnniVTCw1rfPlGWCe1w+O23eEjAiy0rHElmrvs0ijCu/UPE93W0A8q5TDkZnD0/HCIzm89SFzz8NNbhU68B2HLUdLmwFrQQm9mVzFdGFFIU2VkWNy3gRZSqt5MPHBn15rBvZyvPSNmw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by DBBPR08MB6026.eurprd08.prod.outlook.com
 (2603:10a6:10:1f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:00:33 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:00:33 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 2/5] iwd: Report a network connected only once iwd is connected
Date: Tue, 24 Nov 2026 13:00:26 +0100
Message-ID: <20261124120029.1288258-3-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0041.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::32) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|DBBPR08MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: eae4469d-cfeb-4cbe-b4f1-08df4a228b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|786006|376014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261021123027099003|261009223327099003|261022105027099003|261021121427099003|261009220027099003|261022075727099003|261026140227099003|261026121527099003|261009221227099003|261009221727099003|261009223027099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	V77w4LIuKQejD93nFryj7KMX3XBpdfVXJgUjkEFE7HdRNkJl4B9ZPdcTSsMjVCtycCuflerrrsaSkm/pDbao/0TOkhlu8A4BaynAydJO5yYToKH+hX/l2JYXO0uhmLpl8/KS9PYTbqYauc5r4vZNCofjjLpR4c+BSPeNVQTa65Eg5yePMoRqb6tLt8YHxXjguWbzJndr9KAjsb/Uk24GZYufATbTa4cNq3R+utWCsdwj030bkAAZRKKn/nhDhDru+MIXD+3rTUJ9Jwy/i1JwcTVdP688LN1gWil3BC0ncK9YgGAC2UEZTTEEMuEodwGcoAaU3KofzDYxttKfMm4zVpvM1sWocwzjBhEGg18e3c9oUt/H73r3r+tmnqpV+I5a6rBwueGgnUz8AFfKPejCbNXRgOA7dnIj1sNfk0aKkpo6bnpXi03BuoQDr4gksv6OUTbD1s8g6PdWkjO56jYGeqTkENJFKLeyeXIOQF7H6+oob7eyzrqoARotJ5JVDKxpvJf8/HhkI/9WrRZi3AyUJKSyzyMRmjAfQQ/2QyzjtVl19oqptame0HW8m03fobed8C7C8OIx2hjzJ9pfSA0lxS0f0GIMYEn4BGSvo8WciomCYjhUmcSfR0/p5enBKVixbagzUpfAY0ayg5AvROKGSJZ97ApPUVodKkEUO4DFPbw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(786006)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261009223327099003)(261022105027099003)(261021121427099003)(261009220027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBofSoLsd+UOWz4zyQVPsqckXqGYzxybtgANt8dtXmKvv3SJbdTwQduvq/LQ?=
 =?us-ascii?Q?OBHOc1nQJ5IboqoZ94poRUwZHjACRFySKRczsJh13CWLiL3vC7fHGE7B8BhL?=
 =?us-ascii?Q?62M4o0/wTnBMpIp2CvumsPd8xwHeAbV90aFrBp5Qmfvj5/ft0T0dLX3DZui4?=
 =?us-ascii?Q?YCHAXQTqI6nBf7DdpatKbo2SlZOQEIviv6VTitCVgzaEC/SHjcLm8dXy81cQ?=
 =?us-ascii?Q?+9/RLhrYgNNWlmdhv3NZ3lrBdEW0ZXAhynx/1+CExAD+VLd5vDRSsmvfJSU5?=
 =?us-ascii?Q?ey0uxLly6iW+FGD2qiF52aIuhZIcW9WkvPYN2cq8i7gSbkN2Nxo8IGf/mVmx?=
 =?us-ascii?Q?8TxA4kSLodsmBmvCBUczm+nC2g/CATz1CXUsV4W1wgvmJv6pX2BLv9Tm8tpK?=
 =?us-ascii?Q?duxFoXCQ2xkfwghzApsaailwwViMcryBXLg5EfqKst3p3/QTyyDtjV6m0thC?=
 =?us-ascii?Q?5Jag4ecamjDQVWIcIFOLZLFSkqEjrydGMQoR+G0wCdpkqeKL8JCq2VFXBaCu?=
 =?us-ascii?Q?4YfeyluyGjWr0bgFmWxszZfEKr3qAa8AmLWNKbMBaV6qNh5aHR5QUvKmujSZ?=
 =?us-ascii?Q?bEogaA1OVAHLEkHihNxIol9+AQrxHFJriotLF0GupBsRkh3JbMo3pCfE+EjH?=
 =?us-ascii?Q?MzCwF2S+PhTBAIH7U3Mr/NLpGr/uWncYvidjkavmg7ahcQHJi4YfjTo7S9NM?=
 =?us-ascii?Q?wybVxLY3+HUmSHSCAHLL58/wQ9pe6P0oDLbHC6hMri2yM75NvqHZ6dNaYn+e?=
 =?us-ascii?Q?yRgrUDnm7DoCGkzRPEw2Lp6td8EEYiIUX9EBOiRShKvyAz4OkfsGIcFoCJYh?=
 =?us-ascii?Q?7rEx0SH+EUN3XLZGtC9HZUZPLgNm1PC8UplLh69ZiTRaxpa++DfPA0W/i/XJ?=
 =?us-ascii?Q?f6YNfAmZZZ/gwAU+GKkxu7kx92VeImeKoxQ4QYzWu/t/pHbHuXQyLaMfmWkS?=
 =?us-ascii?Q?WTCq+DM+yWZH3eGEVCEYdVzAUcaJDFpadMr6JRiIUtM5TKdilZV3I5H4hv85?=
 =?us-ascii?Q?JlzIof8myJ/lJ+rQsyjwtbr8mEataisDFi1J3wcwvZ8Azsbxkwsvv9kWHZdi?=
 =?us-ascii?Q?nbgzAWZI4JMIPsyAoVbS/dsfudvc4UXJyGCI6B5mBFVQE/OFyTJSvOZNll8H?=
 =?us-ascii?Q?tv1J1NdIDydehi9mdLoULdCfp1/ubk7kej4+EsNdpIxR7klQmoNCBf1B5ba4?=
 =?us-ascii?Q?zSIYyECPWF7blYfblEJVi94HOlBcW82YtHgh5WkZwk2F8UiiBuzSuORndmbZ?=
 =?us-ascii?Q?5rTCYyzJHFhrlgt/+dcKejaTI8d1tj/Migqh6wgGsJ86zyi6LgKFmeG0NScF?=
 =?us-ascii?Q?iI6aRH0ZYOCAFQy/2LZPVhAD20MQWrcr7qvWxwJAZAsAFTEup8x7Mam/cTII?=
 =?us-ascii?Q?/mB25J91uVc3UglZJ6mfxEnSXs0W2nEHmM2uNFTyCl+BAowFIYvZpwqfu0LD?=
 =?us-ascii?Q?NLTaiBP1nWfLao+VZ9HRqbPeMD512dG7IS37gYua/szlg5g0PYGZdbm+Xpz0?=
 =?us-ascii?Q?Efl61RU/qhFsL9xP5FAIufl96lEy4OeBZyRBlmPAbMhn96jqyXMdgs8A3XwW?=
 =?us-ascii?Q?tO4dc/3DWToMJipfXl35q1QQnLTJkgiDE0dj6pe1/qJrqtog8xvBDGVYt2PD?=
 =?us-ascii?Q?WiIC9be+gH06h/eEeMYJCNnOrzxd2X2uGC5n1QDOmkTGjgexr3ohF9Rq2D9n?=
 =?us-ascii?Q?26lP6QVUrEIN9ZZ2yJ/Mz0Op/gee2zKodVIx2lv49FuK68UGdc99rQIKLAOe?=
 =?us-ascii?Q?fFPWA+hQUzKvfst2OCtEqXTEYdOjcciuywRytXkfm9YBro92EcDh?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: eae4469d-cfeb-4cbe-b4f1-08df4a228b39
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:00:33.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nuf8MSz9SxXuLrqTuH9AWFSuv6x2+acGGJNQrwFAai7sV3aiTXdY6YQd09xiljBN/QnZRUl/e8rQCkeIejFRxtDuu3bz04YaJPKRu7TlDjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6026

iwd sets the Connected property of a network as soon as it starts
connecting to it, before the association and any 802.1X authentication
have been completed. The network was reported as connected at that
point, so with a fixed IPv4 configuration the service became ready, and
Connect() returned successfully, even when the connection then failed.
With DHCP this went unnoticed, since DHCP only completes once the
connection has been established.

Only report the network as connected once the station also entered the
connected state.
---
 plugins/iwd.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 19229c10..7cfec424 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -247,6 +247,19 @@ static void update_network_connected(struct iwd_network *iwdn)
 	connman_network_set_connected(iwdn->network, true);
 }
 
+/*
+ * iwd reports a network as connected as soon as it starts connecting to
+ * it. Its station only enters the connected state once the connection,
+ * including any 802.1X authentication, has been established.
+ */
+static bool station_connected(struct iwd_network *iwdn)
+{
+	struct iwd_station *iwds = g_hash_table_lookup(stations, iwdn->device);
+
+	return iwds && !g_strcmp0(iwds->state, "connected") &&
+			!g_strcmp0(iwds->connected_network, iwdn->path);
+}
+
 static void cm_network_connect_cb(DBusMessage *message, void *user_data)
 {
 	const char *path = user_data;
@@ -1254,10 +1267,10 @@ static void network_property_change(GDBusProxy *proxy, const char *name,
 
 		DBG("%s connected %d", path, iwdn->connected);
 
-		if (iwdn->connected)
-			update_network_connected(iwdn);
-		else
+		if (!iwdn->connected)
 			update_network_disconnected(iwdn);
+		else if (station_connected(iwdn))
+			update_network_connected(iwdn);
 	} else if (!strcmp(name, "KnownNetwork")) {
 		g_free(iwdn->known_network);
 		iwdn->known_network =
@@ -1404,6 +1417,7 @@ static void station_property_change(GDBusProxy *proxy, const char *name,
 		DBusMessageIter *iter, void *user_data)
 {
 	struct iwd_station *iwds;
+	struct iwd_network *iwdn;
 	struct iwd_device *iwdd;
 	const char *path;
 
@@ -1420,6 +1434,14 @@ static void station_property_change(GDBusProxy *proxy, const char *name,
 		iwds->state = g_strdup(state);
 
 		DBG("%s state %s", path, iwds->state);
+
+		if (!g_strcmp0(iwds->state, "connected") &&
+				iwds->connected_network) {
+			iwdn = g_hash_table_lookup(networks,
+						iwds->connected_network);
+			if (iwdn && iwdn->connected)
+				update_network_connected(iwdn);
+		}
 	} else if (!strcmp(name, "ConnectedNetwork")) {
 		const char *connected_network;
 
@@ -1831,7 +1853,7 @@ static void create_network(GDBusProxy *proxy)
 
 	add_network(path, iwdn);
 
-	if (iwdn->connected)
+	if (iwdn->connected && station_connected(iwdn))
 		update_network_connected(iwdn);
 }
 
@@ -1950,6 +1972,14 @@ static void create_station(GDBusProxy *proxy)
 	DBG("state '%s' connected_network %s scanning %d",
 		iwds->state, iwds->connected_network, iwds->scanning);
 
+	if (!g_strcmp0(iwds->state, "connected") && iwds->connected_network) {
+		struct iwd_network *iwdn = g_hash_table_lookup(networks,
+						iwds->connected_network);
+
+		if (iwdn && iwdn->connected)
+			update_network_connected(iwdn);
+	}
+
 	g_dbus_proxy_set_property_watch(iwds->proxy,
 			station_property_change, NULL);
 }
-- 
2.53.0

