Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2F2CA9
	for <connman@lists.linux.dev>; Wed, 26 Jan 2022 22:49:28 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4JkdwV4Ryzz4xGGH
	for <connman@lists.linux.dev>; Wed, 26 Jan 2022 22:40:42 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="a7qwulYC"
Date: Wed, 26 Jan 2022 22:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail2; t=1643236825;
	bh=5cykv5o/xk5hfuGp56yiMw0fwzczkRdzguchg4jhFPw=;
	h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
	b=a7qwulYCLOhCcWtLgf/0qphtxhE70yVLWpXIHNPFC+emSGHsaVg04fffEOXKRirjS
	 d2hhfqJ6A5OMDVZ5xzB2Pw+UYoBe4mc8YxNy9nrwgdSuZc7eIAzzRKQCSAn5Hs+Mfe
	 mcwDsJoazNTu3n4KmwLDjZzG1tw38Q1L/OfOgUXS/gDuutyvwUXA4ZxnK+2eaIu6Jd
	 3qUHegyZS+mmKJjbTL5mQfKI4cr36BW/Z+XXQG6UXloolwG9pMBKsjQQ9Zi0RvwaV/
	 7n8WyVI9o9aeISRqm9nAyUxNRSbUyQBZw2MhyUp0tlDZD/pEBsK1r8WbNp+IX4Jpr4
	 IQuA8Ft/z/QOQ==
To: connman@lists.linux.dev
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Reply-To: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Subject: Unification to connman configuration? Now it 3 separated places.
Message-ID: <e69350dd-6028-841f-8f0a-069cb4ec16d1@protonmail.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
	autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
	mailout.protonmail.ch

Hi,

I'd like to discuss the possibility to unify the configuration of connman.

Currently there are three places where one configure connman:

- Command line arguments to deamon
- /etc/connman/main.conf file
- /var/lib/connman/settings

Which is quite a hassle to maintain.

To go with actual examples

- disable dns proxy -- only via command line argument.
- disable hostname updates via dhcp -- /etc/connman/main.conf file
- disable NTP client -- /var/lib/connman/settings file

Would it be possible to unify those into a single interface?

-- Piotr.

