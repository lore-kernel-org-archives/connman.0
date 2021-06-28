Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E757177
	for <connman@lists.linux.dev>; Mon, 28 Jun 2021 19:54:14 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id CD40250051C;
	Mon, 28 Jun 2021 21:54:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 950D7500284;
	Mon, 28 Jun 2021 21:54:11 +0200 (CEST)
Date: Mon, 28 Jun 2021 21:54:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: John Keeping <john@metanate.com>
Cc: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>,
	connman@lists.linux.dev
Subject: Re: [PATCH] service: Complete only after user connection retries
Message-ID: <20210628195411.innzcyprpozgtuag@beryllium.lan>
References: <PR1PR02MB4794EB6ADA4A23AA374EE58493909@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210327124254.iorhou27y3u4pwih@beryllium.lan>
 <20210615120930.2970caef.john@metanate.com>
 <20210628075835.dvlm6bnrzmknr56i@beryllium.lan>
 <20210628160413.416f51e4.john@metanate.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628160413.416f51e4.john@metanate.com>

Hi John,

On Mon, Jun 28, 2021 at 04:04:13PM +0100, John Keeping wrote:
> > Could you try to add some debug printfs and report back?
> 
> It looks like the length of the invalid passphrase matters here.  If I
> use a short passphrase like you have above then I reproduce that
> behaviour, but if the wrong passphrase has at least 8 characters then it
> enters the failure state.

D'oh! You are so right :)

> I think __connman_service_check_passphrase() is rejecting the short
> passphrase so it never even gets to wpa_supplicant.
> 
> In the failing case, I don't get the chance to choose to retry.  Instead
> the output looks like:
> 
> 	Passphrase? asdfgghjgj
> 	Agent ReportError wifi_b0f1ecffb46f_7073475462456b44_managed_psk
> 	  invalid-key
> 	Agent request cancelled by ConnMan
> 	Retry (yes/no)? connmanctl>
> 
> where the new prompt appears instantly.  Inspecting the DBus traffic, I
> see that connman calls Agent.ReportError and then immediately calls
> Agent.Cancel (the timestamp is less than a millisecond later, although
> there is a call to fi.w1.fpa_supplicant1.Interface.Disconnect in
> between).
> 
> I added extra logging in report_error_cb() and can confirm that this is
> never called when this happens.

Alright, we are getting closer. Hmm, just an idea what could happen is
the agent state machine gets canceled (the supplicant is likely to say,
password is not working) and this it eats up the pending callback.

Thanks,
Daniel
