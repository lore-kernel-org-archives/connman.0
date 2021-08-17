Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967A6D19
	for <connman@lists.linux.dev>; Tue, 17 Aug 2021 06:01:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28F505E3F1;
	Tue, 17 Aug 2021 08:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1629180073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YwoiFU8abta9BNvyaFi+qRofBpvmk9bUkfwSoKdXLS8=;
	b=doGcHq1zslz968rbzoGkeStDXL5fnJTnWZzdU9qO+T5c3JyJO7EIVRB2n0WfIEOBIxEGWY
	YedmVwLcnv85bvS7IEg3EPz8XJhyWJr/eSDnVnOiUd4wA6Zknp8c4+EnKcghQ4TkN8zw4Z
	RZfKb/Z5jXlPfVOGJ9xobIrae9zrKel5LxMipwtdJgDi5+gWDSPiDp338QWx3Vf+cs6qkm
	EG3CUfqyz1RKlHh4Ahr1dHL60JkRwKg7tIGGepbG17CfGGRnTeQZyzFeiuH8qFfTVlthCT
	wANds+4I8ItVP08lNj0R42VBH14s39KdrSLuWj5JbWT9YsyQk1mUuIzUYSeRQQ==
Date: Tue, 17 Aug 2021 08:01:10 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 0/3] Improve invalid auth and disconnect notify on l2tp
 and pptp
Message-ID: <20210817060110.txygy4gtkke5gnng@carbon.lan>
References: <20210813134209.23253-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813134209.23253-1-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Fri, Aug 13, 2021 at 04:42:06PM +0300, Jussi Laakkonen wrote:
> Both l2tp and pptp have the symptom that when authentication is invalid
> the binary keeps on looping disconnect notify. As a solution to this the
> task can be stopped to ensure that binary also dies. And to further make
> the process better adapt similar connect done -approach that is used in,
> e.g., OpenVPN to ensure the callback (vpn-provider.c:connect_cb()) will
> get called only once.
> 
> This change makes both plugins to respond with 0 ("ok") only after the
> notify from the binary is received that connection is established. Both
> of the plugins did reply with 0 right after run_connect() which was not
> the proper way.
> 
> Also add support for using ConnMan specific control file with xl2tpd
> using -C switch. 

Patches applied. Thanks!
Daniel
