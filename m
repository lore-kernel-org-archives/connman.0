Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795472535;
	b=DPsWelhHrHqg6gQqhChPcFYZq5wzTN6hYBvI6aGEAmh9JiovIWF8APvu/xjlywFkPR7E
	 ngXl68LfWd7dH/t71nstxbASFCI3ThTC6AfG9uL6uDxhmVCZX3SUY4eFBYSHoy51cbT0J
	 6O8v7J/VbR5Opm0s5zlUIob9gFxePkQWJGrmmC3j3owImfBq4HbHo39vvJpNjWpYtCZm3
	 Lb+dZeg7bMs4sHeD11yT7qk6Ui2fFlzckQpiqwti8ZFPo6kdofnjmxvkkqrqZuiPNTLuh
	 7JMvV291bwtWi398+j0HNBVORUqsgckfUicX3BYu58Wym8XpScjTZn7KFnYuF4iNIVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472535;
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
	bh=VwjLclWQ4bofG5pQ2Sl4E90LLEeRl8nofUoxaGznD/g=;
	b=xZgCnfS0INeP0cSAyVxi4bB/FtT/i9dx4WLcalCKCARSrlX9qic4MJyBOT0MvwRhcs7N
	 WeuKML3z9JQ2dVsiKd2J0bo07h4XI/64NJBLaAS7aRT8luVnvX7EjpbSoGNbLggVS+7Yc
	 dHk3GXR6S5nhAQKgNiu4+QgFTcuIwGJMJgF4INcSI1YWHh4d2FD3AvcO0SUFYz5UTfWVx
	 1UoZEoGxvSRzjYTGqsIiB39WGKf9auAs5BM5dCYUwAYGRWTIcV1uzIsmgrFssrzZNWDs2
	 DVXrDxHDh/nk8A4KzLa1Rpb9BLb7bRoZ/9MBnq9tS49rQbycvFQxgKJ746W+2gxlDpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=RH5IbjVX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021109.outbound.protection.outlook.com [52.101.65.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BD606A31E
	for <connman@lists.linux.dev>; Mon, 23 Nov 2026 22:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D0BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=RH5IbjVX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+Ho2Ew/AqSTW740Xqh8TiOvaaBzTlH1mGDRnXdziul0qpD+Z3eq6yvP3xIJt1SXdQgRtTMP5YNgMvg+0MBMGtc1a/BbCO08ino81NTHivy4UQB1NLFh+1wAEqSpyEXPTS7OyviJsVI4fOIp+qR6Oc4Vn9NNn+07kQmdXDFAbzefILrA/4bBHEN3BGBRVSLQCZ5cfy5jbE+IxtDOLkLL2QDEVLM4IAf6oOKIS/HBXr/aeZj6GRkP6Etc6IuUMnlqwK2pFQK8DqE4/xO0DXPLwo2dTBchevU9Fv4RxOkbVRqdVMBk0vOym0gju+XKuB1L0APjvPj3HbQ0+irEtmCrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwjLclWQ4bofG5pQ2Sl4E90LLEeRl8nofUoxaGznD/g=;
 b=A4B/YPfzV+AjZcsFJv/SLAqHl8HQT0AlSo/18euD8dOqkCNrlSirbPEKsewMAxk7+ACIFCQbAXnqOh1XpZtZANP91DEm5LOnJwg8DruWOQZhGsEcwzQeX3jY06I4U5jV019aA2ndigcne76EOS1AT3byhg4iRu4GhLrhomHSKs51cGWccC8d0Sw9ZjUelOoX/4YjOQ85cfpVfXVuRznRnbRVqPu+BRTAhNYmrOv4Ef4JkJ5bpOH6plSGJZk+5KhJ3EWfZP0f6varObQ9cP+hm/P+F3cFxZYQ4sDNdQxUmmi8u1xJEz+7/VFf4atStauh7mhAbA7c5NI0epa4slcsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwjLclWQ4bofG5pQ2Sl4E90LLEeRl8nofUoxaGznD/g=;
 b=RH5IbjVXPRAXmKsEZ9fDbeBp6QDY8VUPbjhBBi7ViBawSiezPymdKSUE+myKtn62AaBXIexC9FIod3Jei4NL419FHKZQmdiCsssoLN11roMpxnt6cuOsMQzvaNmeBwUbwFbK7sSHxuA5GCNfqMiYBWoktZT1F66idml7ivfFjqg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by AS8PR08MB6728.eurprd08.prod.outlook.com
 (2603:10a6:20b:396::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 22:22:12 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:22:12 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 2/3] gsupplicant: Call disconnect callback when RemoveNetwork cannot be sent
Date: Mon, 23 Nov 2026 23:21:41 +0100
Message-ID: <20261123222142.1092055-3-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be>
References: <20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0643.eurprd06.prod.outlook.com
 (2603:10a6:20b:46f::15) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|AS8PR08MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc1dd04-209b-458a-2c8f-08df49b038aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|786006|376014|366016|261102123227099003|261021121427099003|10067099003|11063799006|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B5agxcAQK72RDzDyRkUXe2WQZ+wgO/QynvZhYq+OLFWRs+6s2lCO6EMncTm1+jva7HZtuuFZjYPC9KTAo4uHIYhV1OUqBhPu35LF/HTC67ku4X5wngu0/upt0cSTv8gN9+TqyNK+wGrEMX4+3O2/MSdBjXwG9rD5PfCNZ47UY9+29hA4bSBd9VQBUPcDx1cxwhM1NNn4eeyQ9EBl/uJoVuI+UWipEYYSnSkuoO4rz5kU/ejJHKUIB2HudHo+TB720OCG0GGK6RZLbql/ARhGfxwF1zh+A0INASeLgEzaQz1EHtWcXVR9IlZwt4O1HK8GuGJj4/pNcJ7jrNaxN2n5ZM/TwdwsuXadUnzlwaNvDp8jqq0oskWLLarkZdoBGsEJRFbGv27rzi6rEPYXGjVzbeLY23fUVAU48nPiWqaZBY7GIT/LBT4U3WivjMLUb+hl0nYEiG4r0GS5zuwYioLP5wKqqjRtpXCSD/Ak3QAd/FiHLQeS/HC1ZMVCnbWuCDAaa6btR9/oT7KXGSO1zsX4pB+0Z3rFIFpHZYAa1b9NatDAuknq5al4EFbf2UEp99y6o7wlOVnA1JjmEXz5RIloGS+Mnz27WNM839+KemXsUDXf6KKTWp4R5nY8eJ1KI+NOZMv2O6JmjZ0WQj2XFrrqQ7O3qHO502/lgecDN5CYvCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(786006)(376014)(366016)(261102123227099003)(261021121427099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MeYxJI64ABI57MZpF2MyFeTGW26+gsLcUQBvGE0MZ1l7CDRB2g/Rr05Kz2Ue?=
 =?us-ascii?Q?QB2g8cmZHgpzLog5c4Ibtc7NUrMH+zrUP1qpW+xMfTCQ2nOTPN33/c+fwz0D?=
 =?us-ascii?Q?uhRwweszAlxUldozioVYVI67AXRD3wlR470DjaJ+GFaypaHnRfkzvDz+xRzi?=
 =?us-ascii?Q?H7ggGc9S+Yid7LmgZTXGo5YdYngqo4sD9k7CGrwJ3QOGU87kaHAmANf41xv4?=
 =?us-ascii?Q?wbAbWJZeu785oapxkAY/9aTr5XOIjzPyv4XiHtvGuO6OX4d5rVIs3SRE+qkc?=
 =?us-ascii?Q?TbCdgkCaZcci3iaUkLvJGsKT6mohFkNgpuprAVnvOtBHRxf5CNshVqyrd0r2?=
 =?us-ascii?Q?eYwbYqAtAv1v/LCxPupUm2wj3WXO1DNjhLkPQTO7WGPpI5phATvEoNQbhi5K?=
 =?us-ascii?Q?0fDrupr8NG0P5JHI4aP/en92RpIx5ysb0risMbqbDxpa4Z9NpTOoSQlIJwHK?=
 =?us-ascii?Q?Jn0Ul4RJMGnpKLrCgMVNuhmqCyXbGl020yOnmycrKLTb2MrQab3Ti3KXCNL6?=
 =?us-ascii?Q?+A5Y8U4Lv4wuGRv3gPoyctb+NIsKTVG28pO2XLGLgfzzrIJJgrk8w4eL/ZPz?=
 =?us-ascii?Q?XU03LOrd5awgwjR8F62QuREunQ0J7ELfxTIM7mSrWVX1mjfomItB1B6U1FlB?=
 =?us-ascii?Q?2VXPrq2CKX3WzMUAPydcehovwGrujJtFfbG+arGDxdUrgo8G8TiSt0Tnj9u1?=
 =?us-ascii?Q?4YGBuY7Jm9Wf1J5jzy72sYIwGMOC8QDLbncvz8hrr50Em59JsApFu7e61n2m?=
 =?us-ascii?Q?kqPMiu+oo7AErRAR6cFnIhLGTb62OSjlG/iYdB4eyZEKGcpdhl99cyKssOkX?=
 =?us-ascii?Q?k9B6ciONNLTMIGhD4H26MO20P3vnnG4DErdLeuFO/y1XH2Jlhw3ARWxuYpA9?=
 =?us-ascii?Q?8XGq+04+TplUjc/K1I79vqqWneA+gVvDTgosJvbqjL9LbpEqFQGMfnt8/8DW?=
 =?us-ascii?Q?tmjLDsIpow6QFvPAYENZN/BRQZBQ154qZk81obHMsSJDLl9DsCSalQFF4cSi?=
 =?us-ascii?Q?TLrlMs3XvYNP570l1I8EkA4tuxRTZW09+DlTpiJZEjHqaMYS1rfHew5E+ex0?=
 =?us-ascii?Q?xlOfNgBdHrB5oNkt2Etf3Eo2ny+VJME0mHXfaN4OjB+muT9ZMqPPyV89h4Uh?=
 =?us-ascii?Q?I8V76TxBTm1bs3lSVw7arsnFeVsiS9b1Js+G1NbH7T5z0gqnsEwXeHDm6vkn?=
 =?us-ascii?Q?MceTaB+ZliAjlWo5de+BByG6ni3DCWt9M21VpkehjyCopWHpBfjFMzDbZtw+?=
 =?us-ascii?Q?As3MtrmJmNhKpMA+wGU7hQgCD06aHFiS+OCel2XAaDFZ6WDcoCWnf8wDuo0C?=
 =?us-ascii?Q?SwPHB+0EB3gQIjh823nM6rXQvfv8xlB7yuiBHdFZJQjRV8PDBueDIpD7JbAv?=
 =?us-ascii?Q?VDMvSrD85kLaQBfYasohsO/hNNT6EA4zZWDEfcs0Gl0anQB3LaZetSU2N04n?=
 =?us-ascii?Q?gdmTmiu5BGQViaVrMaRCLMx4n2zhTyscQSe9Jo6KintFexsDoJDhdOcptV3v?=
 =?us-ascii?Q?KKzzQfWkKfbgOgHja59KyzirghBrUXyBqqaUOi/E2/Ui80DkUgbo6pMGtUUs?=
 =?us-ascii?Q?Dxd7duXWmmqUULL+xGan9PAXAtPIQLkxusx7EkwKDNPUWi0Kx7CHKDtB2uOr?=
 =?us-ascii?Q?HMjfilpyNSdCXt5qG139CgHZWt2mkQyuznMmVEc3yQkagkk8+h3kbxATjXPO?=
 =?us-ascii?Q?HJqW1KOu85NAJxYwIV4UDvQvgV1ofHzU9Dt6EXu9lRSWxiW09YHi7AxZdl+C?=
 =?us-ascii?Q?XNQjfU25vi2Kk2/mwwbM5DZlLNnyU72G7jgAdKfJ2nQ1UEUlJR33HZJFYt8B?=
X-MS-Exchange-AntiSpam-MessageData-1: NT+jvT+con3cL8DTmoN4IlUzGoAkKO5NMw0=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc1dd04-209b-458a-2c8f-08df49b038aa
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:22:12.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbSN4aqW2iUQPQOXXp9aXsNHjVxDH2c4dV8dhQwE6pGHdJtstxiGbwk5Y/YmbMUCPs98frXt7Ww6apj8AwFMlN7j40op/9bKXDbyuO+Ymxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6728

When disconnecting, the network is removed from wpa_supplicant once
the Disconnect call completes, and the disconnect callback is called
once that RemoveNetwork call completes. However, if the RemoveNetwork
call cannot be sent, the disconnect data is freed without calling the
callback, so the caller never learns that the disconnect is over.

Fix this by calling the callback with an error in that case.
---
 gsupplicant/supplicant.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 5e289953..50cdeca3 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -5316,6 +5316,9 @@ static void interface_disconnect_result(const char *error,
 
 	if (result != -ECONNABORTED) {
 		if (network_remove(data) < 0) {
+			if (data->callback)
+				data->callback(-EIO, data->interface,
+							data->user_data);
 			g_free(data->path);
 			remove_ssid(data->ssid);
 			dbus_free(data);
-- 
2.56.1

