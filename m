Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0877482DA
	for <connman@lists.linux.dev>; Tue, 13 Feb 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830222; cv=none; b=p1gYvGg9AZfWPl5asWOAInlhu7et48zD72fJJL9YCBhz9NBl5vqNsHwgTgxXiX/v8CE54yVPOTCZmZ+9rUW590aMGD5xAjKaK3KB8o667xW02s9ZkINGrjQlTdPJx8nNgkCJQLfkk/THAnqrn0JRg59GCEpVjlU80EnF2FOI19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830222; c=relaxed/simple;
	bh=LaXy4T26A5SE9xNEQtezsL4DDEMqs7dFdDxEtm3QJvU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=aimkJCd/6cTMZ4ESiFS+zbVvY4QfR/DzEznEAAvEQ5jbIQZidJtpqzNl6UmHJgJa9SaLUoeAykoloqvlcfYaHiRa5O/kRIKYiHpI8HhA/XZwCxKrsiS0gMgvFCDKXd/rqtdXdCJEAZgLfCc39fhXnehjzmtV5SPq9QOMViDQpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b=CjsqPWZk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b="CjsqPWZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707830218; x=1708435018; i=rtie@gmx.de;
	bh=LaXy4T26A5SE9xNEQtezsL4DDEMqs7dFdDxEtm3QJvU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=CjsqPWZkLBaIy+Nb+iZxUeUFnwvHC/ozd7zhadOL2cEROumODak3RT+kV8SD6ne4
	 wyommdRArGj5aWOIlQa+jzU5misaL7K7hvSlvTIl/0QZqeWAqWbXy/jQIL7dZpiIe
	 XEGGy/t1IDEayNQ7mWrbdcEAUz4L8LBxgsn3SiGRsgTIUMrbywQoJsge/je5Xbe5k
	 xiqlzNGj7CYDnh6ZL/pG9s1W7fLdH4eDzRCl6+RF2rg0nYW7iFRTtwQmHQjbjfHCX
	 +LU3hoTpYNpfMY7OHcwEgBBLS6gBQ7a5+JFno3jWBmMqoj8FttE4+R1mRArVjwV5s
	 MlbHnmeYUmtfMz3krw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1rEHIU3hPL-00oZdc for
 <connman@lists.linux.dev>; Tue, 13 Feb 2024 14:16:57 +0100
Message-ID: <faf0afbd-8241-428a-ad9a-f284d915ffa2@gmx.de>
Date: Tue, 13 Feb 2024 14:16:57 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] wifi: Fix memory leak.
Content-Language: de-DE, en-US
From: Robert Tiemann <rtie@gmx.de>
To: connman@lists.linux.dev
References: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
In-Reply-To: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KmnMi2xKmupayvALgsR0hTmOKd65QqphZppvYKK5f/LZyqvfHVW
 DC7K4ZvFUtmyfwjLNWPFP3TRD9E2c8aa0bjrvPYXr3FJ6D4i3Yqtl6su4B4h+gvnUskb73q
 HCiOoF0ZLYlZ+bjFY9KrGx4AQoTlcBFZr4vlHBLDQmy7EUUIh34C/Ck01NB5SlTtd9w1mdh
 KT+A/WaBxAw2up6mbCQsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q/UGr3YoHXU=;OPnywG5yjQhpRu9mgAVU7Um4LuY
 x6401mD2c8stSO48zJojl8/3gs/qrUXlnlyEDZZhQN2qt8+Pq34IrR8b2rGyeruVjPnitba87
 oNgllxkbEirrfcM9AxpEhRFfT9BnoGosA9b5eB8cMIipyIexTvkzPfXPiuFqhaVsR4rhKD5OH
 RpwlvDhcI3lTsvVnIYLtOSvI1RUkkLYg0I1/UYGuRonV9kRBG9gl7z5gZAFhzJAvrOM6itxo/
 JnUHEqtDTgpmeMnnNSkNdqh5Cl9CdogMjO6p37cZ6yMFfVxa8cxgQoEejQxRqPwFHM7e6i19T
 pUc+0sLK9SrGW+o5814TtSRhxc2KbGjWWg1kDPRSXG+9kQwxeB4OogAekln7GlVfjnyaWrB/c
 ck62IMEPxRdv32h5htpka95knvIR1WJY2+C/cpjVpuNvi2Cxc5gn5EkWqB1FOz7C34xcURiQU
 Z78VM1yQsB65wqaxynfgNU1Ft62mGUb1izoOohni3GrhO1Ai5y86ro3Kz9myUkysPu+EpAeyX
 9JNYHcSQzrOunb5MoklfjoxXVCDOG0raS7Lc2LGjb5O77s6mhvZAQPzJwBU1yS4+XfMNy3L21
 yfff4xnBdwzuPaYi9UOmVuuTt7o6j+Cm8HOGOlr1IzfgGzyoaL7kiLHKJ6Khk91fG6t/L3Onu
 a+nrqnO619WnvtNvz0CfdKISIat7vqPecXYZVAe0Y1hIIhtLOVfOgJXmHTn8WnfbpH2eSUGk3
 mf62F+Quj6NRAyprte8Rc0LpX6cVUhYFiFEGGcle/meZUujLxTxh8oepjJYMRwKJOsielVf6w
 gyaYflL/M/EoCCK1k+ZqHTAf/H8pSeiwfotxS+zuwa9fE=

A GSupplicantSSID instance was leaked in ssid_ap_init() in case
connman_technology_get_wifi_tethering() didn't succeed.
=2D--
 plugins/wifi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index ba5aa2d7..cc30d258 100644
=2D-- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -3387,8 +3387,10 @@ static GSupplicantSSID *ssid_ap_init(const struct c=
onnman_technology *technology
 	ret =3D connman_technology_get_wifi_tethering(technology,
 						&ssid, &passphrase,
 						&freq);
-	if (ret =3D=3D false)
+	if (ret =3D=3D false) {
+		g_free(ap);
 		return NULL;
+	}

 	ap->mode =3D G_SUPPLICANT_MODE_MASTER;
 	ap->ssid =3D g_strdup(ssid);
=2D-
2.34.1
