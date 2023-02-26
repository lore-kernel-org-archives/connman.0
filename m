Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E093D61
	for <connman@lists.linux.dev>; Sun, 26 Feb 2023 19:21:19 +0000 (UTC)
Date: Sun, 26 Feb 2023 19:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1677439272; x=1677698472;
	bh=/r8f9m59SOJd/hiqovF7BCLUMfmMos5S+1PK23OQEGw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lY8nA1giSdk2qpd3VvWriUfkP85dVYmz6EaOZEExyozeddA9IAvyAUN0p+NylhavO
	 s2RkNUMq+JDnI8RR0VNe9Yp4Aycubb0y0uwpXDcfC02GmLnMKDtlAD1cMt1og4MVOf
	 wu50kX8/j99XciWClEdvY1fd+XjdHTiigjB9mLLye6IleJ07MSSvHSCvr8NtZl59qN
	 YtLW/W5CzCF2VCrAUYRIPpeugxGOJQgy10A4Nh/fqxdgv8lTq2oYC74wzX7QNO4B+j
	 0Na/rnzvzw+Mo1GPmorKsNFKRlLM20SgvGqdjV+Qz/rgYomXsgic/aGJwYpI/vfSsy
	 O7qWYTqFPcZcg==
To: connman@lists.linux.dev
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Subject: Re: No 6GHz networks found if connman does the scan, but connman see them if 'iw DEV scan' used instead.
Message-ID: <91794321-2d0b-0c40-3d02-9880c20c7cab@protonmail.ch>
In-Reply-To: <2712e513-6def-4ed1-d88a-68c961f995e3@protonmail.ch>
References: <2712e513-6def-4ed1-d88a-68c961f995e3@protonmail.ch>
Feedback-ID: 7579861:user:proton
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/02/2023 11.44, Piotr Karbowski wrote:
> Hi,
>
> It seems like whenever connman does scan for the networks it will never
> see the 6 GHz one (wifi 6e) in the list of services. However if I use
> 'iw' to scan, then the connmanctl services does see them and even allow
> me to connect to them.
>
> [...]

Let me expand a bit and make a correction.

With wpa_supplicant I can try to connect there, and see in kernel log it
does authenticate with AP but no network is ever reachable. So 6 GHz AP
is unusable regardless.

I've now built latest connman git with --disable-wifi --enable-iwd and
started connmand with --wifi=3Diwd_agent. All with iwd-2.3.

Now 'scan wifi' does bring the 6 GHz network up and I can successfully
connect there just fine.

After disconnect or reboot however I can no longer connect there, and
connman nor iwd do see the access point until I restart the AP, however
other devices like mobile phone seems to continue to work even when PC
(with ax210, iwd and connman) cannot. This most likely is issue on
access point side, but for anecdotal value I wanted to add it here.

If you have any hints how can I get 6 GHz fully operational with
connman, please let me know.

-- Piotr.

