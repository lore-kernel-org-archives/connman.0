Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB355764
	for <connman@lists.linux.dev>; Tue, 13 Feb 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830274; cv=none; b=I6KQwGlrZILB3KV+CUvykqb8dbxXX32Qg4BvxrSRhz1DoJlOmysCG9tUjGikvx/+tkKwNCSX0ndo7P2UWU/cEYwyrHwGQWjLdZqzZqBulJ7Tm8sDVWUzexLA/AY8i6vX0QMlNTngMc5bKshTM2ibjKhOMEEy9cO5z0HzVu3kswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830274; c=relaxed/simple;
	bh=Wuqb8naqBurWD9R7E/+zTAG7syKah97ArWOMZYfgRjM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=j4ZfR6bfOI5ONSMAT3Va0clwWxIah52MSOQAMz9W0kep4vFx9b7fb+J0uvDRj3fUTg+vqaKZX1HLQhdJ0pmnbyq3CW1DnrHmbm/uWYbUX5rKRynMUjRocZZsl8oMTPzuEcAkZZGpESza3cKv80bBatNFhBlIwYVFPaMSt0EGcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b=ODF9mjQ+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b="ODF9mjQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707830270; x=1708435070; i=rtie@gmx.de;
	bh=Wuqb8naqBurWD9R7E/+zTAG7syKah97ArWOMZYfgRjM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=ODF9mjQ+Lg83ztxdZ9nwNLoKVIfvYibBqx4a1xPMcIdh4g9JRT2vZwm0f0fN07o1
	 rs5uiCYWIgxouFyZundosYWJHwKAIvIpvI2ECPSA0/8jmKZPaA09aX3ot11aOpvMh
	 srp1yjOd8NUBv12PajssR8XGsP1mD2Ex/PEeocNqYnKwRY06ysflC+zKuqXptqjij
	 7eS2mk32CClYVZtBiPJz/6dPDugKY7VhhcJfl/S7aMmWJmpabC7tbppWs/+UrjAb6
	 bk6nCVxLEtFcFuxxQxAgdnRQGqhOGmbkgMysCQy6R4d9yggMNeYgJpza9jcMFLCBX
	 5crWNi5G9sK8QUcTUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1rQQSC16Hq-00R0wD for
 <connman@lists.linux.dev>; Tue, 13 Feb 2024 14:17:50 +0100
Message-ID: <c1736788-7a9d-4064-8bd5-31b53fb575f8@gmx.de>
Date: Tue, 13 Feb 2024 14:17:50 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] wifi: Fix indentation.
Content-Language: de-DE, en-US
From: Robert Tiemann <rtie@gmx.de>
To: connman@lists.linux.dev
References: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
In-Reply-To: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y5TyjY0TnNSakx5LYD7Pf49Qh1He85tEDonbDbqGy7YMYqUyNud
 Rg49w9V/9JM9sNkbtVuP6wF/dQN8yhVQDB567AFsSfnGcfXuuY2EnIbA0624uGZfrbLdjLz
 o9xPJfniq/MiZZyXh9bfch/M4yg4E9OUsF2Bk6Wotug0bY7Cxqt3e8szHMUuTWhJp65iJU5
 0vEaDq6Ks3z4x4FJFKI6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZKfbG2fQtfE=;Yyt/XUcEDbackN7ivHmiub1e51N
 oidtRKpTM3T/yAPmyqZ0UDAYDEU/C48jcPtpfmzs/Ok2UnlmJ1NvlRj3tF9kfQtS75SKJj2+k
 DwO0YIsB83FHC6bc8CRExLK4TAm4HadbMpnAx+2FRjZR7WJJkyORei1oF1U4rRxqPyOJtzwkf
 aYooq1SxuaI/VAD1SqHh5Si0eNNS4WiUf9MhLqZSamKMLKzZ2vae2CG80JpDH/UOYVaFmmQQ0
 ejqlQtuY8mrBl9EvCq8uYO1G7GVVPWIZ5P1Go/sqdRsJrOajis72bZ7dMgXZq2x0YRa7mtlES
 P2FNKsk2CGrxljhVwKuajEDqoqAVz9K3RN/+DMT5YS1eBzJu8vemrTLlA2yOLBhC0zKxZnxr0
 2L7l0FXmYYf9zeXdo81oLqvJYzv7NFbhElLnzngDAlzKMZaLKKvG0UHN9iuQi/Kh9yMw5YhgK
 9a4d0xnC3Iht+12SKU6F2pHqowDrm0z1nniviF9tii8yINWX29CyUQYi0GFHS3LZZYgIRIRKq
 gIU12j7tCucnu782vBrnb6D2ewaKzjyouYq6wH25yiR9ewimCmvMvzcX/kv1+Z2GUHfbx8KaY
 XpZBpErzQSBcZFg8lNlziWMIR0AzjL/gKC/lZBtO9PtY+TmAxojLQhGLcDT+5LGCu41gWLITK
 bfkGGtgtqvxMnwXXf0StQwHx7oLx8IJl9PDnaGpeUHVHkHMYu22Oj/U9OdvRCKNapHO4oCrhU
 zhJafj23pB9v5+nE+/P7voNo0JWBVRKLJgIcArEsJomUUek1MQSrL4Vb7TE7BiHyvfH3/wZVy
 FKqxnCD7fnLDYia+trWMt5+Dvpdv22SpDX/D+JuZZdZAI=


=2D--
 plugins/wifi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index cc30d258..12389fa6 100644
=2D-- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -3405,11 +3405,11 @@ static GSupplicantSSID *ssid_ap_init(const struct =
connman_technology *technology
 		ap->security =3D G_SUPPLICANT_SECURITY_NONE;
 		ap->passphrase =3D NULL;
 	} else {
-	       ap->security =3D G_SUPPLICANT_SECURITY_PSK;
-	       ap->protocol =3D G_SUPPLICANT_PROTO_RSN;
-	       ap->pairwise_cipher =3D G_SUPPLICANT_PAIRWISE_CCMP;
-	       ap->group_cipher =3D G_SUPPLICANT_GROUP_CCMP;
-	       ap->passphrase =3D g_strdup(passphrase);
+		ap->security =3D G_SUPPLICANT_SECURITY_PSK;
+		ap->protocol =3D G_SUPPLICANT_PROTO_RSN;
+		ap->pairwise_cipher =3D G_SUPPLICANT_PAIRWISE_CCMP;
+		ap->group_cipher =3D G_SUPPLICANT_GROUP_CCMP;
+		ap->passphrase =3D g_strdup(passphrase);
 	}

 	return ap;
=2D-
2.34.1
