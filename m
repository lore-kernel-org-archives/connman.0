Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B588287E
	for <connman@lists.linux.dev>; Fri,  7 Aug 2026 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062346; cv=none; b=ZiEV4rwasnl1UU5cSC6z8V+wa8OxE+Za4HgfdUJSwgpVZqo8Qij5UMfqAHRFPV9wqxLkkIGHAM8ukvGM1ISHmLdOrto9yzz+S2OSarUwjwVDLaBKxRbRmohPQ9WeF758eoBfpKLNA9NOk792GGQqxT88xmDiOcP9ZwBdNttgHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062346; c=relaxed/simple;
	bh=7sPtPLYnA8g2SSZREoB53LazHKjoeektaXh+3Qv+ChE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iit+gOLKuWPjmKzDPqbx8XmgUn/uhkie9/xQhtfT/ShIPZzeAfPhPQJAyPJ7Pvuzf1PG1xfzus/VBOtiPL0pjdUwCoAivaos/livfHfBKeZlYlg4HpakIjqAHUNxwMZIJakdQyjtBhrA0Q2ZwSis6mu95VsdpBDaUvaow/Nnq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com; spf=fail smtp.mailfrom=dgtlrift.com; dkim=pass (2048-bit key) header.d=dgtlrift-com.20251104.gappssmtp.com header.i=@dgtlrift-com.20251104.gappssmtp.com header.b=GLepPWtR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dgtlrift-com.20251104.gappssmtp.com header.i=@dgtlrift-com.20251104.gappssmtp.com header.b="GLepPWtR"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ed2a00f12so45433237b3.2
        for <connman@lists.linux.dev>; Thu, 06 Aug 2026 17:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dgtlrift-com.20251104.gappssmtp.com; s=20251104; t=1786062342; x=1786667142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ILN02NkmraV0GUTgQkcZQzSvP1ZMr8BPBWvNBqDZH1o=;
        b=GLepPWtRWLTkyNXLWJyJozK0s37+fR2xgY9dsAdQQGOda5ye3bSKj6L2SClVeziB9H
         exOdL9Pir+uVOEiVfQLlWiPUjATQE/rt8a1hhPufPdxWzWMBIGrYs+U+GKThOYr7Hnol
         Tbe85UyILGgARQRZYV/ZhoCtvhbHcx5kLAssdc06ft+9pC08fuPSltuGScswfjg4wd/T
         W4EDVhnUyqxPkFgPNwnMNRtvBe1ZIpKV2vfBE9z3PZ0XRgVYouYqziv7+NVri5oy+RJk
         VB5FY/QVccmZRysG/3AOPT16n9NCQhOHAsOzOOxDMZOJ8NfDEWlWymmr7REZwEropOLW
         L92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062342; x=1786667142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILN02NkmraV0GUTgQkcZQzSvP1ZMr8BPBWvNBqDZH1o=;
        b=hSBAiDPvEqcOMyOAPAfMkdn2L/imLYId3KTdYjL5GPu6kGEIOri6X1NzZ0AA7JM9tC
         E5TOx/i4+/OB3SCQsQV9AtfkRn7xETZPOJtuyMiB1LPbMAC1DPNvKL/NFdB9q+oCt3bD
         UTcGoGhX5ySezxSwFBI/GUUOYzBU+jSU6CvNqYJTTA/3d29v4R56TRniyfdT/+mMKfgO
         ihVr503BIn8QaVHMjRntjKjNz/M4/lPqYLwnnRPjqjjd7JqPRu53bpFA2W4YTVokpHrN
         Ekuzo7NJbOFJCFfR2alqKQ3Cjq9BvD9gfe+nrz0KaS0q8FFP+3JaGB5PHQq4eKoRggnd
         09+A==
X-Gm-Message-State: AOJu0Ywo/K+wdzGkkDYoaVuvLWjChJFaYIZKgW11OXyeSEeDzPnY9K76
	m2WmT10e1uGY/gFQgvHFuBXoKfvCt6i9YWSByyyxrpCTlbVHBgeQcbrYmZugWdTAmZALFo8nHo5
	nntmePw==
X-Gm-Gg: AR+sD13dnaL33R161ma1AlCTVPzzheclLf5hCiqcez9PsIvKPAYOcJReOWOgxAOUylt
	V7RvohCj22NFco9Pop7OEyqucM/FhFHWC036o3vR4zvR/5T6rlDf3oKJaS6zNN8t9a5RZusD+ws
	9T+3CTobLoShrAkKYOwsYmDjuXSjYZkK5Dq+1HPBJgOFj1pI7+03hIGwMmKDTWRU9wjodMQ+gE/
	jD2JKDZtCZxxYU/lw/3PvT9hCF3LCDiQDXo6YcriUHcg/r0KbCAuHKLiR7Am9kGezUa/KXDmeTs
	lvW6DFP0o5Io4v9DEtZ6wX0F9xASka+nmyKl1fsO9Yvqc+ygGhBo0vtzm6kly00RzJGVW3HvYy8
	lAIm+JXJiQSD+NGsbHg+IRvYvPXbBgx1pf4tTP8c29/6azUD955AoWe93EjJLHWqWzyxk9cXxFo
	pDcKnaYH/NRRRl+c4JkXVzyZxd3PyRupERaY7Lr+7rTBSF/HEb0n/hyjhxeHhJ0/GGDzjXhbMKl
	dHntmiF+OJ7eE2HvNoJHXSLoaMZFMUijpb3OZ52c5Bg6ro=
X-Received: by 2002:a05:690c:498e:b0:81d:75b4:925f with SMTP id 00721157ae682-820224a9a8amr116428617b3.19.1786062342364;
        Thu, 06 Aug 2026 17:25:42 -0700 (PDT)
Received: from jim-ThinkPad-T580.. (99-35-40-167.lightspeed.tukrga.sbcglobal.net. [99.35.40.167])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f0c75b51sm917347b3.18.2026.08.06.17.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:25:41 -0700 (PDT)
From: Jim Hanley <jhanley@dgtlrift.com>
X-Google-Original-From: Jim Hanley <jhanley@DGtlRift.com>
To: connman@lists.linux.dev
Cc: Jim Hanley <jhanley@DGtlRift.com>
Subject: [PATCH 1/1] wifi: expose BSSID + real dBm signal over D-Bus
Date: Thu,  6 Aug 2026 20:25:38 -0400
Message-ID: <20260807002538.998375-1-jhanley@DGtlRift.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds the data ConnMan's WiFi scan path already receives from
wpa_supplicant but was discarding, for consumers doing WiFi-based
geolocation (Google Geolocation API / Mozilla Ichnaea-style lookups),
and a new method to fetch it in one call. Design rationale, the full
per-record payload shape, and the parallel NetworkManager patch this
was written alongside live in the sibling research repo at
../dbus-wifi-scan-schema/{README.md,schema.json}.

Three pieces:

1. BSSID: struct g_supplicant_bss already has it (bssid[6], from
   wpa_supplicant's own BSSID property, gsupplicant/supplicant.c),
   but gsupplicant.h never exposed a getter, and connman_network had
   no field for it, so plugins/wifi.c had no way to retain it.

   GSupplicantNetwork already picks one representative BSS per SSID
   for its "Signal"/"Frequency" getters (network->best_bss, the
   highest-signal BSS seen for that SSID) -- add
   g_supplicant_network_get_bssid() following that exact existing
   precedent, returning best_bss's BSSID. Thread it into a new
   `bssid` field on struct connman_network (src/network.c), set
   alongside strength/frequency in plugins/wifi.c's network_added()
   and network_changed().

   This is the minimal option from the two considered (see the
   design doc's "What each patch needs to add" section): it reports
   one BSSID per SSID/security combination, not the full physical
   BSS set when several access points share an SSID. The fuller
   option -- reworking gsupplicant to expose every physical BSS, not
   just the aggregate's "best" one -- was deliberately not attempted
   here: it would need a new per-BSS iteration API in gsupplicant.h
   plus a decision about which ConnMan layer owns assembling
   per-BSS-not-per-service D-Bus output, which is a real design
   question for upstream discussion, not something to decide
   unilaterally in this patch. Flagging it as an open question rather
   than guessing keeps this patch's semantics change additive and
   easy to review; connman_network's existing SSID-aggregated
   semantics, which other ConnMan code depends on, are untouched.

2. Real dBm: g_supplicant_network_get_signal() already returns real
   dBm (wpa_supplicant's Signal property); calculate_strength()
   (plugins/wifi.c) already reads it and only kept the lossy 0-100
   percent it computes. Add a `signal_dbm` field to connman_network,
   populated from the same already-public getter next to the new
   bssid field.

3. D-Bus: add read-only BSSID (string) and StrengthDbm (int16)
   properties to net.connman.Service, next to the existing Strength
   percent (src/service.c, doc/service-api.txt). Add
   array{dict} GetScanResults() on a new
   net.connman.Technology.WifiGeolocation1 interface, registered
   only on the WiFi technology object alongside the existing
   net.connman.Technology interface (precedent: net.connman.Clock
   already shares net.connman.Manager's object path this way). This
   interface name is an explicit strawman -- see the comment on
   CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE in include/dbus.h --
   not a name that has had any upstream discussion.

Verification: no internet/hardware access in this sandbox to run
against a live wpa_supplicant. `./bootstrap-configure` fails before
reaching this code (autoreconf needs libtool, which isn't installed
and can't be without root in this sandbox). As a substitute, verified
every changed/added .c file individually compiles clean with
`gcc -fsyntax-only` against the real project headers (reconstructing
the include/connman/ symlink layout Makefile.am normally generates).
Also manually re-read the full diff against doc/coding-style.txt.

Not a complete, submission-ready patch: doc/coding-style.txt says
ConnMan does not use Signed-off-by lines (unlike most kernel.org
projects), so none is included here, but this still needs review
from an actual ConnMan contributor, and ideally live-hardware
testing, before being proposed upstream.

wifi: document access-control tradeoff for BSSID/StrengthDbm/GetScanResults

Unlike the sibling NetworkManager patch, ConnMan's bus policy
(src/connman-dbus.conf) has no per-interface rules -- just root, any
at_console="true" local console user, or nothing. So the new BSSID/
StrengthDbm properties and GetScanResults() automatically inherit the
same reachability as the pre-existing Strength percent; no policy-file
change was needed for them to work.

That's exactly the design question worth surfacing rather than deciding
silently: BSSID was not exposed by ConnMan at all before this patch,
and is now reachable to that same broad audience. Neither of ConnMan's
two existing PolicyKit privilege buckets (plugins/polkit.c:
CONNMAN_PRIVILEGE_MODIFY for state-changing calls, CONNMAN_PRIVILEGE_SECRET
for credentials) covers read-only, non-secret data like this, so even
with the optional PolicyKit plugin enabled, none of this new data would
be gated by it. A third privilege bucket is a real option, deliberately
not added here -- naming/scoping a new PolicyKit action is exactly the
kind of upstream bikeshed this patch has otherwise avoided deciding
unilaterally (see the interface-name comment already in include/dbus.h),
so it's left as an open question for real patch review instead.

Schema definition can be found at https://github.com/dgtlrift/dbus-wifi-scan-schema.git

Signed-off-by: Jim Hanley <jhanley@DGtlRift.com>
---
 doc/service-api.txt       |  29 +++++++
 doc/technology-api.txt    |  44 ++++++++++
 gsupplicant/gsupplicant.h |  11 +++
 gsupplicant/supplicant.c  |   8 ++
 include/dbus.h            |  39 +++++++++
 include/network.h         |   6 ++
 plugins/wifi.c            |  15 ++++
 src/network.c             |  81 ++++++++++++++++++
 src/service.c             |  40 +++++++++
 src/technology.c          | 176 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 449 insertions(+)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 89208a6..3224fef 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -209,6 +209,35 @@ Properties	string State [readonly]
 			This property will not be present for Ethernet
 			devices.
 
+		string BSSID [readonly]
+
+			The BSSID (hardware/MAC address) of the access point
+			this service is currently associated with, in
+			"aa:bb:cc:dd:ee:ff" lower-case colon-hex form.
+
+			A given WiFi network name/security combination can
+			be reachable via more than one physical access point
+			(BSSID); this property reflects only the single
+			access point ConnMan currently considers strongest
+			for this service, the same one Strength/StrengthDbm
+			are derived from -- it is not a list of every access
+			point seen for this service.
+
+			This property is only present for WiFi services for
+			which a BSSID has been received from at least one
+			scan result.
+
+		int16 StrengthDbm [readonly]
+
+			The real, calibrated received signal strength (RSSI)
+			in dBm of the access point named by BSSID above, as
+			reported by the WiFi driver/firmware. Unlike Strength,
+			this is not normalized/clamped to a 0-100 range.
+
+			This property is only present for WiFi services for
+			which a signal reading has been received from at
+			least one scan result.
+
 		boolean Favorite [readonly]
 
 			Will be true if a cable is plugged in or the user
diff --git a/doc/technology-api.txt b/doc/technology-api.txt
index cdf3039..22d7a94 100644
--- a/doc/technology-api.txt
+++ b/doc/technology-api.txt
@@ -107,3 +107,47 @@ Properties	boolean Powered [readwrite]
 
 			This property is only valid for the WiFi technology and it's
 			optional. Default frequency is 2412 Mhz.
+
+wifi_geolocation interface (strawman, not yet upstream-agreed)
+================================================================
+
+Service		net.connman
+Interface	net.connman.Technology.WifiGeolocation1
+Object path	[variable prefix]/{technology0,technology1,...} (same object
+		path as the WiFi technology's net.connman.Technology
+		interface above; this is a second interface registered on
+		it, not a separate object)
+
+This interface name is a strawman placeholder, not an interface that has
+had any upstream discussion -- see the comment on
+CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE in include/dbus.h. Only
+registered on the WiFi technology object.
+
+Methods		array{dict} GetScanResults()
+
+			Returns the most recently known WiFi scan results,
+			one dict per currently visible connman_service that
+			has a BSSID (see the BSSID/StrengthDbm properties in
+			service-api.txt). This is a read of cached results
+			only; call Scan() above first (it blocks until scan
+			results are available) if fresher data is needed.
+
+			Each dict has (at minimum) string keys "macAddress",
+			"signalStrength" (int32, dBm), "signalStrengthUnit"
+			(string, "dBm" or "dBm_estimated_from_percent"),
+			"signalStrengthRawPercent" (int32, 0-100), and
+			"source" (string, always "connman"); "frequencyMhz"
+			(uint16) and "ssid" (string) are included when known.
+			This shape mirrors the reconciled cross-project
+			schema in ../../dbus-wifi-scan-schema/schema.json in
+			the sibling research repo this was designed against;
+			see that repo's README.md for the full rationale.
+
+			Known limitation: since connman_service/
+			connman_network aggregate by SSID+security rather
+			than by physical BSSID, this reports at most one
+			record per WiFi service, i.e. one BSSID per SSID/
+			security combination even if more than one physical
+			access point shares it -- not a full per-BSSID scan
+			dump. See src/technology.c's
+			append_wifi_geolocation_scan_result() doc comment.
diff --git a/gsupplicant/gsupplicant.h b/gsupplicant/gsupplicant.h
index eab6293..a587dac 100644
--- a/gsupplicant/gsupplicant.h
+++ b/gsupplicant/gsupplicant.h
@@ -328,6 +328,17 @@ const void *g_supplicant_network_get_ssid(GSupplicantNetwork *network,
 const char *g_supplicant_network_get_mode(GSupplicantNetwork *network);
 const char *g_supplicant_network_get_security(GSupplicantNetwork *network);
 dbus_int16_t g_supplicant_network_get_signal(GSupplicantNetwork *network);
+/*
+ * Returns the 6-octet BSSID of the network's currently selected/strongest
+ * BSS (see network->best_bss in supplicant.c), i.e. the exact same
+ * representative BSS whose signal g_supplicant_network_get_signal() above
+ * returns. NULL if the network has no known BSS. A GSupplicantNetwork
+ * aggregates by SSID and can represent several physical BSSes; like the
+ * existing Signal/Frequency getters, this only exposes the single BSS
+ * ConnMan currently considers "best" for the network, not the full BSS set.
+ */
+const unsigned char *g_supplicant_network_get_bssid(
+						GSupplicantNetwork *network);
 dbus_uint16_t g_supplicant_network_get_frequency(GSupplicantNetwork *network);
 dbus_bool_t g_supplicant_network_get_wps(GSupplicantNetwork *network);
 dbus_bool_t g_supplicant_network_is_wps_active(GSupplicantNetwork *network);
diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 5e28995..68639c9 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -1277,6 +1277,14 @@ dbus_int16_t g_supplicant_network_get_signal(GSupplicantNetwork *network)
 	return network->signal;
 }
 
+const unsigned char *g_supplicant_network_get_bssid(GSupplicantNetwork *network)
+{
+	if (!network || !network->best_bss)
+		return NULL;
+
+	return network->best_bss->bssid;
+}
+
 dbus_uint16_t g_supplicant_network_get_frequency(GSupplicantNetwork *network)
 {
 	if (!network)
diff --git a/include/dbus.h b/include/dbus.h
index bcab418..e2fd164 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -46,6 +46,45 @@ extern "C" {
 #define CONNMAN_NOTIFICATION_INTERFACE	CONNMAN_SERVICE ".Notification"
 #define CONNMAN_PEER_INTERFACE		CONNMAN_SERVICE ".Peer"
 
+/*
+ * Strawman interface name for the wifi_geolocation D-Bus surface (see
+ * ../dbus-wifi-scan-schema/README.md's "Proposed common D-Bus interface"
+ * section in the sibling research repo this patch was designed against).
+ * That doc's org.freedesktop.WifiGeolocationScan1 name was explicitly
+ * called out there as unlikely to be accepted as-is under the
+ * freedesktop.org namespace by either project's upstream, suggesting
+ * something namespaced per-project instead -- this is that suggestion for
+ * ConnMan, not a name that has had any upstream discussion. Expect this to
+ * be bikeshedded/renamed as part of real patch review.
+ */
+#define CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE \
+			CONNMAN_TECHNOLOGY_INTERFACE ".WifiGeolocation1"
+
+/*
+ * Access control for the new BSSID/StrengthDbm Service properties and the
+ * GetScanResults() method above: deliberately left ungated beyond
+ * ConnMan's existing default bus policy (src/connman-dbus.conf --
+ * unlike NetworkManager's D-Bus policy, ConnMan has no per-interface
+ * rules at all; access is root, or any at_console="true" locally-logged-
+ * in console user, or nothing). That means this new data automatically
+ * inherits the same reachability as the pre-existing Strength percent --
+ * no policy-file change was needed for it to work, unlike the sibling
+ * NetworkManager patch, which had a real gap there.
+ *
+ * That's a real design question worth surfacing, not a decision to make
+ * silently here: BSSID was not exposed by ConnMan at all before this
+ * patch, and it's now reachable to that same broad at_console audience.
+ * Neither of the two PolicyKit privilege buckets below covers read-only,
+ * non-secret data like this (CONNMAN_PRIVILEGE_MODIFY is for
+ * state-changing calls, CONNMAN_PRIVILEGE_SECRET is for credentials/
+ * passphrases) -- plugins/polkit.c's optional PolicyKit plugin, even if
+ * enabled, would not gate this new data at all. A third privilege bucket
+ * (e.g. CONNMAN_PRIVILEGE_GEOLOCATION) is a real option, deliberately not
+ * added here: naming/scoping a new PolicyKit action is exactly the kind
+ * of upstream-maintainer bikeshed this patch has otherwise avoided
+ * deciding unilaterally (see the interface-name comment above), so it's
+ * left as an open question for real patch review instead.
+ */
 #define CONNMAN_PRIVILEGE_MODIFY	1
 #define CONNMAN_PRIVILEGE_SECRET	2
 
diff --git a/include/network.h b/include/network.h
index 2078509..3487292 100644
--- a/include/network.h
+++ b/include/network.h
@@ -129,6 +129,12 @@ uint8_t connman_network_get_strength(struct connman_network *network);
 int connman_network_set_frequency(struct connman_network *network,
 					uint16_t frequency);
 uint16_t connman_network_get_frequency(struct connman_network *network);
+int connman_network_set_bssid(struct connman_network *network,
+					const unsigned char *bssid);
+const unsigned char *connman_network_get_bssid(struct connman_network *network);
+int connman_network_set_signal_dbm(struct connman_network *network,
+					int16_t signal_dbm);
+int16_t connman_network_get_signal_dbm(struct connman_network *network);
 int connman_network_set_autoconnect(struct connman_network *network,
 				bool autoconnect);
 
diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a..d43fa4f 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2926,6 +2926,17 @@ static void network_added(GSupplicantNetwork *supplicant_network)
 	connman_network_set_string(network, "WiFi.Security", security);
 	connman_network_set_strength(network,
 				calculate_strength(supplicant_network));
+	/*
+	 * Real dBm (RSSI) and BSSID of the network's currently "best" BSS,
+	 * for the wifi_geolocation D-Bus surface -- see calculate_strength()
+	 * above for why the lossy percent alone isn't enough for that use
+	 * case, and g_supplicant_network_get_bssid()'s doc comment
+	 * (gsupplicant/gsupplicant.h) for the one-BSSID-per-SSID caveat.
+	 */
+	connman_network_set_signal_dbm(network,
+				g_supplicant_network_get_signal(supplicant_network));
+	connman_network_set_bssid(network,
+				g_supplicant_network_get_bssid(supplicant_network));
 	connman_network_set_bool(network, "WiFi.WPS", wps);
 	connman_network_set_bool(network, "WiFi.WPSAdvertising",
 				wps_advertizing);
@@ -3042,6 +3053,10 @@ static void network_changed(GSupplicantNetwork *network, const char *property)
 	} else if (g_str_equal(property, "Signal")) {
 		connman_network_set_strength(connman_network,
 					calculate_strength(network));
+		connman_network_set_signal_dbm(connman_network,
+					g_supplicant_network_get_signal(network));
+		connman_network_set_bssid(connman_network,
+					g_supplicant_network_get_bssid(network));
 		update_needed = true;
 	} else
 		update_needed = false;
diff --git a/src/network.c b/src/network.c
index 416a7e7..891378a 100644
--- a/src/network.c
+++ b/src/network.c
@@ -25,6 +25,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <netinet/if_ether.h>
 
 #include "connman.h"
 #include <connman/acd.h>
@@ -63,6 +64,20 @@ struct connman_network {
 	bool roaming;
 	uint8_t strength;
 	uint16_t frequency;
+	/*
+	 * BSSID of the physical AP this network was last (re)discovered on,
+	 * and the real dBm signal reading for that same BSS. Populated by
+	 * plugins/wifi.c from gsupplicant (wpa_supplicant only reports these
+	 * for WiFi; both are all-zero/0 -- see connman_network_get_bssid()/
+	 * connman_network_get_signal_dbm() -- for any other network type,
+	 * or before a WiFi network's first scan result has been processed).
+	 * Note a GSupplicantNetwork (and so, one connman_network here) can
+	 * represent several physical BSSes sharing one SSID/security; this
+	 * only tracks the single BSS currently considered "best" (same one
+	 * "strength" above is derived from), not the full physical BSS set.
+	 */
+	unsigned char bssid[ETH_ALEN];
+	int16_t signal_dbm;
 	char *identifier;
 	char *name;
 	char *node;
@@ -2118,6 +2133,72 @@ uint16_t connman_network_get_frequency(struct connman_network *network)
 	return network->frequency;
 }
 
+/**
+ * connman_network_set_bssid:
+ * @network: network structure
+ * @bssid: 6-octet BSSID, or NULL to clear
+ *
+ * Set the BSSID of the physical AP this network was last seen on.
+ */
+int connman_network_set_bssid(struct connman_network *network,
+					const unsigned char *bssid)
+{
+	if (bssid)
+		memcpy(network->bssid, bssid, ETH_ALEN);
+	else
+		memset(network->bssid, 0, ETH_ALEN);
+
+	return 0;
+}
+
+/**
+ * connman_network_get_bssid:
+ * @network: network structure
+ *
+ * Returns a pointer to the network's 6-octet BSSID, or NULL if none has
+ * been set yet (e.g. non-WiFi network, or WiFi network with no scan result
+ * processed so far).
+ */
+const unsigned char *connman_network_get_bssid(struct connman_network *network)
+{
+	static const unsigned char empty_bssid[ETH_ALEN];
+
+	if (!memcmp(network->bssid, empty_bssid, ETH_ALEN))
+		return NULL;
+
+	return network->bssid;
+}
+
+/**
+ * connman_network_set_signal_dbm:
+ * @network: network structure
+ * @signal_dbm: real, calibrated signal strength in dBm (RSSI)
+ *
+ * Set the real dBm signal value for this network, alongside the existing
+ * lossy 0-100 "strength" percent (connman_network_set_strength()). Unlike
+ * strength, this value is not normalized/clamped by ConnMan.
+ */
+int connman_network_set_signal_dbm(struct connman_network *network,
+					int16_t signal_dbm)
+{
+	network->signal_dbm = signal_dbm;
+
+	return 0;
+}
+
+/**
+ * connman_network_get_signal_dbm:
+ * @network: network structure
+ *
+ * Returns the real dBm signal value previously set via
+ * connman_network_set_signal_dbm(), or 0 if never set (real WiFi dBm
+ * readings are always negative, so 0 unambiguously means "unknown").
+ */
+int16_t connman_network_get_signal_dbm(struct connman_network *network)
+{
+	return network->signal_dbm;
+}
+
 int connman_network_set_autoconnect(struct connman_network *network,
 				bool autoconnect)
 {
diff --git a/src/service.c b/src/service.c
index d5869b1..532cb36 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5305,6 +5305,46 @@ static void append_properties(DBusMessageIter *dict, dbus_bool_t limited,
 		connman_dbus_dict_append_basic(dict, "Strength",
 					DBUS_TYPE_BYTE, &service->strength);
 
+	/*
+	 * BSSID/StrengthDbm: added for the wifi_geolocation D-Bus surface
+	 * (see doc/service-api.txt, and the related GetScanResults() method
+	 * on CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE in
+	 * src/technology.c). Read live from service->network rather than
+	 * cached on connman_service, matching how e.g. the WiFi SSID/
+	 * Frequency pair is read live from service->network elsewhere in
+	 * this file (service_save()). Only present when this is a WiFi
+	 * service with a live network object that has actually reported a
+	 * BSSID/dBm reading.
+	 *
+	 * Access control for these two properties is deliberately left as
+	 * ConnMan's existing default (no new PolicyKit gate) -- see the
+	 * comment next to CONNMAN_PRIVILEGE_MODIFY/SECRET in include/dbus.h
+	 * for the full reasoning and why this is flagged as an open
+	 * question, not a silent decision.
+	 */
+	if (service->network) {
+		const unsigned char *bssid;
+		int16_t signal_dbm;
+
+		bssid = connman_network_get_bssid(service->network);
+		if (bssid) {
+			char bssid_str[18];
+			const char *bssid_ptr = bssid_str;
+
+			snprintf(bssid_str, sizeof(bssid_str),
+					"%02x:%02x:%02x:%02x:%02x:%02x",
+					bssid[0], bssid[1], bssid[2],
+					bssid[3], bssid[4], bssid[5]);
+			connman_dbus_dict_append_basic(dict, "BSSID",
+					DBUS_TYPE_STRING, &bssid_ptr);
+		}
+
+		signal_dbm = connman_network_get_signal_dbm(service->network);
+		if (signal_dbm != 0)
+			connman_dbus_dict_append_basic(dict, "StrengthDbm",
+					DBUS_TYPE_INT16, &signal_dbm);
+	}
+
 	val = service->favorite;
 	connman_dbus_dict_append_basic(dict, "Favorite",
 					DBUS_TYPE_BOOLEAN, &val);
diff --git a/src/technology.c b/src/technology.c
index 933070f..0be4b89 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -24,6 +24,7 @@
 #endif
 
 #include <errno.h>
+#include <stdio.h>
 #include <string.h>
 
 #include <gdbus.h>
@@ -1172,6 +1173,157 @@ static DBusMessage *scan(DBusConnection *conn, DBusMessage *msg, void *data)
 	return NULL;
 }
 
+/*
+ * --- wifi_geolocation D-Bus surface --------------------------------------
+ *
+ * Implements GetScanResults() on CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE
+ * (see include/dbus.h for why that interface name is a strawman, not an
+ * upstream-agreed name). Design rationale and the full record shape this
+ * mirrors live in ../dbus-wifi-scan-schema/{README.md,schema.json} in the
+ * sibling research repo this patch was written against.
+ *
+ * Each element enumerates one connman_service of type WIFI that has a
+ * BSSID available (connman_network_get_bssid(), populated by
+ * plugins/wifi.c from gsupplicant -- see its doc comment in
+ * gsupplicant/gsupplicant.h). Services without one yet are skipped, since
+ * "macAddress" is a required field of the schema this mirrors.
+ *
+ * Known limitation, not fixed by this patch: connman_service/
+ * connman_network aggregate by SSID+security, not by physical BSSID, and
+ * only track the single BSS ConnMan currently considers "best" for a given
+ * SSID (see connman_network_get_bssid()'s doc comment, src/network.c). If
+ * several physical access points share one SSID/security, only one of
+ * them is represented here -- this is a real, deliberate fidelity gap
+ * versus a true per-BSSID scan dump, flagged for upstream discussion
+ * rather than solved by restructuring connman_network/connman_service's
+ * existing SSID-aggregated semantics, which other ConnMan code relies on.
+ */
+static void append_wifi_geolocation_scan_result(DBusMessageIter *array,
+						struct connman_service *service)
+{
+	struct connman_network *network;
+	DBusMessageIter dict;
+	const unsigned char *bssid;
+	const void *ssid;
+	unsigned int ssid_len = 0;
+	char bssid_str[18];
+	const char *bssid_ptr = bssid_str;
+	const char *source_str = "connman";
+	const char *unit_str;
+	dbus_int32_t signal_dbm_val;
+	dbus_int32_t strength_pct_val;
+	dbus_uint16_t frequency;
+	int16_t signal_dbm;
+
+	if (connman_service_get_type(service) != CONNMAN_SERVICE_TYPE_WIFI)
+		return;
+
+	network = __connman_service_get_network(service);
+	if (!network)
+		return;
+
+	bssid = connman_network_get_bssid(network);
+	if (!bssid)
+		return;
+
+	snprintf(bssid_str, sizeof(bssid_str),
+			"%02x:%02x:%02x:%02x:%02x:%02x",
+			bssid[0], bssid[1], bssid[2],
+			bssid[3], bssid[4], bssid[5]);
+
+	connman_dbus_dict_open(array, &dict);
+
+	connman_dbus_dict_append_basic(&dict, "macAddress",
+					DBUS_TYPE_STRING, &bssid_ptr);
+
+	signal_dbm = connman_network_get_signal_dbm(network);
+	strength_pct_val = connman_network_get_strength(network);
+
+	if (signal_dbm != 0) {
+		unit_str = "dBm";
+		signal_dbm_val = signal_dbm;
+	} else {
+		/*
+		 * No real dBm captured for this network yet (e.g. no
+		 * "Signal" update processed since this patch loaded);
+		 * fall back to the schema's documented interim estimate
+		 * rather than omit this required field. Same linear
+		 * estimate calculate_strength() (plugins/wifi.c) uses in
+		 * reverse.
+		 */
+		unit_str = "dBm_estimated_from_percent";
+		signal_dbm_val = (dbus_int32_t) strength_pct_val - 120;
+	}
+
+	connman_dbus_dict_append_basic(&dict, "signalStrength",
+					DBUS_TYPE_INT32, &signal_dbm_val);
+	connman_dbus_dict_append_basic(&dict, "signalStrengthUnit",
+					DBUS_TYPE_STRING, &unit_str);
+	connman_dbus_dict_append_basic(&dict, "signalStrengthRawPercent",
+					DBUS_TYPE_INT32, &strength_pct_val);
+
+	frequency = connman_network_get_frequency(network);
+	if (frequency)
+		connman_dbus_dict_append_basic(&dict, "frequencyMhz",
+					DBUS_TYPE_UINT16, &frequency);
+
+	ssid = connman_network_get_blob(network, "WiFi.SSID", &ssid_len);
+	if (ssid && ssid_len > 0) {
+		char *ssid_str = g_strndup((const char *) ssid, ssid_len);
+
+		connman_dbus_dict_append_basic(&dict, "ssid",
+					DBUS_TYPE_STRING, &ssid_str);
+		g_free(ssid_str);
+	}
+
+	connman_dbus_dict_append_basic(&dict, "source",
+					DBUS_TYPE_STRING, &source_str);
+
+	connman_dbus_dict_close(array, &dict);
+}
+
+static int append_wifi_geolocation_scan_result_cb(
+		struct connman_service *service, void *user_data)
+{
+	append_wifi_geolocation_scan_result(user_data, service);
+
+	return 0;
+}
+
+static DBusMessage *get_scan_results(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
+
+	connman_service_iterate_services(append_wifi_geolocation_scan_result_cb,
+						&array);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
+static const GDBusMethodTable wifi_geolocation_methods[] = {
+	{ GDBUS_METHOD("GetScanResults",
+			NULL, GDBUS_ARGS({ "results", "aa{sv}" }),
+			get_scan_results) },
+	{ },
+};
+
 static const GDBusMethodTable technology_methods[] = {
 	{ GDBUS_DEPRECATED_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -1204,6 +1356,25 @@ static bool technology_dbus_register(struct connman_technology *technology)
 		return false;
 	}
 
+	/*
+	 * wifi_geolocation's GetScanResults() (see above) is only
+	 * meaningful for the WiFi technology; registered as a second
+	 * interface on the same object path, following the precedent of
+	 * net.connman.Clock sharing CONNMAN_MANAGER_PATH with
+	 * net.connman.Manager (src/clock.c).
+	 */
+	if (technology->type == CONNMAN_SERVICE_TYPE_WIFI) {
+		bool ok;
+
+		ok = g_dbus_register_interface(connection, technology->path,
+				CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE,
+				wifi_geolocation_methods, NULL,
+				NULL, technology, NULL);
+		if (!ok)
+			connman_error("Failed to register %s",
+				CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE);
+	}
+
 	technology_added_signal(technology);
 	technology->dbus_registered = true;
 
@@ -1216,6 +1387,11 @@ static void technology_dbus_unregister(struct connman_technology *technology)
 		return;
 
 	technology_removed_signal(technology);
+
+	if (technology->type == CONNMAN_SERVICE_TYPE_WIFI)
+		g_dbus_unregister_interface(connection, technology->path,
+			CONNMAN_TECHNOLOGY_WIFI_GEOLOCATION_INTERFACE);
+
 	g_dbus_unregister_interface(connection, technology->path,
 		CONNMAN_TECHNOLOGY_INTERFACE);
 
-- 
2.43.0

