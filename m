Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395E2FAF
	for <connman@lists.linux.dev>; Fri, 13 Aug 2021 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 44560ed1-fc3c-11eb-b1af-005056bdfda7;
	Fri, 13 Aug 2021 16:42:14 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: Matt Vogt <matthew.vogt@jollamobile.com>
Subject: [PATCH 1/3] l2tp: Create control file for xl2tpd
Date: Fri, 13 Aug 2021 16:42:07 +0300
Message-Id: <20210813134209.23253-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210813134209.23253-1-jussi.laakkonen@jolla.com>
References: <20210813134209.23253-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Vogt <matthew.vogt@jollamobile.com>

Create and use connman specific control file with xl2tpd.
---
 vpn/plugins/l2tp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/vpn/plugins/l2tp.c b/vpn/plugins/l2tp.c
index 1e4fcd1f..5213b345 100644
--- a/vpn/plugins/l2tp.c
+++ b/vpn/plugins/l2tp.c
@@ -651,7 +651,7 @@ static int run_connect(struct vpn_provider *provider,
 			vpn_provider_connect_cb_t cb, void *user_data,
 			const char *username, const char *password)
 {
-	char *l2tp_name, *pppd_name;
+	char *l2tp_name, *ctrl_name, *pppd_name;
 	int l2tp_fd, pppd_fd;
 	int err;
 
@@ -674,12 +674,24 @@ static int run_connect(struct vpn_provider *provider,
 		goto done;
 	}
 
-	pppd_name = g_strdup_printf(VPN_STATEDIR "/connman-ppp-option.conf");
+	ctrl_name = g_strconcat(VPN_STATEDIR, "/connman-xl2tpd-control", NULL);
+
+	if (mkfifo(ctrl_name, S_IRUSR|S_IWUSR) != 0 && errno != EEXIST) {
+		connman_error("Error creating xl2tp control pipe");
+		g_free(l2tp_name);
+		g_free(ctrl_name);
+		close(l2tp_fd);
+		err = -EIO;
+		goto done;
+	}
+
+	pppd_name = g_strconcat(VPN_STATEDIR, "/connman-ppp-option.conf", NULL);
 
 	pppd_fd = open(pppd_name, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
 	if (pppd_fd < 0) {
 		connman_error("Error writing pppd config");
 		g_free(l2tp_name);
+		g_free(ctrl_name);
 		g_free(pppd_name);
 		close(l2tp_fd);
 		err = -EIO;
@@ -691,9 +703,11 @@ static int run_connect(struct vpn_provider *provider,
 	write_pppd_option(provider, pppd_fd);
 
 	connman_task_add_argument(task, "-D", NULL);
+	connman_task_add_argument(task, "-C", ctrl_name);
 	connman_task_add_argument(task, "-c", l2tp_name);
 
 	g_free(l2tp_name);
+	g_free(ctrl_name);
 	g_free(pppd_name);
 	close(l2tp_fd);
 	close(pppd_fd);
-- 
2.20.1

