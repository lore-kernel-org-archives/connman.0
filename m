Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381229CA
	for <connman@lists.linux.dev>; Thu, 14 Oct 2021 07:33:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B1BB60F75;
	Thu, 14 Oct 2021 09:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634196821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1ByAUcU2DZEEECm4KQrjBjnZ3SgWCVBB+IYKKEOLQ2A=;
	b=da/fJ0qK8ToqP4xkhYXhOOArM4ysVEeJ1EDu/EDFvEY5TTXWIiugH2KIRDZJl/TsGfA8Qd
	zGbDs9D7WnI4HxyTyFSQdZpJ4Om639iM467NtEIXdX9p6BokZCaA03BZR37iNGVzahgES2
	1WZamGZG9XS/Fqhik139rU4dQG8LwzKgnsNQhl8VZR+SvKIEBft72adA8pLTj067odQhx6
	sE5hRdsnC59GkaFN/8xB9A1UabARaApGJLQpXN749X6eHR2f8Ngnf3YB44hAcqWVeKlZ1t
	tLgdXAnK8qAWkaYhLjxCweXIS8FHvfhITpgwGxdRXkugO5c96Ll19IOjDQQUYQ==
Date: Thu, 14 Oct 2021 09:33:37 +0200
From: Daniel Wagner <wagi@monom.org>
To: Thomas Green <TGreen2@Sorenson.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Removing old service directories
Message-ID: <20211014073337.wvlnjeognyhlw5dw@carbon.lan>
References: <DM6PR04MB700338BA0F2EBF84D07EF5759FAE9@DM6PR04MB7003.namprd04.prod.outlook.com>
 <20211006123643.txym4njkm7pqnken@carbon.fritz.box>
 <DM6PR04MB7003F49568682041E308855A9FB79@DM6PR04MB7003.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR04MB7003F49568682041E308855A9FB79@DM6PR04MB7003.namprd04.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Thomas,

On Wed, Oct 13, 2021 at 10:47:42PM +0000, Thomas Green wrote:
> Thank you so much for this information.  Is there any plan to take this up
> again?

The last attempt (Bosch?) was almost there. As I said there were a
couple of small issues left, but unfortunately, there was never a
followup and I forgot after a while.

I searched again for the last attempt, I only found these posts:

https://lists.01.org/hyperkitty/list/connman@lists.01.org/message/4RJBOEEVYDAWFDT4PJ64FJ3PSAQ2SBMM/
https://lists.01.org/hyperkitty/list/connman@lists.01.org/thread/PTMSQLBY6RKGYWUFWA7FDBRT5RZCWI7H/

> Is it something that would be better for me to take up, or for your
> group?

If you want to work on, please go ahead. It's not that difficult.

> Currently the only work around I can think of is to shutdown connman,
> remove the files, then restart connman.  This is really not the option
> I was hoping for.

Yes, that's a show stopper.

Daniel
