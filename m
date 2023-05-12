Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327523D48
	for <connman@lists.linux.dev>; Fri, 12 May 2023 20:27:36 +0000 (UTC)
Date: Fri, 12 May 2023 20:08:58 +0000
Authentication-Results: mail-4321.protonmail.ch;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="T5o0+jQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1683922149; x=1684181349;
	bh=IgL1IzFqD8vbYpYJ/KaG7OKnBfQqvsCJOfbJ7cQ2nSM=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T5o0+jQnUrJwxE2yTdQR/jGYjxnpWuVfdT/TyMFwptx/N6VESEGcrrSfRYxRy9zHB
	 +5/GmErzkXrbPgFCR9Rs6BTbPA5FVOvmyeeELqkwKj+vw7aDTNYo76iMMz1MXCeF7t
	 RsoT2kUSi63bJs2fBUTv0d5RKMXqk4LdQA4HAAtIzFzEA2xcDnl+/42MHYA19ojA1T
	 uRcwKuw6bwadrV6DPmoSz06YQ9K89vDB+FgYFxor/qcM2alLJ9NfSiSJ8lhku8eaPE
	 e1HGMyILAMMDtRWl5t1TahLWgFYmmwGgsBolfw8yWd28NdvDOyLXK9vIoGKU4qFoMl
	 gSVneOYlikWRg==
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Subject: MTU configuration when not using DHCP?
Message-ID: <442783c0-7c42-2e90-657e-81610a65f71f@protonmail.ch>
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

I am running on a weird network that needs a lower MTU setting for
wireless clients otherwise those often have issues with connection.
Currently there seems to not be interface to set MTU when configuring
static IP on interfaces.

I went briefly though source code and I see that the MTU sent by DHCP
will be in used as well as there's '--mtu' for VPN clients.

Is there any chance to support mtu setting per network? Like

=09config wifi_FOOBARBAZ mtu 1458

or any other per-network or per-interface configuration?

-- Piotr.

