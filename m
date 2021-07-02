Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56706168
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 07:52:14 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 3FAF9500587;
	Fri,  2 Jul 2021 09:52:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id 0B35D500289;
	Fri,  2 Jul 2021 09:52:12 +0200 (CEST)
Date: Fri, 2 Jul 2021 09:52:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: apply_relevant_default_downgrade cleanup
Message-ID: <20210702075211.2oxu5tsvj33ly7og@beryllium.lan>
References: <PR1PR02MB4794724A7C2ACD0A92E18F6193089@PR1PR02MB4794.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR1PR02MB4794724A7C2ACD0A92E18F6193089@PR1PR02MB4794.eurprd02.prod.outlook.com>

Hi Emmanuel,

On Wed, Jun 23, 2021 at 01:41:35PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> For uniformity reasons, and to ensure the state coherence, the
> apply_relevant_default_downgrade shall rely on downgrade_state generic
> function, instead of processing itself the state downgrade.

Patch applied! Nice cleanup.
Daniel
