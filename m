Received: from metanate.com (dougal.metanate.com [90.155.101.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C9177
	for <connman@lists.linux.dev>; Tue, 29 Jun 2021 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
	:Content-Description; bh=75HjOqYDOq+Bfj84Plg6yh5+JmQ+wvdTQysh9srEbMs=; b=BCsw
	xF+/d2icsRd3tJsu5LyfNs9KmAfsMApYil+jgpHrggDOh2gBSU35VeHaJOzVmXQH4UFXkbF75mUo1
	naMMYpOPKpNOHU31im4QEL++wl+LbrT9L66YaFi4XKnQ9voISasxxtwsbdTBUMSjhpWNlsjeahOzB
	C4N3V3ZeAR679xo0x30irzVQ4sbOJV+0nZ1FU9dRtNzBrxdc38G9ue8eEft5DhqItQD35dspuoInE
	Aqf7p2k4hc0TpVJ/rOhg0Gtl37xlTHFFCOBG1/5Y+xkFdUFw52VvZaVcZ4+v8iE3frqSHlQmS7o+e
	EbB2mpltclnNE8I84YCN6NIu0TZx7w==;
Received: from [81.174.171.191] (helo=donbot)
	by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <john@metanate.com>)
	id 1lyBIJ-00022E-Dd; Tue, 29 Jun 2021 11:48:43 +0100
Date: Tue, 29 Jun 2021 11:48:42 +0100
From: John Keeping <john@metanate.com>
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] agent: Always inform upper layer via callback
Message-ID: <20210629114842.2d8a486d.john@metanate.com>
In-Reply-To: <20210629073326.22689-1-wagi@monom.org>
References: <20210629073326.22689-1-wagi@monom.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES

On Tue, 29 Jun 2021 09:33:26 +0200
Daniel Wagner <wagi@monom.org> wrote:

> The upper state machine expects to be called in all cases. Do not
> silenty eat up the callback.
> 
> Fixes: 8ea2d67a6e89 ("service: Complete only after user connection retries")
> Reported by John Keeping

Tested-by: John Keeping <john@metanate.com>

I've run through a few tests with this patch and it looks good!

Thanks for tracking down the issue here.


John
