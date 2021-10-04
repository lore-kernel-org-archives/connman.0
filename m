Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45C3FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:34:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BE745E368;
	Mon,  4 Oct 2021 08:34:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633329285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=m3xi6JdE5ste0hcQYp4i4btt8D75ySQpkrX6hljOoAU=;
	b=vYexHX5+CkrSD9xq0TP9uwADgAwFwHBvLbwU2iCQ2+1cpesyRdfzdMN0LyNcZ0TgFSRWm0
	sDlpM58lJjXnAbqXj90clpZ97bDC60LXcTFjlf4UFu8Jlr8VvkbhaiZmkvKqTIzxzDTjvz
	O2MrIwJGS8qwf4kXenZmQ5XxL6fKCuOpm59vwSSuAC3P9iECCKhytdK90G3tSWFd+X/igl
	X5enkrdi0tJ2DOsHC0i3ZMUmw39F7tijGL1AdV5fWRDufofylP0IUHYk0wvWqwCcdQD/l8
	BOdjISQ0ibPbtLSTojkXe7k4/0sHgU//rnOlin2O9Co909XhDpmMyP5dJN2Yrw==
Date: Mon, 4 Oct 2021 08:34:45 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 2/2] manager: Add TetheringClientsChanged GBUS_SIGNAL
Message-ID: <20211004063445.iajbdwjz3yrzwz5o@beryllium.lan>
References: <20211001122607.34360-1-michael@amarulasolutions.com>
 <20211001122607.34360-2-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001122607.34360-2-michael@amarulasolutions.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Oct 01, 2021 at 12:26:07PM +0000, Michael Trimarchi wrote:
> Add TetheringClientsChanged as dbus signal. This can be
> seen using d-feet or other tool

Patch applied.

Thanks,
Daniel
