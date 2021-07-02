Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7D29CA
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 07:25:43 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 69B63500587;
	Fri,  2 Jul 2021 09:25:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id 378CB500289;
	Fri,  2 Jul 2021 09:25:41 +0200 (CEST)
Date: Fri, 2 Jul 2021 09:25:40 +0200
From: Daniel Wagner <wagi@monom.org>
To: Andrei Datcu <datcuandrei@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Calling Service::Remove will not raise the
 Service::PropertyChanged event
Message-ID: <20210702072540.h2anfir7n76nnu5h@beryllium.lan>
References: <CAAmFs7kfnSfLbUo2dvBQD9cGyNz-Bmro144JSxWsALZat3L5uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmFs7kfnSfLbUo2dvBQD9cGyNz-Bmro144JSxWsALZat3L5uQ@mail.gmail.com>

Hi Andrei,

On Tue, Jun 22, 2021 at 09:15:24PM +0300, Andrei Datcu wrote:
> I'm having a wifi service with:
> State == "idle"
> Error == "invalid-key"
> 
> Calling Service::Remove() will correctly reset the "Error" property.
> There will be no Service::PropertyChanged signal emitted however. Is
> this a bug or is this technically not considered a property change
> since the property is now missing all together from the property set?

Good question. I tend to say, the reason why no PropertyChanged is
issued is that the service itself is removed and not just a
property. Given that you call 'Remove' and get a reply message which
says, it the request was either successful or not should be
enough. Also, the D-Bus service object should be removed then and
this should give another signal source.

Thanks,
Daniel
