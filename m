Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58221C04
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 16:53:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18F4AE2FEB;
	Wed, 23 Nov 2022 17:46:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1669221984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3Qf3K7CiL7rak4QD9VQrH32sN5M/g/OCnxSqk35eBtA=;
	b=dafqVejo+fqoLDmFBrJ/MrYQuFn7zh7z8nCTNyknP69KKTWjQUi10gPlQBCjkAaz/AYPhc
	zviB+PaziqtTRayum6X903xMFb6oraDQfLaeOIwn6vuLSBE6YkQ8VAfJX1OHLxaVT53yaI
	sIliOy4/AYlhJyfvaAEpiRstgwO7n9jcGanYDOprYXl6WZNFyB+IDx+B6AGyc4qHVA3e4f
	Z2yn1qX1DFQf1dx9xSvJNZG61RR6pyivr6E3EGEUiKRoMe91eJy1ZB8ZavjF35t9feEnNn
	b0ysT8o1ELvhRUdX6t7VAxN3C1lUgyw2Jex0HyDCHxYFd5h2HxyaYZxvyhl8Ew==
Message-ID: <1981e97d-7775-c3a2-e011-6c073be8d254@monom.org>
Date: Wed, 23 Nov 2022 17:46:22 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: autoip address set/reset loop
Content-Language: en-US
To: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Cc: connman@lists.linux.dev
References: <9af7ed7a-be9b-962a-bcfd-8b482d45a65f@gmail.com>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <9af7ed7a-be9b-962a-bcfd-8b482d45a65f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Geoffrey

On 23.11.22 15:56, Geoffrey Van Landeghem wrote:
> Subject: Re: autoip address set/reset loop
> 
> Here is the patch:
> 
>  From b7750b925714572cba12275e6da49b8b70cd3fbb Mon Sep 17 00:00:00 2001
> From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
> Date: Tue, 22 Nov 2022 19:50:12 +0100
> Subject: [PATCH] ipconfig: revert not adding invalid gateway routes

Thanks for digging into this bug. But this trading one bug against 
another one. If not I need an explanation why this is okay to do.

Thanks,
Daniel
