Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928CC28D827
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302817; cv=none; b=fbVrT0avb3GnZLCfJXj4tlNVKzZ5KqsPKiVdU4F33rxcSop1yCGe80WFwQ67pfNRGkk8GCQ8ZnfocaAB64IRcY88Z/rCE3eEOWFwiOi3lsEZpVGnVKj6saKz8zkyTyVJMgM7g9Q5A4XclbVf44qBnrXlPSEjpQrccYK6YK03G4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302817; c=relaxed/simple;
	bh=vf/eufLSZauboerl2Wbf+EQW3fmROqMp3SGC1anvdJo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNm99S7DmRR4cUs+7eEGf6UMtUQ0LD+a9/o76StqFnpSUspsMs4vJ5lwcLd/oLoDhl1iSx3ECpiPYcFwsnqs3sSeCGDAHeB0gdmLdXbh6G8gxU6GFzWW0uhuZ5zqPy60zzwLKX8KW0jqd1DXC4wqzGM6WAErxwKDFA2IEWRMGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=xhMxSGDV; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="xhMxSGDV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hipSS29psuz3xGcxGZ27U7cy4dOHzD6yolYcv03dHho=; b=xhMxSGDV43oToEibMhr20OGwt6
	swdmFXaAFmuyU9fBWN7Xop8w490hYo1S+u+8gJBA6eDF3hali1Gg2hqZUCvyXl8P6qlnoS++cSF7s
	Dz+Rgvtvml4nQmdN4X2HtTjLUW4ZiRyGllUPHNBy+UWhXFM+GNvwuy2DnahFEQD/hCmYN2mrNBU+e
	udh5d7KcbBIMgMW7KY/I1WZcHfnPpKvkTbFb9uiGmb9/DA8/6nokkTI/YXnrnFlBKCPe22QwSydnh
	2HSkK5tKkymyb5UzbFdNQmCBNcH5oS3ydguyXk9pyJPFI7V06sBoA744zZGeSiH6d/Y6BXgNGX4fk
	ZSXnwZQA==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIp-004Gb9-0s
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:55 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 8/8] vpn: Fix mem leak of gid_list in task setup
Date: Thu, 10 Apr 2025 18:58:46 +0300
Message-Id: <20250410155846.252858-9-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:604d:112d:4f8c:3578
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Fix mem leak reported by Clang analyzer.
---
 vpn/plugins/vpn.c | 3 ++-
 1 file changed, 2 insertions(+)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index fc2a0e74..1644e16d 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -506,6 +506,8 @@ static void vpn_task_setup(gpointer user_data)
 	/* Change user for the task if set, requires CAP_SETUID */
 	if (uid > 0 && setuid(uid))
 		connman_error("error setting uid %d %s", uid, strerror(errno));
+
+	g_free(gid_list);
 }


--
2.39.5


