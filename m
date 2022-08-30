Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A929A1
	for <connman@lists.linux.dev>; Tue, 30 Aug 2022 14:36:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF0055E07F;
	Tue, 30 Aug 2022 16:36:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661870180; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EFkOIV+VGyLAoestAiLeE/bKAJKMSvbhRGDUPxl+RxI=;
	b=iCV/sKUVp8UKJ1qNt0q2LeDfgSmQn1hXXJHRTCD20ZGSYne3tShPLZ9/SVu5r+j3B62M5R
	R+5eMHtcMLzoUAZneCHfevYRl92G+B6NBanrN2voCXIzOjr0nziebEvikdgojDQPsx0KS0
	068JeV9dyfRGMaFSsmy/tbAXE9MUp0X03NQpnrozZYCXA/yyrp83+TNwRC3sEIm6oQAAD2
	3Hc9O8JxufTC6+8pWUngg7ynbyGAvO028oZu15XGmA2x2Lv/DsOFz+geyJIModp+nlKw3S
	Pe8QF+nrKSbDczMNxFt0FxA+fuJbxRLsj6RSjdlznJNv3ffnKNO0/rJ5snU26w==
Message-ID: <7d291a8b-712e-50a5-041d-feeca49f9d4e@monom.org>
Date: Tue, 30 Aug 2022 16:36:19 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] resolver: Add path to resolv.conf to config options
Content-Language: en-US
To: Jakub Jirutka <jakub@jirutka.cz>, connman@lists.linux.dev
References: <20220615165350.11431-1-jakub@jirutka.cz>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <20220615165350.11431-1-jakub@jirutka.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

seems there is something wrong with this patch:

(connmand:3947): GLib-WARNING **: 13:14:06.270: GError set over the top 
of a previous GError or uninitialized memory.
This indicates a bug in someone's code. You must ensure an error is NULL 
before it's set.
The overwriting error message was: Key file does not have key 
?ResolvConf? in group ?General?
