Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ACE7A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 15:23:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E2FB5D381;
	Mon, 14 Feb 2022 16:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644852210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZRPt45KeM/VCx5IuqavqdOxbl0GBsZmJHsixSbcUtcE=;
	b=phO39uxJstse0bRHbPEvh4FtPt/LLapdjXT7N1UXPHMfR4tMc05aSvENLJfnGjJ+Ztc9fF
	CHJu/QrvYypKR+bsvPNTEc45hHcoq0dXeJ3d/WhnasR7uMBj6ER3aUNUkrCEKrH/Ca+R3h
	uK+Paqqd8d+7pfhUA09QVWXWlVSP7+8krIiYqXiIAIRA+34xKp+oBw9Kj6e//2peA7Asu4
	LQpKkBtfJo8k5FVpBxV2wZx94YJge253kpHu1srTuT513Je3mp9KvyfzQHm2a/zsoEM9fo
	hVc8OfegCMvypNIVSVkagnws4DOCzTwvYrgLLcdYMtl88gzrSxb7qH1nRZbq5w==
Date: Mon, 14 Feb 2022 16:23:29 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Use same signal strength calculation as
 wpa_supplicant
Message-ID: <20220214152329.g27nz7ennzsj5ked@carbon.lan>
References: <20220214021357.522946-1-net147@gmail.com>
 <20220214073654.5wwvht6ntswylci5@carbon.lan>
 <CANwerB32EdUdktYrPx36X2XBrO366s6mHCcy0da0FUm6LMH8ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANwerB32EdUdktYrPx36X2XBrO366s6mHCcy0da0FUm6LMH8ig@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Feb 14, 2022 at 10:31:03PM +1100, Jonathan Liu wrote:
> It is the same mapping of dBm to 0-100 range as
> https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/wifi.c#n2805
> For wpa_supplicant,
> g_supplicant_network_get_signal(supplicant_network) returns the dBm
> value.
> For iwd, you need to divide the number by 100 to get dBm value.

Please add this information to the commit message.

Daniel
