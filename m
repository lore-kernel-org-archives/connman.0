Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479217;
	b=lePzJwOyH3MdICGr+J7UkjVXxNOrr8B6ukd/8vwtpgMV1UiUfUfb46r2DEw8yAtu8fAK
	 W+tk+QSIBKYuw5Q9pzI1B5An7oY+bkInZVGoduz3JxThB/WO9nmDiPfVEB/4tJ2ioIFhI
	 UPB2VAA59KTF0Vk4ng/x+3toB20rKKRSIjK2UA0z+c03cgyWisRNBOfgwYKkIUXB21KQ5
	 UhuJS0RcP6UuPkyGBgsE3C7XVCb0Tm23OB5HW9KX/HrGePoUyhqtPJ0JR50I75aikzUPk
	 KpKM0EOjwjrQc3l6yUpUhDP6rZs7VaP9HajzVS9rs307KtYuNQmWpGZz4Lut7ezDMLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479217;
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
	bh=PF5wu5GUSHpb0v0Zde6BAkbq5PRtEhj7b20zU6wxfL8=;
	b=LflhgCFH6G0Iis5B1bordJ++ekGU0IX5oTLaPezxwnVHBtXyqcKGtZg33loJrOzRsJY2
	 Ci95HmsiaqCp5ypCTziqb6vVjLFeStCcwHj9IoNVBpiNpPJMo0tefuwBkWtdUEWgiKVUj
	 o2Jqhxtfd1k4yt7pKqtiVepA07l6D74Q62KiMamfky2oC1S8/BBsPC5Rbc3877spXztp6
	 4OIUnJn/X5017aWuQme7G3k6U5xCbYi66Cz3Yp3TOVQ8TjSgz9/WGfaMe9FTEDfwrcgQw
	 a4CVgOkj++SDNRedE/LagmVpwSBE70Vco+NtLpg7caoMT8vBDCFZwgl0K4UznVsb2LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=tBJMhBLg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.108
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021108.outbound.protection.outlook.com [52.101.70.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F5606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 383F5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=tBJMhBLg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNatG1y0lZit2oCjujHXgN4Ndw9qE8FHDDAV3jcxI0wTHJBBRXnoBiTZII+lBgfmMywYoid3lj2fkeYX7jFmiap6ZpkoEG7Z7diKHL3u7xDHgQpMRy/baUBaDeNCi0aQOYT74PF315La7n+8xG6QxqE+JVrVz9UwjEKNcV6b2j4FO7isFOBx+a/tqam/XmT/P8CXjpIc5y4eJIvAUhznDQwQU8oUP+QRU6zImFN3B3eUGKY6xZYAjl3cW+a7BM3Kv+Q4cvCxybqHCzd7BXwaLgUI1sEO4PR1NTU5kN4tbTcyeM6KKU7t/EtOijIp3sT9/pdxL1HcFzfQxn/iIZpXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF5wu5GUSHpb0v0Zde6BAkbq5PRtEhj7b20zU6wxfL8=;
 b=uiBB/dW2jAT+iaG54DZEEeOcCEza101zEyPLiRklt1gT5lNpuZsJwSurwze5kszDjM/e812p+Q8FuxYd6XpQ6ShjfUySucAqolwKvs9CwJ1V/6v5MiazGoNhL01HHNdREn9VfVQ7JzZJElCWOM1ejUE8QnrB5GOAKADWXxXfQ0ge0N3ZpQYp5016ohcPHzvEcVoU08Dm24/JDu0JDn/HzYeX3fk3Scg5cEWDZ08jtMatC5AWMXCDjvWiUsg09tytuqLAvjAsBJvoQROPhjBjCl5sx04MGx11nmVUp0y3ESN3DpRxSQkS8SZ8Wb/9iDN36e7gQfovk0khiO0Zjd2/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF5wu5GUSHpb0v0Zde6BAkbq5PRtEhj7b20zU6wxfL8=;
 b=tBJMhBLgkZBbi18iFLyQ7/Te3YA4W5CUml3aGwc9HFEi2AlXyW2HvjQM3tFRmjiRk7C/QQyaAgsa2U7gtPdT7sUezUqF3omNNeQ48P+3Rivg09ii/QjJ3nDD/9jxviiFmMUVvbrkrj9Ykc5rd84Z8jcPXk5woCTkJ/wbrI6oC2c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:33 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:33 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 13/15] service: Ask agent to confirm TOFU certificate
Date: Tue, 24 Nov 2026 01:13:09 +0100
Message-ID: <20261124001311.1161845-14-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::27) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: dfaad9ba-3372-446e-5a60-08df49bfc6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021123027099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	gNljyyEvVvn53n/EFTx5Om36+frZrstsm7FprMWd6jB0l1Y3fpFNnILbjcFOQzszYNU3rM89OT48BfSmlPX0d/qi1aIsr23wA384iuFM8AcFsTMJ/5d5ST/u6ilecRGRjmUyRcQ66MK5eKUfueyG076dWr/Pt7Fhk/l5FfZMbrYXsj+kUElvL/BiDZCinVrJmkKE0dS640lrWFhAmRP7Mc6iYRP405tCbaj07l9CgymR6geEWDBp633XKxFH4DDP3TnOxb+nIaJbOVvhDd0sryIbqixmCEncWylAzGCGdh1Jv0VlB+euxkWlPr1oTldHx3kfkkPtjE5zgBTuJix1/er1BlDm/gCxb6DxtlNTOv0/sbHXC1CpgKiWH0HdKqUg1O5BPetT1OLL+79ZE/VmymR9M8IiEuK1tD7RqQ2M2/exn62N0iKw0uAHVlwJNBNhpytcS/uCOyVuIarJrkZ6M2k70HjjFX7c8l+zxYzgv591Fgv4MIt6flM3IcZoNKf+3HfpPudFNrKoQtO87Y81zLsYP3W9dXWz/0WThaFFAIWVfVzIurqq6t0cqoUkkvKRUfdeCun0yRgS6fa+NMFWo/JaLFPuTD8955R6lhvh84jVJR1dmlxYyHS8nNjyPOrtJz3/Sp0goTA6O0LV8doTXp///b7CbvrkogvwAURWhis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021123027099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdOBMisa/u2eMSB7S218odgoUfAbgmyEAC4iimFb4G2OBLbAUL+e7NC32kPV?=
 =?us-ascii?Q?5Kk4TRCWO8ERbHknOTSpGbGMpJHb9SWbRvUvwGTekPwLLm95NgRjW0jzq5e6?=
 =?us-ascii?Q?2WIlRKeiRavf3rsVVDJLE0e9b+qQz2M7ZXWOfXzrwoO6Cw1awz2T/IJQVemQ?=
 =?us-ascii?Q?MciLKghuXrjBQiUM4624MPGjI2OXgBk50Yit3IXG7pE0TGBPEmH2jImeSQgs?=
 =?us-ascii?Q?n6RvAx/Vjcq36hDFn65jx/GoRDdgFn+FPvWTAqF/iKfWFKviVZNDrcRtDZa9?=
 =?us-ascii?Q?6IRImAL8y0e6zNy2Ic8M3y4OyV1eFD+KBDQ8FiJ5P80s1M+2hy6fXiMZKqH9?=
 =?us-ascii?Q?VVshWeXOBuJ9GJmoohXuRhd5CYU2B4bU+L+vQ+AFF2bxE4NQ+19z4PDq+TQD?=
 =?us-ascii?Q?fSxzG4gFZggtKBZuixbpbTPgSa+WP1HdarOjmniRaGuYW5IPj34RNaVmpSqP?=
 =?us-ascii?Q?EAJFSfqkEX0mkOcPYQUEKBw3xOa3u/vNRXvsExqyS5nvtfIOwE2pH1FP30Ee?=
 =?us-ascii?Q?4gadxuEcu8SRe2MujY/Klxc+UN9hZSi6fbY3dHKyKEz1QxlYhN7/X9ELpkXg?=
 =?us-ascii?Q?VwD7WKXiubzzSqswqgfjLB/3EgaVL4vrSbu04IbN9W2zOqoBsYB4Nu0nUUxG?=
 =?us-ascii?Q?OA4mSuShh07W4xIo0OTs7hD5yaIq+vDVli7fhZZGnf7Q0XsT5x1YMzLCV7Rn?=
 =?us-ascii?Q?TXQgqrqQCWSVI8TwngZ6bBe36dysI2LmcdFlJP7ea3HoKfIcgXaJVNdtaK6x?=
 =?us-ascii?Q?+gDJcAM425u1pfOXF65DIz58aPm2fNv3t0CQvP+SdpnlJQ5bmkhGSrzVDZHI?=
 =?us-ascii?Q?oALUPOxASZqggDR70tull6czMEpwAK04cMV/Tim800DybMyagZZmfeD18pGt?=
 =?us-ascii?Q?FHUrZsHaOSVn+CCkYQiSqywUGBPUt6ekPdTgSINUw1TZtEarqjQsbA9LudKY?=
 =?us-ascii?Q?YwVhUpY7lvVqH18F8pf2m5MpYWMYFcqM41N8QD3RFRrOsKfXOp+P3BMck2nY?=
 =?us-ascii?Q?+xqYBAtV94RVj/zGPC/3trLTpgS/JFKJublBLIcDsqnd6R2m6QQqllomg/zg?=
 =?us-ascii?Q?wxHqZzfimoIjuAIDOCXd9AQUC0jlXSvz3KDfKxcKe5a/tKXD3bHDzH0OcI5V?=
 =?us-ascii?Q?r0LsLbe2ObcoIqhS8WEri/zUq4es8EGoaiwvUId3R3edIEvQVnL5NUxXgLec?=
 =?us-ascii?Q?B2Ae7sDkV+d2wFRImXlPU+4DiYKvxD5BxZGkvrmtjS9oCoODrGYCnBsK0v6Z?=
 =?us-ascii?Q?VNKzGiLfL+i3eFbmqNXgiP7h62UuX7htYzFTHHobi6VKkJpr64A3S8AzMVFt?=
 =?us-ascii?Q?LxbCj8+jU8LvwcRNDsY8aM5Fdx+/VO4INhyQP1bgA4cbbmBJOmnedq2AlkL/?=
 =?us-ascii?Q?qiz9GLQTM5EexSattiJQYMqqTUcHx+jRYeu5zJoHYUGrmloBrnnA1NyEDCrs?=
 =?us-ascii?Q?uWy9Z7Ukz4ZzbsD/dOSf7C4kQScCwxuBoHGfMB4lWUYgEAbBL5EgPYZ5O+xD?=
 =?us-ascii?Q?hfulUkizINLMlWlkx0IutrR8H4lDPCxnOwAuNg+FmstNuNNdiH6WPdLMM9/C?=
 =?us-ascii?Q?oBxqcCLx+9iV3nMxwOjMhglUia/KzDBdZiyacA+Nffb2fmgZmr0kKaZQFGMW?=
 =?us-ascii?Q?Fw/6U49qXDhwqvbTgnENj2wh5yvs11yDiqmMGi28Ef1+FNcAfhI9vv83q/kQ?=
 =?us-ascii?Q?r7ud+mNCZ7daZUE1cCwnH/9xA/KU+Jgu6TonULhODYR985+L83nwoB8cGwa+?=
 =?us-ascii?Q?rsrF1ppu4KyGX4qLKERwbDCC8J2vsdbrEbTZmJi5RH8p1fQTK2kWUCnl9dz7?=
X-MS-Exchange-AntiSpam-MessageData-1: JBEsGlnKKKAa+F+rGTX3JMuK7q1wmGOYNjI=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaad9ba-3372-446e-5a60-08df49bfc6cf
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:33.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9PcKL3r9zgTYD8xRYsnD3S3aHP2XJlTcs+VdxqXJNL44N9lrY1qyNrISU8CIL9Uk76sIHaJ1ZftNLfHdoF8+1mS+xX4yoWtyAZ+6+7vyDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

When an agent is registered, ask it to confirm the certificate seen on
the TOFU probe connection before pinning it. The agent is asked once
the probe has ended, so the request is not cancelled by the probe
being torn down.

If the certificate is rejected, or the agent cannot be asked, nothing
is pinned, the pending Connect() fails and the service is left in
failure state so it is not auto connected again until the user does.
Without a registered agent the certificate is accepted.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/service.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index 8d9381ce..44928978 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7578,16 +7578,63 @@ static void tofu_resolve(struct connman_service *service)
 	tofu_request_free(req);
 }
 
+static void tofu_agent_reply(struct connman_service *service,
+					bool accepted, void *user_data)
+{
+	struct tofu_request *req = service->tofu_request;
+
+	if (req && !req->decided) {
+		if (!accepted)
+			connman_info("TOFU: certificate %s for %s rejected",
+					req->hash, service->identifier);
+
+		req->decided = true;
+		req->accepted = accepted && !req->cancelled;
+		tofu_resolve(service);
+	}
+
+	connman_service_unref(service);
+}
+
+/*
+ * Ask the agent to confirm the certificate. Without an agent there is
+ * nobody to ask and the certificate is accepted, but when asking an
+ * agent fails the certificate is rejected.
+ */
 static void tofu_decide(struct connman_service *service)
 {
 	struct tofu_request *req = service->tofu_request;
+	const char *sender = NULL;
+	int err;
 
-	connman_info("TOFU: accepting %s certificate %s for %s without "
-			"verification", req->is_ca ? "CA" : "server",
-			req->hash, service->identifier);
+	if (req->pending)
+		sender = dbus_message_get_sender(req->pending);
+
+	if (!connman_agent_get_info(sender, NULL, NULL)) {
+		connman_info("TOFU: no agent, accepting %s certificate %s "
+				"for %s without verification",
+				req->is_ca ? "CA" : "server", req->hash,
+				service->identifier);
+		req->decided = true;
+		req->accepted = true;
+		return;
+	}
 
+	err = __connman_agent_request_certificate_authorization(service,
+				tofu_agent_reply, req->is_ca, req->subject,
+				req->hash, req->is_ca && !req->domain ?
+					service->domain_match : req->domain,
+				sender, NULL);
+	if (err == -EINPROGRESS) {
+		connman_service_ref(service);
+		return;
+	}
+
+	connman_warn("TOFU: asking agent failed (%s), rejecting certificate "
+			"%s for %s", strerror(-err), req->hash,
+			service->identifier);
 	req->decided = true;
-	req->accepted = true;
+	req->accepted = false;
 }
 
 static gboolean tofu_probe_finished(gpointer user_data)
-- 
2.56.1

