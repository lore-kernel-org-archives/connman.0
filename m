Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F37A
	for <connman@lists.linux.dev>; Mon, 16 May 2022 06:35:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22D3D5D95A;
	Mon, 16 May 2022 08:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1652682903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Rjo8cNdzw1VKdawscrHNSgxBnRa7IqwlIzoI6+2fgXw=;
	b=gGbTzMbemTBzkC58Bkf3b3t1ZRUu0oEbGjdpujlvE2Z8eQF/w4SZhjroFCijWmcVl0at1L
	M0AMXzQC0FleZoJh4h+WoSJoOMrkrhz3JOuK5gcTop4MaDSfLcxeajNN5Qty6qg40OuG/B
	+0vWGQcETNP+41tlk9Bps7Kut9sEd+4+A8BDHXuyVeZKYcId5IYMixbv4dboHbDMNsIJCj
	v+7rX8+8EdRrVHxQrfTiYB60soUXB5HBLF4U2alU6ty3IRM3t4MN521wP61LHRcTSYBBWY
	Tp7duN2RpNmlGhFO3zT689MZoyN7ctVAZV3x8T6GuMmz8b0rxJy5XGfdAoLNQg==
Date: Mon, 16 May 2022 08:35:02 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ryan Smith <ryan.smith@density.io>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v1] dnsproxy: fix debug logging
Message-ID: <20220516063502.j3d6f6f4wtqelc67@beryllium.lan>
References: <20220411165821.501633-1-ryan.smith@density.io>
 <20220414185139.eq5w2jirf4e7fy35@beryllium.lan>
 <CAM7Wg-XfW6h570F0pUQMcsQEMYo7Y39oLFJ3nZo=KewhU6qOsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7Wg-XfW6h570F0pUQMcsQEMYo7Y39oLFJ3nZo=KewhU6qOsg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Apr 14, 2022 at 02:45:28PM -0600, Ryan Smith wrote:
> I will take a crack at minimal DBG logging when I get a chance. As is,
> it is impossible to enable debugging of src/dnsproxy.c from the
> command line. It would require a specially-compiled version.

As I said, I consider most of these DBG statements as left overs from
the development phase. These are way to noise to keep them around on
default. One thing we could try to do is toreuse the env
CONNMAN_RESOLV_DEBUG for this.
