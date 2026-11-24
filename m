Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479211;
	b=CZkNUUZPyU4oVT8UZiArMfAplhrOXsRV8IQvsu7rYYpJh2Tj68NquEkxfuKrH76LdPOO
	 /IL1U7MCYMLbi/eWMSkAamMHcZ79TFdEFRwHwkwU1ABRmkRgQkSgaI4WpQe/eMQlX5oiX
	 oxa7uJhAdQIpFdMXN8zcd6FqjMd+OUVYs/j000rvwPFklOvtrVAkpghXdbO7SYl6MwiCc
	 HJ9kly+ya8oRuB68p4ws5XUCEo9HH28m3vmB+mTzxgqmYUY4+rTXwr10F6MFWnZUXP57g
	 tCsXhkTqsfS2zazhxiOtMQ/gGJ8txJVIWYZcDrJJCAp0iOYWsIg+ZK5fYQEiOKr/QyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479211;
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
	bh=VpY7Q4dR4wbd+JVHaWY6KUkdJhhPHPcf5mvPHkv1jPM=;
	b=4lQW+z7frswD89xKlCmR4L9csaTPQ9rdmlyyO/OPztYCNLWStFcFcabLGg6jPAdNdAVf
	 WHj1e3OtcVLxC7gfwwwkTqLb7lBQqybDeqLj+s+DAH3b59p4VeHbEsmXUVDGbgTF/v2t4
	 Wuli7MeWx2Jgy5KxcT7HEWoy3rcYuB8KUemB+zkZa46qlk/6fzVqGuyLV3jvJ4/KkU+fY
	 RkL4l7zAPILWKviOYQxRe79sKIuQ1fubkwfrAVIFErD063fl8SSzi6xVaeDgljxew/ecs
	 lSkLsopTCBW+Z0P0WiPFcBQliJHoVYlj6IyY8JVIAmDOWHsN5Ces52MV80W0blLdlPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=NqkM36NT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE670606A322
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE670606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=NqkM36NT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnTlMWMehv9B+UDl1dl2pAR24TOQfELU14FsJUJL386sYU3SCw2fqcV3M5tvMoxi/4jU20YQnbM7rPMXkfo3nR2+H7i6yEkPivcyOWm0MGmnoPm7m4Io76+uuhI7CBAeekvX0fIBo4SqZLTr8r76MITTGkN2Z1uxJuaaPofzJPQzFwuORbDSeDHp0IoWlFkHvmP9182PPxcpGrznTmI8z3zCMMkKuV6mAkZdH4FxZVba9xB3WCHHn+Gu5RMMpFei5yUek9cO5JUgYs3Cc5UBjog9gR4yMM7IX3ysCK9zAwqCTjK3ngd05Srpn0qLZ2WkYQd+6/7oQD+WdeUZn4dpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpY7Q4dR4wbd+JVHaWY6KUkdJhhPHPcf5mvPHkv1jPM=;
 b=vRWQ44YcpudG6vKHF7tYiKSbgCEBHJB7kbQOEs+0iWQg870Quw7IeAjHdiokyhilH7UKprdx1EnlHQrylPnTHB8rZMAet8ShjtaMzUGYvznSmyA2njicG3oP0blEwYowfntKilmjRH1AhTMNKnyK0lPv7WiZjL5uF759SVIijz0b5XDNWGfj2nEGvF3sdniaP/z5CKpTvH40nMFUqJT4dn8kAaNHestC1XWQT0Y1hCxNhlP/+oJEs2hamrt60V3PhpQ2eibgsNB6QJ+hzF8ECllnme6dBzOYUK+kR+eSpKynOPHaBThvMRv7Jj4M8FwA6TZBYRUYINrekK40UEnxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpY7Q4dR4wbd+JVHaWY6KUkdJhhPHPcf5mvPHkv1jPM=;
 b=NqkM36NTsafggLFvQ8QJ7ngX7n8SR2Bw25MV1497aQ9wZNvMgl20KdjUnoP+ig9sqJbQhGcyW473ZKDrFk+ucbcjvLidyh1C/caGbwXfMUOnF9ojw7cJEqmCuV0QpiX8NuhYQ23P9BTD1+Un91cCiAbL5R7geER3lb6QUSNdJ2o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:28 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:28 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 09/15] wifi: Add support for TOFU probe connections
Date: Tue, 24 Nov 2026 01:13:05 +0100
Message-ID: <20261124001311.1161845-10-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::8) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b4ccbb4a-097e-4376-9c06-08df49bfc417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261022075727099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	hSKcmriQmn/lT6HPUeas3LcXIk/SKLo39Oml4i4Qtt7JMYe4cCUAIBXGS8b6gM2+X+EHez6uSppcJsqwWJh88S6u2OHgHcU6fnutK/ffPuH3yRjG6BtwDAZg8boyYunUBjz5JNXphHJWoshg0wZPB0XDhZSy/0OMfB9AAnMSvP4OrbbqfmrHObZyabDQSFaycIMlvHSgyzL8d3Wqiw/pDvMDM71nZa4+JJtng4l1ev8JS5wINisF9ZdyWHpZlZ0zmtlrJ5xnntf5NRAdjlhZNRCKO79I3NzMa+59zcCrnK8ag1OrxVqcwIApPUXBsOVUiS0g+pstOs9Sp35LTBONvLBytSPsgc58S0UWrnvCZ4wYtGn17zqmoDb/JLy0LQAHCo0lbTIoSruzz34I5XchtPi+6Z7l1mdf8iKo+EH1AnKUBFNI1EHfvROQ2fmDDURtSvfgYNO3QhSpQP8JY8pS51CfujBnQqOAi7sVhGGPknu96hrhZPl/eHBKhJWP5on2OKRCFEhJoZ70KOX+LX6Z9D74ZAc05Alf7ySzRiiGqmEa1kBV58mw4uxo0teKPnzoqJRoB+UYFz2IjZBI78nNszm/DCG4xq6A3UnDbvoazBc132s+DfAAJpkt+wtOs/pRBBu4U24BMklFFxB+/brrziXsY74Hmw6ng5rJ1lWfPR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261022075727099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UoyVzhych52xtpL5CW/U7srJHAPJqPu4npP53fVZjnCyqPOCqxAIx8TRUw8?=
 =?us-ascii?Q?KDV9yAQjYrej3rj7K6NNPZGY67UOOss3ydr0gwMFPV5pKIu5MW19oorvKBaq?=
 =?us-ascii?Q?crFysVjR3Rpgoo3Ifj5Wdn9FCJXKK7gE08b/sFnjgSU5MPgYpimisOxyWIIw?=
 =?us-ascii?Q?tbCJAl9vCx5YUAoGxUE6duIXlsiv/wofv0OoWZZBm3ETasKr6l3rFQGS9Mse?=
 =?us-ascii?Q?UKSVDMKNQpulE38353zsk5wR3j+GR5SQkIH8pP/d1eTXeoYjUZhQEYrSfMEm?=
 =?us-ascii?Q?wn/pc4vYmaYvchWRyJPSUmZkWNoiSD0tmsFYzSIUSAq6Kj/VGDHg/PH28BSC?=
 =?us-ascii?Q?R7R+jhLxoKmz3o3pRD2zAhyyVAiOZ8Y2yOIiR7nNjHpiqg3J3drpR1wmrhFt?=
 =?us-ascii?Q?z6R69zF0qfc9ciF/GTbjUVxGucpJJQdysINhe+4AG6oOEVY2UvlC7YoL0QQL?=
 =?us-ascii?Q?L+khOZKPcJpwRml2yj+f3D7dr2+NBy+u81fOaqMpBMkb+wARTND5um5Boq0E?=
 =?us-ascii?Q?F1TRnD6f2OJrIffTJZYU8AjS781Mud4zbeN1sJlwbJ6t2gISxwJ6g6g9kuSg?=
 =?us-ascii?Q?0alh28KTKXZN89/BzApxuAoh8C60EzaiSybn9YDM4LMHmI4BYPsN6jiKuGki?=
 =?us-ascii?Q?zvsIV5VIh34QsgrF5bGgqi2ArlakRuruxnM1Q0gQJjJ9lFfTUpURcSWjvD2W?=
 =?us-ascii?Q?v8UZ6wnsaD5+IPa74G+H3gC42i8Ec9b2mo3h62Gj7/k1UmKugm+bZYEquplu?=
 =?us-ascii?Q?DisqeTGeUKGozcBdIIDxDeuGhA2szG44qXj6eX9hiRGQ+tREIKpACoSl7GdS?=
 =?us-ascii?Q?LcHbE9MvAPzqD2cBuu+kHVe4/C2SAsAbJhizYRR2rs6TVaDwKmE//ljjWfkC?=
 =?us-ascii?Q?gAfFAAIE6Tky48xKce45jKpLEOpD1Fbi1OXmHYr5yLpbb8sPZXIXucQeUpI7?=
 =?us-ascii?Q?uTkuqaWomwyDlQ/NEIEDk1Zsc3E0RXhxtVyqMHfdUmoPeKYuvCy+7y0Ax1vS?=
 =?us-ascii?Q?fNXfBkbLiTdKL7V5dXzVPluMCO7lq+q/tgxZj19gGfOUHLdUt5dOKW92Uecc?=
 =?us-ascii?Q?UW0cJA8E9azgGQR6U5Pebjek5kfnqls8Bw5Ys49mABDk81aai8EUfaSvZK6r?=
 =?us-ascii?Q?7eLQQhDGrF6fFDWdI2GTEOXFkOrKqy3HU34mijJBm5Klb0xNQasAKjtgQaEw?=
 =?us-ascii?Q?qFUQBvjwUMcO8xgqum6EQ2W/nkU16yTlBY9usDbkw3SW/iYshn/XE9PAvNIN?=
 =?us-ascii?Q?f/L9xK4c5NjETEyWDr0lmLnqWXsy7YhC2fZZb8EwZxoxGyZHI+E3B6FX1C/a?=
 =?us-ascii?Q?wHvqYp4BigG0ApYTCtYoZEPc+iLw2Eg2WmEsTSbbj8fdJzMPtJmD9xYVEwX7?=
 =?us-ascii?Q?sxmDhHflUg7cUSj9nlBg2letMCjEtlQqAxMHFDat6k0xGTlKJALbNHG9jYAw?=
 =?us-ascii?Q?vRXVio2G/msLogA9BtmECudVAew4G/ZF6k+i3Ht6W2w78LAksbgCvpKLiFK/?=
 =?us-ascii?Q?Uwzs5qPuCvRnOcKcxpzwRz4kJkqgRlBGx6ed0vsP0wpbAeGhRCLxfWWBBBME?=
 =?us-ascii?Q?XpYWnyW7GLCEon7sDgQg3h4vfvGs9Tpx1S9DDbhsPHa2PhFp9ETBeRt9Nf8o?=
 =?us-ascii?Q?0b289L6YTRx1GLYjnqIYJvDk/ZrwXIBNZJtnye5bKVnWpGtkoxmpiEpAdmXd?=
 =?us-ascii?Q?dO688o7qOASsDepbMprt5hErGHh+/6akV9biaySk5IMA/lw4MJWYCaQ9kOdW?=
 =?us-ascii?Q?pspTrA1kB7D4HTXbr+hImR2jadp5UGr0lyRQiqokGEqD0IU97G7J+QydcEZQ?=
X-MS-Exchange-AntiSpam-MessageData-1: BYEiTaSGpMANFgqkLcUCx8JUWUZmYMudXyk=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ccbb4a-097e-4376-9c06-08df49bfc417
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:28.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs2OZdbiB3cvuafd2Iyn/cMzUmKSBrGk9TOp1Dtl0nZzxUQOpwOqA9ykRoUtH4h4GN+AaUIkcUpYDEAM+J1Vj9FOAcAtRn1OwGbNWh2z8pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

On a TOFU probe connection no password is sent to the unverified
authentication server, so the authentication fails once the server
certificate has been seen through the Certification signal. The hash
of that server certificate is then reported to the service.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 plugins/wifi.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 741962d5..3d5f3055 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -147,6 +147,9 @@ struct wifi_data {
 	unsigned int watch;
 	int retries;
 	int load_shaping_retries;
+	struct {
+		bool done;
+	} tofu;
 	struct hidden_params *hidden;
 	bool postpone_hidden;
 	struct wifi_tethering_info *tethering_param;
@@ -898,6 +901,11 @@ static void check_p2p_technology(void)
 	}
 }
 
+static void tofu_reset(struct wifi_data *wifi)
+{
+	wifi->tofu.done = false;
+}
+
 static void wifi_remove(struct connman_device *device)
 {
 	struct wifi_data *wifi = connman_device_get_data(device);
@@ -2207,6 +2215,16 @@ static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
 		ssid->identity = g_strdup(connman_network_get_string(
 			network, "WiFi.AgentIdentity"));
 
+	/*
+	 * The TOFU probe does not verify the server, so the password is
+	 * not sent: the authentication fails after the server certificate
+	 * has been seen.
+	 */
+	if (connman_network_get_bool(network, "WiFi.TOFUProbe")) {
+		g_free((char *) ssid->passphrase);
+		ssid->passphrase = g_strdup("");
+	}
+
 	ssid->anonymous_identity = g_strdup(
 		connman_network_get_string(network, "WiFi.AnonymousIdentity"));
 	ssid->ca_cert_path = g_strdup(
@@ -2268,6 +2286,7 @@ static int network_connect(struct connman_network *network)
 
 		wifi->network = connman_network_ref(network);
 		wifi->retries = 0;
+		tofu_reset(wifi);
 
 		return g_supplicant_interface_connect(interface, ssid,
 						connect_callback, network);
@@ -3344,6 +3363,66 @@ static void assoc_status_code(GSupplicantInterface *interface, int status_code)
 	}
 }
 
+static char *hex_to_colon_hex(const char *hex)
+{
+	GString *str = g_string_new(NULL);
+	size_t i;
+
+	for (i = 0; hex[i]; i++) {
+		if (i > 0 && i % 2 == 0)
+			g_string_append_c(str, ':');
+		g_string_append_c(str, g_ascii_toupper(hex[i]));
+	}
+
+	return g_string_free(str, FALSE);
+}
+
+static void tofu_report(struct wifi_data *wifi,
+				const GSupplicantCertification *cert)
+{
+	struct connman_service_tofu_cert tofu = { };
+	struct connman_service *service;
+	char *hash;
+
+	service = connman_service_lookup_from_network(wifi->network);
+	if (!service)
+		return;
+
+	hash = hex_to_colon_hex(cert->cert_hash);
+
+	tofu.hash = hash;
+	tofu.subject = cert->subject;
+
+	connman_service_tofu_certificate(service, &tofu);
+
+	g_free(hash);
+}
+
+static void certification(GSupplicantInterface *interface,
+				const GSupplicantCertification *cert)
+{
+	struct wifi_data *wifi = g_supplicant_interface_get_data(interface);
+
+	DBG("depth %u subject %s hash %s", cert->depth, cert->subject,
+							cert->cert_hash);
+
+	if (!wifi || !wifi->network || wifi->tofu.done)
+		return;
+
+	if (!connman_network_get_bool(wifi->network, "WiFi.TOFUProbe"))
+		return;
+
+	/* Only the server certificate, at depth 0, is pinned */
+	if (cert->depth > 0)
+		return;
+
+	if (!cert->cert_hash || strlen(cert->cert_hash) != 64)
+		return;
+
+	wifi->tofu.done = true;
+	tofu_report(wifi, cert);
+}
+
 static const GSupplicantCallbacks callbacks = {
 	.system_ready		= system_ready,
 	.system_killed		= system_killed,
@@ -3367,6 +3446,7 @@ static const GSupplicantCallbacks callbacks = {
 	.debug			= debug,
 	.disconnect_reasoncode  = disconnect_reasoncode,
 	.assoc_status_code      = assoc_status_code,
+	.certification		= certification,
 };
 
 
-- 
2.56.1

