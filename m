Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88C70
	for <connman@lists.linux.dev>; Thu, 24 Jun 2021 08:10:10 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 4453850064D;
	Thu, 24 Jun 2021 10:10:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 100A050022D;
	Thu, 24 Jun 2021 10:10:07 +0200 (CEST)
Date: Thu, 24 Jun 2021 10:10:07 +0200
From: Daniel Wagner <wagi@monom.org>
To: John Keeping <john@metanate.com>
Cc: Andrei Datcu <datcuandrei@gmail.com>, connman@lists.linux.dev
Subject: Re: Clearing service error from invalid-key will not invoke the
 agent anymore
Message-ID: <20210624081007.emsej5aik57gypff@beryllium.lan>
References: <CAAmFs7=AcOmoNWVaGEoi_9FPgh3NBS1LiceWOVQgL0xS=hnKYw@mail.gmail.com>
 <20210622193132.5cd53815.john@metanate.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622193132.5cd53815.john@metanate.com>

On Tue, Jun 22, 2021 at 07:31:32PM +0100, John Keeping wrote:
> Hi Andrei,
> 
> On Tue, 22 Jun 2021 21:10:05 +0300
> Andrei Datcu <datcuandrei@gmail.com> wrote:
> 
> > Using version 1.40, I'm trying to connect to a basic psk wifi hotspot.
> > If I input a wrong key to the agent request, the service will
> > correctly get Error == "invalid-key" (and State == "idle"). Invoking
> > Service::ClearProperty("Error") will put the service in a weird state:
> > every subsequent Service::Connect() call will fail without ever
> > requesting any agent input. To leave this state, one has to call
> > `Service::Remove()`.
> > Is this expected or is this a bug?
> 
> This sounds like the issue I reported here:
> 
> 	https://lore.kernel.org/connman/20210615120930.2970caef.john@metanate.com/
> 
> I have reverted 8ea2d67a6e8935d06f71b1ec77a2f89d72be49eb locally and
> that fixes this scenario.

Thanks for the reminder. I'll look into it.
