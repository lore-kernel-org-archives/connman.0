Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D5C89
	for <connman@lists.linux.dev>; Tue, 15 Feb 2022 08:54:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 425B35D332;
	Tue, 15 Feb 2022 09:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644915264; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=k7J8w6nAmVfeirUkzfkAEdCkuzPUbOgvPPJep0lKQWE=;
	b=PCb9yjpnXHgB5a9wD2KA2sHtky5JE+hV/+3bAgd2M9GpA52zN1ne5VRj5WhcfIFLHnkG8J
	8ER+bISWQ4EvsPNM4y0wtUj5FwWwWgy9mkDhRAqWvmkGMjj2n8o1kcgedtocjrL7dKkkYT
	12YfutdiTT3oa8Q3Kj6KH5+XwrP0j8EVP27yXO375VtTQl/mDGN+4++BV7t+36pf+zTrXf
	pSjx+3ITbEBlRChJBxZOmZfSGd/RQWQZaV9DQNR1hnHNL+ol5bB4Xxz65PHL7fOYEeYCaJ
	vAcpZw0zYbDis/0hZQbSoE9s9CMnobmjbH2SIaEFl2RUfW/HjvgsY6En4/o/uw==
Date: Tue, 15 Feb 2022 09:54:21 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Use same signal strength calculation as
 wpa_supplicant
Message-ID: <20220215085421.etbz6gznwcb3qsct@carbon.lan>
References: <20220214021357.522946-1-net147@gmail.com>
 <20220214073654.5wwvht6ntswylci5@carbon.lan>
 <CANwerB32EdUdktYrPx36X2XBrO366s6mHCcy0da0FUm6LMH8ig@mail.gmail.com>
 <20220214152329.g27nz7ennzsj5ked@carbon.lan>
 <CANwerB1uBPi4fXfECCwxuAgDsPQHfBW8=aXbwqbmUQNicothOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANwerB1uBPi4fXfECCwxuAgDsPQHfBW8=aXbwqbmUQNicothOw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Feb 15, 2022 at 08:41:35AM +1100, Jonathan Liu wrote:
> Can we first reach a consensus about whether to
> 1. Change the iwd signal calculation to match wpa_supplicant

Yes.

> 2. Change the wpa_supplicant signal calculation to match iwd
> 3. Do nothing to either plugin to avoid changing behavior of existing
> devices/applications or Linux distributions using connman

No, people will complain and think it's an regression.

> If we change the wpa_supplicant calculation then I imagine people
> would complain about reduced signal strength after updating (e.g. in
> OSMC and many other devices/applications or Linux distributions using
> connman).

For sure.

> The wpa_supplicant calculation regards a signal level of -20 dBm or
> higher as 100%.
> The iwd calculation regards a signal level of -20 dBm as 80% and 0 dBm as 100%.

The signal strength is used to sort the services internally. IIRC, this
might trigger the connect algorithm for wpa_supplicant but for iwd it
shouldn't as we rely on iwd to do the right thing (see the 'native'
connect mode). So we should not change the wpa_supplicant signal
strenght math (check the git history on this topic).

Daniel
