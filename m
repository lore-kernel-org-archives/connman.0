Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7634699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:08:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D77085E01E;
	Sun, 28 Aug 2022 20:08:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661710087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rGWJ+0t4qkEI6ze8NhU8XrCANpt8MhMWQSTyanq5eus=;
	b=c3x9fTawyEykdULCLrNaarcUBHyu2zzgb/gVQ0sF0sqDd6oPEbWpBC60oy7g9EgzPaPxWc
	FqePkncP1vVyC05RoQ5xSYsYRFu6gFNQJyV3073+sAh8Xii3QOA05WCVnCKrB3QyIw9KCG
	U2YkNHUruRt8pwpz0HFLkW75YmfLC+1fLomgLxcD/EUd9Vfg1WnOKiPF2rM75+yaQ9eYtf
	akI08IJzlzH4EMS+InV7aYag21nuhDu5VG9IwcNV8T0Dk+ExvByeVkLHiBd1LBGXnjf3J8
	ir5EtZwY67gpeG7lGm+8aiN0c3QOE4QUlKTjdUJY8Ox5+qcTzAUA7dt4pQYXYw==
Date: Sun, 28 Aug 2022 20:08:07 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828180807.jqq26kcm7ev3ukdv@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <20220828174050.ate53trz2opzyczg@beryllium.lan>
 <20220828180009.xifu45ui3qa7pckn@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828180009.xifu45ui3qa7pckn@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3

I suppose we could make __connman_ipconfig_gateway_add() a bit more
restrictive:

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a22bb..9f17f4989ea8 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1172,7 +1172,7 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
 
 	DBG("");
 
-	if (!ipconfig->address)
+	if (!ipconfig->address || !ipconfig->address->gateway)
 		return -EINVAL;
 
 	service = __connman_service_lookup_from_index(ipconfig->index);
