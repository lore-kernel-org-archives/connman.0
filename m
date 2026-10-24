Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792864238;
	b=iw+331rJa0Fbg0OQaTXNPlMP8lCZgxnvwvCQUGKkGYL//JKCgjSqJOOatCy7+3wDR12T
	 UThXLgGi2vNJRrakmRLwXB1pjbi3UToD9T4EaMI/qhvz+E2Y0wOqBY+gqId9mIbInRxy9
	 bVTiETo5be3fboAt6BOaSncPdcOfine+0dQ56eG1zm9a9t0WCsXjjn62a0NTLnyqiFVHg
	 pj4AIlkoHVGHoBXBAttTtvBjJEa+HnSDeYh2DOzXZCHwB6Rsl+qLOKPc7L6fMZH22qJM9
	 lfKbCiEu5XhcmVSjSC13jSJ9j1N43pH1CVlfsP2VwHAiFeMyYeVsSNRbIyfpy7d1k1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864238;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=4KfQ7rmB70694T+fUBlWSvV1ivsb2HuMHMaXkI3k2A4=;
	b=0tMAh6xFe7kjbQcrhxxR53wYplR2mf5N43qkNXWqmfT7mxykHVimuW3e+m2bBBm6/djm
	 fgxgqpS7SVuBZ3q0hf4RspcfGLEcDwGFoKa+8UhDPIKcfEwMKmTuXlGUC3tgsXgD+6hmG
	 Y8FtYGCnW+LrLit2ZtvJCHM5yDkN+BmKrY+iItnyW/wVboKf9NF2LGw5nDI7tqVF1X5lw
	 dAT7fiss3StgUey6YJzwlK2P91Y7vaPpyYFlpXxZx3XGK6QANGRSeOSHUBHkyHFOBM/M8
	 XrQCriU6IR1igTcrekphdsoE/AQ7AfrdGpC577HMFvh08EOt06rIpB1aomObx7N8UwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=nzRehv9P;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8B606A31A
	for <connman@lists.linux.dev>; Sat, 24 Oct 2026 17:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=nzRehv9P
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 71C53160078;
	Sat, 24 Oct 2026 13:50:36 -0400 (EDT)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EFF66124E45;
	Sat, 24 Oct 2026 13:50:35 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Subject: [PATCH 1/2] gsupplicant: Own a copy of 'alpha2' for the life of a 'Country' set.
Date: Sat, 24 Oct 2026 10:50:32 -0700
Message-ID: <53431ec7faf3a879d4baf3661c8ac1f8e8238d5d.1792863816.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792863816.git.gerickson@nuovations.com>
References: <cover.1792863816.git.gerickson@nuovations.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=4KfQ7rmB70694T+fUBlWSvV1ivsb2HuMHMaXkI3k2A4=; b=nzRehv9PEJ6cAQnnWlk2HBztwDJpn16SVyn1C0KDAFWWvHpvOfn6bZvu9EJVkckR2+WdISVb54+ZnYVZnTctzt2nJMlGXacbSWdCpAHJhqtOL7kLdCyE4Zy37+DFUufVzK2nqLMdRF4+wjKRBq31EJg2uo2bEH8q0MdR0M3Krxaxo9S1zjuwUy5mGJ6lmA+RJZmHytR/TbZLWr1EwacEqe43gG+PNovFVJavwbqZnFZgjNZybtPlDglwufX+nfEfKaf+NYmSDVCiJHw6vyDeG5vWWis/kokgU1z9cdXf6tG2NRnSGtx35gGDYgMPryHs+w/12KiskZdvMvJacHjtcQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

'g_supplicant_set_country' and 'g_supplicant_interface_set_country'
stored the caller's 'alpha2' pointer, without copying it, in the
'struct supplicant_regdom' request context, and 'country_result'
passed that same pointer back to the caller's callback when
wpa_supplicant answered the asynchronous D-Bus 'Country' property
set. The string therefore had to stay valid for the whole D-Bus round
trip, and nothing ensured that it did.

Since fe9307c987a0 ("device: Setup regdom when powering up to maintain
consistency"), 'connman_device_set_powered' passes the string returned
by '__connman_technology_get_regdom' to 'connman_device_set_regdom'.
That string is the technology's own 'regdom' (or 'global_regdom'),
which 'connman_technology_regdom_notify' frees when the reply to that
very request arrives:

    connman_device_set_powered
      connman_device_set_regdom(device, technology->regdom)
        wifi_set_regdom
          g_supplicant_interface_set_country      /* borrows it */

    country_result
      wifi_regdom_callback(result, technology->regdom, device)
        connman_device_regdom_notify
          __connman_technology_notify_regdom_by_device
            connman_technology_regdom_notify
              g_free(technology->regdom);
              technology->regdom = g_strdup(alpha2); /* reads it */

So, once a regulatory domain has been set, for example from the
cellular network by the oFono plugin, connmand built with
AddressSanitizer reports a heap-use-after-free and aborts each time a
Wi-Fi device is powered on again. Built without it, connmand may store
a garbage regulatory domain or corrupt its heap.

The borrowed string can also be freed by a call other than the one
that reads it:

  * 'connman_technology_set_regdom' replaces every technology's
    'regdom', and 'global_regdom', synchronously. A new regulatory
    domain arriving while a power-on request is outstanding therefore
    frees the string that request's reply hands back.

  * The timezone module, with 'RegdomFollowsTimezone' set, frees its
    'alpha2' immediately after passing it to
    'connman_technology_set_regdom', which can hand it to either
    function, through 'set_regdom_by_device' or the technology driver
    'set_regdom' method.

Make the request context own a copy of 'alpha2' for its lifetime:
duplicate it when the request is made and free it when the request
completes in 'country_result', or when it cannot be sent. The D-Bus
message already carries its own copy of the string once it is built,
so the callback was the only use of the pointer after the call
returned. Every callback now receives a string that is valid for its
duration, whatever the caller has done with its own string meanwhile.

Fixes: fe9307c987a0 ("device: Setup regdom when powering up to maintain consistency")
Fixes: bce73f1bdbf1 ("timezone: Change regdom along timezone, use localtime config")
---
 gsupplicant/supplicant.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 5e2899536d76..134147229be4 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -3690,7 +3690,7 @@ void g_supplicant_interface_cancel(GSupplicantInterface *interface)
 
 struct supplicant_regdom {
 	GSupplicantCountryCallback callback;
-	const char *alpha2;
+	char *alpha2;
 	const void *user_data;
 };
 
@@ -3714,6 +3714,7 @@ static void country_result(const char *error,
 		regdom->callback(result, regdom->alpha2,
 					(void *) regdom->user_data);
 
+	g_free(regdom->alpha2);
 	g_free(regdom);
 }
 
@@ -3742,7 +3743,7 @@ int g_supplicant_set_country(const char *alpha2,
 		return -ENOMEM;
 
 	regdom->callback = callback;
-	regdom->alpha2 = alpha2;
+	regdom->alpha2 = g_strdup(alpha2);
 	regdom->user_data = user_data;
 
 	ret =  supplicant_dbus_property_set(SUPPLICANT_PATH, SUPPLICANT_INTERFACE,
@@ -3750,6 +3751,7 @@ int g_supplicant_set_country(const char *alpha2,
 					country_params, country_result,
 					regdom, NULL);
 	if (ret < 0) {
+		g_free(regdom->alpha2);
 		dbus_free(regdom);
 		SUPPLICANT_DBG("Unable to set Country configuration");
 	}
@@ -3769,7 +3771,7 @@ int g_supplicant_interface_set_country(GSupplicantInterface *interface,
 		return -ENOMEM;
 
 	regdom->callback = callback;
-	regdom->alpha2 = alpha2;
+	regdom->alpha2 = g_strdup(alpha2);
 	regdom->user_data = user_data;
 
 	ret =  supplicant_dbus_property_set(interface->path,
@@ -3778,6 +3780,7 @@ int g_supplicant_interface_set_country(GSupplicantInterface *interface,
 				country_params, country_result,
 					regdom, NULL);
 	if (ret < 0) {
+		g_free(regdom->alpha2);
 		dbus_free(regdom);
 		SUPPLICANT_DBG("Unable to set Country configuration");
 	}
-- 
2.52.0

