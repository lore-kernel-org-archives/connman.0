Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C113B787
	for <connman@lists.linux.dev>; Thu, 25 Jan 2024 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221788; cv=none; b=pAsb5WgLiiB0gONaUbFfYNxyGvCHRmqDkrT8xAe3TOAKS2oZG/5+w6gVGbanuFfL2z2RX7jkrY+SiGSYLAK0FMC+u7CfQHHZK6LSlj5BO5yJf9a9s1JpgMWqVBTvnvQ7Ia/ToFhIGBikhoIRekvScl/7t60ZKMRZCCZ+uq2coIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221788; c=relaxed/simple;
	bh=8Lku1vfXOb2X0beArvF1zILtw2Ning/wqVT5SPiNRGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UofWjU9gRnsy57xYS9/UrNzIDUtTIhMmwZrGcNCYYv+m3Hvla81sVSaS0KSwRhNB0Dif/fXhRcFRHLobx6Pmil6XXTPfo1MoVlPPRRyyYF94XaLfmu1JhinuQxiuVSTEcjZO4z2y36GdsDCm8q7YSnaTtQWoJVKNFBYS66lTu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksqShaNT; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksqShaNT"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-210c535a19bso3601060fac.1
        for <connman@lists.linux.dev>; Thu, 25 Jan 2024 14:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706221786; x=1706826586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZj8PW2IaipMw6kucClDsTpP272FY8CtzXwUX+CaRL0=;
        b=ksqShaNTARSi3nryKai5Quu1zZlVKIUNLvIuHdGBZuiwSz6Hn/n4rNdV79dGRp4ZTx
         p6fEoikHO+SnOVWK4J0Kbt8X+6kqqsrMkIYLBtfoCYVe5ZgYE72C59RiShLsjwEr8FO5
         R1AqrvKoSc0KZzA3Rr5pCni9dCvUE6GflQjjzESHaxdiXhXzyRFMkxhGtFROvaCSQTO7
         z/afm1ZFsg7nVBEQSspz7/Xz7ggnW8RWdF0OvS4pSLZxNRtk2OR4/WMGGOpCpst+PJ8K
         RtsUNR5icD/St5Q/kVrxr5q9uJgscLwJWkjydHdfIKstzdAJC9PR38ScaEjkLs9OztHo
         qGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221786; x=1706826586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZj8PW2IaipMw6kucClDsTpP272FY8CtzXwUX+CaRL0=;
        b=Ee8uLbFyvyq0BDIvXek+MnY6mPvHFSSGKCxZVtENu1vjozooOh3RKav1uaWOlB4gQz
         BI1PpOVn4Ib6kdXs0526wVTmSMVAo4kmRw6eQP8FXtZB9d3OLgUPXErQ+0dIKCd8RKM4
         XLutqLNdOh1oSIpASQVLGrGfgP0eZM1S0sXijz+KjM5v6mn2+63UVgaXpa8m2eAYa8pz
         CVdiqwV9ttuIHkptJusRqmGJMEc1RHn92QEdY3UsmXPpsPvwEZyU8preIvuwVYgWf/jr
         Yb2fRyOEi4u9APloPzMKaHlHl/nKKSnYkMehsvjfUPpYE8JgT2SZ9riNKWhWbxkgK4Is
         EVpQ==
X-Gm-Message-State: AOJu0YwPKeqZQRstREzR5KSF5GpxorZr92VNe6OqbSrIOlG2gQPC9Ef2
	kAOoWrvZNQGnVcdNiyFhXqCOH3PhpvanrohacSybhr9QuIGucQoK8Etpqrwj
X-Google-Smtp-Source: AGHT+IEVPeXjsE/JS6leBihgybZL4u/yfrLuD4Q/WxfL1wf+h9QScRDXjfX3KY91PKdrlFY4wooc0g==
X-Received: by 2002:a05:6870:ac93:b0:214:3f32:5233 with SMTP id ns19-20020a056870ac9300b002143f325233mr428755oab.12.1706221786445;
        Thu, 25 Jan 2024 14:29:46 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id ra21-20020a056871611500b00214d57a61easm11355oab.44.2024.01.25.14.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:29:46 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/2] ofono: Don't invoke SetProperty unnecessarily
Date: Thu, 25 Jan 2024 16:28:48 -0600
Message-ID: <20240125222858.640572-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125222858.640572-1-denkenz@gmail.com>
References: <20240125222858.640572-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When org.ofono.Modem.Powered property changes, connman invokes the
SetProperty method again with the new value.  This is pointless and
only creates unnecessary DBus traffic.

connmand[30]: plugins/ofono.c:modem_set_powered() /phonesim powered 1
connmand[30]: plugins/ofono.c:set_property() /phonesim path /phonesim org.ofono.Modem.Powered
connmand[30]: plugins/ofono.c:set_property_reply() /phonesim path /phonesim org.ofono.Modem.Powered
connmand[30]: plugins/ofono.c:modem_changed() /phonesim Powered 1
connmand[30]: plugins/ofono.c:modem_set_powered() /phonesim powered 1
connmand[30]: plugins/ofono.c:set_property() /phonesim path /phonesim org.ofono.Modem.Powered
connmand[30]: plugins/ofono.c:set_property_reply() /phonesim path /phonesim org.ofono.Modem.Powered

Fixes: 054dacc71c6a ("ofono: Set "powered" property according to value")
---
 plugins/ofono.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 9d0d44547a2c..65a722fd85d6 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -1969,12 +1969,11 @@ static gboolean modem_changed(DBusConnection *conn, DBusMessage *message,
 		dbus_bool_t powered;
 
 		dbus_message_iter_get_basic(&value, &powered);
+
 		modem->powered = powered;
+		modem->set_powered = powered;
 
 		DBG("%s Powered %d", modem->path, modem->powered);
-
-		/* Set the powered according to the value */
-		modem_set_powered(modem, powered);
 	} else if (g_str_equal(key, "Online")) {
 		dbus_bool_t online;
 
-- 
2.43.0

