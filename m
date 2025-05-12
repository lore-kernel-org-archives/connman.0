Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B51804A
	for <connman@lists.linux.dev>; Mon, 12 May 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039954; cv=none; b=U/jfrdRbOzK+xc7Qi7qwTAhpRaDxHv1DaCbvQZgFEbZZUdRgRkN6mZtHXHXGvtollKYfX7w+NF5xVdRvl5yOhm9diR1zbcLRiun7rJghMv6VmxBiLACR7Ktvz96ikZVTaJdR1Y8sDFAKeKXafyh1OMsVnX+VPLMAiImU7U0/bOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039954; c=relaxed/simple;
	bh=AcXZQ22yLKXgCEovwUclU9TpKyczsUirSww8be8znns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKglVZE8xAn+B2klwxLg2q+48DXKZZcHKfRWsybXkjZYcS10wkA4e9/aM7ChEFLKEet2ewibF9F2oUn7ncpfv1IuoI6TPSlsGcMSBnkhEgHMPdoi1CEV53doNK+xhqQMo+l9ZVNUv1srneO8IibL7kjAR6u2WWPibK3ek1j/hXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=UyosieGF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UyosieGF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1fa0d8884so1622013f8f.3
        for <connman@lists.linux.dev>; Mon, 12 May 2025 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1747039950; x=1747644750; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCHuii/5P9vkIno5BOmBYrrXv2T45rLinxAOuKOdNko=;
        b=UyosieGFNGHFBYQ7KIC2lXO4/S3bqBoDusdw6I87+RrA89Lq2QEczhiiHmjiJ8bEpR
         +ozLoMs9IyLJqRNNS4mgppEP4SlA60r+SC2BVzjY98KU69gmV35I/hO4KDYpqZYh5spe
         7SrnqWFJm3gOm4Lc9g1CS8lUb/nC42utJOyzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747039950; x=1747644750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCHuii/5P9vkIno5BOmBYrrXv2T45rLinxAOuKOdNko=;
        b=Wl1GyqV6NS4iuJUfBj0J55BVbbFOPyN4zuWz8ce3UPqUzSlhds9dnB4uQnSHBunz3J
         zBqU72De9+Rx8tlu5peQYaax9JoRO469vAzFXRW7wxwRHQEatZ7Aia5mTgNkkmYLUeGZ
         01t8K1c6IvxyolZDuY8vzdE8LvpcUJzLTVi3S1/JYtptMix9PIz9u+W3uNFxejdGPcKz
         EJscpwxamQxzMglSV3/zLowfhVCLOxgfW8UsfqMu4EtVO5424aYsRdvWB0uuEMxryUQf
         q11sCNZyJzJyirWgFTcCrFpVjadZHouFeFzr7iqOPtF5RPKPxB7W1i3O+nBZkH0Q7s4M
         bkIg==
X-Gm-Message-State: AOJu0YzO5xsiz9YRN8JoVJT9sbROb5r/4j8G4+2uzeZqhWfIVzkD2aVA
	KZjX+N8aagzWsDvkwaLWaGOJ50g5pTsTPnvt3aBOuR5Rh6Tb6fIsboi2fcYwunbd/Q74HPt1WTY
	zIWgv4oxJ
X-Gm-Gg: ASbGnctxZ7ORdXKqRgzYVw+pNlaLMHeFqHF7p+StAvFuzxv/BiEE0PAiQtbDcMkMXca
	FtX2hbrCwkq/4Lt5HUxs1pe/28aDzA/qfdoQ0OTgLV4/cfEvy3qyfv+Q1j1567JKUHa2ueIK2V6
	7BYRu1cdHBU+VSZOMzE2wLqYHjqLN/kWTxoAEHCL7yttEV8GfoPViX6lc/xSlMM8ADmKDurUiK/
	FI7gQoLjfQy8zwmEMxo6guGX0FqBGAEw/TrWMAxuwCTtWLj6VdVv5+NOICVKoD53gl4Lk7gEF4A
	JWfblX3Fs2UsKh8hEqH9fhNcJsoeC74QaHgtRi820sfgepNcconiJCFUJW9Ho1tMcso7FrQNunR
	RiHsyhs+L6AzYM/UeXRQEaPBe+g==
X-Google-Smtp-Source: AGHT+IFAcn6h2vlgLIOSttTENQw8LZvZuPMVE57EE9Db85TQherDTqUDDwirUNVSt3oT9/lWQ8GGBQ==
X-Received: by 2002:a05:6000:40dc:b0:3a0:6ae3:a1a with SMTP id ffacd0b85a97d-3a1f6446d0amr8601845f8f.23.1747039950617;
        Mon, 12 May 2025 01:52:30 -0700 (PDT)
Received: from panicking.fritz.box (p5b26784b.dip0.t-ipconnect.de. [91.38.120.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ca47sm11752878f8f.73.2025.05.12.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:52:29 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	"Dembianny, Sven (GDE-EDSD5)" <sven.dembianny@bshg.com>
Subject: [PATCH] gsupplicant: MFP optional for WPA2-Personal
Date: Mon, 12 May 2025 10:52:23 +0200
Message-ID: <20250512085223.411606-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dembianny, Sven (GDE-EDSD5)" <sven.dembianny@bshg.com>

Previous MFP support was restricted to WPA3, however it is also possible
to set MFP to mandatory on APs with WPA2.

wpa_supplicant config:

* WPA2-Personal: key_mgmt="WPA-PSK-SHA256" ; iee80211w=1

It is important that the default value of MFPC bit is 1 on the final-commercial
version of the device. It is a mandatory WFA requirement.
---
 gsupplicant/supplicant.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index f3be9e7b..2ebfa2c6 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -4955,6 +4955,7 @@ static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
 		add_network_security_ciphers(dict, ssid);
 		break;
 	case G_SUPPLICANT_SECURITY_PSK:
+		ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
 		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE) {
 			if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK) {
 				/*
@@ -4962,15 +4963,16 @@ static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
 				 * WPA2-Personal (PSK) and WPA3-Personal (SAE)
 				 */
 				key_mgmt = "SAE WPA-PSK";
-				ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
 			} else {
 				key_mgmt = "SAE";
 				ieee80211w = G_SUPPLICANT_MFP_REQUIRED;
 			}
-			add_network_ieee80211w(dict, ssid, ieee80211w);
+		} else if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK_256) {
+			key_mgmt = "WPA-PSK-SHA256";
 		} else {
 			key_mgmt = "WPA-PSK";
 		}
+		add_network_ieee80211w(dict, ssid, ieee80211w);
 		add_network_security_psk(dict, ssid);
 		add_network_security_ciphers(dict, ssid);
 		add_network_security_proto(dict, ssid);
-- 
2.43.0

