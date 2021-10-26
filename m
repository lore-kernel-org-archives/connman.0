Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B22CA8
	for <connman@lists.linux.dev>; Tue, 26 Oct 2021 07:37:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 903FE5E359;
	Tue, 26 Oct 2021 09:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1635233859; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Rz0IGzJeEFSYBBRA0/eIoTLpcFIF+LNLi/t8Ek4AyKI=;
	b=uyoZ8sRJZLLYMcbhZCvYwuiFeCTDfpab4asO+8Sn2N6JsGxOqYfntjnfpPYeEmQxwrse6b
	9hh5YsgXiMaU+LJA1R05XrPjWR09Ue2IEUMgJcDgak8OrD5ayrPp9nILDL+1tFusdNOvRP
	/IwDWSpWKC6PlveCrG4Z7eRv3VXGe8szpcODtX6Qt3VyAVBgc8vpoguy1ZaO6q4bhCcbKs
	9HiZEeumh7aqHjE/Jt+rFYqcf3MmqptcVQOwllJ/MoP6lG3FYu5MqNJMZkXYQuN4DyX9pd
	OEmhZdo4fjKUeANMLW3ijwHHOZsfWOO2T5GPjw2C1c15M9R3fQVgZGizf6G0NQ==
Date: Tue, 26 Oct 2021 09:37:37 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev, Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Subject: Re: [PATCH] Add GetKnownServices api to connaman
Message-ID: <20211026073737.jtlyqaj2azyiauee@carbon.lan>
References: <20211025132643.4485-1-michael@amarulasolutions.com>
 <20211026070413.fv5bbuwpch3qelab@beryllium.lan>
 <CAOf5uwk-7TNhtfqUY-7Pb_w1id3yq5=jyJdv0Gf9OE46Zp+DAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwk-7TNhtfqUY-7Pb_w1id3yq5=jyJdv0Gf9OE46Zp+DAg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Oct 26, 2021 at 09:09:06AM +0200, Michael Nazzareno Trimarchi wrote:
> > > +             service->identifier = g_strdup(services[i]);
> > > +             service_id_parts = g_strsplit(services[i], "_", -1);
> > > +
> > > +             if (service_id_parts == NULL) {
> > > +                     g_free(service);
> > > +                     continue;
> > > +             }
> >
> > IIRC, this check will always be false, as g_strsplit() will return a
> > valid array or call abort() if allocation fails.
> >
> 
> I don't want an abort to be called, I will adjust it.

Sorry, I didn't express it clearly, g_strsplit() will call abort(). This
means the return value of g_str*() function always succeed, thus you
don't have to check for NULL.
