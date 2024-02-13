Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BD55780
	for <connman@lists.linux.dev>; Tue, 13 Feb 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830105; cv=none; b=BwQL6bCdjSmci1JxE4pXnhS1p07jO7tRejHDPyRk9wrmXapCkfcUmZGlW5oV3ZbAL9iYTNXPkDdLJWUeFY0bsLX9Z3c5FXSCs1RbWHtaQF7YfRk+Hrrzm/x8OuXEq5yc5iImJ0fean+kH7/WVxp7C+D8v2k2DzNybADHNepeXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830105; c=relaxed/simple;
	bh=npGgP6+Rk/C3isaZP8f27uWoCroQt20BkJLsVtTLYnM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=oBJtuDBn+kCJ2RbWuEf3DLMDOHMLhB2RVVQqeNLGZP/xuD5ghdkW2wuYL4AhvNGtpcPfj/O9SQCFnN5sNrjs6vCnab8pZ7X2kX6fvlnxe5mSPxMDQ3JX894JgzRKTNCv+u43hwB9IyNq/nfJaQ+quQdhucQwvGOPP9xsREikmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b=noCdMewT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b="noCdMewT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707830101; x=1708434901; i=rtie@gmx.de;
	bh=npGgP6+Rk/C3isaZP8f27uWoCroQt20BkJLsVtTLYnM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=noCdMewT9uXi7EvIiHhfL9HV0Ph0lrqQm3zmC+WEkkJ7ij22T7c7Xcz71aJmK8fT
	 5qS5nq5Ea1S6CVFrr24ABrWm2stau9gBAIKZrslIKneDopsn93IzBUTP+8TQOn/g+
	 daufpKIv7cLRL14MAWEk+JpsPmTTZHzl9rKjjrs+PUYrRL4IICqOT/Ad1eQNewbB4
	 I++cr3ZstytAZxTDzRObbRKoogbvgLBs+DwX8Q+GUg4gFxSFbipqam0kXNJZ5XeSs
	 lDJc2BTXMn8df+PW3ghwbYRTpCh0ZJ0Wz6Mmz5XnMzibv+/MR4IAjurzblXWmIGsx
	 AS974RfZtKGzD+chVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1rhoik2dlr-009l4e for
 <connman@lists.linux.dev>; Tue, 13 Feb 2024 14:15:01 +0100
Message-ID: <12ba9a91-450d-4f40-9178-df2c2fca214f@gmx.de>
Date: Tue, 13 Feb 2024 14:15:01 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] wifi: Fix use-after-free when tethering is disabled.
Content-Language: de-DE, en-US
From: Robert Tiemann <rtie@gmx.de>
To: connman@lists.linux.dev
References: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
In-Reply-To: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hGhGU0zbopGPpdnN1/nK63s7Yc/4f69FEV8DttiYVGguXeFI87B
 /3oki9XLHDvv5VFWaCstMxdG8XZ772uHhs2CWerjh7B90+V4wQjBSeYUvDFenWCJUmS6unG
 R1Pwx3HfuPY9lGcxhqA4UcBq+85DbYutI1AtJi7Ys1vZS9QlNQXHDwp5dGGVz2+FMleJ+yh
 GikK8I6zHpGMsFgCyHf7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RjhHllwCrZQ=;U3vneUqX5rpVak7kCKy5uIkOWmK
 Z8qKez1Rxk1FR8t/Oy0bOy1h6Vx+VghEvCytUMW7JjGJROX3n0i6q1QrU1SxfOG0j3r4Ono8z
 x8XxzXNMBASL/qV9kSODGr7DTS8gd03txq7EfZDqgnoJjrzMGo5jDRD4bqcBZ71bK6fovb6n9
 BYrWTOds3PwEH3hWoG7Q9QJwKsCgLzKmWte1qgWIzbaC+/R/6oLJMWZHqt1Cua7WBA4Oge0lu
 CxDFGgb0Kymw05dGza07wc4jwAyPn7MOUXbQS9CI7hddJV8h6K+VlhH9jneB7QWD2qXHTe5Wm
 MqbaKu8HPzPFsdmeMyajUW0elLJE55aECy/Smbu1aqvgNP7/Vp4zGdAjZTaymIH3/Wjhwr1Zl
 H3J+2WO8U8OjNe4dP2ul2IxKrV9cXcfiMN31rinP/EInVTts/19maGPdXGFDlybdYlo3CJOQg
 TQdPjkjJjcO/woVYcMtcsQaTG3dOu5LBAjndPeHg/TcxA0NBPX8oKrYqsauOqhv7ohh1cpDvO
 YArvabEAFrR+wCEZxncvdAkNZnKsJbq/k9V1nOddkxUDkn5ai1AyA1SbjXMZOzFGNv56icDCM
 J4VYfkdDBdgU6IRyll/z2sodl0ehF92bBeDjRlADaRWrBChsNohHWY+6rJgX3plpTqu3KrNSb
 33Z9HUk5aOL3olIgoOyC/Uc4O8qnkbHZ7/occ6dPXc6dmf7wc3PGBH0fXhMjRWdlfpYyQJHoR
 E763WZdq694FXNJSYfstepiivs8kmAKnKbswcH2Zwxu5FeT6pS1CK2ybVW9s6svi/xdKE3nfm
 njgILI2yb+3RVmkrMdwRsxhqTpUN/0VpYs21SNg6W0ibE=

The bug frequently causes junk being written to the
Tethering.Identifier and Tethering.Passphrase entries in the settings
file. This in turn prevents Connman from starting up at all the next
time it is run.

To reproduce with connmanctl, use the following commands:

    enable wifi
    tether wifi on MyNetwork ThePassphrase
    tether wifi off

Then have a look at the settings file.

Disabling tethering causes a call of remove_ssid() from
interface_select_network_result() in gsupplicant/supplicant.c, which
frees the SSID and passphrase strings of the given GSupplicantSSID
structure (originally initialized by the wifi plugin). These strings,
however, are shared with a connman_technology structure, and they are
accessed in technology_save() (called indirectly from set_property()
in technology.c) after they have been freed.

To fix this bug, the affected strings are copied into the
GSupplicantSSID structure instead of simply assigning them. We make
sure (1) to free them in case supplicant didn't take the
GSupplicantSSID structure due to an error, and (2) to avoid double
frees in ap_create_callback() and sta_remove_callback().

Originally, there were two GSupplicantSSID instances in the wifi
plugin: one for the supplicant, and one stored in the wifi_data's
tethering_param structure. The latter, however, was never used, so
this commit removes its allocation to avoid a new memory leak, to save
memory, and to generally avoid confusion.

The bug fixed by this commit was introduced in 481d08f108.
=2D--
 plugins/wifi.c | 54 ++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index ed7437f5..ba5aa2d7 100644
=2D-- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2547,6 +2547,16 @@ static bool handle_sae_authentication_failure(struc=
t connman_network *network,
 	return true;
 }

+static void wifi_data_free_tethering_info(struct wifi_data *wifi)
+{
+	if (!wifi->tethering_param)
+		return;
+
+	g_assert(wifi->tethering_param->ssid =3D=3D NULL);
+	g_free(wifi->tethering_param);
+	wifi->tethering_param =3D NULL;
+}
+
 static void interface_state(GSupplicantInterface *interface)
 {
 	struct connman_network *network;
@@ -2568,11 +2578,7 @@ static void interface_state(GSupplicantInterface *i=
nterface)
 		return;

 	if (state =3D=3D G_SUPPLICANT_STATE_COMPLETED) {
-		if (wifi->tethering_param) {
-			g_free(wifi->tethering_param->ssid);
-			g_free(wifi->tethering_param);
-			wifi->tethering_param =3D NULL;
-		}
+		wifi_data_free_tethering_info(wifi);

 		if (wifi->tethering)
 			stop_autoscan(device);
@@ -2832,9 +2838,7 @@ static void ap_create_fail(GSupplicantInterface *int=
erface)
 			connman_technology_tethering_notify(wifi_technology,false);
 		}

-		g_free(wifi->tethering_param->ssid);
-		g_free(wifi->tethering_param);
-		wifi->tethering_param =3D NULL;
+		wifi_data_free_tethering_info(wifi);
 	}
 }

@@ -3387,7 +3391,7 @@ static GSupplicantSSID *ssid_ap_init(const struct co=
nnman_technology *technology
 		return NULL;

 	ap->mode =3D G_SUPPLICANT_MODE_MASTER;
-	ap->ssid =3D ssid;
+	ap->ssid =3D g_strdup(ssid);
 	ap->ssid_len =3D strlen(ssid);
 	ap->scan_ssid =3D 0;
 	if (freq)
@@ -3403,7 +3407,7 @@ static GSupplicantSSID *ssid_ap_init(const struct co=
nnman_technology *technology
 	       ap->protocol =3D G_SUPPLICANT_PROTO_RSN;
 	       ap->pairwise_cipher =3D G_SUPPLICANT_PAIRWISE_CCMP;
 	       ap->group_cipher =3D G_SUPPLICANT_GROUP_CCMP;
-	       ap->passphrase =3D passphrase;
+	       ap->passphrase =3D g_strdup(passphrase);
 	}

 	return ap;
@@ -3423,9 +3427,7 @@ static void ap_start_callback(int result, GSupplican=
tInterface *interface,

 		if (info->wifi->ap_supported =3D=3D WIFI_AP_SUPPORTED) {
 			connman_technology_tethering_notify(info->technology, false);
-			g_free(info->wifi->tethering_param->ssid);
-			g_free(info->wifi->tethering_param);
-			info->wifi->tethering_param =3D NULL;
+			wifi_data_free_tethering_info(info->wifi);
 		}
 	}

@@ -3448,14 +3450,10 @@ static void ap_create_callback(int result,

 		if (info->wifi->ap_supported =3D=3D WIFI_AP_SUPPORTED) {
 			connman_technology_tethering_notify(info->technology, false);
-			g_free(info->wifi->tethering_param->ssid);
-			g_free(info->wifi->tethering_param);
-			info->wifi->tethering_param =3D NULL;
-
+			wifi_data_free_tethering_info(info->wifi);
 		}

 		g_free(info->ifname);
-		g_free(info->ssid);
 		g_free(info);
 		return;
 	}
@@ -3483,14 +3481,10 @@ static void sta_remove_callback(int result,
 		info->wifi->tethering =3D false;
 		connman_technology_tethering_notify(info->technology, false);

-		if (info->wifi->ap_supported =3D=3D WIFI_AP_SUPPORTED) {
-			g_free(info->wifi->tethering_param->ssid);
-			g_free(info->wifi->tethering_param);
-			info->wifi->tethering_param =3D NULL;
-		}
+		if (info->wifi->ap_supported =3D=3D WIFI_AP_SUPPORTED)
+			wifi_data_free_tethering_info(info->wifi);

 		g_free(info->ifname);
-		g_free(info->ssid);
 		g_free(info);
 		return;
 	}
@@ -3563,9 +3557,6 @@ static int enable_wifi_tethering(struct connman_tech=
nology *technology,
 		info->ifname =3D g_strdup(ifname);

 		wifi->tethering_param->technology =3D technology;
-		wifi->tethering_param->ssid =3D ssid_ap_init(technology);
-		if (!wifi->tethering_param->ssid)
-			goto failed;

 		info->wifi->tethering =3D true;
 		info->wifi->ap_supported =3D WIFI_AP_SUPPORTED;
@@ -3584,10 +3575,13 @@ static int enable_wifi_tethering(struct connman_te=
chnology *technology,

 	failed:
 		g_free(info->ifname);
-		g_free(info->ssid);
+		if (info->ssid) {
+			g_free((char *)info->ssid->ssid);
+			g_free((char *)info->ssid->passphrase);
+			g_free(info->ssid);
+		}
 		g_free(info);
-		g_free(wifi->tethering_param);
-		wifi->tethering_param =3D NULL;
+		wifi_data_free_tethering_info(wifi);

 		/*
 		 * Remove bridge if it was correctly created but remove
=2D-
2.34.1
