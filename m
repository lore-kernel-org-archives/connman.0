Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3B7A
	for <connman@lists.linux.dev>; Mon, 16 May 2022 06:35:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC95A5D97A;
	Mon, 16 May 2022 08:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1652682938; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=U/B+xpJjyqkIHhWIVrpR7ooMxpdDZG9zHz6tlHFgPpg=;
	b=N1w66Pyp9IDHbKRWQ9IUtrCTRZEovekUXf8BX39Le0igWvxePpYzJWSzeDrxyZviYPffyx
	H24tMRxMLUd31Vp/HTeLYS9wgSzzqUNhcCRcQfdOPZIWSoQZ1jKlgG6v3TGjqIORlgGRyL
	99uckcpAhHUIkkURn3QdI8T+AvpidbgTCXrZgRV/eGpCWAwT2kSeVR7pqhnqGuL/1jCmJk
	rH3eLaNtRePQ9UWwjzMFKY0wwnXRT9fruYu7fvVR4VBhnQ4TLctyewqyv970CD/SDHoQAn
	neJvICcSLdB4W9pI0BXrFNzNOYvT/hZrgizU+a+QFvtKcWmYqraVp1fW6qrB8g==
Date: Mon, 16 May 2022 08:35:37 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ryan Smith <ryan.smith@density.io>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v1 2/2] wispr: Fix online check when using WPAD/PAC
Message-ID: <20220516063537.w4pcfgxscxmotg5h@beryllium.lan>
References: <20220411173217.505144-1-ryan.smith@density.io>
 <20220411173217.505144-2-ryan.smith@density.io>
 <20220414190136.zebsvyjysfyem3tz@beryllium.lan>
 <CAM7Wg-Xhvm9zFJx4wnr5pVo_VDGTh+UK9GSbDX_HB+uAVk0kiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7Wg-Xhvm9zFJx4wnr5pVo_VDGTh+UK9GSbDX_HB+uAVk0kiw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Apr 14, 2022 at 02:44:49PM -0600, Ryan Smith wrote:
> It looks good to me. Thanks for the quick response!

And now I got really slow. Was on holiday...
