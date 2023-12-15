Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DC20F8
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A422E7310E
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 21:16:54 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 64A7F7312C
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 21:16:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] service: Both Cancel and Stop Online Checks where Appropriate
Date: Thu, 14 Dec 2023 18:16:51 -0800
Message-ID: <20231215021653.2156275-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This both cancels, via 'cancel_online_check', and stops, via
'__connman_wispr_stop' online checks on service disconnect or
free. The former terminates any in-flight or recurring check activity
in "service.c" and the latter terminates the same in "wispr.c".

Failure to cancel as well as stop can lead to a use-after-free fault
in one-shot or continuous online check mode when a latent online check
reschedule timer fires after the service has been disconnected or
deallocated.

To support these cancelations with a single 'cancel_online_check'
function call, support is added for passing
'CONNMAN_IPCONFIG_TYPE_ALL' to 'cancel_online_check' as the IP
configuration type parameter.

Grant Erickson (2):
  service: Add support for 'CONNMAN_IPCONFIG_TYPE_ALL' to
    'cancel_online_check'.
  service: Both cancel and stop online checks where appropriate.

 src/service.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.42.0

