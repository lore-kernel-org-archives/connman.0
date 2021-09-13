Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D513FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 06:37:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EDA15E30A;
	Mon, 13 Sep 2021 08:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1631514464; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=62L37lh4Ws6IQILlUgrIex2YCvulbs0BpZ9TdVzHX7M=;
	b=nbu9I28eJXGLfDHqckFSS8GXnrb2a+Hb69Ql5zbaic2+ZJQwAp+Gwp0rWwenswDalr329V
	jjeGIwy5LUuKjuu/LU1jEHrUPE4ArHPMNSFn/k+9xZysnuFAroErbpbm6qFXu59UB7E6Y7
	5Cl7S74IDLrnLIzaoJ3PjgbrXgcEbbQReIOPUIfvjg9D+8wNT24aqBPOjzsuYWARLZPgsS
	u+3H10pc3CWP72fd3u3yxZPcC5Pud/KW+Xt/caOkR0NOWMYJEAA2wJxG90yraa0KbkgiCb
	Vuzf6xoHs/v2XeCjCbBhi9/oPCZXpi/vjOP69QRAWNvedFtXP7kiOCPbQZypRg==
Date: Mon, 13 Sep 2021 08:27:39 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com
Subject: Re: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
Message-ID: <20210913062739.ltsywwgs7lzsz7mp@beryllium.lan>
References: <20210804212315.265376-1-ariel.dalessandro@collabora.com>
 <20210805060704.maeaww6q75x4obqy@beryllium.lan>
 <d4e6e9ee-0f0b-1fa2-c814-4eebaac304ce@collabora.com>
 <9186c76b-f2e7-03ec-55ad-2bc5c3177db2@collabora.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9186c76b-f2e7-03ec-55ad-2bc5c3177db2@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ariel,

[back from holiday :)]

On Thu, Sep 09, 2021 at 08:10:10AM -0300, Ariel D'Alessandro wrote:
> >> This looks good. If no one speaks up I am going to apply it.
> 
> Any other feedback on this one? Can we merge it?

Sure, patch applied.

Thanks!
Daniel
