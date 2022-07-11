Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1151FB7
	for <connman@lists.linux.dev>; Mon, 11 Jul 2022 07:46:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFCF15DDB3;
	Mon, 11 Jul 2022 09:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1657525553; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vbdPynJxYDBN6nr8tCen4pTbvI1RHoNKlStTuUfras8=;
	b=IYMar9zZNbYxDWXDllsFz/qwyQDe4CP6Lqqkua+PS/6yEq56Vygc66PoEHlPyRPSTUU3sa
	0F8EE604v6+RrVcQUISdmBAif1ygUdi19jJ3Yu11nb3tK4pAzDt17IJKRFocrmpOoQ0yqn
	+fCS9J0Ce3pmArqd5WH4dEGwtXae/2cQHoDVe2BD4E3vCFGaqkfg+HxxFihEaEHlx0mz/N
	IkkOyN0/qNZU/2i30OXBtD7LHnofZKAhaWHrZPgfeWhcTNFQ5dOxIE8YIdSZ5HIcNBK5x8
	KHr+v0KPXbtIK3fcUSknrlta9gKVOWJzkc/nwhOPFT/GI7SjRDuWR2wXgJ+CIQ==
Date: Mon, 11 Jul 2022 09:45:51 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jakub Jirutka <jakub@jirutka.cz>
Cc: connman@lists.linux.dev
Subject: Re: Service state change is not emitted on net.connman.Service
Message-ID: <20220711074551.m5ohm74noepd4s45@beryllium>
References: <4df95b51-0da9-6bf1-967f-17bfe8cbf782@jirutka.cz>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df95b51-0da9-6bf1-967f-17bfe8cbf782@jirutka.cz>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On Thu, Jun 09, 2022 at 03:46:07AM +0200, Jakub Jirutka wrote:
> Can you please fix this problem or explain me how it can be fixed?

This allowed_property_changed is pretty funky indeed. It got added to
filter out p2p events which were not supposed to be seen. At least
this is what I read from the git history.

Anyway, 100ms timeout has really the small of a hack IMO. It seems
ConnMan lacks the ability to order signals. From your description, it
sounds like the Ethernet events are within the timeout limit.

Not really sure how to address this though. Maybe do not call
service_schedule_changed() in __connman_service_create_from_network()
and instead send the ServiceChanged first?

Thanks,
Daniel

