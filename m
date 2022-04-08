Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9C362
	for <connman@lists.linux.dev>; Fri,  8 Apr 2022 07:30:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B9625D685;
	Fri,  8 Apr 2022 09:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649402469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PadM7hwYsVnLGZ20Rp3oKuaRmTrptn94wifYHhlZL58=;
	b=F9+S1W8pNBsfsj9F3xhi31RnZwCXgiwiwFmVZCClwpQ54SNkahd3DX+4uMwx5JbjkTjV8U
	sg4GCwFPKHzE1DGeCwijJofqgiYeo18YFyqLrKC17CejdUODdG9HOLYIDeFcuKKIcRSgyN
	EhfHWM4r7t9Y9HEKpgwo8M/Bx65odyTQR6Bw+UXVXQQGdJC17RQMwalNo4mhIz34vTQ+Jy
	I19VpbdxaDOHmJ0VLZIExMG5zDJvz/qHt7eD8syMvL3PzrK3puj+QIJi2a03TPMHAX9img
	IUfJpc5BOPHKiH0gLk8wUw8YkwPLd3MjsWt0RgPnQA3s1rgv0MLdhQ8bfCckcA==
From: Daniel Wagner <wagi@monom.org>
To: Daniel Linjama <daniel@dev.linjama.com>,
	connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 0/2] Replace hardcoded paths with configurable runstatedir
Date: Fri,  8 Apr 2022 09:20:18 +0200
Message-Id: <164940240736.15543.5537464319001054370.b4-ty@monom.org>
In-Reply-To: <20220406180240.1191631-1-daniel@dev.linjama.com>
References: <20220406180240.1191631-1-daniel@dev.linjama.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 6 Apr 2022 21:02:38 +0300, Daniel Linjama wrote:
> Add support for configurable $(runstatedir) with RUNSTATEDIR and replace hardcoded /var/run paths
> 
> Daniel Linjama (2):
>   build: Support configurable run dir with RUNSTATEDIR
>   vpn: Replace hardcoded paths with RUNSTATEDIR
> 
> Makefile.am        | 2 ++
>  Makefile.plugins   | 1 +
>  vpn/plugins/vpnc.c | 2 +-
>  vpn/vpn-util.c     | 4 ++--
>  4 files changed, 6 insertions(+), 3 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] build: Support configurable run dir with RUNSTATEDIR
      commit: a18acc883b7312d425eb0565e5f2c4d5235f2182
[2/2] vpn: Replace hardcoded paths with RUNSTATEDIR
      commit: 7c341aef347eb2a399a2717aa79ac6043f503430

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
