Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2412A38
	for <connman@lists.linux.dev>; Tue, 28 Feb 2023 07:40:21 +0000 (UTC)
Date: Tue, 28 Feb 2023 07:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1677570013; x=1677829213;
	bh=rW1WAWqAGUaFNDqsMMLqzhxczkvPe8LNyRb5KiZsCkU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jJnFdtnatbPgGFVv9XJHxlwM7XGS2XAQn+CbcyMORd3789Q+d/PqywJ8nAxRz2hUC
	 L2nbZoakfwuDCbIjeMrSogZY8mRBpbC/d+cdJjHDqD8topMWzU8c30qg/0X/1upmvy
	 KgTHhgmEncxA7GkJqmA7pbz0+i+wF4jwOygWf8vO028HFiGn9C/P3HYQbV6KJhEw1Y
	 4RJdJVZzFMImMpj1vFvc6VCs7gswXXIllGAk1zDIlVWdOuY9Q4YJK1jukjHzub+zwN
	 jXb3LOLqEYYNRY1oc2dvJSLtZS5SwfS3eQHhUc7xgqWzJeJSvV7bnIQC0j2eBJJ1Xn
	 NVKEmvvpK5HtQ==
To: Marcel Holtmann <marcel@holtmann.org>
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Subject: Re: No 6GHz networks found if connman does the scan, but connman see them if 'iw DEV scan' used instead.
Message-ID: <5044b999-10b7-a9d2-5637-2f3eb0f67a40@protonmail.ch>
In-Reply-To: <F230A2F7-0A25-4E12-AAE3-DD4C5D167D5D@holtmann.org>
References: <2712e513-6def-4ed1-d88a-68c961f995e3@protonmail.ch> <91794321-2d0b-0c40-3d02-9880c20c7cab@protonmail.ch> <20230227080130.gtmid6ojmjmn6h4q@carbon.lan> <1a20dca6-8431-1d24-1ad9-7ae6b386c29d@protonmail.ch> <F230A2F7-0A25-4E12-AAE3-DD4C5D167D5D@holtmann.org>
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

On 28/02/2023 08.02, Marcel Holtmann wrote:
> with /etc/main/iwd.conf you have an option to set the country code. The
> Intel WiFi might still overwrite it and do their own thing, but there
> is some option to set it from the get go.

Thanks for the hint. Unfortunately Intel's wifi will ignore it entirely,
the 'iw reg get' will show global being set to PL but phy#0 which is
AX210 will remain country 00 until it decides otherwise and the
frequencies remains locked. What I notice is restarting my AP does seems
to advertise somehow the country and then immediately all my devices
with ax200 and ax210 gets proper country code PL, but I am unable to
reproduce this without restarting entire AP, which is not really
feasible given it will take long time to get back online, with DFS
channels and whatsnot. Wifi is really convoluted technology.

-- Piotr.

