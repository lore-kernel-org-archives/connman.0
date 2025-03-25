Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FD1EE7AA
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878778; cv=none; b=mEZuWggrGxY+EQs8KyX2Djgo1C+a2YYji+eEAGea91yGBgsik8CmBunUQhXyKPz4cts92OGq+wVQLvWRArXTIC4RFeDi/JzOlPiMnqW1fptWyCYR70AK5zmqF/1pWmi2IbqaiWBROqndKe6v2JXrSUlFws2JlBFyed0dmfpjVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878778; c=relaxed/simple;
	bh=uWNUmkhnPGC8wdWubzI1aJG8B+53wcsJw4KEMscDKk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HnB52Fd0ERkimOi1j/XbImgSwiZNOyPphfPk/vujHcMLi6WTbPCuJd2H/E7bq96GftcUtuOeUh0vg3rs7eGambgmWTcVJVlf7wJ1xPlNNrsthbDLKEbq6kEeN2YXU/SQHW+KUKxVWEqIKweVGSSqok82Iy5MLhLeJ5zyrKlWfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=T2jbYedr; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="T2jbYedr"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 76FF0164AA4
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:29 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 266FA12516C
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:29 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 0/9] Close Two GWeb Request "Bookend" Failure "Holes"
Date: Mon, 24 Mar 2025 21:59:18 -0700
Message-ID: <cover.1742878567.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=cdBfXnJ6WW7OBzQdLsqROom3Wy5JW+3XB1cP06T9LjU=; b=T2jbYedrAeleGCSq4LIMbu9x4J3THooqxDgnIL1Y5QDV+iCRGbebouexrhrMw9lM7++IYlooCt+aaq8sSV4SY25kEwNSGFpN2tmF+GHTWl9NCyE2fDIzs+BeFQwk4n7FxGQPwTLqxDF4hFo2s6MJaQm75wEg/6saof1rHPANXbSCjjXui73BxDzVpF25ZnaWSwzs7jdyBEHFY4WTjYMlRJwkUdO5keZXDWphKKZevXocUZYBLo+T4XaFC9EE1Dbx6DBfhgC5Nq++b6d1NIioZcLT7E/ucnSq32L77vdqc8KTp2VuFeQGzmxR0wbV/H633874KQoqV7OJLnTLFOHc6w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

There existed, prior to this set of changes, two "holes" in the
finalization of web request sessions that can (for example, in a client
such as WISPr) leave one or both of IPv4 and IPv6 "online" HTTP-based
Internet reachability checks "dangling" and non-renewing such that an
expected active, default network service failover does not occur when
it should.

The first of those two failure "holes" involves an end-of-file (EOF)
condition. In the normal case, there are a series of one or more data
receipts for the web request as headers and, if present, the body of
the request response are fulfilled. When there is no further data to
send, the final receive completes with 'g_io_channel_read_chars'
returning 'G_IO_STATUS_EOF' status and zero (0) bytes read. This should
and does lead to a successful EOF closure of the web request.

However, there is a second EOF case that appears to happen with a
random distribution in the nginx server backing the default "online"
HTTP-based Internet reachability check URLs,
'ipv[46].connman.net/online/status.html'. In that case, the nginx
server appears to periodically do an unexpected and spontaneous remote
connection close after the initial connection but before any data has
been received.

For WISPr, presently, all such failures hit the same error-handling
block which effectively maps such a failure to the effective "null"
'GWEB_HTTP_STATUS_CODE_UNKNOWN' status value. Unfortunately, clients
such as WISPr have no way to distinguish this as an actual failure or
success and so it lands on the case:

	case GWEB_HTTP_STATUS_CODE_UNKNOWN:
		wispr_portal_context_ref(wp_context);
		__connman_agent_request_browser(wp_context->service,
				wispr_portal_browser_reply_cb,
				wp_context->status_url, wp_context);

which does not "bookend" the original, initiating WISPr web request
and leaves the original request "dangling" and non-renewed, eventually
leading to the aforementioned "hole" and network service failover
failure.

To handle this failure EOF case, if GWeb asked for a non-zero amount
of data from 'g_io_channel_read_chars' but received none and has
accumulated no headers thus far upon receiving the status
'G_IO_STATUS_EOF', then GWeb assumes that the remote peer server
unexpectedly closed the connection, and synthesizes a new GError with
the error 'ECONNRESET'. With the addition of the optional, immutable
GError parameter to the GWebResult callback function, clients such as
WISPr can now distinguish between a HTTP non-response in which no HTTP
data was received and one in which HTTP data was received and the
status can be disguished by the HTTP status code.

The second of the two failure "holes" involves the case where
'g_io_channel_read_chars' returns 'G_IO_STATUS_ERROR' status. Prior to
this change, this funneled to the same "hole" as the
'G_IO_STATUS_ERROR' failure with the same consequence to clients such
as WISPr.

To handle this second error case, GWeb now passes a glib GError
pointer to 'g_io_channel_read_chars'. If it is set, GWeb passes the
GError through to the GWebResult callback function. Otherwise, it
synthesizes a GError anew from 'EIO'. As with the failure EOF case,
this allows clients to distinguish and handle such failures and to
successfully "bookend" their initial web request.

With these changes, WISPr now leverages the newly-added
'GWebResultFunc' GError parameter to refactor
'wispr_portal_web_result' into 'wispr_portal_web_result_failure' and
'wispr_portal_web_result_success' with the former handling
non-successful cases and the latter handling successful HTTP status
code cases.

With this change, the second, failure EOF case will now return a
non-null GError instance from 'GWebResultFunc' and will be handled as
a failure by 'wispr_portal_web_result_failure', "bookending" the
original "online" HTTP-based Internet reachability check.

All of the prior HTTP status code cases are handled by
'wispr_portal_web_result_success'.

This approachs works within the boundaries of the following constraints:

  1. The gio/gio.h header cannot be included in either src/wispr.c
     or src/service.c since that throws a bunch of symbol conflicts
     with gdbus/gdbus.h which redefines a number of symbols otherwise
     defined by gio/gio.h.

  2. 'handle_online_check_failure' in src/service.c needs to determine
     when a check failed due to cancellation.

     a. Historically, it looked at 'err == -ECANCELED' from the WISPr
        closure callback.

     b. However, due to (1), using 'g_error_matches(error, G_IO_ERROR,
        G_IO_ERROR_CANCELLED)' instead of 'err == -ECANCELED' cannot be
        used. So, passing 'const GError *error' all the way through will
        not work.

  3. Some HTTP status codes are failures insofar as WISPr is
     concerned. The codes are not important, the error messages are.

  4. WISPr failure messages need to be logged in src/service.c by
     'online_check_log_failure'. A simple null-terminated C string
     will do.

Grant Erickson (9):
  gweb: Adopt optional, immutable GError instance for GWeb result
    errors.
  gweb: Added and leveraged 'call_result_func_{failure,success}'
    wrappers.
  gweb: Close web request session finalization 'hole'.
  gweb: Add documentation to 'received_data_{finalize,continue}'.
  wispr: Refactor 'wispr_portal_web_result' to leverage 'GError'.
  wispr: Document 'wispr_portal_web_result_failure'.
  wispr: Document 'wispr_portal_web_result_success'.
  wispr: Document 'wispr_portal_web_result'.
  wispr: Add an optional 'message' parameter to '__connman_wispr_cb_t'.

 gweb/gweb.c      | 267 +++++++++++++++++++++++++++++++++++++++++------
 gweb/gweb.h      |   2 +-
 src/6to4.c       |   3 +-
 src/connman.h    |   3 +-
 src/service.c    |  61 +++++++----
 src/wispr.c      | 185 +++++++++++++++++++++++++-------
 tools/web-test.c |   2 +-
 tools/wispr.c    |   2 +-
 8 files changed, 430 insertions(+), 95 deletions(-)

-- 
2.45.0

