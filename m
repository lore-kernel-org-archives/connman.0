Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9CA2CA3
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:00:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E4B05D19E;
	Tue, 25 Jan 2022 10:00:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643101230; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mODhJgfuc9kWnWenoEWJkl5TBYEgaAEGZ0JqRWXUTvk=;
	b=fdCTQkeuzsAiW46U4VyziAxeeBTOL27/s2k4xd46IswFXXA12ThSrxzLOxlyPS8ARo3AXN
	+70ClYlGaFQqdaKmw2DoBpm/JUyJVzrFTAPqtvh7J9zsJFFax9JSgHE2ZhgjpCWU/esKJK
	J9gXkfrocioPEOSEWnAYBxgoQrcWzHkzonkeiafpTxgry6a5lFiUpSt6J7/WORoGm2SbYV
	goRYLs3nwPMJpcEOVjROpydJOmVZxszwA4SuUzn6Ims/W8QGbowRRMjgoR+hvlsJKSKH3A
	Ns2Xa1ONCUArbO3hsX8nq7JbLlPSRUNzJCbiw4nmO7Qj+r+Ek0OdOjYMxk2zCg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Matthias Gerstner <mgerstner@suse.de>
Subject: [PATCH 2/5] dnsproxy: Update TCP length header
Date: Tue, 25 Jan 2022 10:00:23 +0100
Message-Id: <20220125090026.5108-3-wagi@monom.org>
In-Reply-To: <20220125090026.5108-1-wagi@monom.org>
References: <20220125090026.5108-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Gerstner <mgerstner@suse.de>

---
 src/dnsproxy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index fbbee0413f8f..cdfafbc292f2 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2166,6 +2166,9 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 			err = sendto(sk, req->resp, req->resplen, 0,
 				&req->sa, req->sa_len);
 	} else {
+		uint16_t tcp_len = htons(req->resplen - 2);
+		/* correct TCP message length */
+		memcpy(req->resp, &tcp_len, sizeof(tcp_len));
 		sk = req->client_sk;
 		err = send(sk, req->resp, req->resplen, MSG_NOSIGNAL);
 	}
-- 
2.34.1

