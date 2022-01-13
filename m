Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A3168
	for <connman@lists.linux.dev>; Thu, 13 Jan 2022 16:11:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F0035CD01;
	Thu, 13 Jan 2022 17:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642089940; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pOvqNuSUxOSnoBlXSLnXrZTeRJ7l9Kbt7bWTZ/SiGqc=;
	b=ROL1v58mFEADHY2ngEtsOY9Nog3fA6kyQmzjCwAzXbh2nkqPvROEnNNC61lEmIMRKKKcCD
	cu8jXP837JwGWFgiEA4nQAEyf4chMLosPK+qZ/kHcJrc3yKNmTKmsEGzjo/Kdw7cW8bOSu
	vHXJErZ+WdA7kA991JUtPqV9sAkzfSDUEGQRhTQU/+jEcw82bhgqRZLFB43xp35Tp8X6e6
	MrfbQuB9nuFcNv/OGXM3kBcwZBzzk2DCKVz6iqYaVMsRqsJnBJGVzuXAde79I9uR2JvT5M
	2L5igor0AsZ2kaBVmL7ZId+ssyDB5ksZ22M150gPGjS0uoQIN1ORm66c5ib/Lw==
Message-ID: <55549edc-f52b-0552-2134-d87c6dc71416@monom.org>
Date: Thu, 13 Jan 2022 17:05:37 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Network with same ssid question
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 connman@lists.linux.dev
References: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On 13.01.22 16:43, Michael Nazzareno Trimarchi wrote:
> I'm not sure about this use case. If we have multiple networks with
> the same ssid, should connman show all of them?

IIRC, ConnMan merges those together and only exposes it one Service.

Daniel
