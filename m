Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179C70
	for <connman@lists.linux.dev>; Mon, 26 Jul 2021 07:28:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AED35E3D9;
	Mon, 26 Jul 2021 09:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1627284168; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Kmt7Y/f4uC45HRtT2lQH7qrTO9pV1zKRQn6p7EzQKJg=;
	b=FR8g1Wg0JKlgj10uOGEzkeNPy/T5UO7DA2J+PH4qdJ02w2APLLGSvATjShs22SaBuh16Gk
	LgIyYwhr+eRLCfapHjR7zji+Gn8pc5D4nc5ngzSSqSlD8pI1hsCA27yDM3TxHBt/1FeUmn
	X/O7NwL0bmHNou15GwufK4db1yVOB8P+9eoXuJgQ3UrFjdd7Qp5VX2fo/tN1jqvoDd4R1P
	r4M2n0V6oviYubH6LUal19TC3+0OmIW1cDRkjO8BR2yS++LFUChevuMYAhmNSuMMXZz/VZ
	yxjLCRZQqkh9+MdetIaY+zm6XsCPeo9JbLiDErN70g4QwtbYcBOP2K3kVJe0mQ==
Date: Mon, 26 Jul 2021 09:22:47 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: service_update_preferred_order cleanup
Message-ID: <20210726072247.q6ri36ovkrwiyua2@beryllium.lan>
References: <MRZP264MB1544B944E70E53B4B1A9287693E19@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210720121428.p3t54ne3emuxz3bl@beryllium.lan>
 <MRZP264MB15449923E85D932705598E8F93E29@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB15449923E85D932705598E8F93E29@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Tue, Jul 20, 2021 at 12:31:25PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Great to see you back, and hoping you will  be able to check my other
> pending patches, as I will generate a new release soon.

Thanks. A few days holiday was really necessary. Though I am still
pretty sluggish response time. Sorry about that.

> > This is not just a pure refactoring change. Because
> 
> > -                     if (default_service->type == tech_array[i])
> > -                             return -EALREADY;
> 
> > is missing. This is only relevant for service_indicate_state() when we
> > would ignore the new service. Hmm, not totally sure what it means. Did
> > you figure out why this is not needed anymore?
> In fact, it is not missing, I presume it is the case corresponding to:
> service_compare_preferred(default_service, new_service) == -1, 
> which means the return -EALREADY; after the condition block of
> if (service_compare_preferred(default_service, new_service) > 0).

Ah, right. I'll apply the patch.

Thanks,
Daniel
