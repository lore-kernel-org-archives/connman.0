Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E246173
	for <connman@lists.linux.dev>; Mon, 14 Jun 2021 07:00:46 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 5504E50056C;
	Mon, 14 Jun 2021 09:00:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id E44315004AE;
	Mon, 14 Jun 2021 09:00:42 +0200 (CEST)
Date: Mon, 14 Jun 2021 09:00:42 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com,
	andrew.shadura@collabora.co.uk, niraj.g@samsung.com,
	n.chaprana@samsung.com, marcel@holtmann.org
Subject: Re: [RFC connman v2 1/1] WIP: Add wpa_supplicant WPA3-SAE support
Message-ID: <20210614070042.mtst3o4utquyzfkq@beryllium.lan>
References: <20210527214134.33792-1-ariel.dalessandro@collabora.com>
 <20210527214134.33792-2-ariel.dalessandro@collabora.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527214134.33792-2-ariel.dalessandro@collabora.com>

Hi Ariel,

On Thu, May 27, 2021 at 06:41:34PM -0300, Ariel D'Alessandro wrote:
> Implement WPA3-SAE authentication on connman side using wpa_supplicant
> backend.
> 
> Initially based on Tizen project:
> 
>   https://review.tizen.org/git/?p=platform/upstream/connman.git
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

We don't do the SOB, so I just dropped.

I applied the patch, there were small style issues which I fixed it
directly.

Probably we should update the documentation which wpa_supplicant version
is needed to support WPA3.

Thanks,
Daniel
