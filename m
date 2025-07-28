Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500622FE15
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742424; cv=none; b=M5TFADAMCtQj/FSP8m1Z1tl9TXvX6zDCieMzecR2+ql8WeYkneLUd8gYMgOjJYPxGc+dqRRFGQIpPC2GFIHNRgPOLnEhwrztcp9UE9MysjO7xOnnImIgNUVpooFdCHh/5UzmyPKAaQj4+OrKamtGJMUxHyl3rmDE9ma7Xr9jdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742424; c=relaxed/simple;
	bh=E0muC65pLzl4hbGFOagiA1uPDn+HNkdmcJoSzYlloHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLeeVM5jQlO0l+7eUWzeFWuphDmLC/SQm3mdcmMjeEAJPCKcTg2CXZ/bSoDD1pVZcWU5Q0fyAzayBa+q8iEwoup9O3+llyJgK7/d0/uoyocg2dujkJD5K46V6OyuIjNNmKe55fUdSXMPjzl28gzE6X4GCfaNwkybciAASNGCJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Fh9dnDon; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Fh9dnDon"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4C262164A8F
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:19 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 05EBF124E6D
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:18 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] main: Introduce 'DefaultEnabledTechnologies' setting.
Date: Mon, 28 Jul 2025 15:32:15 -0700
Message-ID: <20250728223217.3991877-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250728223217.3991877-1-gerickson@nuovations.com>
References: <20250728223217.3991877-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=pdbC3+UCSGa7PKVhorb+1Mt0bRmaRIs343Es/B4Qxyo=; b=Fh9dnDonTfElnRpgXza9ZjbPOqwOcdLHgY18FItWXMRun8nDN6HTRZ9G66/0A2pDa+/u05zcLchHoLYXkiXjbeprhtX/iQSvPuSSYTnHIuFze25OHCjivCtpFg9Won2OpjuFY81eoA5ykrTUxVU27FrEGpuEVR9cceSnR1J7tfBXjBtbX0QEYEv9unZNJFuXF7CJ/boSJ8rAEd7MV0vccrG4NTvYN+KdrqBYBPcIK+vj0sHZfPPVyjCdQOE4kM7hXS8wQxCD0r1KpVyv4JbCrswX4IbGbhareLS59HVfTNHhDiYOUtQO2UwGZl+2bZ1P3MUPBwKz8wSDk/FWlgns8Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This introduces a new 'DefaultEnabledTechnologies' configuration
setting.

Since nearly the beginning of connman, it has behaved such that the
Ethernet technology is enabled (that is, powered) by
default. Currently, this is hard-coded behavior into
src/technology.c:technology_load.

However, if a different or additional technology is desired, there has
historically been no way to achieve this via configuration.

The 'DefaultEnabledTechnologies' key/value pair is a list of
technologies that are marked enabled (that is, powered) by default,
separated by commas ",". The default value for this entry when empty
is 'ethernet', matching the legacy behavior prior to the introduction
of this setting.
---
 src/main.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/main.c b/src/main.c
index 5d13fb7bbd27..7090926426eb 100644
--- a/src/main.c
+++ b/src/main.c
@@ -78,6 +78,11 @@ static char *default_auto_connect[] = {
 	NULL
 };
 
+static char *default_enabled_techs[] = {
+	"ethernet",
+	NULL
+};
+
 static char *default_favorite_techs[] = {
 	"ethernet",
 	NULL
@@ -99,6 +104,7 @@ static struct {
 	bool bg_scan;
 	char **pref_timeservers;
 	unsigned int *auto_connect;
+	unsigned int *enabled_techs;
 	unsigned int *favorite_techs;
 	unsigned int *preferred_techs;
 	unsigned int *always_connected_techs;
@@ -134,6 +140,7 @@ static struct {
 	.bg_scan = true,
 	.pref_timeservers = NULL,
 	.auto_connect = NULL,
+	.enabled_techs = NULL,
 	.favorite_techs = NULL,
 	.preferred_techs = NULL,
 	.always_connected_techs = NULL,
@@ -171,6 +178,7 @@ static struct {
 #define CONF_BG_SCAN                    "BackgroundScanning"
 #define CONF_PREF_TIMESERVERS           "FallbackTimeservers"
 #define CONF_AUTO_CONNECT_TECHS         "DefaultAutoConnectTechnologies"
+#define CONF_ENABLED_TECHS              "DefaultEnabledTechnologies"
 #define CONF_FAVORITE_TECHS             "DefaultFavoriteTechnologies"
 #define CONF_ALWAYS_CONNECTED_TECHS     "AlwaysConnectedTechnologies"
 #define CONF_PREFERRED_TECHS            "PreferredTechnologies"
@@ -207,6 +215,7 @@ static const char *supported_options[] = {
 	CONF_BG_SCAN,
 	CONF_PREF_TIMESERVERS,
 	CONF_AUTO_CONNECT_TECHS,
+	CONF_ENABLED_TECHS,
 	CONF_FAVORITE_TECHS,
 	CONF_ALWAYS_CONNECTED_TECHS,
 	CONF_PREFERRED_TECHS,
@@ -437,6 +446,9 @@ static void parse_config(GKeyFile *config, const char *file)
 		connman_settings.auto_connect =
 			parse_service_types(default_auto_connect,
 					CONF_ARRAY_SIZE(default_auto_connect));
+		connman_settings.enabled_techs =
+			parse_service_types(default_enabled_techs,
+					CONF_ARRAY_SIZE(default_enabled_techs));
 		connman_settings.favorite_techs =
 			parse_service_types(default_favorite_techs,
 					CONF_ARRAY_SIZE(default_favorite_techs));
@@ -481,6 +493,23 @@ static void parse_config(GKeyFile *config, const char *file)
 
 	g_clear_error(&error);
 
+	/* DefaultEnabledTechnologies */
+
+	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
+			CONF_ENABLED_TECHS, &len, &error);
+
+	if (!error)
+		connman_settings.enabled_techs =
+			parse_service_types(str_list, len);
+	else
+		connman_settings.enabled_techs =
+			parse_service_types(default_enabled_techs,
+				CONF_ARRAY_SIZE(default_enabled_techs));
+
+	g_strfreev(str_list);
+
+	g_clear_error(&error);
+
 	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
 			CONF_FAVORITE_TECHS, &len, &error);
 
@@ -1111,6 +1140,9 @@ unsigned int *connman_setting_get_uint_list(const char *key)
 	if (g_str_equal(key, CONF_AUTO_CONNECT_TECHS))
 		return connman_settings.auto_connect;
 
+	if (g_str_equal(key, CONF_ENABLED_TECHS))
+		return connman_settings.enabled_techs;
+
 	if (g_str_equal(key, CONF_FAVORITE_TECHS))
 		return connman_settings.favorite_techs;
 
-- 
2.45.0

