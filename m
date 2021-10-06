Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B592C87
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 12:56:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E20E6176C;
	Wed,  6 Oct 2021 14:56:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633525012; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lHTPaeu4I6Kjce7SJqOWxBxjOrIDnU8LKy6rDkiLio0=;
	b=TiSeXgr5THUcaCmj6UoWExBQ/X2v6aGopL2vJv9c53vIY9WM8xXN1VYA5o1efDtyKiWM66
	KOFtKS6yFaCbIyNTPjiGlpuGJ8L7gDl2I5ybISMeNY3JfAjcU+AGwEpID6BKAYHHl/zEO0
	cRqkjeg17QUHk2zXNFbf/JgN1IVHXF6Slo+rpZmCDxtmHit6RL7X6F/j7HV/ly1NTjVbs8
	HIdE6JbCuZEYk3g3xqcVA4H86FTovYH826j7VSFIMvoMWMytKATLBpWRGIwCd4eY7RRWTQ
	z5v/DNikZMdr2jODGcFK1yv30VKTkC+5g2gXx+DgP7VGZmbuwGyAadtPF2nhug==
Date: Wed, 6 Oct 2021 14:56:51 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH 2/3] iwd: Connection of hidden networks
Message-ID: <20211006125651.tgnfrbqh4fjgyuku@carbon.fritz.box>
References: <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211004070314.ehj6a5wjkhexu4xb@beryllium.lan>
 <MRZP264MB1544E27898924DAB6CBBF9E793AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211006115927.lfqei7bai5slvyup@carbon.fritz.box>
 <MRZP264MB154456BC4444DD80E9F399BE93B09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154456BC4444DD80E9F399BE93B09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Oct 06, 2021 at 12:44:05PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > Please send them as new patch. Thanks.
> Do you mean I should version the updated patches I have just sent back?

I would really appreciate if you could send your patches following the
normal Linux kernel patch submission work flow. That is send the patch
directly with 'git send-email'. git send-email gets the threading etc
all right. Please check the kernel docs on how to setup your git
environment. Doing so I can pick them directly from the mailing list and
don't have to manually copy&past stuff around.

> > In this case, why do you not release the resources associated with the
> > pointer? Isn't this a leak?
> I don't think so. It is done via the hidden_params_free(), given as argument of
> g_dbus_proxy_method_call().

In this case it would be better to set the pointer to NULL right after
the resource is freed.

