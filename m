Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8D2D048
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 272FE73225
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:08:37 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E902C732D3
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:08:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 3/3] service: Leverage return status of 
 'service_downgrade_online_state'.
Date: Mon, 6 Nov 2023 14:08:36 -0800
References: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
Message-Id: <686D7B66-9885-4BD6-91D0-B3DDD0DAA482@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages the newly-changed 'bool' return status of
'service_downgrade_online_state' in 'complete_online_check' is leveraged
to avoid polling service state before and after the call to
'service_downgrade_online_state' to determine whether to take downgrade-
specific action.
---
 src/service.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index 8b6110b6..e807decf 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1825,7 +1825,6 @@ static void complete_online_check(struct =
connman_service *service,
 	GSourceFunc redo_func;
 	unsigned int *interval;
 	guint *timeout;
-	enum connman_service_state current_state;
 	guint seconds;
 	guint current_timeout;
=20
@@ -1858,9 +1857,7 @@ static void complete_online_check(struct =
connman_service *service,
 	if (success) {
 		*interval =3D online_check_max_interval;
 	} else {
-		current_state =3D service->state;
-		service_downgrade_online_state(service);
-		if (current_state !=3D service->state)
+		if (service_downgrade_online_state(service))
 			*interval =3D online_check_initial_interval;
 		if (service !=3D connman_service_get_default()) {
 			return;
--=20
2.42.0

