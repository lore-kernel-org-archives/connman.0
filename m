Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F015A7
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 19:03:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B21725D37C;
	Thu, 14 Apr 2022 21:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649963006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dJLXW0Oq5dLf5sWEzM80UCZfCy6M/Iqh+2KeZkWVRaM=;
	b=ASe5gmWNnwpoOLMp0t//DGO1VTEvyUHz8+zLUxXwXwGQkOcRtoYphvuZvWAlBqnC/1+UUy
	elBHFx0KXe9GY53Kx38totNHnD1smQTpw3JOWupdpfCmVemS94YtsDfAoRm0m7n+3bubdP
	zA9QHZ96Gb7nA3s2KKWeP8fB90+5lxwZ1AUeoXnUSYrgq1am8Y7Ub6P0GAdE/+kZS6UZso
	4D8g2nXsxqu2JRqCnGTdwiN8CXom+/2QSRZ9sfJtV6c94J9KM0Rz00QrxLEsOTSVzL2Ng1
	cE+1waKNMiTbkTrbGJfZEpDWNsHMyM1s7WNYK0sAssfUcZ4W+rVjCjBD4SkkPQ==
Date: Thu, 14 Apr 2022 21:03:26 +0200
From: Daniel Wagner <wagi@monom.org>
To: Vishwanath Chandapur <vishwavtu@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Request for feature
Message-ID: <20220414190326.lrewsky2lfmnyh3g@beryllium.lan>
References: <CALQBcOdNjp5WvTXGVLBynASHc0K0fDArggDo=imX31dXJkHjSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQBcOdNjp5WvTXGVLBynASHc0K0fDArggDo=imX31dXJkHjSA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Tue, Apr 12, 2022 at 12:53:17PM +0530, Vishwanath Chandapur wrote:
> Group,
> 
> In the current design of connman, if a client fails to discover a DHCP
> server, it will assign IPV4LL ip address.
> In some systems it is not desirable.
> 
> Hence it will be good to have a runtime config like "fallback-ipv4ll".
> 
> Please let me know your feedback so I can create a patch for this?

It's not the first time hearing this. Sure, though I would like to see
that the config option can be oversteered via the D-Bus API.

Thanks,
Daniel
