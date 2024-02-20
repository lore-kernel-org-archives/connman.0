Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2133.outbound.protection.outlook.com [40.107.6.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3263512
	for <connman@lists.linux.dev>; Tue, 20 Feb 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423967; cv=fail; b=oS8xEqwNOEFXEBX6/iEb2BgV8VqfnynGvm7vkz9GTqI3GusmKonIJEWNAtfNBw7Sf3lTB6/vl1+4RasJiqlyDzkZzZIrfbfDDemYWIBAJvezz5WaKMIowmdttSxM91LgRJrk7h+mMszcd/VlLzkr5705v4ymL+83Qsp3WfONRco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423967; c=relaxed/simple;
	bh=rwp307qnboAOXNjs10YIoCw7jPfas2gihUn8uKJQeeA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YLyY866Q+C6uGa4My1Y+7eu7t7+Y31BkVBR/EF6M+9l+vm61aeaqsHQ8a161J5dBOr1pfkXDEuNTOmUtkbhihzhuqy77zHCkhQo3QOJr1qye0T0d1vkaAYqDQdMDcBbSNpXGf8lyyqVLpYxQJuKYYcRCPKeKijh8+EEj4HN4iPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=WJ/D3T8H; arc=fail smtp.client-ip=40.107.6.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="WJ/D3T8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dnrmy3bFrF7aCgCJyL04Y9VPbpK828osHvcHxQ3Csp8YWyewuJwplByP7DzSOroh0Ec1pTediOo7dGJDrQvXD5hukwNZ9EKP8ksBOA496SzsG0hOBx1VILRMYU45KTnv1SGW5VQVv+RCaXHsLQjNDKmTy0kgB8bOKwfej5KdL29TEHHCy8PEAjvLhl0GgOQIcjJtafG+FvuJ7BvAv+83Xg/nSt83BOLeAnRPQFURGinGbNfQbYGvUIAwnAtsOSUALXN90efjgCnSXV8AsteoZg2ae8tAX1sNLh1sUi5vUB2aObYNjFym4yg0mCea8sM/4zvS5xpapTnuMRlkq1e8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6HI89/ZP8W8jDrjSyGBnO9CXTZGRp9t4vK/16pDudk=;
 b=j6pKg/RQhTOQgic53bW8n3CMOo0e4USnlnGjSYSnuLKQBoyd7rYvaAMT5SYSJyBqOuPmLYIvQpcMBWDRgWbz7idlY3Xe7sb55sW1sMqNWk6YAPAwJ2WSKh7GOtx0qA3hbtQwO02FCzCtK3AUvcXvxNSncaY90jUNYQ3cKfJRMVlvm2vseduXCTZOWftti9wvjN426rHh/Fwu3fIRJCgYTg7Hxel49HhEHmqbvYI21Ji31dpwzOSGmvL4xMR7ghmOZYhuuBq6Vim2XQ84i1O/Ynu2Ub5ocFU3Y7VUueh9j+V9Tp4I+GYZEnpyMiHueLvgiHJ8tsI/hTXA8eGYICU8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6HI89/ZP8W8jDrjSyGBnO9CXTZGRp9t4vK/16pDudk=;
 b=WJ/D3T8H3KYQvd9blkyxaTfEb/d+FNZHMMAf53JoKE6hOS86ty96LQVipC3T4GyCSfwWSyH7mHw08Ez1np8x8opNvi4M6SH+nbODeWYGtkkGzry9duphaXE5vWXErRqDW5sSPvdYXPDVVZEls1sFsAUsWRuVpJRJUi1lAvrX5hhrsYhw2dd5VtZeXjcHSXhe5uN06pJrMKt/fkJ15VDU1sece8u6AgsgbokHBP0XfHOJb7ETLV/VYQu5ygW4jesq62xMLjZ29KPiAC57o+mPnzJvutplDM/gGYseLKmwkIw8NwpSuCUw2JnJQnx4cOf3Y20l+K7FfwEwGRbi0oUTOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17)
 by DB9PR10MB8262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:12:41 +0000
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09]) by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09%3]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:12:41 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: connman@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] End connection if connection failure and no agent
Date: Tue, 20 Feb 2024 11:11:38 +0100
Message-Id: <20240220101139.36171-1-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 74703485-466b-43ac-fee1-08dc31fc78cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KpayJk7/7GJcAZmEOLKvDugU6TRbVCRkKdvCpCFsJKcTAgPGhwNvMFc9LXqXSDaB3IUe4gxsXW+EbZ53oHbJow73BsP79OYFQQT+xTu1tqeQvdQ2iLzDR1sUKNQC338RfiNaLtmW4adRiukyKXH1QrWlGoaGDbG+RMcw/QE3G3UPKS6Pu4cg5DUR9b1tP9yHlgiwY3eF7BP3Hvux/MfW4uzoBsQSFVPyHXAvyFuEED0R27P7jg1DuNT0DVGTypY+w8sWX8y3s4Lfk17iYWiQf/LCg4UhJBWYxZxZLE5yusx3tvqgx0GCIx/DfW4hXz5zi1JiqgBn14hFKr+8nYUOpG0UvvJhEVHMh5PQgMlNDzTRDVAL1cBCNqfBtrAsGkAsF4nAuX2LCcW1zIDH00ZOTtgw97t1T+asW73tD9S9X2Md7VU+nDqA8aC+cJyc0Z/cLUlDQCkQkhIh4cawXZsmJsXeJ/S1v6dNq69bKqkQhmSpS23oQXcOL2I8tw7Nt2NtBsaR+yfJpCan+ngH6RdqH3+gAj1lnnmQKyreKZSjVKcBdSwh1/jjngBMYH6NkJrZJIsg5ygA5IFS2+RU/QjgdJOa4CeqXFheTEJjRKJrIjgiEqBqpzgSpzsNSqx3gWUr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+D6LFT7Adkz+8XDq6W35JwJ3AZUJXX9jtju4N0trrh1peqejjxdUpkfjYR9?=
 =?us-ascii?Q?19pNdtq9XHUC5FzpCXkVcueK+uHU/Z4VHkF0i4jkk40P6cS1qBQOUY/iFRD4?=
 =?us-ascii?Q?nwiD7evtKbO8eVNkGACdGr4ClQKzWmHUpzOel2sSEcZPN6QH39RkoEkinojm?=
 =?us-ascii?Q?bZ5jOYls2VP3JfuLIbVVQfsIpUfyhmCRXw8vFW7Mi4b942HmNVGNiVXnC36d?=
 =?us-ascii?Q?7rtpBtI+CEoKEe74h9VnnPkTPoVhYqgO3iymi+ksRv8HNW3XlUWz/npwA+1I?=
 =?us-ascii?Q?jJH3W+w5FlDsi5DaHNppw8qyfWCY/PFMl7c3L3Ukw56mjP3giNTZLC7p/09R?=
 =?us-ascii?Q?yig3pO1tXpW+nEJBcCKAWl4sTvsQwrzjO+u6QJL0OYDpdZ/mJULIPumXbb7z?=
 =?us-ascii?Q?wKJzB6laB9p+ChIvYo3j9xc2vQQJQWmO09bQEfLriCvLMLdLS365juTi382g?=
 =?us-ascii?Q?zqV/DF3SNeYrXXxFOUtvdS/I1A2f2fNi1T4cZhmzdC242JLQamq26HCQTaQE?=
 =?us-ascii?Q?1n8mp7keENjcIvBTz1zWki7QII++Z4+lat6MoARRPjfHl0WuTa6+geS04rtk?=
 =?us-ascii?Q?/fKIzzXvbuf4ypM2h/UbAhp9tRyIOjCufERBnY1XQUs9XzkhjdO/U0c894rc?=
 =?us-ascii?Q?UexPUdMKm+jYsiRf3Mn0djkbmC2GGgWyqQLUtv90dt0gS+okcHEmYuZ0r2+l?=
 =?us-ascii?Q?UOj7HMB87GB8hGCu9VWON1QWH6PdKUN3TexPTQA3Emmktde+D/xuwQTN6FU1?=
 =?us-ascii?Q?4IKNB3eF7QmrGx5o2AyoMv/hyu541D+Rf7DGeNoVGgNpbKGxgZ1FV/61NsQK?=
 =?us-ascii?Q?8Q/yxeyukRukSSI4RfopvM/mZjQpaxfJdBS1ZBECB9SnpfyRxz24BSjT8dSz?=
 =?us-ascii?Q?E+ouNOL5/bsQXpSg810VJhDkHT9WlNWpPsa8LF7Lt0FHvrehV4aQA+aYpA95?=
 =?us-ascii?Q?TM0FQ3GA9qZMlSxfUJxNOGa2FibePRigr6cI83TDkehWAIA6HWJmyJ5lwhxa?=
 =?us-ascii?Q?57rHPX6lWZqrZ9dk519y5TAdl+ne+BX7MEr1r6Is44zovfEfSeId46XT53Gj?=
 =?us-ascii?Q?O2aHfmz9h+KI7ivVnlyfREqICfe64W4urpPjXa68D7E2qMRy+6UunqYYpJHO?=
 =?us-ascii?Q?Hs11zKe4Ep30pN0RYD3LAFz6xNEhEmJDXWZOqj55qVHuLApHecGhIuSGePwg?=
 =?us-ascii?Q?3P28ZEcpky+l5vVKBRaHfuWr9U6gvE5kK4zo7GO3wqOn4RpeGfaleNVAdtbP?=
 =?us-ascii?Q?cw5+TUOI4NQTgZA/POHxcx2C8OkcFqKcZ2VotedzXvZT7nHCqvAu5rkozWY0?=
 =?us-ascii?Q?QgQhYCwUT4XDgbLYF/tZsHrinGTla/ThTHDUP9GbumacwDSeZpVjaoJBn/qt?=
 =?us-ascii?Q?FDjmY+P+Un+28HWyOO2Q6C7EUSKExWNpKkwN0ToffZgk1lyI2V3XhoBvKQwe?=
 =?us-ascii?Q?NO+qmJ4Ntuc9g+ZI3ZfPh0G0uAtDDdV+xlzHAGaAzhLdVRzccGwdfi5F77UO?=
 =?us-ascii?Q?ahj3qBCuSk1nZw55JSe6am0ZE5Hm92wAAl6qd59yLm8lZUEqUlrCzRdGZL8L?=
 =?us-ascii?Q?vaKe+KRNIb43lHw2q89CAJLa1glMCZ28eicK0y9D?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 74703485-466b-43ac-fee1-08dc31fc78cd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:12:40.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch6gVzDl1bBbjJZSX7vNRIThSgK9nER4XomH2uXkGUVisAY70WlLBK5XGzXBFcUgTXSwfZmrMsEK+nYe1/QGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8262

I have a modem that is not able to reactivate a context just after a disconnection (I have an error in AT+CGDCONT in this case). Some seconds later, connection is possible.

With connman 1.39, here is what happens when I disconnect and reconnect corresponding connman service:

root@klk-zcel-030030:~ # date; connmanctl disconnect cellular_206018060790006_context1; date; connmanctl connect cellular_206018060790006_context1; date
Tue Feb 20 10:00:19 UTC 2024
Disconnected cellular_206018060790006_context1
Tue Feb 20 10:00:19 UTC 2024
Error /net/connman/service/cellular_206018060790006_context1: Input/output error
Tue Feb 20 10:00:20 UTC 2024

With connman 1.41, behavior changes:

root@klk-zcel-030030:/# date; connmanctl disconnect cellular_206018060790006_context1; date; connmanctl connect cellular_206018060790006_context1; date
Tue Jan  2 15:41:31 UTC 2024
Disconnected cellular_206018060790006_context1
Tue Jan  2 15:41:31 UTC 2024
Error /net/connman/service/cellular_206018060790006_context1: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.
Tue Jan  2 15:43:31 UTC 2024

"connmanctl connect" lasts 2 minutes (it ends with connection timeout).
After the first unsuccessful connection attempt, nothing happens. No new context activation is asked to Ofono. During these 2 minutes, if I try to connect the service, I receive an "in progress" error. This looks like a bug to me.

Change comes from commit 8ea2d67a6e8935d06f71b1ec77a2f89d72be49eb (service: Complete only after user connection retries). service_complete is not called anymore when error is received from ofono plugin. We wait for agent to call report_error_cb. There is no agent in this case so report_error_cb is never called.

I think that service_complete should be called if there is no agent.

Christophe Ronco (1):
  service: End connection if connection failure and no agent

 src/service.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

