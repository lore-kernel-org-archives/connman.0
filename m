Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B710229CA
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 07:53:37 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id D0C00500587;
	Fri,  2 Jul 2021 09:53:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id A3A4B500289;
	Fri,  2 Jul 2021 09:53:35 +0200 (CEST)
Date: Fri, 2 Jul 2021 09:53:35 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Ignore state information in service reordering
Message-ID: <20210702075335.opqr3lc7kzell6lv@beryllium.lan>
References: <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>

Hi Emmanuel,

On Wed, Jun 23, 2021 at 02:58:00PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> The states of the default and new services shall not impact
> the preferred service reordering.

I suspect this one is needed to the moving of the
update_default(). Let's first figure out why you need the first patch.

Thanks,
Daniel
