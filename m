Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F433B995B
	for <connman@lists.linux.dev>; Tue, 12 May 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600208; cv=none; b=cxecCFoxN6/a2mRtxqaXRQ14YccJavmguQxmsaYwTNx8SR96S5k89RrM9O6+yK5PMbUr2OXBYD91xdHpFNomxSO08HPLIB2gL2+VY01vVsMPxcBrtUCynREj4XCEPcv4nrZiSjYH91xT/rivKeZGIWzkgNzt+fpptpoKamuZ+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600208; c=relaxed/simple;
	bh=3DrYjJLi02wP1jai2NUXSV+wBgho+cL9YLO5GbWDbiM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbGSV/kPAJTfzWF9i+3ftrFvT9wmCrSzjp9gnn6T+Qvlan0HK43ri1WEfv7hoaZX7crPkeJzSUA7Boij+CLKrmN9DXka3MOtwAgxOP9Sl6Gmpv4UhRB9zUdxx4eLo4REX0zOKJ0Xa4lRCc39U3IoXrN8ONtK8kMXRXFm4XmzARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Z+Cfvq0a; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Z+Cfvq0a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zKuqy1m529TdMNU+Z2i8n/xY3MsatAniC+Nrmqolp/M=; b=Z+Cfvq0aCtrr1A1Nvnl5T4EY0Z
	fQWMv3p+uC+zbj3cxhdoXtGXSt8fIgWTvg127l1z/8KTxY0vMkE8gQ9Al7klzyq0yNzlLU+CsFIL/
	yfOTomRtlylcOre2Dty2/KMRJusgJ64lMz6R0T4Rfghsx0RMjDmzhzoWtnVDUb+CCGMCdf9fApc1A
	WVVW3yIBsP6k8dWlG5s3w/3DCHugewCB2lBmwQD9iknyJb/0PEtq3s+q3A65bQ9Z7QoQXB/8tNoqD
	ODgreBaG0Jrul+1PDL4c62TCdEFd5AuFJPIisAOH6Vz8DTES7Cr2xnocRt2dkO4YWoGzb+UcS/PJX
	0ARnGtaQ==;
Received: from [2a10:a5c0:37:6500:9c0c:5ab0:fb2a:7a98] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wMp9y-00EZ9d-0i
	for connman@lists.linux.dev;
	Tue, 12 May 2026 18:36:38 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] device: Add device string to type conversion function
Date: Tue, 12 May 2026 18:36:22 +0300
Message-ID: <20260512153627.443352-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512153627.443352-1-jussi.laakkonen@jolla.com>
References: <20260512153627.443352-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: NEURAL_SPAM(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260512153627.443352-2-jussi.laakkonen@jolla.com

Convert device type strings to device types.
---
 src/connman.h |  1 +
 src/device.c  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index 7ebda7af..e55be0a2 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -605,6 +605,7 @@ void __connman_device_cleanup(void);
 
 void __connman_device_list(DBusMessageIter *iter, void *user_data);
 
+enum connman_device_type __connman_device_string2type(const char *str);
 enum connman_service_type __connman_device_get_service_type(struct connman_device *device);
 struct connman_device *__connman_device_find_device(enum connman_service_type type);
 int __connman_device_request_scan(enum connman_service_type type);
diff --git a/src/device.c b/src/device.c
index 55670099..477970bb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -126,6 +126,24 @@ static const char *type2string(enum connman_device_type type)
 	return NULL;
 }
 
+enum connman_device_type __connman_device_string2type(const char *str)
+{
+	if (!g_strcmp0(str,"ethernet"))
+		return CONNMAN_DEVICE_TYPE_ETHERNET;
+	if (!g_strcmp0(str,"wifi"))
+		return CONNMAN_DEVICE_TYPE_WIFI;
+	if (!g_strcmp0(str,"bluetooth"))
+		return CONNMAN_DEVICE_TYPE_BLUETOOTH;
+	if (!g_strcmp0(str,"gps"))
+		return CONNMAN_DEVICE_TYPE_GPS;
+	if (!g_strcmp0(str,"cellular"))
+		return CONNMAN_DEVICE_TYPE_CELLULAR;
+	if (!g_strcmp0(str,"gadget"))
+		return CONNMAN_DEVICE_TYPE_GADGET;
+
+	return CONNMAN_DEVICE_TYPE_UNKNOWN;
+}
+
 enum connman_service_type __connman_device_get_service_type(
 				struct connman_device *device)
 {
-- 
2.47.3

