Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2133.outbound.protection.outlook.com [40.107.6.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212245FDC5
	for <connman@lists.linux.dev>; Tue, 20 Feb 2024 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423969; cv=fail; b=IdaHl0yKvTAtAhb0ddshGOpFqsIqBa7PeTQt13D3DXas0bBqDGBOnxuL67nEFx0SCe+mgIiEHwnXeCFznfjJd3ycszORg5ZavkwNr5/9omhVy+AeS2pUBIMNViVVgRdagIujFPdJz4jA1K5L8kiV1CtYfi6vUvaMCeKWwGg2vnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423969; c=relaxed/simple;
	bh=YS9Wuoe8Wm2rc8A3nDn9l3rm5N6rDsadFWoGorzwt9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5UZ/jjhHsArkpjKUOk5gE5ORsFg416xLxBqsfCyLDnVLACViVX63amAdXz4oVD5LkBu2ALX0uE4OJQIBmkqulTJNBJqCSbiASjW1l3ghakOCTMEFx/sCvidbnkt68FbhzJZJ96PG7lcbAK1w+zKucDJOJbhEJUbiIBJo3uf/lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=UAhz+rwn; arc=fail smtp.client-ip=40.107.6.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="UAhz+rwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhseT/6ZAj2JMJHxGqc9Xq61SyzmxW0F1e2jZeMIzKxdHoNFzVPxBH/+m0caZzXCrnS0yvLZ0lpdgmsvhZ4afmj6NpHx9BcPiN9PJelUEWpxhahP+hvq2F572JS2qF3FL+EznI91QoztOoXv4AJLKIyMKg6kTHqChkxLr1DjXlmF8h2vFtN4Wywm71HL/Zcfk23+DfJUayABjYxPYkMktsR3VxMdG9O9nV9oalEkNWwCwZq+DY/KBFKF9raiX8RKh8MXRuGip3oYHgGANn4ju7cShEc3BPEjP1d8GJVy4upnDfxsx8eEGMPqvEAZ6g+rK1WFLdtF4TCfhbHwjkoAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/NLF26l2AZ76MZ26oEmeuqK1EiOaZv33qQtRyTWjtU=;
 b=ejC/FfwzDUezS3HhkvveMeM8xt6pz5GcX1LjPcP/CgskF0cbX4JTL/n3RY4Yk3F7S4njdt3y1T5wUJw36Fr9Q1ejm6DIhX1HT9SfsOgaqdsOp0tcbhArIcHRmNq14UaWiMqKMO+GQ+ITG7ZKo9+ZMOZjgUPJmdASfXgatW/gvg7erSs4flK1N9hiuUr0kU4lSQkNlNMsUQ7DPDC7ZycNnMocwWhCPjPYZLtKshU6thXgVKGxMUYuHze/TN/xzsq3Xc+bz0kpI73P6nv9VmUEr1P+GOqNo7gEbZh+gTb/m8dhwgGdyqxHYnYCC1cqrBCI0CGJVFJg8UxtSt8rXTGGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/NLF26l2AZ76MZ26oEmeuqK1EiOaZv33qQtRyTWjtU=;
 b=UAhz+rwn6LarW+jYl2FPfPFTpzoUyhgj3rURpeLXFGMCgQXBkDolEW9sTgiIURAibOx+J6KvsHpnKJ8pYekBN47AQ7ap3vBMToiZfN+M7YW1aNaUGHBFJWbSc7ptmi0diA+jEWT3wkOjXNa1Hm4yhRAqWT6N3MqulAben0n524m1F5jNNaH1jxutxgG3CEnaMnyIoqF+ykn6168Q2dI7KIHrzRvnHfgnQzXT8j6YnVDaQgXEZ4xvuDtbJWPn3NvyyOBNagPpaujfD74MfWqdjzS+VUqonTwODvLwgHI3xvoS4xDndqeK5ZDlUgLsXIpJToAWcW3sZwsrTtzhVfZyeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17)
 by DB9PR10MB8262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:12:42 +0000
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09]) by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09%3]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:12:42 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: connman@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] service: End connection if connection failure and no agent
Date: Tue, 20 Feb 2024 11:11:39 +0100
Message-Id: <20240220101139.36171-2-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220101139.36171-1-c.ronco@kerlink.fr>
References: <20240220101139.36171-1-c.ronco@kerlink.fr>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::12) To VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1cd::17)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7810:EE_|DB9PR10MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: bf418458-a0e4-4b56-d30b-08dc31fc790f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wBNdYcmqcs3HFkP/gpk9LDM2iZ4/c4Lxpe7U3dAnqaUeP3oIZ2d/IBCc8LpG2dyDrz3Y9JYUgfj0tAvtZJSZBTzdTFaQx209UddzDkl/aa/4QG+Os70xfuAylwTqlYFkEwpFVvbavX43vdzFHRzc1NaRH+K9iuZtynZ7XPsWPBDHK00BFm1ikHdELZ9v4Ds8TxpUo6tpHnd6rvTy1AbcREjgRWLZcjmWNJjjD/RvXyvMTJNoh+1HBSBrAnlWxEQRE2DRvT9yvrfMv70u8RKUwMga1fOPr56jFsF4RXAnkT2f3UbdZXfDgUtDBozlShZ/UZPEFFUofwdq/yTsj3K82F2yUpQipP73dsRpSnH66SI9xfH2mif0mfnkez8XyvjQm1FktNonBIU9GyofvMomIy/Un2MpKxzhFQT1kjASN5DtWt1jyaO6waaKobo5yko+4Ela9XySTeSCMUIGcfcvZOBR96Si/XkKiTgQibAhQbbpZRX123rV4P1Sum1tgCZ/iCh9g3vwkhw429FtgWSW4780HGmDR6w7540AEMe8QfhuBWank26dt2kjhBnYSGH8TIeMmFNqYonKOpHrac2EF6KRWTjgIvO4o4HkGmC6CL6T2/MKTmS1YlCSIxyBaCD+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QI/Z+e48VVvWYRhaqcjGqBOWO0CsNs0AYasyYvrVeHm22m3sbzCu3wFXujuS?=
 =?us-ascii?Q?fBtf8w5/O3InnIlg9g5iaR8L6ZrTJzS7yY1+cCNF9JLqj4hNlLIjJlU3MYtY?=
 =?us-ascii?Q?VmIecKrPOHMsYfDygmgLU9ziMMsXCC54gPMlsFo3eQ2Z6OZH4MGvCQ+tWP75?=
 =?us-ascii?Q?Zc7poc6A5uaJgntIXUv+9B/buGDimVgyRE7eecBGLk6hAkkmV/NxSgnDjDiZ?=
 =?us-ascii?Q?CuYMPqVpfjW1L0MaF8OS6CL4c1jg8K2/udSxmasraa6XTCM0TSqYG8ViiCLM?=
 =?us-ascii?Q?L2fC87Uuc7ijy4BRpZ9a7RHiZO1qUuhqTwMsyICsGsHWldSnHsBF+nO3gGgw?=
 =?us-ascii?Q?vNd7sAVV+UxOen9DfH5Poz33b1iz57NZHhcEb8RCHcG9BOvF6stKrP9bWfjX?=
 =?us-ascii?Q?0rhHYZSq9xSt4loVJToddMxLyjiMCFEA1XiZk+XzZ+6O5lZv5XttO3GHc6Vo?=
 =?us-ascii?Q?+MME11+6XwFgAv8MBeOQ+RafM6HQJ9vJxOTu8L3X5s9ndPx6qS9mKc5Odc/k?=
 =?us-ascii?Q?OQcqwjZi8K4Y4/rEhWBQVf/5K2nQa/1i9TU3MLwyFzWY92vzjV98pAysMpLs?=
 =?us-ascii?Q?R1xtcGUZQiCcn9MK8yBekp3UPnRiXl4I8msQ6D2tgwwQ5eRp3mZ7VFWRGD1/?=
 =?us-ascii?Q?fwDF4gadskXF6Sb+85DMkrhMTNtcAHQdCsC+8bwfUFbFLyZVyWLDELGEJ1yt?=
 =?us-ascii?Q?3LLnSFEfOT0rSOlb/pEhao9QH3inpjk8qbLrla/36I2LFhItXMKTEGCvykaw?=
 =?us-ascii?Q?LUp5v5x+un/Q8+mGVgRcLFoDwa3onrpoRgFPnG+t3KfB44RtlHJZ9P6V66JA?=
 =?us-ascii?Q?ikVUdLm7lRfqZ+Jf2KGGLz+56qpFzGceKxT/fGZ6SXurxirf0GS6E++o0odr?=
 =?us-ascii?Q?jllpCk9vd5tWAy8+olc1mqJcdoQSUE5LJsGdnZlKXYdtyZtWIu9FzhuPGYLv?=
 =?us-ascii?Q?9wlT0TDCeFwqVAFZx/vAAqbR8ZTeALKW7VSmXwWhl7EPP4BsuPrEmD16KkQz?=
 =?us-ascii?Q?AfqMyohK3jyzTIwJJ8xIijF8IzAnC3HUp50920CswIfPYRRIuG1KVsA+PIE4?=
 =?us-ascii?Q?3cP0Iz4Se5Sq/tY1vSvk8XRUoYVpq0nPN/pqp+Lu1uky4WDJItUL16vXYaZL?=
 =?us-ascii?Q?ZLpvOYU5nTo933EgPwzHpRRbRcWhGfhda2iYeKUc8J5/69I1glKaFS/7WKkq?=
 =?us-ascii?Q?FY6az5hIM+W/BgFPVnlr6MEx3gDNAelJAtfit73hueaEJlw4w1Fl/y31rlK5?=
 =?us-ascii?Q?bNPt4ZzGvXDYFAMGDCyGjcvkb1KZxajoX1kUdGn4JyI0mQ3a/uv7TJ6iL6T2?=
 =?us-ascii?Q?EOEtVASqLb8mHWfL8C35zik8wpy12es+p/BI3gHV2RQLGt71YAWNI2vqTxmX?=
 =?us-ascii?Q?x0jE5mdRBNYcPs7qMf9KmJL4OEu2SKsA/zeQr8cYWmXhmM2ef2lFmqWu+Zec?=
 =?us-ascii?Q?OePNkw5dYhJeVhXzNybasvcl0Ak/qVTXg7mesmoH/wIAjHDtDjCdeo1/VLMe?=
 =?us-ascii?Q?JeifNDzrKmviHBWdfbvqfFGNTB4svEmwk9L4jtzWVZJNvjF9wM8rrJ5RVo9A?=
 =?us-ascii?Q?H6aqlgWspaKq/0h8c/N8yDDaMRlUL9a7azX5I3Lg?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: bf418458-a0e4-4b56-d30b-08dc31fc790f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:12:41.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nknmx9Vr5G7cyuLuMTDjm9w1FpHrtzzxiQAXn/p7W3rPjS9/ef/7t1V6BuNoKOmZOdMQ11uiMW82mx8zBOJn4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8262

Immediately call service_complete in case of connection failure and no
connman agent.
---
 src/service.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index f3e022c9..805cfca7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -9189,12 +9189,14 @@ static int service_indicate_state(struct connman_service *service)
 	case CONNMAN_SERVICE_STATE_FAILURE:
 		if (service->connect_reason == CONNMAN_SERVICE_CONNECT_REASON_USER ||
 			service->connect_reason == CONNMAN_SERVICE_CONNECT_REASON_NATIVE) {
-			connman_agent_report_error(service, service->path,
+			result = connman_agent_report_error(service,
+						service->path,
 						error2string(service->error),
 						report_error_cb,
 						get_dbus_sender(service),
 						NULL);
-			goto notifier;
+			if (result == -EINPROGRESS)
+				goto notifier;
 		}
 		service_complete(service);
 		break;
-- 
2.25.1

