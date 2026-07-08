Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49413ACF0B
	for <connman@lists.linux.dev>; Wed,  8 Jul 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533418; cv=none; b=MA3IU7JaCOVou2985Ugfeu70WjhzQEBHW106YEutmbj8WAE51p0jYohIsMTM1HzQGBPXh8X6PWWx4bMoSXSWYmXW+pOE7VW6XVg8OLmAuzKv033jd6R9cbAtEfrvxJKRIp4TqwwiUbsBSxJF8V2rm/iG6qNrUi6HYcrGZS2/2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533418; c=relaxed/simple;
	bh=DxBv/T9Aje0N/MV641R1QkDXkMUgfL4DHBgBtMcxH1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQLQmGuHQp5cSMMJLwoQgIloPYxiaYNM1lkyDYFJtDctcwBPOT3ft50XUilmM50mq6+Esq+hkaLY38z4EYR1w85BX+zN01IMR8RzUe11lGyhZwHbKBnwRsaoOiJ3pYsMRgF27uLzjYA2y1dpAvr/d2AYdzYiVXiwxgjmyl9hM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV5Ezc7n; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV5Ezc7n"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-470174001a0so625168f8f.0
        for <connman@lists.linux.dev>; Wed, 08 Jul 2026 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783533415; x=1784138215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7yXoPu2ZBScQA9Qcz4CtVC0XpJq6JC3a1qK7tcoW5o=;
        b=IV5Ezc7nkbH/r5EQwdSqGnQgrx2HqP0D12XYuxqtMhpP0aMg+8/19LholTJYGfNXAH
         vPsldmVy9lE359zwa6PxQJAVoopKK9O2pXWPB3bxaJrm6LKGDk8ubuuXN5iE6eiMQsUB
         FLGh2c+NHu4GIpo2EoGu+MZ32PkXC8CcOvPiGajYYuruQwZUDwLqLO72NeB9q4jy8qA1
         yg7VG7yB6w2TyWNQW1kbwXI+Vs2/zfT+eM0Z+YH9EP2OhNw0Bm6juvUPBHz75+3Pt4D1
         GT2Udb5w2OYlNB2j2UkIygAS3hfeb22R1kvUEj6mhdGFd73dMzu9dtNIIm2MHbqEHf9y
         n01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533415; x=1784138215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7yXoPu2ZBScQA9Qcz4CtVC0XpJq6JC3a1qK7tcoW5o=;
        b=Xnhc2gB1zB0Gapitdiidep/jdONhI+8ptz0XTa8LtiAHpq2xZw6gdaadz9X6iZbZW3
         CYXbVdQKBEkcHa6zHSLssaK7jR3Mj3R8Hi3IxqjdbzkanMtEnkhvJWTGlE2GeMKPMYzj
         A58yEtUTF+48eJtoeZO/XNU4Ku/e7h3lR5+H7SuchY3KBbhG4k44r2Udba1KcBeenemc
         AX4X6PUYH3MoJv8iSFSD2ExpE6d26tpJKi8W79tSWRToGNxBncv20G7pNBfzHXyQ48wx
         1k7no150rOkFzJ/g5OBCiaHHk3c7cb1VnPSIY4BcEvgPxzQqawnjWU52ltdSzvaXuQZp
         KrSw==
X-Gm-Message-State: AOJu0Yxbl2k/C+akAhPxb2fIEc3lMpBY98SbHzj1w8ANS7EBT56z/s4e
	Uualq2Ef3pfKIghOOODnkd8OUcrH4mFosnyhSq1aCctCxyZGjMHHwvmStBw0Sm1B
X-Gm-Gg: AfdE7cmoo9VgIiAsVSQJwTnNp5Pifp+gs3tLAws/AQBtva92iBBTD4FZtQRKBLPIYHm
	OEXkCnd6JIHxKZnIPZTzTI6l2HiWwMHNi3Xxtmhg+Jx0DG3WJeXXz379yEngOr9rGdDEsOipWTm
	mc8EUGt6z5wEUYHdm3YyrS+OktlcuZ7Ik0dom5ArFEwecOtFgFXyFl5eTXdbZePKv3kHMj6fIrj
	tCnHoissSh3xNVcJJzPFy5ei6VTRCCZ0dKFXiy83Hxl501wu7o3U18b+QtgPSklcWhGva4Su7fR
	stGogQdLaprPYERplGiiDm/jn3mPPD9JdGrK9ubSpLqloh8J3t/iygRRrm19hjN5CrQRKaC5mTs
	z2EHzo1BO9noeXCIYeNKY8R0AQaJnu0uBTeYLBmLRyo/Q57ZJApQYFernZ6PhWi6rMg3wb4LQRH
	o1VbbvOARjtC8w6J4uczF6VWyHlAlHdmCw0HRJL0/VVeuV/W4wTjNuTzXcV/JozCp+LV61
X-Received: by 2002:a05:6000:616:b0:476:a715:1a with SMTP id ffacd0b85a97d-47df07fbd41mr4129543f8f.41.1783533415156;
        Wed, 08 Jul 2026 10:56:55 -0700 (PDT)
Received: from Mac.degu-bleak.ts.net ([2a07:7e81:8205:0:5dc4:6779:6584:5b39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm48061787f8f.7.2026.07.08.10.56.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 10:56:54 -0700 (PDT)
From: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
To: connman@lists.linux.dev
Cc: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
Subject: [PATCH 1/2] technology: Ignore invalid UTF-8 tethering identifier and passphrase
Date: Wed,  8 Jul 2026 19:56:49 +0200
Message-ID: <20260708175650.16177-2-giuseppe.eletto98@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708175650.16177-1-giuseppe.eletto98@gmail.com>
References: <20260708175650.16177-1-giuseppe.eletto98@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

technology_load() reads the WiFi tethering identifier and passphrase from
the global settings file. The passphrase is additionally passed through
g_strcompress(), which turns stored octal escapes such as "\215\301\252"
back into raw bytes.

When the settings file is corrupted, for example after an unclean shutdown
on flash based storage, these strings may no longer be valid UTF-8:

  [WiFi]
  Tethering.Identifier=@?????
  Tethering.Passphrase=PW\215\301\252\252

Both values are later handed to D-Bus in append_properties() when the
technology is registered and the TechnologyAdded signal is emitted.
libdbus aborts the process when a string that is not valid UTF-8 is
appended to a message, so connmand crashes on every start and never
recovers on its own:

  Aborting (signal 6) [/usr/sbin/connmand]
  #6  libdbus-1.so.3  dbus_message_iter_append_basic
  #7  connmand        connman_dbus_dict_append_basic
  #8  connmand        append_properties
  #9  connmand        technology_added_signal
  #10 connmand        technology_dbus_register
  #11 connmand        technology_get

Validate both values with g_utf8_validate() right after loading them and
ignore the ones that are not valid UTF-8.
---
 src/technology.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/technology.c b/src/technology.c
index 933070f0..8bdb296e 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -481,11 +481,27 @@ static void technology_load(struct connman_technology *technology)
 	technology->tethering_ident = g_key_file_get_string(keyfile,
 				identifier, "Tethering.Identifier", NULL);
 
+	if (technology->tethering_ident &&
+			!g_utf8_validate(technology->tethering_ident, -1, NULL)) {
+		connman_warn("Ignoring invalid Tethering.Identifier for %s",
+								identifier);
+		g_free(technology->tethering_ident);
+		technology->tethering_ident = NULL;
+	}
+
 	enc = g_key_file_get_string(keyfile,
 				identifier, "Tethering.Passphrase", NULL);
 	if (enc) {
 		technology->tethering_passphrase = g_strcompress(enc);
 		g_free(enc);
+
+		if (!g_utf8_validate(technology->tethering_passphrase,
+								-1, NULL)) {
+			connman_warn("Ignoring invalid Tethering.Passphrase "
+						"for %s", identifier);
+			g_free(technology->tethering_passphrase);
+			technology->tethering_passphrase = NULL;
+		}
 	}
 
 	technology->tethering_freq = g_key_file_get_integer(keyfile,
-- 
2.50.1

