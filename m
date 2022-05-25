Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF2A56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 07:14:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6B825D9D9;
	Wed, 25 May 2022 09:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653462869; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pn5IDNnSo+gXIa/UDAHS4bvB0omagpQD85zap51NoOs=;
	b=vj+AJRsKLxBRYhTiGDKNwa0be94sPbanuu1HM4RPZxJ3Mg9cwikNKMrJG8PHRALNiWUr/Y
	OVfgpm210b9odxmJyYvCyUdIQkCpSIBAYK3cQW+uikuLRaEChNye5rhjFdtyElfYbsJTvQ
	DHJwSEkpr176TIVbSi5d02a/Z5oqmTPH3n53mywN0npVnqXg7lMOWaP5hNqG84L+lcKKD6
	4niIR1zEiAEN70PCD/kXiId0qEbkMsCUAPhmvNZ/xP7Aq91LzTNJojz1TP20bcxYRofYr4
	fMESG/hqntD8Zb216Yex7DlPxLDaibn/0Qfq/OQK5zX9A/yxYnI3DfNBYPeCPQ==
Date: Wed, 25 May 2022 09:14:28 +0200
From: Daniel Wagner <wagi@monom.org>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: connman@lists.linux.dev, jeik01.kim@samsung.com
Subject: Re: [PATCH] wispr: Prevent use-after-free from __connman_wispr_stop()
Message-ID: <20220525071428.ogzuezyctzqxtwzx@beryllium.lan>
References: <CGME20220524095332epcas1p43ec50919c2e0eac3b3b87c64b7c526ca@epcas1p4.samsung.com>
 <20220524095921.13971-1-sw0312.kim@samsung.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524095921.13971-1-sw0312.kim@samsung.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, May 24, 2022 at 06:59:21PM +0900, Seung-Woo Kim wrote:
> From __connman_wispr_stop(), list element wispr_portal freed by
> g_hash_table_remove() is accessed. Prevent the use-after-free by
> accessing the list element before free.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

Good catch. Patch applied.

Thanks,
Daniel
