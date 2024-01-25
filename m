Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC8131E4F
	for <connman@lists.linux.dev>; Thu, 25 Jan 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219785; cv=none; b=gqKcZlpCNo9B3NcIz8NZFJYNaXLP1Ebqmo4DLa2UWBnOpbH8AGdR/zlaBmBAmAsHnCvqlsVQWcVO3wMp1VD0SonC0TD+qGfYpY6DFY05TYLYtugqPuSHv/0/j+bt71edRxErH2HNLHG8u2z+xgNrZDMmvr+2Aq70zd1L1ZDYSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219785; c=relaxed/simple;
	bh=mCLg1BF7N0e9gfpRC9e3gJbRH+Rtb21bKZgxRBWTNQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWLULg6i7wkqnWEKMlpu0nJy6p2Hs6Jq2lbYS0rlIp0ZRwyD0wLhOkw6W1Uw7qe2CSU1P0Pf2D3iPuijwR1wPF5bG8qYmFqilnTsQfVo1p/eGLFsRh6ZHuislda9Ccb9XJ6Gm5cRGb0mNJ6jzHfWITZBiOF9PnsTa0uQQo3Rk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsjTRpQ7; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsjTRpQ7"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-599e913264eso580777eaf.1
        for <connman@lists.linux.dev>; Thu, 25 Jan 2024 13:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706219782; x=1706824582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPfIZHbe+Pb8cesiOclJ1BbsMfdO14eQRhdUst8FGRY=;
        b=SsjTRpQ7w4e0mPglefeTu4zAPeohcRhR94eNGSffXlzaoBDr14DOaHafeqM/j5w1zb
         zqyE0pg4EgqYBhcXFFpgBbZNunHtGRfZPGqebrKbNDdRIMfBZBOmVRQWUSU5mXNvn/8Q
         WjNCzJeltaN/L0LjRz4bD3eTdHJxy/hyRR7QVWsWmf3QLk+9b7aEC+2wDTkVpMTkVaue
         NNcD35WmGh2LE0tEr5UeT1f0Z9hT8Iy2WWQ+rFAxLhQmOr3WcKss6VXEdWNHWbF1/HNf
         uswUyrgs2XYwh4jDjEwLF7zUbpgM6JNfCBIMOp+XTcsfUF2CD8QTVeuWEXqBIMG2ZZUm
         RAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219782; x=1706824582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPfIZHbe+Pb8cesiOclJ1BbsMfdO14eQRhdUst8FGRY=;
        b=XZfqHZIqtjKUG95igFioMDEPkiyb/oU8idkcj3/RlKKdXqgqCNn/AHB5s2qA5Po2Bx
         0oxD7VDqcflWKdX4Nt7cZCPfcRVGHMlNzbytcu/NiepL67vvHKXffp7Zw9y98TjCsIRJ
         1SiKUDws2Syo9hbD5yvB8OyCoXlWZa58h+U/HQhMZsd2ChnbEkCEmv/2vV/06usTWSLn
         363+lkxQFFHuRXPJhDemBuz0uM/8SB8HAB54hkme4iKDT6R9aceCnIzgJffM/r1QMnDX
         122I4LeWTL/VpkP2hotQyiND7FlhxmgJc1eV2vBsoik/lUuwlyL97cCZJq6ujjHrRCxI
         bXGg==
X-Gm-Message-State: AOJu0YymGKZe/0osHqKgcVqG8aSYHkJS7slmFug1i1K9mw6sM0bU1iD4
	P0OnQmp25XoAbAiQ4es534YxBjComxX+WSCSOtM/AGTs5253JBMT4SBr2BO6
X-Google-Smtp-Source: AGHT+IFTIHervpKnSBGgwtviriVeME2J/TB+MtG06tYyZk662x6xya21FJpdC3Vh7nFD26+yJrRnfA==
X-Received: by 2002:a4a:a60c:0:b0:599:c1cf:eaaa with SMTP id e12-20020a4aa60c000000b00599c1cfeaaamr398409oom.12.1706219782232;
        Thu, 25 Jan 2024 13:56:22 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j1-20020a4ac541000000b00598d6a3ff3bsm586467ooq.13.2024.01.25.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:56:21 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] ofono: Don't invoke SetProperty unnecessarily
Date: Thu, 25 Jan 2024 15:55:16 -0600
Message-ID: <20240125215533.640304-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125215533.640304-1-denkenz@gmail.com>
References: <20240125215533.640304-1-denkenz@gmail.com>
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
index 9d0d44547a2c..6b711b979046 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -1969,12 +1969,11 @@ static gboolean modem_changed(DBusConnection *conn, DBusMessage *message,
 		dbus_bool_t powered;
 
 		dbus_message_iter_get_basic(&value, &powered);
-		modem->powered = powered;
 
 		DBG("%s Powered %d", modem->path, modem->powered);
 
-		/* Set the powered according to the value */
-		modem_set_powered(modem, powered);
+		modem->powered = powered;
+		modem->set_powered = powered;
 	} else if (g_str_equal(key, "Online")) {
 		dbus_bool_t online;
 
-- 
2.43.0

