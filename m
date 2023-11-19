Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89414291
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 315A1730F7
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:16 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D69BC7310A
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 00/17] Address Redundant IPv4 Reachability Checks
Date: Sun, 19 Nov 2023 09:06:56 -0800
Message-ID: <20231119170714.775270-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116010259.628527-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses an issue in which, when 'EnableOnlineCheck' is
asserted, two (2) concurrent IPv4 and one (1) IPv6 reachability checks
get queued.

The issue is addressed by introducing and leveraging
'__connman_wispr_cancel' in 'cancel_online_check' to ensure that a
pending or in-flight WISPr portal detection request or an "online"
HTTP-based Internet reachability check is canceled not only in the
service module but in the WISPr module as well.

This prevents two concurrent, outstanding, and redundant IPv4 WISPr
requests from being in-flight when EnableOnlineCheck is asserted.

Prior to these changes, this redundancy was set in motion by:

    1. The two back-to-back IPv4 probes get triggered by both of the
       following paths:

       a. Triggered from 'default_changed' and
          'start_wispr_if_connected'. This is the newer path,
          chronologically, in the code base.

       b. Triggered from 'service_ip_bound', 'address_updated', and
          'start_online_check'. This is the older path, chronologically,
          in the code base.

    2. With the following commits addressed:

       a. 812e171 ("Close three '__connman_wisp_start' failure closure
          holes.")

          * With this fix alone, at minimum, the first probe above (1)
            would have resulted, eventually in a failure closure with
            'complete_online_check'.

       b. 5f95851 ("wispr: Avoid 'connman_proxy_lookup' call for
          'UNKNOWN' proxy method.") fixed, the first IPv4 probe from
          (1) no longer "falls down a 'hole'" and gets lost (closure-
          and accounting-wise).

          * With this fix, the first IPv4 probe is no longer a
            complete throwaway--it actually succeeds. However, since
            it does so, it becomes the first of the two redundant IPv4
            checks.

By employing '__connman_wispr_cancel', 'cancel_online_check' quells
the first IPv4 check triggered from 'default_changed' and
'start_wispr_if_connected' and replaces it, fully (in both the service
and WISpr modules), with the second IPv4 check triggered from
'service_ip_bound', 'address_updated', and 'start_online_check'.

Grant Erickson (17):
  wispr: Rename context proxy-related data members.
  wispr: Add and leverage 'is_wispr_supported'.
  wispr: Add documentation to 'is_wispr_supported'.
  service: Document service unref calls in 'cancel_online_check'.
  wispr: Add documentation to 'wispr_portal_detect'.
  wispr: Add documentation to '__connman_wispr_stop'.
  wispr: Add and leverage 'cancel_connman_wispr_portal_context'.
  wispr: Add documentation to 'cancel_connman_wispr_portal_context'.
  gweb: Add optional OS error status parameter to 'g_web_request_*'.
  wispr: Add and leverage an OS error parameter to
    '__connman_wispr_cb_t'.
  service: Add IP configuration type to 'cancel_online_check'.
  gweb: Add reference count debug statements.
  gweb: Factor out GWeb destruction into 'g_web_free'.
  wispr: Add '__connman_wispr_cancel' interface.
  wispr: Add documentation to '__connman_wispr_cancel'.
  wispr: Avoid double-free in 'free_wispr_routes'.
  service: Leverage '__connman_wispr_cancel'.

 gweb/gweb.c      |  94 +++++++++----
 gweb/gweb.h      |   8 +-
 src/6to4.c       |   2 +-
 src/connman.h    |   5 +-
 src/service.c    |  70 ++++++++--
 src/wispr.c      | 342 ++++++++++++++++++++++++++++++++++++++++-------
 tools/web-test.c |   3 +-
 tools/wispr.c    |   8 +-
 8 files changed, 440 insertions(+), 92 deletions(-)

-- 
2.42.0

