Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEC2564
	for <connman@lists.linux.dev>; Tue, 11 Oct 2022 09:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Myi/0vbVZhWlpRRfNoLHaZc29B7gkT/CmGc8OwAbnHAY6RD8BHusdcYvnHlCo+jndcOE/UPmA1ZpLLSNUrhgN3uns8ZEA+9kCL05tlu1ZEAW2ebMFRoFV5bKSweVOj9/0aL03X3d+ZK3OSIJRdLP6jCbqf28BlD+t2OhQJf+ImO9V2vuWBLJYsPM6TyJzTKeQnmV/NwBJUxTg1mIaA/X2fOcDAfnFNdzMZaRFuBO7VyhgRUEI+auIRJ6fRFVLCuU2oMFggnyLsuo8T4j5AX+J3frTgFNEcne217ZSJwZZU7ZM+Vd0PJEAguQkF4iYx2pW9V65mpRhxvL8WNqOiWfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAF9H/VfszDpTzso9PY2qmXXV59oGtuiyOwYxiRq5po=;
 b=JFzf20wYIITgF5CK1X8qVjH+hkZdwD1BHeKLwh+6MgDgmetv691Eqas926NlyJG2xvVbjlI2znhxcXUeIgDj56cHZ0a8xwhsP7H4Bud6OIz5RHCAelbi5IxK7mAW3IeNwvRLcwWOFCQWwn5+uyqDYAg5j2Mc74S9xz/XRwcLMz3WZC/XLnomqWFDc9KzsavuqP8AwtrW4wq5wFQlbDPtEqj2N6GGKqyklD92vCCvM8BCzmSsMmlKXDDNYB1u4rgRynF+AyuO+RT9F7hNLUEnL5me+t0qUpto0N7YzeRNoFuqHv7BeO2QHY78NE+wGbgF9lm2uAcqLfM+C4vCtmkfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAF9H/VfszDpTzso9PY2qmXXV59oGtuiyOwYxiRq5po=;
 b=KMyXbkMcTIBcHMfPla39pk2RkqKaw1WuG/LdG0QfrUaUfU6QmlKW0SmYqlg402E+kOKX/Lsabe3SCX7FRSodqXORFaOpvQ7xTiQyFjU7XfQcoYL+ZZ6J0XYli2WEuRH5wr6pGfDm3ec2ofdJpefMPR/1ShQk6QVt03SloN2U2BukVzCDx0K0fNbhMo+RhCgVoTBBvRVyn8TQmwrsLBP6VVgJX0sZ9Bfwqsddwd92EYMBgBuswAnV8FntFVAyQzbaaAREkh3l2qVBnmLFPhEJ5rIadEH9W8mGi301/nYFMLZ2OHyxHPi5QGFdZ6Gw/0hIgoq/YQi/oBf7hrg7f+TE2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:21::32)
 by PAVPR10MB7058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 11 Oct
 2022 09:56:58 +0000
Received: from AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::646b:6d29:4cef:1cc7]) by AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::646b:6d29:4cef:1cc7%7]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 09:56:58 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: connman@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] dnsproxy: enable Fallback DNS server when created if needed
Date: Tue, 11 Oct 2022 11:56:41 +0200
Message-Id: <20221011095641.19310-2-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011095641.19310-1-c.ronco@kerlink.fr>
References: <20221011095641.19310-1-c.ronco@kerlink.fr>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:208:14::17) To AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:21::32)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR10MB1795:EE_|PAVPR10MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 14105eb6-78b1-469e-3b8a-08daab6eefd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m4qJiJN0xBKW2E527jdKGlPm+Wv59qkxaj0gNHZHwzFH5z/oC1k1eaBcbvh50UB8kyXEwM32z4aSbN74pe2MPTQ5Z16L088h0TMRZrsIYuTr0XFyLAK7rFfW/zgPjkhMs9erOTCUjJFEc/UL8JHRwTLV3jWgBp7OEhOuc1X+8pxyDABzcPSc1+X4ARuFOQs36OPtv4RgCpzjrzzzKP5QhCUgtEoa0+Pce0Jd1YNVEp/GrzGQph/A9utLEt12xIyRujsVTqmSFft997bRcpsWqEoho3A/GkcoK6lYOHltpj9ZA3R2fwogAgqX35Q7nnb5B9c6YcjKY6nJwv/czpd/TP8HAEXntwc/Si9nr+TuQDoklKOmbCW5Y39xN1dFv8OhR2KQxwnhTaMav2KNZnVeEXIW2SX+0/3uguhZS/FQsFz0CWP1UNtlyqryrnQe4mqhMFiYPu2RH9U/bmBBgstD6vH9yUqx0Z8Dabuq4gp4NA+p3zo6NbxIzZUwXo7HNQAnBx1OhScgiCrVWoWADjWFoyHuH95b+uDZ6KtV/be2ZsNy01nw0DlNp7OWJmuZI/vr0WDr6XwzVFPLfjvU+Tvbg2X22lZE2J5CTgqD2T+r/ECZUl9uSmtFYucYcoPT2rjDeL6ODuT3+CyQvvDyQkLSLbOu1JghlhwURgLNG4f+CXOIkq69j+VQtNDtK09jVzLA/lzudsoH2pKT1sHjMO6F8l6DA4VyuKXvPdnN9c7nOlTAxszCImedWdYsAawN2Ea8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39840400004)(136003)(366004)(396003)(451199015)(41300700001)(1076003)(5660300002)(66946007)(2906002)(6512007)(6916009)(6506007)(186003)(52116002)(66556008)(316002)(2616005)(4326008)(38350700002)(8676002)(38100700002)(66476007)(6486002)(86362001)(107886003)(478600001)(36756003)(83380400001)(26005)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ua2gQzV2d4ge1/6+bwRQQxgeWWIGkXcVJl9j13Wfdr0q2vvrxx7vRRE19PGI?=
 =?us-ascii?Q?kAVuy4AOsXWTKYadvkL3kekqexIfxaUQUedUXcaGI5PBrk6SiS9bYCkSc90T?=
 =?us-ascii?Q?zxZOhz3ht/jfsuN9W2MgpFcAgX2Ooz2tAAAYxdHvAfvrbYdxMcocrnpK/0m9?=
 =?us-ascii?Q?k7JRm2XHwiW7HW8wzwwhU/IL2R1N+Tef1Y1PniqFxOeI6ElI887QwD/tkMD9?=
 =?us-ascii?Q?1GNEXNRhKVmCahOj2NIt5tIEbqwKXhyyBgVkCWUze9jsnhSqnVZELAqUwwnX?=
 =?us-ascii?Q?zECSPURY0K0Y6g/AkwN+SMybNpvaDmMJBXPyYQvmkmety9l3N253dUaDegdn?=
 =?us-ascii?Q?qhrKabW8428qc8/NbjvD4UtRbhTqla8hjxKEsJQnFWbx9eZDzF2tigajZLXL?=
 =?us-ascii?Q?Y8E4gmeHDeIY6cSXX8vHl1ovP/FSFSB/S4CjD/jrcWaV8hI0w+hbNlNxXKWb?=
 =?us-ascii?Q?Tp5jHcoYplMoXJamNxB1GdL9/NOS3MhnPDHKivmDKLxi3yXxPBmzW52zbF+/?=
 =?us-ascii?Q?wb1N6/tS3c24WF7g6latrdRXFQA4ExqqtnuoHFEtQ7O4VFgmVDyI5JMNC7aO?=
 =?us-ascii?Q?clLJ52K12icciBPZ1iVewvLxIkZm16NAqTfkj4flYAmg485nhpEDMhgZedeF?=
 =?us-ascii?Q?NvoE3gsZy/H5i4cSl7n2dY47x5J6UoKFzj4bv9FbsemM2cZc0Joq/mlXdmFG?=
 =?us-ascii?Q?CRxlaCrqBXmrPjcNPJuskEgNz0v16gpdXZYAxb8GDQznxKHrkEWkbyMU5L2F?=
 =?us-ascii?Q?Z/HJneDwGTbaLt9NCgVPuKDxXdxg6l30s0ZSzhJ6K9OWRZS7suZJknljjenj?=
 =?us-ascii?Q?jOlykaL6snNAWzxjYbAL8qMNEBoLzMiRvtOKZnYdT90AqVXd9jwsaUMcn9wa?=
 =?us-ascii?Q?bLzWvefbYM4ga2oo3S8DDkg8g5eJvn3CE5H1HSri9SLxkK2agz4axTzIchte?=
 =?us-ascii?Q?2xWM4W+STA3yF3lo90GLPMZ72tR+eY2yJvHsazDWbMkOajUVWiW1CVymJBDC?=
 =?us-ascii?Q?YI3hL/RY0d+9yBrgfdoJdazrGoeVFCR4V36IkVCrojRGk6EUCGqj5ItNzifN?=
 =?us-ascii?Q?55duCReDW5buS1vsWsb0W328XSEmeeMxDupECa1VUcQJeBop3bgH8LaV6NFv?=
 =?us-ascii?Q?iOqOtsVlRnVrO3KM6gCzGOLuFhwbUp4wlZkTYrUhqagkn6xQfe8VNUqjeQqA?=
 =?us-ascii?Q?S2FTnJb+6ed7uv/sJ2Hx09gisAFzIABCurDG6nzNcJ/+hoB2rlPY4I2/gs4w?=
 =?us-ascii?Q?eT+mRK6cqoIwRB/IbwFkcXYDsm74r5RdhOaMuasJ5wqb/ohVqwlqvb746LnQ?=
 =?us-ascii?Q?tOiLa8hL/TXvNIvbrCfc3z/cxGDJbQvEON8I9CZt0QKhzp5UVtDO0voXulcP?=
 =?us-ascii?Q?xA6ppsp1Hw83alBVFcR2qoHmMlGMxKELwIG+ZdTiXjai/RlvyM75HAbV7/lR?=
 =?us-ascii?Q?mdPIuKSzrEd8lSrKHqdp9hzuF4c9yju3YIZuN85TwVBlhP4QO/lvgCmrSkQW?=
 =?us-ascii?Q?u4YWjDzzF3YpjStxk9zmuNFE9NqMd83bKplCB9pYvMOirLoRp3Y57SPtn+0C?=
 =?us-ascii?Q?/5OOXQIg4UFkeY3+c5Bq4cZTOvI5R4KbSK6gl/FJ?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 14105eb6-78b1-469e-3b8a-08daab6eefd4
X-MS-Exchange-CrossTenant-AuthSource: AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 09:56:58.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTHc2XumdtBGtNhzSv7yNUmxoCuPbH4kCXf1nYMP2JY4MFsACFfkmO3mcdhhrZIc+Bzoizb09F3/Lj/Z+GE7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7058

If there is no default DNS server when a fallback DNS server is created,
enable it.
---
 src/dnsproxy.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 22730047..a810b676 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2586,6 +2586,20 @@ static void enable_fallback(bool enable)
 	}
 }
 
+static unsigned int get_enabled_server_number(void)
+{
+	GSList *list;
+	unsigned int result = 0;
+
+	for (list = server_list; list; list = list->next) {
+		struct server_data *data = list->data;
+
+		if (data->index != -1 && data->enabled == true)
+			result++;
+	}
+	return result;
+}
+
 static struct server_data *create_server(int index,
 					const char *domain, const char *server,
 					int protocol)
@@ -2674,6 +2688,9 @@ static struct server_data *create_server(int index,
 			DBG("Adding DNS server %s", data->server);
 
 			enable_fallback(false);
+		} else if (data->index == -1 && get_enabled_server_number() == 0) {
+			data->enabled = true;
+			DBG("Adding fallback DNS server %s", data->server);
 		}
 
 		server_list = g_slist_append(server_list, data);
@@ -2834,7 +2851,6 @@ int __connman_dnsproxy_append(int index, const char *domain,
 static void remove_server(int index, const char *server, int protocol)
 {
 	struct server_data *data;
-	GSList *list;
 
 	data = find_server(index, server, protocol);
 	if (!data)
@@ -2842,14 +2858,8 @@ static void remove_server(int index, const char *server, int protocol)
 
 	destroy_server(data);
 
-	for (list = server_list; list; list = list->next) {
-		data = list->data;
-
-		if (data->index != -1 && data->enabled == true)
-			return;
-	}
-
-	enable_fallback(true);
+	if (get_enabled_server_number() == 0)
+		enable_fallback(true);
 }
 
 int __connman_dnsproxy_remove(int index, const char *domain,
-- 
2.25.1

