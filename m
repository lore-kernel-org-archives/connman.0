Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53AA56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 07:05:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8B2F5D874;
	Wed, 25 May 2022 09:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653462325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yiG/Ht/t6083LVxl3m968CzHD1IiDOC/l02XkJs2aTI=;
	b=05xxC4dZjEfHRHLDw7//voze7taSryM03L+G0cL5xXjX5mQARKpibPRfc9TvpFuh52CX+8
	LGOgrq70/d5d5Dau6IlqM0xlosJauX20d1FW0HBWevefQoN3C/c6kIuFbBYZBg6lXMYCVx
	9qBuIpVGyCNR3CQGiZIBodj6JwHUjm+w9VcudwF8LkWeU9tRDjdASdGrwlmaBbp2RR9CCz
	TWlN5gpEM3ZkDq1sLskZZs0Gj81xjQKPNXCpQOXxi0Xpln0q+qMV9yVike/MAwRJ8sk3xS
	tVRcC5sDKPDo51h7MWFbdBX3CBIe9YalIN6Ht5AWKnizmTryimxEIdeNgz6BxQ==
Date: Wed, 25 May 2022 09:05:24 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jakub Jirutka <jakub@jirutka.cz>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] service: Add "Ethernet" property for VPN into
 n.c.Manager GetServices
Message-ID: <20220525070524.jwmo43rkyk7xphvh@beryllium.lan>
References: <20220426194853.13343-1-jakub@jirutka.cz>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426194853.13343-1-jakub@jirutka.cz>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Apr 26, 2022 at 09:48:53PM +0200, Jakub Jirutka wrote:
> Scope:
> This patch affects the Service properties exposed by D-Bus method
> GetServices in interface net.connman.Manager.

Patch applied.
Thanks,
Daniel
