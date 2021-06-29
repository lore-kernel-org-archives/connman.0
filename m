Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93517F
	for <connman@lists.linux.dev>; Tue, 29 Jun 2021 07:35:32 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 9871C50051C;
	Tue, 29 Jun 2021 09:35:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 69D455003CD;
	Tue, 29 Jun 2021 09:35:30 +0200 (CEST)
Date: Tue, 29 Jun 2021 09:35:30 +0200
From: Daniel Wagner <wagi@monom.org>
To: John Keeping <john@metanate.com>
Cc: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>,
	connman@lists.linux.dev
Subject: Re: [PATCH] service: Complete only after user connection retries
Message-ID: <20210629073530.fyu2jzkcxwm6fvya@beryllium.lan>
References: <PR1PR02MB4794EB6ADA4A23AA374EE58493909@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210327124254.iorhou27y3u4pwih@beryllium.lan>
 <20210615120930.2970caef.john@metanate.com>
 <20210628075835.dvlm6bnrzmknr56i@beryllium.lan>
 <20210628160413.416f51e4.john@metanate.com>
 <20210628195411.innzcyprpozgtuag@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628195411.innzcyprpozgtuag@beryllium.lan>

Hi John,

On Mon, Jun 28, 2021 at 09:54:11PM +0200, Daniel Wagner wrote:
> Alright, we are getting closer. Hmm, just an idea what could happen is
> the agent state machine gets canceled (the supplicant is likely to say,
> password is not working) and this it eats up the pending callback.

I think I found the place were lost the callback. I just send out the
patch. Please give it a go. If possible please also test some other use
cases. I am not sure if this change is not introduce another
regression...

Thanks,
Daniel
