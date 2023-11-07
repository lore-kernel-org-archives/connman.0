Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834030645
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A7815731F4;
	Tue,  7 Nov 2023 17:52:43 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 433C873248;
	Tue,  7 Nov 2023 17:52:43 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 1/3 v2] gweb: Rename 'parse_url'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <01231125-E711-40E1-AA83-C3A2E266981A@nuovations.com>
Date: Tue, 7 Nov 2023 14:52:42 -0800
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <691A5A8B-89B5-4194-983B-63E62A95A5A4@nuovations.com>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <01231125-E711-40E1-AA83-C3A2E266981A@nuovations.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'parse_url' to 'parse_request_and_proxy_urls' to more
accurately reflect its role and function in processing BOTH a request
URL and, optionally, a proxy URL for the specified web request session.
---
 gweb/gweb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 13c6c5f2..4d464cf2 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1107,7 +1107,7 @@ static int create_transport(struct web_session =
*session)
 	return 0;
 }
=20
-static int parse_url(struct web_session *session,
+static int parse_request_and_proxy_urls(struct web_session *session,
 				const char *url, const char *proxy)
 {
 	char *scheme, *host, *port, *path;
@@ -1297,7 +1297,7 @@ static guint do_request(GWeb *web, const char =
*url,
 	if (!session)
 		return 0;
=20
-	if (parse_url(session, url, web->proxy) < 0) {
+	if (parse_request_and_proxy_urls(session, url, web->proxy) < 0) =
{
 		free_session(session);
 		return 0;
 	}
--=20
2.42.0

