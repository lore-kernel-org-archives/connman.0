Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D81363
	for <connman@lists.linux.dev>; Mon, 16 Jan 2023 07:33:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3A60DAF2B;
	Mon, 16 Jan 2023 08:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1673854381; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MzNYQ/go6o4P02Lh5YsnS5ocIh/ZT3BtsQm345bUDU4=;
	b=HwkCqCp6eu4n0p2Khf1sjFKn3vPe21K0MKzUQRrQ8Uk0sqf5eW7aQdmuE7ZVrNDh3knXZn
	SNezpCgUC+ViDCckCpjYiAR0Chd7GVGM5myv8WxIqptK02NyA5uixPrcCJbWllx8G+mHY7
	Zzo8x0282B+XjrZbRsn7sOUGPANOAa+JAlFw7YeFeRYJ7kJqibZXVjhirwl54/fQpcCDXw
	qQPUBk18pPd/w63DhJrKdu8LwK21WGPHjDn8ZfygQqDEmNulYJwQaPkCjOSip7/huUpSNA
	Cwg6mEZNoGWWxxi7Mgri/C8nYkBRORAhryOCYh3EmKnrLIZa87T2Hm9uJ54Mbw==
Date: Mon, 16 Jan 2023 08:33:00 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: Jade Lovelace <jade@jade.fyi>, connman@lists.linux.dev
Subject: Re: Connman Request for feature
Message-ID: <20230116073300.hy6spqhqitohj3eu@beryllium.lan>
References: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
 <20230102084635.74a7xgmwmvbxiodn@beryllium.lan>
 <CAG17S_MbDM+-Jv4AvyeLU3_P-TYoLXaN+Ym-38UbqkCpDTnuOQ@mail.gmail.com>
 <CAG17S_O_cy2gCgsdSLqpy6c5JXVg=LeGS9pxE-3SzHsHYs1YzQ@mail.gmail.com>
 <CAFA9we8eF3Uof5vTVZPNHcTxfwK5JUXVgV_n8TZVpi+zEYcD0w@mail.gmail.com>
 <CAG17S_MWsA98=doWTPMkGJMK0G_wfwrNaASjDz6nTWO+dd_Znw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_MWsA98=doWTPMkGJMK0G_wfwrNaASjDz6nTWO+dd_Znw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Jan 09, 2023 at 12:12:28PM -0600, KeithG wrote:
 Thanks for the hints. I'll have to see if I can make heads and or
> tails of this. As you can tell from my first attempt, I am not well
> versed in this. I'll see if I can get some help and make a patch. As
> it was, I locked up the machine and it wouldn't even connect via
> ethernet.

Let me see if I can get quickly a patch for you ready to test. When I looked at
it, it didn't strike me as that complicated to get going (yep, famous last
words).
