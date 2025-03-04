Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038EBE5E
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050684; cv=none; b=L456wJJpZCEYLhbhneBbd1YHTNn2KGDKoMiCI760vWCNEgPs6PjiJQiN9DKpY9ojw0wIXwISpH0YQP38yOkRmmkWUsP6BMtU3D+FSpE7p4AwqqkvlE+pnP+9uwaJ2aPqSO1QAjaf8LX0kmsnKTG2rDDtBvlAsGyOVIBh20yo+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050684; c=relaxed/simple;
	bh=ieOmx8crtALBZ0D8dKsr5ShV9TCGrVTrYHJhDiMsup0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L/HrJNvvo1vwRPeSRBowbU10UOvucubZ80kb4uC7Eu0LkucpWxjAGmmikMWhKa0LuN9DP5kQtrLaarvMe7k8QQvxomatSsovvcfffed/2NPZmYNqw12wGHo2r8/1JB/R5ek3UE2QQlHICL4gQESX32c1ZccJPm7j5vY8xRJpNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=szKqgRl8; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="szKqgRl8"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 7FEAE164B23
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:15 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2A53D124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 00/22] Close Two GWeb Request "Bookend" Failure "Holes"
Date: Mon,  3 Mar 2025 17:10:51 -0800
Message-ID: <cover.1741048994.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=pgyTcpLDbVJbK8QW8oLpYFJoF+vdB7ADjhtyvGrXAso=; b=szKqgRl82crjcIEiBszaL+8aOWd6TWw6g+6Ijnl25LL3UWEmmMl7SpGGOZ11Cvpa9Lq219SmO/K9Oh8IPw0m2M0/W0MkWCk7sO4oxsRVk39U6zr2J5e1o3T5j9wlstACgVFXhI94ixHAkxRsahFuavj7NjGGV3Ad3q1KWFjzM7CKBHZbwV+HxOlbzMdKjuTyKshjYWUPyTMXyOc85VmZmsepku+DPNg0v+jjkm2VcIvhSID6TN0d/7Nd+HKJnGOHyVxtoRuelK1MUsjMpSwQ5fQE7s90UuJlsmVoG+r2HdKucUn5W+7MJB/bVh1UQZ1TqVf/VE8zegpAdhR7Uyz3Iw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

There existed, prior to this set of changes, two "holes" in the
finalization of web request sessions that can, for example in a client
such as WISPr leave one or both of IPv4 and IPv6 "online" HTTP-based
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
of data from 'g_io_channel_read_chars' but received none and
accumulated no headers thus far upon receiving the status
'G_IO_STATUS_EOF', then GWeb assumes that the remote peer server
unexpectedly closed the connection, and synthesizes the error
'-ECONNRESET' with the same HTTP status "null" value of
GWEB_HTTP_STATUS_CODE_UNKNOWN. With the addition of the new
'g_web_result_get_err' interface, clients such as WISPr can now
distinguish between a low-level operating system error in which no
HTTP data was received and a success in which HTTP data was received
and the status can be disguished by the HTTP status code.

The second of the two failure "holes" involves the case where
'g_io_channel_read_chars' returns 'G_IO_STATUS_ERROR' status. Prior to
this change, this funneled to the same "hole" as the 'G_IO_STATUS_ERROR'
failure with the same consequence to clients such as WISPr.

To handle this error case, GWeb now passes a glib 'GError' pointer to
'g_io_channel_read_chars'. If it is set, GWeb maps the resulting error
domain/code pairs to negated POSIX domain errors, and default to '-EIO'
if no suitable mapping can be made. As with the failure EOF case, this
allows clients to distinguish and handle such failures and to
successfully "bookend" their initial web request.

With these changes, WISPr now leverages the newly-added GWeb
'g_web_result_get_err' interface to refactor 'wispr_portal_web_result'
into 'wispr_portal_web_result_err' and
'wispr_portal_web_result_no_err' with the former handling
non-successful POSIX error domain cases and the latter handling
successful HTTP status code cases.

With this change, the second, failure EOF case will now return
'-ECONNRESET' from 'g_web_result_get_err' and will be handled as a
failure by 'wispr_portal_web_result_err', "bookending" the original
"online" HTTP-based Internet reachability check.

All of the prior HTTP status code cases are handled by
'wispr_portal_web_result_no_err'.

Grant Erickson (22):
  gweb: Leverage 'GWEB_HTTP_STATUS_CODE_UNKNOWN' mnemonic.
  gweb: Refactor 'received_data' into
    'received_data_{finalize,continue}'.
  gweb: Added 'g_web_result_has_headers'.
  gweb: Add documentation to 'g_web_result_has_headers'.
  gweb: Added 'g_web_result_get_err'.
  gweb: Add documentation to 'g_web_result_get_err'.
  gweb: Add an OS err parameter to 'call_result_func'.
  gweb: Add documentation to 'call_result_func'.
  gweb: Add documentation to 'g_web_result_get_status'.
  gweb: Add documentation to 'received_data'.
  gweb: Close web request session finalization 'hole'.
  gweb: Add documentation to 'map_gerror'.
  gweb: Add documentation to 'received_data_{finalize,continue}'.
  gweb: Document 'struct _GWebResult'.
  wispr: Add and leverage 'portal_manage_failure_status'.
  wispr: Refactor 'wispr_portal_web_result' to leverage
    'g_web_result_get_err'.
  wispr: Document 'portal_manage_failure_status'.
  wispr: Document 'wispr_portal_web_result_err'.
  wispr: Document 'wispr_portal_web_result_no_err'.
  wispr: Document 'wispr_portal_web_result'.
  wispr: Fix documentation typo in 'portal_manage_success_status'.
  service: Capture and propagate '__connman_wispr_start' return status.

 gweb/gweb.c   | 444 ++++++++++++++++++++++++++++++++++++++++++++++----
 gweb/gweb.h   |   3 +
 src/service.c |   9 +-
 src/wispr.c   | 236 +++++++++++++++++++++------
 4 files changed, 602 insertions(+), 90 deletions(-)

-- 
2.45.0

