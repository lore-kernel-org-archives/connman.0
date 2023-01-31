Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850528E1
	for <connman@lists.linux.dev>; Tue, 31 Jan 2023 11:36:51 +0000 (UTC)
Date: Tue, 31 Jan 2023 11:29:26 +0000
Authentication-Results: mail-41103.protonmail.ch;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="KAM5aLVv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1675164576; x=1675423776;
	bh=0c4SpRw0YGIOhmSWPWahRZ5Lzy/cusITSxIqTFcTwcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KAM5aLVv3GFnIoCoX5oEJ0Ghq7YdVhanjpgnM0VKpdWJgQa7s9k1EtnpQ9rtVTmAK
	 7zTyK3MUWA7vcjb3WZ61RfqJaMLbGpmATO758QPWjasiI/bKjoPkQHwC4wG4OGQcil
	 2JdkZnE+/aMGsmkLypXUfX8GYRdtNFiFBgQlM95/HQiGWMQRUcktuSVrkto+AYexSf
	 Vh6+5Lm5xOSUf9BsKtQkWcM8w/09WrJqZE00f8nU9/VJ70pq3zetYI4t2WkAJK7JmD
	 Rc43w5AY29GOhh5sz00z7WOi9qsk0MoCWnJerPVql/1JyXXbQ6l0oXKM8wHXo66V2p
	 ccg8MZD9XCSjw==
To: Daniel Wagner <wagi@monom.org>
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: connman@lists.linux.dev
Subject: Re: Unification to connman configuration? Now it 3 separated places.
Message-ID: <cf41cdd7-6b79-3619-5bc3-64bc1ec18794@protonmail.ch>
In-Reply-To: <20220214074545.47utpy7s6afeohwq@carbon.lan>
References: <e69350dd-6028-841f-8f0a-069cb4ec16d1@protonmail.ch> <20220130145110.ax6aio73c6le7xrk@beryllium.lan> <42368e37-a297-5a1b-193f-b350b58f6d64@protonmail.ch> <20220214074545.47utpy7s6afeohwq@carbon.lan>
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

On 14/02/2022 08.45, Daniel Wagner wrote:
> On Sun, Jan 30, 2022 at 09:50:31PM +0000, Piotr Karbowski wrote:
>> If you were to move the /var/lib/connman/<SERVICE_NAME>/settings to
>> perhaps subdirectory in /etc/connman/networks/ it could work. One of the
>> example could be NetworkManager that actually dynamically create files
>> in /etc.
>
> /var/lib/connman/* are not configuration files. These files contain the
> state. The are under control of ConnMan and will be overwritten.
>
> That means these files need to live in space where ConnMan can write to
> (/etc will not work). Furthermore, embedded devices tend to be vary
> cautions about write updates and often move such things to a tmpfs.
>
> Another problem is the id used to apply to a newly discovered
> services. The path is constructed using the MAC. In my opinion not very
> convenient and not really future proof.
>
> All this is solvable but it is a bit more work than just moving the dirs
> around. I think we would need to introduce a new configuration logic here=
.
>
>> That would be pretty clean interface to configure connman. Especially if
>> you need to pre-create some configs for services manually like 802.1X
>> that I think is not supported by any userspace utils that ships with
>> connman.
>
> Yes, I do understand the need for something like this. Ideally we
> wouldn't come up with yet another config file format. Maybe we could
> reuse the one from systemd-networkd? No idea if this would work, just an
> idea.

I recently had to do another round of connman configuration which
reminded me about this thread.

Wanted to ask if you still consider this a feature that's worth getting
into? I kind of got used to the current way but still believe it would
benefit many to have it unified. I am all into being the tested if you
ever decide to introduce some new interfaces to configure connman.

-- Piotr.

