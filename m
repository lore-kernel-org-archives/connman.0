Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69119176FB1
	for <connman@lists.linux.dev>; Thu, 18 Apr 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471138; cv=none; b=VnRYxLwCNKI6e3S3xeEj3oEZCuSB3mLvntN9V9SF2FydqDbVTWux6QcvN+FIMjtaEaYjQryA6gYCbyCtZRBCRvmBlWExxQZZVoI/PcgtOvgRWXKaAJFquFXhjKH89KQfIOVjkAzxzdtUygeADc1kFgFcZu9P028eCEBxEd/uZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471138; c=relaxed/simple;
	bh=uqz6HMTgPMFH04aqj29NxwFCBX1snovxxLdbVI1Es5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyPy2KiJfoWcoWS731s0HNftL5BeU3wqQoxUcpFPAP7c1+caH7ymfNJF5NEkVxl28pFE67r66ZyqYHQmstt/0OerA/sqCgdGYspTOT8VnYq7nT4LEfnrUS868WX3LodP9+kUoxjBhoTuFZK9nREN2nUtzBer3WbQxPYkxLSpqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=XjDapK47; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=ODkfvceR; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="XjDapK47";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="ODkfvceR"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IDHC1d008225
	for <connman@lists.linux.dev>; Thu, 18 Apr 2024 13:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=fMU9Yd/Ll+X90PjPAhIAvgAzWfxHYAfCtLBvAfE7AqA=; b=X
	jDapK47zsP+5qEy4hDHgOzcsU1zGszJ+tXexuRBLwavWP4Q+UKvVSVxHvi+t5ofK
	W6/GJwnwqXEVgQdKNymXrM320cI1ZfIIBy5HBMCSzCP+yYAOQx/QliAgfJk6mkHG
	V2mk+RtiQvETCDSMAxJ1mWG7fDhz99FFxrVndyL3/AogFbR1o9NuNWtcxPJeq/m+
	n30klWANVKgLqtKI76csxrq0d3izR7oZhqDbyqmdOvuWjT3MbkPEoCK/pJMHzR1r
	BX1z6wmyzuKA+MWtO5K/SSpeWojGSlbFFp78XSua7K1tclPJZe8lm84N3frRUmXS
	I+cN93yisBjv6JZ/r2A6A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xjnny10ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <connman@lists.linux.dev>; Thu, 18 Apr 2024 13:12:08 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed4203cafdso1285180b3a.0
        for <connman@lists.linux.dev>; Thu, 18 Apr 2024 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713471127; x=1714075927; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMU9Yd/Ll+X90PjPAhIAvgAzWfxHYAfCtLBvAfE7AqA=;
        b=ODkfvceRem7V/uunxxSrTdICo8md+5CFpjFGRRIMCmZFT42HSKMsHVQukBkiCmA2JQ
         +mrvHiz0F04loz8+kWp4C/Jm2tR8rAs/ZxWFo/4NdyiBVebaL8WL20lYYC0iq9z4B8U+
         5H5lei3MAJKZrbjXzNbLB2B6QZ+5G/LvaeP5vEod1yrPm0Lj1OZ48Vrh/vEg6Fm5uOnv
         br565mprIKYA9ZfDOD8eZfvzDuorrmvLPvVnBjO3kNN59VQaTmUrC+tCs5TzFI32QA/D
         XCsiGRGPOhj2tON9dCFyNyfso1PO066wRbcWeLNftFD0nRiPyrXLC+Mhbl9+bQed6H9E
         grJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713471127; x=1714075927;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMU9Yd/Ll+X90PjPAhIAvgAzWfxHYAfCtLBvAfE7AqA=;
        b=kSeu4grECp8jSf0igHgwc46krsM0kK+LjqofO8hz2NovSaSolVtp5V8tfAJ9UomjfP
         UMb9O76lVhu/yvhH/PIrjiUMahZYzDawuYKZgJ0NX18lF9meGGttjntAEW59B7WMlvJa
         Dz7wsLWZtsHjSy5eioJOfzLWg1N1XH2wsdiXlz/PapyGDu5X8bbvL5uwabfXD5lW6Pcs
         AnX5f4+HQOvfMMqpBU5N7eCLVuytXrxSDhNSG9Fp57J/mfUl17yMckhMVi9TmXkB9c3e
         ebhZ3inWK6nh7GXNi/rBcs1WDsvPv+ZIvC0n8hDOndyG+GkKSKlT26gwf7dXLEdYe7my
         tAeQ==
X-Gm-Message-State: AOJu0YzQ1e6Lj19SwZWTlFTBBOZTdmSYe2kDrpIV4QCOB6XlGozssgVa
	wDosdDsGD4xCcfPjFAbxKiBtKk2FXqbYN9PmlvV56jashXb9NBKV6S47+C8ZWi9Gt8yHeV9K9a1
	OEgpSziX5oCqedPA4iisSf6Jw8JuALt64im1ZOesOKL7YxjsY1Tw08j9QqFa+sT5FlATmAAqn6T
	/w8ZKHkh1N6gry7spBDswr896fRgXaxgmYtY7gkTJQMK1Qzm3eetkW
X-Received: by 2002:a05:6a00:2181:b0:6e8:f66f:6b33 with SMTP id h1-20020a056a00218100b006e8f66f6b33mr217436pfi.4.1713471127522;
        Thu, 18 Apr 2024 13:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMUzNbGnB8GgBWZxyzUxlirn3g8CEFJmGarJO1PIC3s05dV1wqU9qywLgBjq0q7f9N/6xMVw==
X-Received: by 2002:a05:6a00:2181:b0:6e8:f66f:6b33 with SMTP id h1-20020a056a00218100b006e8f66f6b33mr217419pfi.4.1713471127045;
        Thu, 18 Apr 2024 13:12:07 -0700 (PDT)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id fk12-20020a056a003a8c00b006e6a684a6ddsm1875789pfb.220.2024.04.18.13.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:12:06 -0700 (PDT)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: connman@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH] iwd: set network to connected if it is already
Date: Thu, 18 Apr 2024 13:11:51 -0700
Message-ID: <20240418201151.624654-1-ram.subramanian@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: coC5s9m-HrYMsGzA7xNNqySHAIX1wcQO
X-Proofpoint-ORIG-GUID: coC5s9m-HrYMsGzA7xNNqySHAIX1wcQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=872
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180146

Without this, connman will wait for a "Connected" signal from iwd, which
is only emitted when iwd connects to a network. If it is already
connected by the time create_network() is run, that network will be
stuck in limbo.
---
 plugins/iwd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 1955140d..19229c10 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -1830,6 +1830,9 @@ static void create_network(GDBusProxy *proxy)
 			network_property_change, NULL);
 
 	add_network(path, iwdn);
+
+	if (iwdn->connected)
+		update_network_connected(iwdn);
 }
 
 static void known_network_property_change(GDBusProxy *proxy, const char *name,
-- 
2.43.2


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
