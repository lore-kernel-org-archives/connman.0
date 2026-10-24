Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860121;
	b=VPe8IG8S3dDukPYnrBG6ox5cKhSCrZH4D0YL7UViQB/aPHSG+DZ5U4ZD5+83E4nNZNyJ
	 Ot7LUd1F2om+HC9FfaLMb6I0LCVWZ1J5gAFnuOpcEpE1z2KXcjAlch2qfdR1fk2554rsC
	 LeSofXkqd9yrKZ6qCAEXG5fgx/9gq8XDHNMA6vsjNtiuKS26xP2HXfN4/KMMFVkosqKQF
	 fgHJJnQSwxJxnmnCnb1qs+1fpnQxlw6prdPVxgke5GrithFZaBg5jtt51kzr4veKhB53V
	 S3N2X17ZJQjSPw21FDMOxxBAe4ZuqbtZAR98ETwOlkkXMJW3GYCikxQogx3/b05WNIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860121;
	h=DMARC-Filter:Received:Received:From:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:To:
	 X-Mailer:DKIM-Signature:X-Scanned-By;
	bh=iBLclvxV5Cl/Akyq3ZwV37saMPKeprSQcOZxrhNe+lQ=;
	b=xqQDQzi2GQHNf4ZqJNsgukPigkMNrtgL1MaC1bPGR9tBlHZLdeLgWbBSKev8xdl35VD1
	 eE5KkY3QXbJDAta5tRILckUYj9xVouzMuSTw/r5/2vmkvJ//Ziw184ZWfKUgz2DKKfgi3
	 8nVCV9XFUGjry7NPUGSPTuO+6YUX2H071/JgkBEMAUvR8Wf95z2O4to1b0oPN+5w3G/cu
	 2wLKjuCjyMjCXOJxb3GJjB8vvbcPeLbMwWOu9V8l8TK85aZXBd32ZruvYjABgeNsoik5M
	 z1Ncf+AVOBnA81Cfmv67H643c7OhiiB8oWxUOiwzKA4W2gh9eOjw44gVzpLH27b41xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=MEK3x5Fz;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C58606A31A
	for <connman@lists.linux.dev>; Sat, 24 Oct 2026 16:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47C58606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=MEK3x5Fz
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A0CA91600A7
	for <connman@lists.linux.dev>; Sat, 24 Oct 2026 12:41:53 -0400 (EDT)
Received: from smtpclient.apple (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 51123124E50
	for <connman@lists.linux.dev>; Sat, 24 Oct 2026 12:41:53 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Aborts on Wi-Fi Enable (Use-after-Free (UAF) of the Regulatory Domain
 String) 
Message-Id: <78DF2762-F6FB-4CAE-914E-22FB02E300E7@nuovations.com>
Date: Sat, 24 Oct 2026 09:41:42 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3864.700.51.1.3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:content-type:content-transfer-encoding:mime-version:subject:message-id:date:to; s=pair-202401062137; bh=iBLclvxV5Cl/Akyq3ZwV37saMPKeprSQcOZxrhNe+lQ=; b=MEK3x5Fz2tmQvzmN95OhZBhqTkP1u6M5r4BYIqW2sjbqnlGSj3rS8E1L9XGUcNVwXgT/gHIDSGqrWlt+6LLyETSZ7uRzDikctO4U237/OqJzZ+odxgD8C80iY0ghZUXtRh/UTMoYBDza2pB0yqF1/h88O8cFek6dIFoMpmlKZfVD5qUMfYW3ykAxRV/Q5QvWlKjMPdyL6K4CnZu/wa0AmMCb3C6Cy2KdSgdZ5GN1a3dWA527cX0bTztT4Fcbhn57ue8YSGNvk1I4jdUctSOxOMHzqVH8qxQ0qn08gQqPV3YZNuxL0PQcXy/NNs3n5Vm7PW/l3USHlT/mjm5JSds0WQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

FYI:

    https://github.com/Nuovations/connman/issues/146

Patches forthcoming.

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

