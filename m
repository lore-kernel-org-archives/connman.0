Received: from metanate.com (dougal.metanate.com [90.155.101.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44071
	for <connman@lists.linux.dev>; Tue, 22 Jun 2021 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
	:Content-Description; bh=GWQH/4feX1sadg/0ruyI15lXIlyVbSEVF6pHWBIOBj0=; b=jhoQ
	A0KnqTACGYHJlD1VKLbREIhiZCcxOkCJN7VyaTyKdqoSSvvPLIwmPHCUi8Ca1WTYGndQ0Y7ewWWJT
	gb+Dmgf0aeAyK2q/LU23TWTiG2I6cQ1RP9EKFjq9QJnLJ5uvPFQukmGrAY+ueOXP25T/cbd6N6u74
	qk7Vu4D7iI9xmhZ13aKKXT8Y5HlsCPxTdBYH4b5fgwKRhfdwKqZLRIc114Wh7GTq1c647CxllBw1n
	OdrgS9KPklDaFyA8tI6Nhln4SMLuPGsgf2RgTJQwO45ejGrlvB5dTh5yq9goZFyoUn+N2OTC+/B9/
	EfHBmc4U4wDGbK+fim8sMSPXpUXeew==;
Received: from [81.174.171.191] (helo=donbot)
	by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <john@metanate.com>)
	id 1lvlBN-0005x8-L6; Tue, 22 Jun 2021 19:31:33 +0100
Date: Tue, 22 Jun 2021 19:31:32 +0100
From: John Keeping <john@metanate.com>
To: Andrei Datcu <datcuandrei@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Clearing service error from invalid-key will not invoke the
 agent anymore
Message-ID: <20210622193132.5cd53815.john@metanate.com>
In-Reply-To: <CAAmFs7=AcOmoNWVaGEoi_9FPgh3NBS1LiceWOVQgL0xS=hnKYw@mail.gmail.com>
References: <CAAmFs7=AcOmoNWVaGEoi_9FPgh3NBS1LiceWOVQgL0xS=hnKYw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES

Hi Andrei,

On Tue, 22 Jun 2021 21:10:05 +0300
Andrei Datcu <datcuandrei@gmail.com> wrote:

> Using version 1.40, I'm trying to connect to a basic psk wifi hotspot.
> If I input a wrong key to the agent request, the service will
> correctly get Error == "invalid-key" (and State == "idle"). Invoking
> Service::ClearProperty("Error") will put the service in a weird state:
> every subsequent Service::Connect() call will fail without ever
> requesting any agent input. To leave this state, one has to call
> `Service::Remove()`.
> Is this expected or is this a bug?

This sounds like the issue I reported here:

	https://lore.kernel.org/connman/20210615120930.2970caef.john@metanate.com/

I have reverted 8ea2d67a6e8935d06f71b1ec77a2f89d72be49eb locally and
that fixes this scenario.


Regards,
John
