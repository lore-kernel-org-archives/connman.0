Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBC2459EA
	for <connman@lists.linux.dev>; Wed,  8 Jul 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533417; cv=none; b=WZhUVjGMcNh7dQ2NJWm8Gmer1tUEDyBOc4GB+WFoByTYR/Y4nFHGl1wqdw3ZR1hKkB3qzJrGQuf2Vh7hjk6yjc/LuE03MCfouzRen41oCsoJQt4J9/3/snq0B+lNaKmQIZQHHQcyoS9fTjDexQaQy9+HmBBOqebr8DBKP7RF1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533417; c=relaxed/simple;
	bh=xm1/mj5gGHZcBEliV7hEGgIr0wl+ua8o5LbT6fw1wBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzxmmkEkpKD5v7v4EMvhxDjjq00VEoNAuCK4vp+Zm+eZ6JEWWabZ55lzFK6XKdFRceA025JqwgAHaNxpSWBg7PYoW8rpXSk5nkEqtkTsh9frZPFDsEiAfHW9i91eZpzFMqsXBZsE3IBItxhfBPvT+f4I0VQ3eO4rYkOSP6EQ3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja271jzH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja271jzH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47df440fcd5so338455f8f.3
        for <connman@lists.linux.dev>; Wed, 08 Jul 2026 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783533415; x=1784138215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=87SUojFFwv5dJh/K74rT7rQEYrbZT9CFzktU1O8NKjs=;
        b=Ja271jzHdYv1kCdnb7fF6rfMsuculd+g4ONaILZMHHuiYq+1zB9zdsZ4lgtu5+2/bp
         QCldIKJag2EH79Wp0vR54MmrcIQTgMISvHxv1/V06JBJaFnjXeX4zRasNjGcJTk4TnoW
         I89CPQxKxrds7klcgCHOAZ+ogjDbqn6lxWJ3F04FyqUF7xbwIpgJKkaHyPcl7mpzyynH
         yXJy0k6eEjTNNLshRZmAjutOQ7loaKfXCsKxK38CtKJMzWcu/rkfG56SXBeJLg4o6baZ
         q1B3MShA7sF0sdS0MFHGybJWAuarr+KbyVZseFGVYLLIh7RHaGHP/RHGObr4Meyygerw
         HJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533415; x=1784138215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87SUojFFwv5dJh/K74rT7rQEYrbZT9CFzktU1O8NKjs=;
        b=pDxTxvvjG3+67JBvaHOhEFpjRGbQdwGHnKGTYrYJwVd2X+Nyk0A6wdVenBRGjnxi1+
         YPuiv2ziMLBUFU4ah8qIq69XB1iILF1kIotsjHFGgUs1nZS4gbbQHKumce8V+AYay9PD
         Kxb5Dnwy3sC1JKAQfbojuyJ56K12avWVQ4if7J88irH6al0tOQE8AjWV1APZkXlcLaum
         3XERAF+/RDGLfl5pL+2gG9hVevQpQAcFI8n706r6dJIjDDHiECumZtaQhN+VMnjsifGQ
         H5nW1Mv1D+h5qR2vvJuH1jEDAIXwsurwYhAbcM3COEmBkBcFVxkbj8HGEJaM7X0GvfYH
         T7fQ==
X-Gm-Message-State: AOJu0YwZfzPFCUT1kajGRKWG2/5D2/4nBMrkaZMP91oqQh56vFDQfxqy
	Sproq1oRcYjJJ0rMVTmm42ZBsopeRg0Tx1E/Oi80zhhvw5QB7H5sPOeKyhjlCDRr
X-Gm-Gg: AfdE7cn+jXrQ0X9pH1G70NmLch6TA7PZwW3sH/tTVOR4vwSaAIDzySrweYAHxfyfWCc
	qaL6DEWg1ZlsSe3y87UvagI6XuoRbbU2BBrwAhliooHkXdLOalhgyop+PWYt0rJ9QqaCPqj7ebP
	jD6yBzDLRurDPk8gbIjgCjMYwjcPT59vcguVkMlgFShuo/uMsm8weEcDO5iy1liG6tF9RGNhDwy
	4vSwMnruDG/1RczxbQeFYQTcEjUQM6n1MjlAB158GbScd2SnXOjBXGAFMwAvm0QjCKoIWFwCcdV
	SGAVP+ISHosBNLK7ePd7S8HiU2axU8zELF8lYy49SR4qH8lrb/TvsaIUEfuDhXzN3LIK2AiAqu/
	d63PzyRnNkm/eT4/hA+zEvbIzW9kdrRTN9+0Kj1yHL70hmaLxPuXSU2AS2Qj+maYD3FXjbRFW+H
	SPBJcB9TalHR+Ayw5Keg6GA8WzArsbKuzhdEdOl9PY0B5pBbqkYBNmdGgLFcyVT5+M4UFJ
X-Received: by 2002:a05:6000:2486:b0:473:f495:4a44 with SMTP id ffacd0b85a97d-47df0800aebmr3901440f8f.41.1783533414510;
        Wed, 08 Jul 2026 10:56:54 -0700 (PDT)
Received: from Mac.degu-bleak.ts.net ([2a07:7e81:8205:0:5dc4:6779:6584:5b39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm48061787f8f.7.2026.07.08.10.56.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 10:56:53 -0700 (PDT)
From: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
To: connman@lists.linux.dev
Cc: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
Subject: [PATCH 0/2] Prevent abort on non-UTF-8 data loaded from storage
Date: Wed,  8 Jul 2026 19:56:48 +0200
Message-ID: <20260708175650.16177-1-giuseppe.eletto98@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While investigating a connmand crash loop on an i.MX91 based device I
found that connmand aborts on start with SIGABRT raised from libdbus.

The global settings file contained a WiFi tethering identifier and/or
passphrase that were no longer valid UTF-8:

  [WiFi]
  Tethering.Identifier=@?????
  Tethering.Passphrase=PW\215\301\252\252

technology_load() loads these values and append_properties() hands them
to D-Bus when the TechnologyAdded signal is emitted. libdbus aborts the
whole process when a string that is not valid UTF-8 is appended to a
message, so connmand crashes on every start and cannot recover without
manually editing or removing the lines from the file:

  Aborting (signal 6) [/usr/sbin/connmand]
  #6  libdbus-1.so.3  dbus_message_iter_append_basic
  #7  connmand        connman_dbus_dict_append_basic
  #8  connmand        append_properties
  #9  connmand        technology_added_signal
  #10 connmand        technology_dbus_register
  #11 connmand        technology_get

The same problem applies to the WiFi service name, which is also loaded
verbatim from storage and exported over D-Bus.

This series makes connmand resilient to such corrupted data by validating
the affected strings with g_utf8_validate() when they are loaded and
ignoring the invalid ones. Values sent over D-Bus are always valid UTF-8,
so only corrupted on-disk data is affected.

Giuseppe Eletto (2):
  technology: Ignore invalid UTF-8 tethering identifier and passphrase
  service: Ignore invalid UTF-8 service name

 src/service.c    |  8 ++++++++
 src/technology.c | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.50.1

