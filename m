Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C420A173
	for <connman@lists.linux.dev>; Tue, 16 Nov 2021 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id e2a4ba01-46ef-11ec-ae1c-005056bdf889;
	Tue, 16 Nov 2021 17:14:25 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v1 2/2] openvpn: Improve configuration value processing
Date: Tue, 16 Nov 2021 17:14:17 +0200
Message-Id: <20211116151417.14827-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
References: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve how the configuration options are processed in OpenVPN. Add a
config option type that is providing better granularity in how the
options should be processed when adding to the task, which eventually
sets them to the binary. Drop the has_value option as unnecessary.

This now allows to add string variables that have a default value when
they are used alone by setting the "opt_type" to OPT_STRING. And adding
the option without a value.

Furthermore, support also setting an option to null for a string option
if the option string value matches the special value set in the array.
This is the case for example with --auth-user-pass where the value "-"
for OpenVPN.AuthUserPass indicates that the password should be queried
from VPN agent using the management interface.
---
 vpn/plugins/openvpn.c | 119 ++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 44 deletions(-)

diff --git a/vpn/plugins/openvpn.c b/vpn/plugins/openvpn.c
index e1962942..761474de 100644
--- a/vpn/plugins/openvpn.c
+++ b/vpn/plugins/openvpn.c
@@ -56,36 +56,48 @@
 
 static DBusConnection *connection;
 
+enum opt_type {
+	OPT_NONE = 0,
+	OPT_STRING = 1,
+	OPT_BOOL = 2,
+};
+
 struct {
-	const char *cm_opt;
-	const char *ov_opt;
-	char       has_value;
+	const char	*cm_opt;
+	const char	*ov_opt;
+	const char	*ov_opt_to_null;
+	enum opt_type	opt_type;
 } ov_options[] = {
-	{ "Host", "--remote", 1 },
-	{ "OpenVPN.CACert", "--ca", 1 },
-	{ "OpenVPN.Cert", "--cert", 1 },
-	{ "OpenVPN.Key", "--key", 1 },
-	{ "OpenVPN.MTU", "--tun-mtu", 1 },
-	{ "OpenVPN.NSCertType", "--ns-cert-type", 1 },
-	{ "OpenVPN.Proto", "--proto", 1 },
-	{ "OpenVPN.Port", "--port", 1 },
-	{ "OpenVPN.AuthUserPass", "--auth-user-pass", 1 },
-	{ "OpenVPN.AskPass", "--askpass", 1 },
-	{ "OpenVPN.AuthNoCache", "--auth-nocache", 0 },
-	{ "OpenVPN.TLSRemote", "--tls-remote", 1 },
-	{ "OpenVPN.TLSAuth", NULL, 1 },
-	{ "OpenVPN.TLSAuthDir", NULL, 1 },
-	{ "OpenVPN.TLSCipher", "--tls-cipher", 1},
-	{ "OpenVPN.Cipher", "--cipher", 1 },
-	{ "OpenVPN.Auth", "--auth", 1 },
-	{ "OpenVPN.CompLZO", "--comp-lzo", 0 },
-	{ "OpenVPN.RemoteCertTls", "--remote-cert-tls", 1 },
-	{ "OpenVPN.ConfigFile", "--config", 1 },
-	{ "OpenVPN.DeviceType", NULL, 1 },
-	{ "OpenVPN.Verb", "--verb", 1 },
-	{ "OpenVPN.Ping", "--ping", 1},
-	{ "OpenVPN.PingExit", "--ping-exit", 1},
-	{ "OpenVPN.RemapUsr1", "--remap-usr1", 1},
+	{ "Host", "--remote", NULL, OPT_STRING},
+	{ "OpenVPN.CACert", "--ca", NULL, OPT_STRING},
+	{ "OpenVPN.Cert", "--cert", NULL, OPT_STRING},
+	{ "OpenVPN.Key", "--key", NULL, OPT_STRING},
+	{ "OpenVPN.MTU", "--tun-mtu", NULL, OPT_STRING},
+	{ "OpenVPN.NSCertType", "--ns-cert-type", NULL, OPT_STRING},
+	{ "OpenVPN.Proto", "--proto", NULL, OPT_STRING},
+	{ "OpenVPN.Port", "--port", NULL, OPT_STRING},
+	/*
+	 * If the AuthUserPass option is "-", provide the input  via management
+	 * interface. To facilitate this set the option as NULL.
+	 */
+	{ "OpenVPN.AuthUserPass", "--auth-user-pass", "-", OPT_STRING},
+	{ "OpenVPN.AskPass", "--askpass", NULL, OPT_STRING},
+	{ "OpenVPN.AuthNoCache", "--auth-nocache", NULL, OPT_BOOL},
+	{ "OpenVPN.TLSRemote", "--tls-remote", NULL, OPT_STRING},
+	{ "OpenVPN.TLSAuth", NULL, NULL, OPT_NONE},
+	{ "OpenVPN.TLSCipher", "--tls-cipher", NULL, OPT_STRING},
+	{ "OpenVPN.TLSAuthDir", NULL, NULL, OPT_NONE},
+	{ "OpenVPN.Cipher", "--cipher", NULL, OPT_STRING},
+	{ "OpenVPN.Auth", "--auth", NULL, OPT_STRING},
+	/* Is set to adaptive by default if value is omitted */
+	{ "OpenVPN.CompLZO", "--comp-lzo", NULL, OPT_STRING},
+	{ "OpenVPN.RemoteCertTls", "--remote-cert-tls", NULL, OPT_STRING},
+	{ "OpenVPN.ConfigFile", "--config", NULL, OPT_STRING},
+	{ "OpenVPN.DeviceType", NULL, NULL, OPT_NONE},
+	{ "OpenVPN.Verb", "--verb", NULL, OPT_STRING},
+	{ "OpenVPN.Ping", "--ping", NULL, OPT_STRING},
+	{ "OpenVPN.PingExit", "--ping-exit", NULL, OPT_STRING},
+	{ "OpenVPN.RemapUsr1", "--remap-usr1", NULL, OPT_STRING},
 };
 
 struct ov_private_data {
@@ -355,29 +367,48 @@ static int ov_save(struct vpn_provider *provider, GKeyFile *keyfile)
 static int task_append_config_data(struct vpn_provider *provider,
 					struct connman_task *task)
 {
-	const char *option;
 	int i;
 
 	for (i = 0; i < (int)ARRAY_SIZE(ov_options); i++) {
-		if (!ov_options[i].ov_opt)
-			continue;
+		const char *ov_opt = ov_options[i].ov_opt;
+		const char *cm_opt = ov_options[i].cm_opt;
+		const char *option = NULL;
 
-		option = vpn_provider_get_string(provider,
-					ov_options[i].cm_opt);
-		if (!option)
+		switch (ov_options[i].opt_type) {
+		case OPT_NONE:
 			continue;
 
-		/*
-		 * If the AuthUserPass option is "-", provide the input
-		 * via management interface
-		 */
-		if (!strcmp(ov_options[i].cm_opt, "OpenVPN.AuthUserPass") &&
-						!strcmp(option, "-"))
-			option = NULL;
+		case OPT_STRING:
+			if (!ov_opt)
+				continue;
+
+			option = vpn_provider_get_string(provider, cm_opt);
+			/*
+			 * A string option may be used alone without a value
+			 * in which case the default value is used by OpenVPN.
+			 */
+			if (!option && !vpn_provider_setting_key_exists(
+							provider, ov_opt))
+				continue;
+
+			const char *opt_to_null = ov_options[i].ov_opt_to_null;
+			if (opt_to_null && !g_strcmp0(option, opt_to_null))
+				option = NULL;
+
+			break;
+
+		case OPT_BOOL:
+			if (!ov_opt)
+				continue;
+
+			/* Ignore the boolean toggle if option is disabled. */
+			if (!vpn_provider_get_boolean(provider, cm_opt, false))
+				continue;
+
+			break;
+		}
 
-		if (connman_task_add_argument(task,
-				ov_options[i].ov_opt,
-				ov_options[i].has_value ? option : NULL) < 0)
+		if (connman_task_add_argument(task, ov_opt, option))
 			return -EIO;
 
 	}
-- 
2.20.1

