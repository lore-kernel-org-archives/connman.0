Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14A2FB8
	for <connman@lists.linux.dev>; Mon, 14 Jun 2021 11:57:05 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id C39CD50032F;
	Mon, 14 Jun 2021 13:57:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 8377C500328;
	Mon, 14 Jun 2021 13:57:02 +0200 (CEST)
Date: Mon, 14 Jun 2021 13:57:02 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com,
	andrew.shadura@collabora.co.uk, niraj.g@samsung.com,
	n.chaprana@samsung.com, marcel@holtmann.org
Subject: Re: [RFC connman v2 1/1] WIP: Add wpa_supplicant WPA3-SAE support
Message-ID: <20210614115702.irahmhk4stcbhebk@beryllium.lan>
References: <20210527214134.33792-1-ariel.dalessandro@collabora.com>
 <20210527214134.33792-2-ariel.dalessandro@collabora.com>
 <20210614070042.mtst3o4utquyzfkq@beryllium.lan>
 <d7977fbd-3d03-e9d9-8a5e-1222707eb285@collabora.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7977fbd-3d03-e9d9-8a5e-1222707eb285@collabora.com>

Hi Ariel,

On Mon, Jun 14, 2021 at 08:50:10AM -0300, Ariel D'Alessandro wrote:
> > I applied the patch, there were small style issues which I fixed it
> > directly.
> 
> Great! Thanks a lot for your help.

Thanks for your contribution. Really appreciated.

> > Probably we should update the documentation which wpa_supplicant version
> > is needed to support WPA3.
> 
> Which doc files should be updated? I can take a look at that and put
> some notes together.

There was some recommendation on the wpa_supplicant version in the
README. I wonder if this is still valid.

Thanks,
Daniel
