Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F629559D
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:45 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53A6A1F8A3
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1646054377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhT6u1HH4dN+dJEJDrBRAYsQKGj/wWfW7aY6O15bpu8=;
	b=dsucTRb3DjflMchX0tHxXsgOZrVc393bhARBexAkwykrQzee1On2O1CH9v+2/iJF1VX8B8
	aMmDRm2gyZ8J1WWA+EzdV19uh1LR82Pv1pvlcia/rbHy/pYBvTCc2V+FST9HQe6yElzt27
	XcgY75Gzx0MoEzUfj0TbiLiqN/e9r+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1646054377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhT6u1HH4dN+dJEJDrBRAYsQKGj/wWfW7aY6O15bpu8=;
	b=VvxPGww0RPsoa1G+a3sYGmU9DUVzKwWuhxFBgxvx8Tm9wG4QqjG/lUv5Zr1C/HoR2IlKu8
	W4C25kylA0V63gDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 250A613C3E
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id alO1B+nLHGIqPwAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:37 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: [PATCH] dnsproxy: add standalone test version of dnsproxy and a test script for it
Date: Mon, 28 Feb 2022 14:19:21 +0100
Message-Id: <20220228131921.5573-2-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228131921.5573-1-matthias.gerstner@suse.de>
References: <20220221084813.sk5thg5pj24ym3db@beryllium.lan>
 <20220228131921.5573-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Gerstner <matthias.gerstner@suse.de>

Since dnsproxy is not really modular this requires building complete
connman minus the original main function. It makes testing a lot easier
though, since this standalone version doesn't require root privileges or
configuration aspects like the D-Bus connection etc.

Only build this if `--enable-test` is given, otherwise complete connmand
would be built twice just by typing `make`. Also don't add this to
CHECK_PROGRAMS, because the test could need some specific settings to
work (e.g. a working /etc/resolv.conf with domain entry).

Add `--enable-test` to bootstrap-configure such that developers notice
possible build errors introduced in the regression test build.
---
 Makefile.am                 |  13 +++
 bootstrap-configure         |   3 +-
 tools/dnsproxy-simple-test  | 112 ++++++++++++++++++++++++++
 tools/dnsproxy-standalone.c | 154 ++++++++++++++++++++++++++++++++++++
 4 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100755 tools/dnsproxy-simple-test
 create mode 100644 tools/dnsproxy-standalone.c

diff --git a/Makefile.am b/Makefile.am
index e5718b19..5ca8e6be 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -434,6 +434,19 @@ test_scripts += test/vpn-connect test/vpn-disconnect test/vpn-get \
 if TEST
 testdir = $(pkglibdir)/test
 test_SCRIPTS = $(test_scripts)
+
+tools_dnsproxy_standalone_CFLAGS = $(src_connmand_CFLAGS) -I$(srcdir)/src
+tools_dnsproxy_standalone_SOURCES = tools/dnsproxy-standalone.c $(src_connmand_SOURCES)
+# for EXTRA_PROGRAMS the BUILT_SOURCES aren't automatically added as
+# dependency, so let's do it explicitly
+tools/dnsproxy-standalone.c: $(BUILT_SOURCES)
+tools_dnsproxy_standalone_LDADD = $(src_connmand_LDADD)
+# pass -zmuldefs to let the linker tolerate the duplicate definition of
+# main(), the first definition from dnsproxy-standalone should be used
+tools_dnsproxy_standalone_LDFLAGS = $(src_connmand_LDFLAGS) -Wl,-zmuldefs
+
+noinst_PROGRAMS += tools/dnsproxy-standalone
+
 endif
 
 EXTRA_DIST += $(test_scripts)
diff --git a/bootstrap-configure b/bootstrap-configure
index 3f697987..ed5ecd78 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -18,4 +18,5 @@ fi
 		--enable-vpnc=builtin \
 		--enable-session-policy-local=builtin \
 		--enable-nmcompat \
-		--enable-polkit $*
+		--enable-polkit $* \
+		--enable-test
diff --git a/tools/dnsproxy-simple-test b/tools/dnsproxy-simple-test
new file mode 100755
index 00000000..b8fd7f77
--- /dev/null
+++ b/tools/dnsproxy-simple-test
@@ -0,0 +1,112 @@
+#!/bin/bash
+
+# this script runs the dnsproxy-standalone test program and runs a couple of
+# standard DNS queries against it, using the currently configured DNS server
+# in the system as dnsproxy configuration.
+
+echoerr() {
+	echo $@ 1>&2
+	exit 1
+}
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	"--valgrind")
+		VALGRIND=`which valgrind`
+		if [ -z "$VALGRIND" ]; then
+			echoerr "no valgrind executable found"
+		fi
+		;;
+	"-h")
+		echo "$0 [--valgrind]"
+		echo "--valgrind: run dnsproxy-standalone in valgrind"
+		exit 2
+		;;
+	*)
+		echoerr "Unknown argument $1"
+		;;
+	esac
+	shift
+done
+
+if [ -e "Makefile" ]; then
+	BUILDROOT="$PWD"
+else
+	if [ ! -n "$BUILDROOT" ]; then
+		echoerr "You need to set the BUILDROOT environment variable or run this script from the connman build tree root"
+	fi
+
+	pushd "$BUILDROOT" >/dev/null || echoerr "couldn't enter $BUILDROOT"
+fi
+make tools/dnsproxy-standalone || echoerr "failed to build dnsproxy-standalone"
+
+HOST=`which host`
+if [ -z "$HOST" ]; then
+	echoerr "Couldn't find 'host' DNS utility"
+fi
+
+DNSPROXY="$BUILDROOT/tools/dnsproxy-standalone"
+
+if [ ! -f "$DNSPROXY" ]; then
+	echoerr "standalone dnsproxy does not exist at $DNSPROXY"
+fi
+
+NS1=`grep -w nameserver -m 1 /etc/resolv.conf | cut -d ' ' -f 2`
+if [ -z "$NS1" ]; then
+	echoerr "Failed to determine system's nameserver from /etc/resolv.conf"
+fi
+
+DOMAIN1=`grep -w search -m 1 /etc/resolv.conf | cut -d ' ' -f 2`
+if [ -z "$DOMAIN1" ]; then
+	echoerr "Failed to determine default DNS domain from /etc/resolv.conf"
+fi
+
+# use an unprivileged port for the proxy so we don't need special permissions
+# to run this test
+PORT=8053
+
+# run the proxy in the background
+$VALGRIND $DNSPROXY $PORT "$DOMAIN1" "$NS1" &
+proxy_pid=$!
+
+cleanup() {
+	if [ $proxy_pid -eq -1 ]; then
+		return 0
+	fi
+	kill $proxy_pid
+	wait $proxy_pid
+	ret=$?
+	proxy_pid=-1
+	return $ret
+}
+
+trap cleanup err exit
+
+sleep 1
+echo -e "\n\n"
+
+# test both UDP and TCP mode
+for TRANSPORT in -U -T; do
+	# test both IPv4 and IPv6
+	for IP in -4 -6; do
+		echo "Testing resolution using transport $TRANSPORT and IP${IP}"
+		set -x
+		$HOST $TRANSPORT $IP -p$PORT www.example.com 127.0.0.1
+		RES=$?
+		set +x
+		if [ $RES -ne 0 ]; then
+			echoerr "resolution failed"
+		fi
+
+		echo -e "\n\n"
+	done
+done
+
+echo -e "\n\nDNS resolution succeeded for all test combinations"
+cleanup
+if [ $? -eq 0 ]; then
+	exit 0
+else
+	echoerr "dnsproxy returned non-zero exit status $?"
+fi
+
diff --git a/tools/dnsproxy-standalone.c b/tools/dnsproxy-standalone.c
new file mode 100644
index 00000000..690b4313
--- /dev/null
+++ b/tools/dnsproxy-standalone.c
@@ -0,0 +1,154 @@
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/signalfd.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "connman.h"
+
+/*
+ * This is a minimal connman setup  that only runs the internal dnsproxy
+ * component for testing. The advantage is that we can do a full integration
+ * test of the dnsproxy logic without requiring root privileges or setting up
+ * other complexities like D-Bus access etc.
+ */
+
+static GMainLoop *main_loop = NULL;
+
+static void usage(const char *prog)
+{
+	fprintf(stderr, "%s: <listen-port> <dns-domain> <dns-server>\n", prog);
+	exit(1);
+}
+
+static unsigned int to_uint(const char *s)
+{
+	char *end = NULL;
+	unsigned int ret;
+
+	ret = strtoul(s, &end, 10);
+
+	if (*end != '\0') {
+		fprintf(stderr, "invalid argument: %s", s);
+		exit(1);
+	}
+
+	return ret;
+}
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	result = read(fd, &si, sizeof(si));
+	if (result != sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+	case SIGTERM:
+		printf("Terminating due to signal\n");
+		g_main_loop_quit(main_loop);
+		break;
+	}
+
+	return TRUE;
+}
+
+static guint setup_signalfd(void)
+{
+	GIOChannel *channel;
+	guint source;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		perror("Failed to set signal mask");
+		return 0;
+	}
+
+	fd = signalfd(-1, &mask, 0);
+	if (fd < 0) {
+		perror("Failed to create signal descriptor");
+		return 0;
+	}
+
+	channel = g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				signal_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
+int main(int argc, const char **argv)
+{
+	unsigned int port = 0;
+	const char *domain = argv[2];
+	const char *server = argv[3];
+	guint signal = 0;
+
+	if (argc != 4)
+	{
+		usage(argv[0]);
+	}
+
+	port = to_uint(argv[1]);
+
+	__connman_util_init();
+	printf("Listening on local port %u\n", port);
+	__connman_dnsproxy_set_listen_port(port);
+
+	if (__connman_dnsproxy_init() < 0) {
+		fprintf(stderr, "failed to initialize dnsproxy\n");
+		return 1;
+	}
+
+	printf("Using DNS server %s on domain %s\n", server, domain);
+
+	if (__connman_dnsproxy_append(-1, domain, server) < 0) {
+		fprintf(stderr, "failed to add DNS server\n");
+		return 1;
+	}
+
+	// we need to trick a bit to make the server entry enter "enabled"
+	// state in dnsproxy. Appending and removing an arbitrary entry causes
+	// "enable_fallback()" to be called which does what we want. Doesn't
+	// make much sense but it is good enough for the standalone server at
+	// the moment.
+	__connman_dnsproxy_append(15, domain, server);
+	__connman_dnsproxy_remove(15, domain, server);
+
+	signal = setup_signalfd();
+
+	main_loop = g_main_loop_new(NULL, FALSE);
+
+	g_main_loop_run(main_loop);
+
+	__connman_dnsproxy_cleanup();
+	__connman_util_cleanup();
+	g_source_remove(signal);
+
+	return 0;
+}
-- 
2.34.1

