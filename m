Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DE212548
	for <connman@lists.linux.dev>; Wed, 15 Apr 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248139; cv=none; b=oUHvwhQspIxq2kyff+TDDbGvBbVX3ddzLF76VpHmUlALtjLe7EiQlatT3L8es890mzLje6yjIi1kqjs8+sZ1sXgVV+DdbaCDnSE32L82dOVsPaDfGIuAF+ENQTFYEmRRIrzHa3p/NIb1MN5sfTDjRKdeFFUaTpBBp3+xgFkrX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248139; c=relaxed/simple;
	bh=jfdXwmgqk2+Trhxkw3KwcJzXs6gp2+FwDmebw0AoTfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/SFhk55xtq9wBeZGGtgjfYxMHte5tpa5FtLYkaVYS4TxVvlXgQM78RyG441NU58UBTWBRPwGw0+eiWdL38pD6VPptI/ldfh0yiAEzd+2KQLSArnJI1ms5Ev5l+HhYX+cvK4pDQkwdChJx5RfVYY3o9kbg8iP/bDRUkbYC5JRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b=kzaxXHid; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b="kzaxXHid"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso77312105e9.3
        for <connman@lists.linux.dev>; Wed, 15 Apr 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20251104.gappssmtp.com; s=20251104; t=1776248136; x=1776852936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPPX2s7PXChXT7C/CTAU7WBmYqBQVybOpxumEcPom0M=;
        b=kzaxXHidsZVqAQwm4L7RmjtWu5DnktGjZOHhJYfBXN2xsfUXxraS254BCpAqHVqp3P
         Is/kJ3/httZEJoZK9Se+sM2BOugq6+1+3f0aiBg+Icn2j2esWAqDkVcNNis08LvXlz4F
         AebOtP9HVlIEf22B5iuMCNBeZj57EZs4tVLz3UT/N3r/WJv36P13vljycDBpM97GTnw6
         JLnGgfiIMWtLOkokwTRXXjMXf9PfNQ6REfv7qsmZYh3SClZ2MoREk1UhZ8klYAIxtsM/
         k9g7X9j3cMHLq70vz6iQ4RpqidQXIMAghzywNGsyqy9CFSBXel0G6gYEAmDX0fu5bIig
         GbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248136; x=1776852936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EPPX2s7PXChXT7C/CTAU7WBmYqBQVybOpxumEcPom0M=;
        b=sE7kqSNhVifPB0vdYxEA0mS+TZO4WPVe+bm1h0e2zL80vdpFe+3IaHZv8vKkE63hQG
         9TkLHlbpnNq9BJdQztIfy7MVGO1UDEiNnx8hKIJqwFGkYIpqoG1KCCJKOG91l+EkcVCe
         1Y3aM8Uflvy5hG6lGzza+1yWq+dUXc7xwZ29SuHiAbO+pQ4b1sMslU2Odr4Rh/dle69X
         Uq5NNp02roe3ktvVIN6P6Dd4h22y4OsF0VR0UkzNv6udrmRSumaDN9vWnZsvv9m94tdr
         jwfXI7J3zuMNiWzEeWXwjKP2O/s2/1yr2DlmKBQm9dDWAU1kkr8J+cSytODZamVUaEy8
         YQdg==
X-Gm-Message-State: AOJu0YxCOTUb8KWW5Jbjs535VFDRj8wGFjSQTTDX1BiAv/ru0VDKPTzg
	1dYNQPWRQoruu0wwJ9wYzP6DWDdnUevLod6UnkeNyZEDG8OlQuWm+n3XUPzrCZrTGcmRT53RJXS
	8ZbwY
X-Gm-Gg: AeBDieuNsEe47odhsJRajwTRY5hPkQvVusgyBEVNmmeHnlsL5thbNRne7HPt+AejtQY
	DGDswX9jSP2o1kXjNJL7ENTqhZ8bvDfiXalbS7DYQXIIBhcR+LPJLVIoWFuXmFjvfZfzsTzFDQ0
	iAQTj0CTmgJ50Urra+Y3L7NEpKIc3lqXw9wXm8bN74A8MrocIgtqtuYqwAo8Wz5BSFook5Im/qR
	flbdUagpJvGCg9uyHJHik3HiZl3dGO0rpVHm5MwnhH7dCuot5Gu00lLeQcJ79ku8Xp6f76ms5Oa
	WkTs6z/8V4JtMOel2xscoewfn9ORy+kxFfIEvUGd1vVTB3FZwSxsGMQqDDrttJVbWGN5ri1urWl
	2wwL1ZvYScRl+pW7azYTZNeB4a7w0frJ8XrFouRmipgKHzhJiKMpgqQ8TJQSa+7ykM/6zVDOT9Y
	BGK2vIu/q7t5VzbAVgBOPVifN5NBjnxBfGmuV2ZICcyTdnL9Yu9SehlUi3MtfmkSZULI8fWRhAe
	ARbdUQXWRKoPWaIeZesez0k6zIINjEhzehZ5BJ08ll8j6f5/4IIRgO9It08Y9+HZtsc3XvdqA==
X-Received: by 2002:a05:600c:34cc:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488d67d882cmr300592325e9.8.1776248136251;
        Wed, 15 Apr 2026 03:15:36 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1513csm131435235e9.2.2026.04.15.03.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:15:35 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Cc: Johannes Emerich <johannes@dividat.com>
Subject: [PATCH 1/3] wifi: Extend auth retry mechanism to WPA3-SAE
Date: Wed, 15 Apr 2026 12:14:59 +0200
Message-ID: <20260415101501.1048919-2-johannes@dividat.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260415101501.1048919-1-johannes@dividat.com>
References: <20260415101501.1048919-1-johannes@dividat.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Special treatment of WPA3-SAE was added in
0d5d05f2a6a6895aa2b1ffeda34489552468327b with the explicit purpose of
triggering a renewed password prompt by setting an invalid-key error if
a disconnect occurred during SAE authentication. The handler
handle_sae_authentication_failure() introduced for this purpose shares
some logic with the older handle_4way_handshake_failure() by
duplication, but does not include a retry mechanism.

We have observed frequent disconnects from WPA3 networks with ConnMan
and wpa_supplicant as well as iwd, resulting in wifi services being
marked with invalid-key error and not considered for connection until
the system is rebooted or the error is manually cleared. Such
disconnects may be caused by intermittent network issues, in which case
wpa_supplicant on its own rapidly recovers and reconnects,
while wpa_supplicant controlled by ConnMan is forced to give up on the
wifi service.

This change extends the existing retry mechanism (previously applied to
failures during 4-way handshake and association timeouts) to SAE
authentication errors, making the system more robust against transient
disturbances. To avoid duplicating similar retry mechanisms, the
mechanisms for SAE and 4WAY are joined. The existing logic to also retry
in case of association failure is integrated into this as well, making
each condition explicit.
---
 plugins/wifi.c | 68 +++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a3..a260872f 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2499,15 +2499,34 @@ static bool handle_assoc_status_code(GSupplicantInterface *interface,
 	return FALSE;
 }
 
-static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
+static bool has_transient_assoc_failure(struct wifi_data *wifi)
+{
+	return ((wifi->state == G_SUPPLICANT_STATE_ASSOCIATING) &&
+			wifi->assoc_code == ASSOC_STATUS_AUTH_TIMEOUT);
+}
+
+/*
+ * If connection fails during authentication or specific association states and
+ * retries for the wifi have not been exhausted, permit to retry connecting.
+ *
+ * When failure is in authentication state and retries are exhausted, an
+ * invalid-key error is set.
+ *
+ * Return value is true if more retries should be permitted.
+ */
+static bool handle_retryable_connection_failures(GSupplicantInterface *interface,
 					struct connman_network *network,
 					struct wifi_data *wifi)
 {
 	struct connman_service *service;
+	struct wifi_network *network_data = connman_network_get_data(network);
+	bool is_sae_auth_state =
+		(network_data->keymgmt & G_SUPPLICANT_KEYMGMT_SAE) &&
+			wifi->state == G_SUPPLICANT_STATE_AUTHENTICATING;
+	bool is_4way_state = wifi->state == G_SUPPLICANT_STATE_4WAY_HANDSHAKE;
+	bool is_auth_failure = is_sae_auth_state || is_4way_state;
 
-	if ((wifi->state != G_SUPPLICANT_STATE_4WAY_HANDSHAKE) &&
-			!((wifi->state == G_SUPPLICANT_STATE_ASSOCIATING) &&
-				(wifi->assoc_code == ASSOC_STATUS_AUTH_TIMEOUT)))
+	if (!is_auth_failure && !has_transient_assoc_failure(wifi))
 		return false;
 
 	if (wifi->connected)
@@ -2519,9 +2538,11 @@ static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
 
 	wifi->retries++;
 
-	if (connman_service_get_favorite(service)) {
-		if (wifi->retries < FAVORITE_MAXIMUM_RETRIES)
-			return true;
+	if (connman_service_get_favorite(service)
+			&& wifi->retries < FAVORITE_MAXIMUM_RETRIES) {
+		DBG("can still retry favorite in state %d (%d/%d)", wifi->state,
+				(wifi->retries + 1), FAVORITE_MAXIMUM_RETRIES);
+		return true;
 	}
 
 	wifi->retries = 0;
@@ -2530,25 +2551,6 @@ static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
 	return false;
 }
 
-static bool handle_sae_authentication_failure(struct connman_network *network,
-					      struct wifi_data *wifi)
-{
-	struct wifi_network *network_data = connman_network_get_data(network);
-
-	if (!(network_data->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
-		return false;
-
-	if (wifi->state != G_SUPPLICANT_STATE_AUTHENTICATING)
-		return false;
-
-	if (wifi->connected)
-		return false;
-
-	connman_network_set_error(network, CONNMAN_NETWORK_ERROR_INVALID_KEY);
-
-	return true;
-}
-
 static void wifi_data_free_tethering_info(struct wifi_data *wifi)
 {
 	if (!wifi->tethering_param)
@@ -2644,19 +2646,7 @@ static void interface_state(GSupplicantInterface *interface)
 		if (handle_assoc_status_code(interface, wifi))
 			break;
 
-		/* If previous state was 4way-handshake, then
-		 * it's either: psk was incorrect and thus we retry
-		 * or if we reach the maximum retries we declare the
-		 * psk as wrong */
-		if (handle_4way_handshake_failure(interface,
-						network, wifi))
-			break;
-
-		/*
-		 * On WPA3-SAE authentication, wpa_supplicant goes directly from
-		 * authenticating to disconnected state if the key was invalid.
-		 */
-		if (handle_sae_authentication_failure(network, wifi))
+		if (handle_retryable_connection_failures(interface, network, wifi))
 			break;
 
 		/* See table 8-36 Reason codes in IEEE Std 802.11 */
-- 
2.51.2

