Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DAC12D
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1E07773203
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 02:58:10 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DC36A7327D
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 02:58:09 -0500 (EST)
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
Subject: [PATCH 1/3] gweb: Rename 'parse_url'.
Date: Mon, 6 Nov 2023 23:58:08 -0800
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
Message-Id: <01231125-E711-40E1-AA83-C3A2E266981A@nuovations.com>
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

