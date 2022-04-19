Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C48ED8
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:52:02 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8686B1F74D
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1650365139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkyu3RmOSxAwt9OiDhZ/dFvrEFZuhfwZ18fg5x0Dyr4=;
	b=QgfAe42WxeyBfCrO9oKFnXWkFO4IT+aIRzThNGVr0N0ifsWsBmqVuKVkkuSMlZ3H40rz2i
	pYgHJ9Ci2F8RT6PckubS3Kaj5rnljCJ5wQK6tW7gReXQ8tIQvxhbNM05pR2JOieppnaDNX
	9PYB3rYPbblW6wDnfxV4GTXh12/vWok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1650365139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkyu3RmOSxAwt9OiDhZ/dFvrEFZuhfwZ18fg5x0Dyr4=;
	b=dO+gmZCp2q7jVW0JnagEuXqpn8fRghk14PjKoqYIgWSIfghCtCczpmNdKeK2I4w1i+iaRb
	QZf6x1gGvlcbWSAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F8D6139BE
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id hVQfH9OSXmLZOAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:39 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 01/12] dnsproxy-simple-test: improve test coverage and test flexibility
Date: Tue, 19 Apr 2022 12:34:50 +0200
Message-Id: <20220419103501.30553-2-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419103501.30553-1-matthias.gerstner@suse.de>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- enable debug() macro for test invocation which allows to get test logs
- actually trigger caching logic explicitly by querying the same
  configurations twice in succession
- count the number of cache hits to catch regressions in the caching
  functionality
- support custom domains for testing specified on the command line
---
 Makefile.am                |   2 +-
 src/dnsproxy.c             |   6 +-
 tools/dnsproxy-simple-test | 113 ++++++++++++++++++++++++++++++++-----
 3 files changed, 104 insertions(+), 17 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index c108b8f3c..1a3dbe3c9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -438,7 +438,7 @@ testdir = $(pkglibdir)/test
 test_SCRIPTS = $(test_scripts)
 
 if INTERNAL_DNS_BACKEND
-tools_dnsproxy_standalone_CFLAGS = $(src_connmand_CFLAGS) -I$(srcdir)/src
+tools_dnsproxy_standalone_CFLAGS = $(src_connmand_CFLAGS) -I$(srcdir)/src -DDNSPROXY_DEBUG
 tools_dnsproxy_standalone_SOURCES = tools/dnsproxy-standalone.c $(src_connmand_SOURCES)
 # for EXTRA_PROGRAMS the BUILT_SOURCES aren't automatically added as
 # dependency, so let's do it explicitly
diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 227300477..fd14c8e0a 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -41,7 +41,11 @@
 
 #include "connman.h"
 
-#define debug(fmt...) do { } while (0)
+#ifdef DNSPROXY_DEBUG
+#	define debug(fmt...) do { } while (0)
+#else
+#	define debug(fmt...) do { fprintf(stderr, fmt); fprintf(stderr, "\n"); } while (0)
+#endif
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 struct domain_hdr {
diff --git a/tools/dnsproxy-simple-test b/tools/dnsproxy-simple-test
index b8fd7f77d..5c2f72925 100755
--- a/tools/dnsproxy-simple-test
+++ b/tools/dnsproxy-simple-test
@@ -6,9 +6,25 @@
 
 echoerr() {
 	echo $@ 1>&2
+	echo -e "\n   >>> ERROR OCCURED <<<   \n" 1>&2
 	exit 1
 }
 
+
+showlog() {
+	if [ -z "$SHOW_LOG" -o -z "$logfile" ]; then
+		return
+	fi
+
+	echo
+	echo "======== debug log ==========="
+	cat "$logfile"
+	echo "===== end debug log =========="
+	echo
+}
+
+TRANSPORTS="-U -T"
+
 while [ $# -gt 0 ]; do
 	case "$1" in
 	"--valgrind")
@@ -16,10 +32,39 @@ while [ $# -gt 0 ]; do
 		if [ -z "$VALGRIND" ]; then
 			echoerr "no valgrind executable found"
 		fi
+		# log valgrind output to stdout, since stderr is used for
+		# debug output from dnsproxy.c already and we want to parse
+		# that.
+		# also cause an error exit it valgrind error occur so that
+		# they're easily noticed.
+		VALGRIND="$VALGRIND --log-fd=1 --error-exitcode=10"
+		;;
+	"--gdb")
+		WAIT_GDB=1
+		# wait forever to avoid timeout conditions during debugging
+		HOST_OPTS="-w"
+		;;
+	"--show-log")
+		SHOW_LOG=1
+		;;
+	"--testdomain="*)
+		TESTDOMAIN=`echo $1 | cut -d '=' -f2-`
+		CUSTOM_TESTDOMAIN=1
+		;;
+	"--only-tcp")
+		TRANSPORTS="-T"
+		;;
+	"--only-udp")
+		TRANSPORTS="-U"
 		;;
 	"-h")
-		echo "$0 [--valgrind]"
+		echo "$0 [--valgrind] [--gdb] [--show-log] [--only-tcp] [--only-udp] [--testdomain=<mydomain>]"
 		echo "--valgrind: run dnsproxy-standalone in valgrind"
+		echo "--gdb: allows you to attach via GDB before tests are started"
+		echo "--show-log: dump debug log from dnsproxy at end of test"
+		echo "--only-tcp: only perform TCP protocol based tests"
+		echo "--only-udp: only perform UDP protocol based tests"
+		echo "--testdomain=<mydomain>: the domain name to resolve"
 		exit 2
 		;;
 	*)
@@ -29,6 +74,11 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
+if [ -n "$VALGRIND" -a -n "$WAIT_GDB" ]; then
+	echo "Cannot mix valgrind frontend and GDB attachment" 1>&2
+	exit 2
+fi
+
 if [ -e "Makefile" ]; then
 	BUILDROOT="$PWD"
 else
@@ -66,7 +116,8 @@ fi
 PORT=8053
 
 # run the proxy in the background
-$VALGRIND $DNSPROXY $PORT "$DOMAIN1" "$NS1" &
+logfile=`mktemp`
+$VALGRIND $DNSPROXY $PORT "$DOMAIN1" "$NS1" 2>"$logfile" &
 proxy_pid=$!
 
 cleanup() {
@@ -77,6 +128,13 @@ cleanup() {
 	wait $proxy_pid
 	ret=$?
 	proxy_pid=-1
+	if [ -n "$logfile" ]; then
+		if [ -n "$SHOW_LOG" ]; then
+			showlog
+		fi
+		rm -f "$logfile"
+		unset logfile
+	fi
 	return $ret
 }
 
@@ -85,24 +143,49 @@ trap cleanup err exit
 sleep 1
 echo -e "\n\n"
 
-# test both UDP and TCP mode
-for TRANSPORT in -U -T; do
-	# test both IPv4 and IPv6
-	for IP in -4 -6; do
-		echo "Testing resolution using transport $TRANSPORT and IP${IP}"
-		set -x
-		$HOST $TRANSPORT $IP -p$PORT www.example.com 127.0.0.1
-		RES=$?
-		set +x
-		if [ $RES -ne 0 ]; then
-			echoerr "resolution failed"
-		fi
+if [ -n "$WAIT_GDB" ]; then
+	echo "You can now attach to the dnsproxy process at PID $proxy_pid."
+	echo "Press ENTER to continue test execution"
+	read _
+fi
+
+if [ -z "$TESTDOMAIN" ]; then
+	TESTDOMAIN="www.example.com"
+fi
 
-		echo -e "\n\n"
+# perform each test twice to actually get cached responses served for each
+# combination
+for I in `seq 2`; do
+	# test both UDP and TCP mode
+	for TRANSPORT in $TRANSPORTS; do
+		# test both IPv4 and IPv6
+		for IP in -4 -6; do
+			echo "Testing resolution using transport $TRANSPORT and IP${IP}"
+			set -x
+			$HOST $HOST_OPTS $TRANSPORT $IP -p$PORT $TESTDOMAIN 127.0.0.1
+			RES=$?
+			set +x
+			if [ $RES -ne 0 ]; then
+				echoerr "resolution failed"
+			fi
+
+			echo -e "\n\n"
+		done
 	done
 done
 
+NUM_HITS=`grep "cache hit.*$TESTDOMAIN" "$logfile" | wc -l`
+
 echo -e "\n\nDNS resolution succeeded for all test combinations"
+echo -e "\nNumber of cache hits: $NUM_HITS\n"
+# assert we have seen the expected number of cache hits in the log
+# this is the amount of cache hits for the default domain tests as seen before
+# refactoring of dnsproxy started.
+if [ -z "$CUSTOM_TESTDOMAIN" -a "$NUM_HITS" -ne 15 ]; then
+	echoerr "Unexpected number of cache hits encountered"
+elif [ "$NUM_HITS" -lt 8 ]; then
+	echoerr "Too low number of cache hits encountered"
+fi
 cleanup
 if [ $? -eq 0 ]; then
 	exit 0
-- 
2.35.1

