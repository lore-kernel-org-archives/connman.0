Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2329CA
	for <connman@lists.linux.dev>; Sun, 30 Jan 2022 21:50:51 +0000 (UTC)
Date: Sun, 30 Jan 2022 21:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail2; t=1643579435;
	bh=HQEMB/SGlVq85/UN516FHzKnDGQUlwqv506wGFRZnaU=;
	h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
	 References:From:To:Cc;
	b=Kr9OQ/60X/dPWuumMXjpLwvOAg6JBSez6ssyNByBq/PUFgy4vz2xa0zCMr5dDIDg8
	 PSya7BLkkR+EdBGsCf2DHDCDK17WmJHHtFKCfSjc7ILIcqHwoLge2Gi8Xbp3WGywzG
	 bED6YB2H9wJy/4BotaWxA5OiYYzeWyu0M37io64ljH5yMeyqhF4vlkp8kSKslSU3gR
	 EM0HKkKZ+x4ywiKsJ85/uRUUxzuB/9Hf0nP1s0jeYqsN6aXm2VLZWtq8zS4c7qkWXB
	 0tDm49jeXvs7XuHRNAP2LJwXSIwH0YBeyJg6Tg1hjM5hQcleGuJUnJ30DwFAFax0/D
	 pnQ4fcjM3F1aQ==
To: Daniel Wagner <wagi@monom.org>
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: connman@lists.linux.dev
Reply-To: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Subject: Re: Unification to connman configuration? Now it 3 separated places.
Message-ID: <42368e37-a297-5a1b-193f-b350b58f6d64@protonmail.ch>
In-Reply-To: <20220130145110.ax6aio73c6le7xrk@beryllium.lan>
References: <e69350dd-6028-841f-8f0a-069cb4ec16d1@protonmail.ch> <20220130145110.ax6aio73c6le7xrk@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
	mailout.protonmail.ch

On 30/01/2022 15.51, Daniel Wagner wrote:
> Hi Piotr,
>
> On Wed, Jan 26, 2022 at 10:40:19PM +0000, Piotr Karbowski wrote:
>>
>> Currently there are three places where one configure connman:
>>
>> - Command line arguments to deamon
>> - /etc/connman/main.conf file
>> - /var/lib/connman/settings
>>
>> Which is quite a hassle to maintain.
>
> Yes, indeed. Let's start with the simplest one:
>
> - /var/lib/connman/settings
>
> This is file is under control of ConnMan. The user is not supposed to
> edit. But it keeps the default settings how ConnMan should behave when
> started for the first time. I suppose we could add those defaults
> settings to /etc/connman/main.conf.
>
> - /etc/connman/main.conf file
>
> This contains the more 'static' configuration bits for ConnMan. I think
> we need a config file for the defaults. Don think we get away without one=
.
>
>> To go with actual examples
>>
>> - disable dns proxy -- only via command line argument.
>
> This should go into the /etc/connman/main.conf. This should be fairly
> simple to do as well.
>
>> - disable hostname updates via dhcp -- /etc/connman/main.conf file
>> - disable NTP client -- /var/lib/connman/settings file
>>
>> Would it be possible to unify those into a single interface?
>
> Yes sure.
>
> For any global default setting we should add/move it to main.conf. The
> difficult bits are the dynamic bits for newly discovered services.

If you were to move the /var/lib/connman/<SERVICE_NAME>/settings to
perhaps subdirectory in /etc/connman/networks/ it could work. One of the
example could be NetworkManager that actually dynamically create files
in /etc.

perhaps the 'data' files could stay in /var/lib/connman/<SERVICE_NAME>/data=
.

That would be pretty clean interface to configure connman. Especially if
you need to pre-create some configs for services manually like 802.1X
that I think is not supported by any userspace utils that ships with
connman.

-- Piotr.

