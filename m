Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AE70
	for <connman@lists.linux.dev>; Wed,  9 Jun 2021 08:00:59 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id E9627500517;
	Wed,  9 Jun 2021 10:00:57 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id BC86D5002C0;
	Wed,  9 Jun 2021 10:00:57 +0200 (CEST)
Date: Wed, 9 Jun 2021 10:00:57 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Valery Kashcheev <v.kascheev@omp.ru>
Subject: Re: [PATCH] dnsproxy: Check the length of buffers before memcpy
Message-ID: <20210609080057.w4rfmhk7gifk4zrr@beryllium.lan>
References: <20210609075935.21746-1-wagi@monom.org>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609075935.21746-1-wagi@monom.org>

Hi,

On Wed, Jun 09, 2021 at 09:59:35AM +0200, Daniel Wagner wrote:
> From: Valery Kashcheev <v.kascheev@omp.ru>
> 
> Fix using a stack-based buffer overflow attack by checking the length of
> the ptr and uptr buffers.
> 
> Fix debug message output.
> 
> Fixes: CVE-2021-33833

Patch applied.

Thanks,
Daniel
