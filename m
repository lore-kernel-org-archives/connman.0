Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159F2CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:48:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBF1F5CD87;
	Sun, 19 Dec 2021 18:48:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639936101; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zJgb++aHlvW0ngHFtHABDb2uMdRtMlvT9BDAsrBN6Yc=;
	b=rzxhAMm2WKy4ZJf9KBbJv9vQ4uZ9GCZAlYItsGHmkK8SIfjGRBxgxdmlUbOCNdOCqFlLOq
	vD+P1zvcfXSkgPvPPxP1V1dtxzslTG4TS08PVo9GcyN2PCOzw3ypVOCq9i0VXjuGPUUBUi
	44gvtucDNnKhp7hYW4CCx5cwZX2hH5LN3U1nAgc5tOJ9K+XnMQsOlALu8ic1UDvHIWnKM7
	KrnwkQyss4fbFuj/pgolqlUwzp+056xC8ToP6P3pggtBLwzUKc8Mx6kB+5DeSzerhT2x3V
	MwNMGIoCV3vC0udsS9QNY+L6DX3amtbyDULUMz+lvOHhSX7gsEeJmBaLhcFw1A==
Date: Sun, 19 Dec 2021 18:48:20 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: Christian Taedcke <christian.taedcke@lemonbeat.com>,
	connman@lists.linux.dev
Subject: Re: [PATCH] ipconfig: Do not enable/disable ipv6 for all ifs
Message-ID: <20211219174820.4a22ybjsc2pmesob@beryllium.lan>
References: <20211122130346.114768-1-christian.taedcke@lemonbeat.com>
 <eaf58704-04c3-b6be-54b9-88ef707f95d2@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf58704-04c3-b6be-54b9-88ef707f95d2@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Nov 22, 2021 at 05:10:09PM +0200, Jussi Laakkonen wrote:
> Good find. This indeed fixes this particular issue, IPv6 does seem to get
> disabled after removing a USB ethernet device. Surprising side effect.

Indeed :)

> With a quick glance I cannot see any problems related to this, I'm not 100%
> sure if there is a case where this disable_ipv6() is used via
> __connman_ipconfig_disable_ipv6() to completely disable IPv6, Daniel?

As far I can tell, ConnMan is operating on per interface level (if using
this interface). So this should be okay.

I am going to apply the patch.
Daniel
