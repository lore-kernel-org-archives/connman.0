Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39D13C9D1
	for <connman@lists.linux.dev>; Wed, 27 Mar 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568622; cv=none; b=VMoIPRHQ9KZKwbmg9biuDedf/za2nmRN+jw2ZGH53eFRgKRqDl16ldLY7t8f4vUhw8ld8cartg6eBivTTsamrZGlHJDXgzNn3aWP8WLJCjwWWcSC6iRfoKJ84qJ3Nt1XgY+vtcDIiIrTeJeRbsW2VERq6sPK8mGIW2h/YzNurQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568622; c=relaxed/simple;
	bh=xy+bwwuSQiIuQkJKrVgmn89uz13fHw/QHR1xR5Pfq6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0wUH/4oMdioWBtZx16iqcJOT4W5T4rKsFamvvf1DoWc5/djqxaQ5VCIC/8Vko+icDIaKdzjm4NIr/hKk/5LrjujSF7uz1SBkoEyuICPz1GmN7Iolive+9/VrBvMir2nfzmG1r80eojtY9PuQZR6AwQo76Z6DPPylzOIhqOkb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqyslX7R; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqyslX7R"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e0f43074edso132510a34.1
        for <connman@lists.linux.dev>; Wed, 27 Mar 2024 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711568620; x=1712173420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19D/RocoxN+rEugx/UILXEo5uIdiJJzYKvejBwM4Eno=;
        b=mqyslX7RS67QNlSnCG8RG5TTrv0wYEtxGJGxbfz9EHDzFkQtwIO36kHAUdyyKVkT3b
         hDDLNRb+zLvhES9MlK0h4Ju71vJhFAydzwmD1a6swdMwFprngsD4u1In4bxZGE2btgpH
         x9NiU+HpcZtyDXGASXhdrCcbRj60vRslx+tBwmdnbS/W17V76vyJP2d5axcuMsnlsKOb
         F5Pe37NLpOnaiAPbhV0PTY3mh50JVajLPUx3NNZ5A1idbo+sU2+LwfI2d+L8ojVtQwsv
         //qk9cj4WftxFW/KMfA/a4cQ2bMAGP3hgVrj0sPFr1TGGYfD0HpGfYhO+nqvEzQEZLq7
         PWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568620; x=1712173420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19D/RocoxN+rEugx/UILXEo5uIdiJJzYKvejBwM4Eno=;
        b=T5lfgw0CcRR6VwQpd0i1oapqtxl71I03eNRS9u7bXC88vcwUFj7DtR/Z/JFJpASXTt
         ZH5Rr9vCVFsxbaqSPqtBVSfqUqbYN2U+cSLVtEHO1RpMdPvG1tLtbaciQ/lV+QuhwNux
         AEQRoj9J39KUMvmeClBC6UQhwT9uFZ0Vbg0/oTqNQMP0Jenz2BoHA/FX4mTzRXv2IjUH
         sTQzQe80694ztLEnoY/lc4SQlWR2Lez3X5K+jzOJif2m6q92VFJKCDweMKf92x3+tGYf
         tziSpEctAaJ2mNbiPbxzU7X+MrsJfJjUAwDsUVS8PWoUnvcwHwOHVb+5qcEJW+6pDF2L
         fkYw==
X-Gm-Message-State: AOJu0Yw9X2uzdlA2sVYNXF8t54nTtoMNOp5uCKJq97/qom5GLtT5uySj
	gGy7BgDtjIQFYJVuORoMcbiXF3sQNyhE5aMWmhJbLv5cE7cUdW0lDCs4wr+X
X-Google-Smtp-Source: AGHT+IExR1ub0oLua6BhZt3IPVSqSRZvnMy6TFe8zWvlYswwhnUZW1bk55SPmMVR46kgS8a4Tk4b7A==
X-Received: by 2002:a05:6830:1199:b0:6e6:8ef9:f2b9 with SMTP id u25-20020a056830119900b006e68ef9f2b9mr1128235otq.13.1711568620262;
        Wed, 27 Mar 2024 12:43:40 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id f22-20020a056830205600b006e6cb624064sm1876919otp.40.2024.03.27.12.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:43:40 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/4] ofono: Set modem->interfaces earlier
Date: Wed, 27 Mar 2024 14:43:33 -0500
Message-ID: <20240327194337.2735677-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327194337.2735677-1-denkenz@gmail.com>
References: <20240327194337.2735677-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update modem->interfaces earlier so that handlers invoked on an
interface being added or removed can check the current interface list.
---
 plugins/ofono.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 1906843335cf..fd8b442a674c 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -2018,18 +2018,15 @@ static gboolean modem_changed(DBusConnection *conn, DBusMessage *message,
 
 		connman_device_set_powered(modem->device, modem->online);
 	} else if (g_str_equal(key, "Interfaces")) {
-		uint8_t interfaces;
+		uint8_t new_interfaces = extract_interfaces(&value);
+		uint8_t old_interfaces = modem->interfaces;
 
-		interfaces = extract_interfaces(&value);
-
-		if (interfaces == modem->interfaces)
+		if (new_interfaces == old_interfaces)
 			return TRUE;
 
-		DBG("%s Interfaces 0x%02x", modem->path, interfaces);
-
-		modem_update_interfaces(modem, modem->interfaces, interfaces);
-
-		modem->interfaces = interfaces;
+		DBG("%s Interfaces 0x%02x", modem->path, new_interfaces);
+		modem->interfaces = new_interfaces;
+		modem_update_interfaces(modem, old_interfaces, new_interfaces);
 	} else if (g_str_equal(key, "Serial")) {
 		char *serial;
 
-- 
2.43.0

