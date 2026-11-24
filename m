Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479219;
	b=LzQukYNCd538i16r9q7secDudbrPRc5miAUO5gGidg8IeYVtysQZWRSB/oswutTzfPOL
	 B6BX3qNDg3GVFDUe2871EXr+eQLjmomKFZ5yRIR8KY5Ny64eo8GyWAE8wxWs7YYjXHIYA
	 yyiYSC+HVB6DHqYrrjsoRz5m54tfLZakopOjoNz9DyQs81m9K9N9KOW+qWAL+7DtmNDt5
	 i18nPndOhQLfjPmNG0yGIJRmp0ZUv0BHx7km6kX2+DXKiAQCvtwuuRDFdrEAr2pN0VHuK
	 xsdj9CjUaT2FrCOcajjYa/Kwjrp25TC5itpNdDbxmKoYtStOi5Do1vMiU/zAe3+w7bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479219;
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
	bh=9bLrEhKHZgpj99iTumPTUYLmkdoPOvwebWnnxnCbjGY=;
	b=2tQnXt9dfDdYPplB2KLg+Jx/Q9XIGWU/vkanYMPDPBBLIAFWHGF42OifmfnWckSptuQj
	 aeSDpkHJm2C69w9hYZ9d5eM2rAHXQg9kD+TMpzyvee+qmDDEGop6/Zd8o5IxhuE6OYiTZ
	 GLdqj5na1tnY3med8H7HK5QjEpBf18OrNjcUMj3yCPSOumXc5EbCYniCLDWUuL4zqnlww
	 NW/pPO+SE3kgaK7iA8R2xeXbnLZxv/8dk5RMw5jRBXncfkHJbnWZCJcW8bT2GWQiFY0Er
	 xNsokISQcaJubdD8i8FfNeo4Z6mDt9ZAIux3xRG9Vo+hXc6cOiHT+UcU9kTLzCxD7Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=F9gPyabf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.108
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021108.outbound.protection.outlook.com [52.101.70.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4A606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D4A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=F9gPyabf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcdAzdTGMfT95B8xoS3C3QHTFkiKfcqIZ+vwJlnjSThtba0i+Zvaoucga/9lT7IVJBxXrByR03aiSNKvSvlfHcl5UrKGxJscR64jfghg/MYlHOE9DysyMPO0slH2XgaSpVuKbz41XJJdLiJrJ0jgjZa7Kjx5ThPWKc7k9sJoPCbEuElluDkhInOs3eXeDkI6MQnLdrkH9glMeIUapIPwPuxC+vcxdb/NKOEl5ePVEgvkcF4siYCx2h/DBJerZBEc+2FONk4kNGKy79B4Jg/ggzLv3aEvnmtS7EJQ8XUhrgfKqrwpZHBMNtIXzCpYk4VXOEXftJwGWgXEhK1x9B6ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bLrEhKHZgpj99iTumPTUYLmkdoPOvwebWnnxnCbjGY=;
 b=Fw27eZ8dXV1JADR4TUtQzqM+r4udO9V4Sx+8hkV28hDLmne2rDuupirtAcND16x2AUfIWB63QqAhITmPDoGjOvivMtGDYMUR+ld0LtbYThjxpXp8288Y4axhAj5WbELnyIHLzjAsAYuAdGrtV/BrdZPa3mtAZM3CgWnrS/+vDL30m8rQ1NfAAcA6BO81PUfizySAncDC84MQPniwXzcsU7aGu5V5HbSR2a/hvOpELAp7QnSMm6R9pIZql5ITSaXGS/h4J04BngZk9FQApLjVsfde7Xr4Mn1gxEyQHNunFOn7Wo6iRALt9L9cEeL1Mur+8nqnq8Wjq8eOVQlkkkdMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bLrEhKHZgpj99iTumPTUYLmkdoPOvwebWnnxnCbjGY=;
 b=F9gPyabfRixSqdq8CXYeyMuRRDSNv3jks7PPjlCofFg961T86vcLYBHLwm8fJlWb/V+qJaq6UIYV6+6dbOPqcb8ugno1j9VhkWrEpSuutsr4Nxhb+nPRNbW2XVSo13YFaVs57cMGYpHhaDCNmdCSu7fN5fwLmWl/D6lHAAPdL4U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:34 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:34 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 14/15] doc: Add RequestCertificateAuthorization to agent API
Date: Tue, 24 Nov 2026 01:13:10 +0100
Message-ID: <20261124001311.1161845-15-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::26) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: dbe4a109-a93a-47aa-f51c-08df49bfc784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021123027099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	lroIpu67xxOZQv9xVSlec5rCeysJ4P7APjz77/zTg9hHTr1ckFkfN3/ZbE0RTPEiq75nOqLV23pd84FLFZ8vfPUs1tRcSxpaSZ2hK4oLKw90/pXVrnBxNImpZnvPuqpBOIYZbimz+eNif91xSu3c4mvNvqHv+cm8MuR1rVqhNLvNKX9wm+SkuMbG0bGJjMw8bXMmjYy9+XloGS58EcVFQywC9m8iCiSCCCc4YdBhwIQNxLGcroTe74TgwStGAtcbV+lG7wJAXsiEMcC7mu53N0QrkRI1IA6Hv7a/NO0mtjZxIFtIUlI3PRNed/8wcF2L2/qYGet/rhBTQAWI3SWzOYYwsFs32LfKXvsQO1opvXlDSwQdt0/TIS9OXqP7gMWI0CDe/DyAjH4bBA/WloGRaSTSEfwaZpsveFszq9D4tQ7OXaBHGnQ+Jf8D5JOAkqwo+0WHyHiHcoSEAk8Uq8iL1Uu/5XNG7Fa3aGCxi+9GbG7G9bZAWRmBEnG1JjPYjSC7f6IumZSIxZWzb2aWWd7ukxfxK3HoJZoJDJGpKpMbq+kc3Q0MsNimXborL8JROkoS6x7fvu3UdZXejnorp/oDQq4JukIK2c/Uh40k4Z9ldhGIM5z2g0RICS5yfrNFddoQeyZCk0AbpnGXZDiYJvMC8Lm11bdioH9mEcw4ceFD/N4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021123027099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o0Cl4cqM59Qw/b9wZfxpeV4fNYfCC1h93pC//yV3DacmgJPOfbbynkfr/0GK?=
 =?us-ascii?Q?xSCjgrM/Bu0O2yc0obRFbJg/lg+HMuQjEPTgSLR7xDSOBv7ynteQ3FOrxIQc?=
 =?us-ascii?Q?K8b4Wz9IrQY45CWtcaur5b+AdEYb+LiLTLLyxi6lamEVor3QiyIAP88cedL3?=
 =?us-ascii?Q?VIK3av4GTrjj0Vm3pHmX1mRSC7i/Im+aq5sXYDBOcqsO0s5v2+l4cXUA+/wI?=
 =?us-ascii?Q?A3GytgDaFjcSxOO8MebhXa0mxxXHWnmH2nO/hr4537Lqr16D3iLTVRr7GrTt?=
 =?us-ascii?Q?IcEXM5JHvgphTkQDgcCq1wTF2IxBGwqr34upVMkQR5zEvq5iNF2YR1LKA1Bp?=
 =?us-ascii?Q?4vm3ZbjFDTzHIYsRM+Mc6bHwgZEIDB/1qw4zbtrLn22SPRWn7kbUP1C01rN+?=
 =?us-ascii?Q?dpNngH3Qf5DlDE6xWMAWgQsJTKL5W5WAeTJfGwa/FKzxg7FwcgY5zWu8tte8?=
 =?us-ascii?Q?tONspxAEW6tnt66g0qAFR8t5lY16+7bobJRUr5tgg7Q7WuRKvrDhD30CJ1ZX?=
 =?us-ascii?Q?2PHDGQfpn1vPpzmEUayrctYWVpIBmpaSMqSkyLBLCOfhst8CbCwtWsRqO7fP?=
 =?us-ascii?Q?ZoZZhJ9Je2ot8o+10EvQ0XEJvbWcUD44nuKGA1hu+0CYTllf1fGjfCUjXIf2?=
 =?us-ascii?Q?+sc7NK6OQOr+zxlVRUDmD3QJAnFcV81oY0arZSjZi+eiB15gZkCv2Ta1m4bC?=
 =?us-ascii?Q?6dn0oVg8Bppjr/cPE+4xxSlWFEuybJjsRi46go90oyiWIUBp+ykRzfuk9wu7?=
 =?us-ascii?Q?eQddM8SFonK28SjulSBJpaqwk38aEDcfTaRdO5cCp0hgnYN+TuWFU+MpFwzE?=
 =?us-ascii?Q?JvNLTMw0+ek5fqDw6HhyG987ohonRYuOO1lak2BSqWcBNSer52dzJIMEpiKc?=
 =?us-ascii?Q?3j4K2HIOloQSeTAt3+VIWeyMvbjjUh50KfMk6EzrykZAKJeroerch1OZM6h7?=
 =?us-ascii?Q?8OlnZmQ8DbPRLfvwkKKAoipTjcvxjw8HZ6k93Nlb6neLUhN5hmCPkgR7e50Q?=
 =?us-ascii?Q?aPLWdYZ7iUvOx3SD93dbv0PY7VMxgLGpdx5KmDmW72uQLQ6RCfAEuXRDCXyl?=
 =?us-ascii?Q?dO1HBZng/4CC8F67hAiQm8w30s10P7mXkIfihkvhdc0y82cgMskC3Zpk6tzW?=
 =?us-ascii?Q?TJnSBz/1J62aIs+jHyxXJwN9Wv8BYpGkm5sPiWuXjYulnPml7iZ3FsG+VsNu?=
 =?us-ascii?Q?JSJiPSera2gQ2/C7pA9j4zPuF+qTXO3t2pydM5Oj8EsgbmHwsQJmJPLPWcW6?=
 =?us-ascii?Q?meiA6Z2JQc1t8qoe97A8vcAZPXFnph/hMmFSxXASKVsoclqA7touZ+8+MN2e?=
 =?us-ascii?Q?Whxn7s1pHbm+gaPne3Vs2MLrAOHHBE45nbfwGKCCfu+lK8dfdCQkDcqYrA6w?=
 =?us-ascii?Q?dRZ2sjDfn58foM5QXAVXncE6nTc50r30YCFlvYNQ02gP4/ulyh6RkI6KgLr3?=
 =?us-ascii?Q?iwk/aw3zkciotTCutAPIsAfZBA4HgCHED3vLJPGNxz9yhQsDM+y7Oo+DpkYh?=
 =?us-ascii?Q?Y8oCx1gTMMDrljR7qbPAHMclUw4VU+/snLfcFex4nxgJb/WGVSdFA0VRElxF?=
 =?us-ascii?Q?WWuf8Kh3Dt0biMwV69Ea/zy6yKvimiXMwy47fKZiONC9OdjvnY6QCosYfm+o?=
 =?us-ascii?Q?t8/gQ3LU9ybOJlppfeFKW8YaLyrvV/GxNY3DZGtsrP/bO0yeue+EhB6Onnlk?=
 =?us-ascii?Q?stmcQhtmWCuOcBOg8A3/4ZzuYD3Sy+L+07drg72FdP4RxmLT16/nHdZQR94Z?=
 =?us-ascii?Q?QionhktTRyIo6amv6rE9wxetcCaUoj/tZa7p1w3E9a64pCqOtHwlDCED30Xc?=
X-MS-Exchange-AntiSpam-MessageData-1: emRsKqKjWYMAz7FUEXYgB/NPlA5dZ6vWrSA=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe4a109-a93a-47aa-f51c-08df49bfc784
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:34.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR09W+TGeUxhuTKqyF44dgkXKw2B2LPmV+pdF4d3mdP7d520BL9bGVKvgoLM9kUel2DHZoFlaNlQduZIosF+nCppR5Aj+rfjc25ro4n1O88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 doc/agent-api.txt     | 42 ++++++++++++++++++++++++++++++++++++++++++
 doc/config-format.txt |  7 ++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index b2becd2a..e498b432 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -89,6 +89,24 @@ Methods		void Release()
 			Possible Errors: net.connman.Agent.Error.Canceled
 			                 net.connman.Agent.Error.Rejected
 
+		dict RequestCertificateAuthorization(object service,
+							dict fields) [experimental]
+
+			This method gets called when a service with TOFU
+			(Trust On First Use) enabled has seen the certificate
+			of its authentication server for the first time, on a
+			connection that did not verify it. The fields describe
+			the certificate; none of them is requested back.
+
+			An empty dictionary should be returned to trust the
+			certificate. It is then pinned and the service is
+			connected, verifying the server against it. Returning
+			an error rejects the certificate: nothing is pinned
+			and the connection fails.
+
+			Possible Errors: net.connman.Agent.Error.Canceled
+			                 net.connman.Agent.Error.Rejected
+
 		void Cancel()
 
 			This method gets called to indicate that the agent
@@ -151,6 +169,30 @@ Fields		string Name
 			Password for WISPr authentication. This field will be
 			requested when connecting to a WISPr-enabled hotspot.
 
+		string CertificateType
+
+			Informational field of RequestCertificateAuthorization.
+			Either "ServerCertificate" for the certificate of the
+			authentication server itself, or "CACertificate" for
+			the self-signed root CA certificate it was issued by.
+
+		string Subject
+
+			Informational field of RequestCertificateAuthorization.
+			Subject name of the certificate.
+
+		string Hash
+
+			Informational field of RequestCertificateAuthorization.
+			SHA-256 fingerprint of the certificate, as colon
+			separated hex pairs.
+
+		string Domain
+
+			Informational field of RequestCertificateAuthorization.
+			Only for a "CACertificate": the domain name the
+			authentication server certificate must match.
+
 Arguments	string Type
 
 			Contains the type of a field. For example "psk", "wep"
diff --git a/doc/config-format.txt b/doc/config-format.txt
index 04a09cda..70d052fa 100644
--- a/doc/config-format.txt
+++ b/doc/config-format.txt
@@ -120,9 +120,10 @@ The following options are valid if Type is "wifi"
   does not send the password. The certificate seen is pinned and used to
   verify the server from then on: a self-signed root CA sent by the server
   together with the server domain name as DomainMatch, or otherwise the
-  server certificate hash. The pinned certificate is kept in the service
-  settings, not in this file, and is forgotten when the service is removed.
-  If missing or set to false, TOFU is not used.
+  server certificate hash. If an agent is registered, it is asked to
+  confirm the certificate first. The pinned certificate is kept in the
+  service settings, not in this file, and is forgotten when the service is
+  removed. If missing or set to false, TOFU is not used.
 
 
 Examples
-- 
2.56.1

