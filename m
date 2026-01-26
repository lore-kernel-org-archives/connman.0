Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DB33A70D
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435089; cv=none; b=JS7Z99Ft96HxdgrUYJyQrTsSCYSPwArIi5KFFjvaJjlwQ4Yz1I3Q2g8Y7VdJ/hlQT1qt8S+lED1kVswzf2Xupn4cPODQMXVrOKAzQ0ZcJ3OxUjLKLCjsOiK2XLQsWWBqlyj2qMuF7ofgD0hvk6DtmQf0ue5zNaX2bDFY8XQhOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435089; c=relaxed/simple;
	bh=F8M2XS+Fi2qoi+3SYva7B77D7hfBOI+e+JuQG+hRmQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNNe9pw6nds0WRdQjXHD3udWPpCut/w1i1J/hTSikd5KNDlPaZVmfugNk2fk5dshs5oBKxxTpiiLKu0/UQJRX3jewewKx3toIcZA08pZXJEf/cqyla7+WK7Ok+eSVw7NknWst9S+T32tKouXR2wWYZhKVXuNH5I8+nxoTF2rhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=MjGHOF3a; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="MjGHOF3a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nK8IGj7HdzOS9tS9Lzk0omCudclAgJUxsoSphSL/wEs=; b=MjGHOF3alPb/lqjz2SiWToPLks
	/rZ/B43D4rHqO0LgWp9jenHuSjYaQFEQ3DMKmnVWoCRNH9F5m+xenLQaCqsZF7joz8WszhJjrbr2i
	Pq4L+AX3DKbJ+GlqiBOH5rZflrFTcVezd8xCQ0XYCFuE50cVnWx8jNFmLQnbzw2pXbxMr9WZsUuhq
	sUnSIuNJWY3okXdxoshVokritbl97Dj3RfPFcMVWO2xWyplyLApZP4skb1GmHHCjHHhj6yXtCXnoH
	/HJ493qVqRAMAXmOCUwI+Qr+ro5ynzgGgMZSSTms+wNBD/ru2DeXwY2cPUdb7uBwKD/sGCGdhuhKa
	wCHNUYfA==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-2h
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 8/9] l2tp: Fix potential TOCTOU cases with the created/removed files
Date: Mon, 26 Jan 2026 15:43:47 +0200
Message-ID: <20260126134410.55749-9-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
References: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Time-of-check to time-of-use (TOCTOU) would be possible with symlinks to
overwrite or remove files. Add O_NOFOLLOW to file creation and check
before unlink() is called that we are not removing a symlink as the
files l2tp.c creates are regular files.

Cleanup the creation and removal code a bit. Set the control pipe
creation to last in the run_connect() so other files are checked first.
In case of error at run_connect() unlink files and free private data to
avoid memory leaks as the task has not been ran, thus, l2tp_died() gets
never called.
---
 vpn/plugins/l2tp.c | 117 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 28 deletions(-)

diff --git a/vpn/plugins/l2tp.c b/vpn/plugins/l2tp.c
index d770a96e..354f2e30 100644
--- a/vpn/plugins/l2tp.c
+++ b/vpn/plugins/l2tp.c
@@ -130,7 +130,7 @@ struct l2tp_private_data {
 	char *if_name;
 	vpn_provider_connect_cb_t cb;
 	void *user_data;
-	bool remove_secrets_file;
+	bool create_secrets_file;
 };
 
 static void l2tp_connect_done(struct l2tp_private_data *data, int err)
@@ -141,6 +141,8 @@ static void l2tp_connect_done(struct l2tp_private_data *data, int err)
 	if (!data || !data->cb)
 		return;
 
+	DBG("");
+
 	/* Ensure that callback is called only once */
 	cb = data->cb;
 	user_data = data->user_data;
@@ -151,6 +153,8 @@ static void l2tp_connect_done(struct l2tp_private_data *data, int err)
 
 static void free_private_data(struct l2tp_private_data *data)
 {
+	DBG("");
+
 	if (vpn_provider_get_plugin_data(data->provider) == data)
 		vpn_provider_set_plugin_data(data->provider, NULL);
 
@@ -558,30 +562,56 @@ static int l2tp_write_secret(struct vpn_provider *provider, int fd)
 	return err;
 }
 
-static void l2tp_died(struct connman_task *task, int exit_code, void *user_data)
+static bool is_file_symlink(const char *filename)
 {
-	struct l2tp_private_data *data = user_data;
-	char *conf_file;
+	int fd;
 
-	DBG("died of %d", exit_code);
+	if (!filename || !*filename)
+		return false;
 
-	vpn_died(task, exit_code, data->provider);
+	fd = open(filename, O_WRONLY|O_NOFOLLOW|O_CLOEXEC);
+	if (fd == -1 && errno == ELOOP)
+		return true;
+
+	if (fd >= 0)
+		close(fd);
+
+	return false;
+}
+
+static void unlink_files(struct l2tp_private_data *data)
+{
+	char *conf_file;
 
-	conf_file = g_strdup_printf(VPN_STATEDIR "/connman-xl2tpd.conf");
-	unlink(conf_file);
+	conf_file = g_strconcat(VPN_STATEDIR, "/connman-xl2tpd.conf", NULL);
+	if (!is_file_symlink(conf_file))
+		unlink(conf_file);
 	g_free(conf_file);
 
-	conf_file = g_strdup_printf(VPN_STATEDIR "/connman-ppp-option.conf");
-	unlink(conf_file);
+	conf_file = g_strconcat(VPN_STATEDIR, "/connman-ppp-option.conf", NULL);
+	if (!is_file_symlink(conf_file))
+		unlink(conf_file);
 	g_free(conf_file);
 
-	if (data->remove_secrets_file) {
+	if (data->create_secrets_file) {
 		conf_file = g_strconcat(VPN_STATEDIR,
 						"/connman-xl2tpd-secrets.conf",
 						NULL);
-		unlink(conf_file);
+		if (!is_file_symlink(conf_file))
+			unlink(conf_file);
 		g_free(conf_file);
 	}
+}
+
+static void l2tp_died(struct connman_task *task, int exit_code, void *user_data)
+{
+	struct l2tp_private_data *data = user_data;
+
+	DBG("exit code %d", exit_code);
+
+	vpn_died(task, exit_code, data->provider);
+
+	unlink_files(data);
 
 	free_private_data(data);
 }
@@ -885,6 +915,22 @@ static int request_input(struct vpn_provider *provider,
 	return -EINPROGRESS;
 }
 
+static int open_file(const char *filename)
+{
+	int fd;
+
+	if (!filename || !*filename)
+		return -EINVAL;
+
+	fd = open(filename, O_RDWR|O_NOFOLLOW|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
+	if (fd < 0 && errno == ELOOP) {
+		connman_error("Refusing to overwrite symlink %s", filename);
+		return -EACCES;
+	}
+
+	return fd;
+}
+
 static int run_connect(struct l2tp_private_data *data,
 			const char *username, const char *password,
 			bool use_challenge, const char *auth_file)
@@ -911,24 +957,16 @@ static int run_connect(struct l2tp_private_data *data,
 
 	l2tp_name = g_strdup_printf(VPN_STATEDIR "/connman-xl2tpd.conf");
 
-	l2tp_fd = open(l2tp_name, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
+	l2tp_fd = open_file(l2tp_name);
 	if (l2tp_fd < 0) {
 		connman_error("Error writing l2tp config");
 		err = -EIO;
 		goto done;
 	}
 
-	ctrl_name = g_strconcat(VPN_STATEDIR, "/connman-xl2tpd-control", NULL);
-
-	if (mkfifo(ctrl_name, S_IRUSR|S_IWUSR) != 0 && errno != EEXIST) {
-		connman_error("Error creating xl2tp control pipe");
-		err = -EIO;
-		goto done;
-	}
-
 	pppd_name = g_strconcat(VPN_STATEDIR, "/connman-ppp-option.conf", NULL);
 
-	pppd_fd = open(pppd_name, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
+	pppd_fd = open_file(pppd_name);
 	if (pppd_fd < 0) {
 		connman_error("Error writing pppd config");
 		err = -EIO;
@@ -941,23 +979,38 @@ static int run_connect(struct l2tp_private_data *data,
 						"/connman-xl2tpd-secrets.conf",
 						NULL);
 
-		secrets_fd = open(secrets_name, O_RDWR|O_CREAT|O_TRUNC,
-						S_IRUSR|S_IWUSR);
+		secrets_fd = open_file(secrets_name);
 		if (secrets_fd < 0) {
-			connman_error("Error writing l2tp secrets");
+			connman_error("Error opening l2tp secrets for writing");
 			err = -EIO;
 			goto done;
 		}
 
 		/* Toggle the created file to be removed at shutdown */
-		data->remove_secrets_file = true;
-		l2tp_write_secret(provider, secrets_fd);
+		data->create_secrets_file = true;
+	}
+
+	/* Create control pipe as last to allow file checks to go through. */
+	ctrl_name = g_strconcat(VPN_STATEDIR, "/connman-xl2tpd-control", NULL);
+
+	if (mkfifo(ctrl_name, S_IRUSR|S_IWUSR) != 0 && errno != EEXIST) {
+		connman_error("Error creating xl2tp control pipe");
+		err = -EIO;
+		goto done;
 	}
 
 	l2tp_write_config(provider, pppd_name, l2tp_fd);
 
 	write_pppd_option(provider, pppd_fd);
 
+	if (data->create_secrets_file) {
+		if (l2tp_write_secret(provider, secrets_fd)) {
+			connman_error("Error writing l2tp secrets file");
+			err = -EIO;
+			goto done;
+		}
+	}
+
 	connman_task_add_argument(task, "-D", NULL);
 	connman_task_add_argument(task, "-C", ctrl_name);
 	connman_task_add_argument(task, "-c", l2tp_name);
@@ -986,8 +1039,16 @@ done:
 	if (secrets_fd != -1)
 		close(secrets_fd);
 
-	if (err)
+	if (err) {
 		l2tp_connect_done(data, -err);
+		/*
+		 * The task has not been run so l2tp_died() never gets called,
+		 * unlink the files when error happens to avoid leaving them
+		 * behind.
+		 */
+		unlink_files(data);
+		free_private_data(data);
+	}
 
 	return err;
 }
-- 
2.47.3

