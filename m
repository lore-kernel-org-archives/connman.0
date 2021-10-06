Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF82C87
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 12:36:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E27AD60A44;
	Wed,  6 Oct 2021 14:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633523805; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SBsWeddRpN0vQC5uo66lB3EI2GpzDmrpCKeZsVVC3f8=;
	b=PSBTn4GEzfWbq85VdIuSJMA2I76n+BVi0JO54BlJAHMYnQ+SBWbvbnvoA0QTg6cxRC1r9H
	qB/tsPwKM2VkbhNMIX1IvCDUKZVS1hsRId00jLH1z/W/ZQ8IDw5+ncSIMwvI4fl8t7u6Y1
	dVJBthR7tu3Wb0jKYpgvUrP5G7iFFu41y0aPojpmP4sPBc+87yWf8XGZNlyuq+h37XlS9D
	mD+XKdVnO2+IZO2f2ZwJYewVDMaI84Xt6TxBp4tRsmVs/hGGesFNqWjM+3iaSVzrYvR5h+
	IWZMhccx3fND1iZuLP8ooU6JLNfi7GWPc/sa2B9k4XF2JbEKUOmxMKURYFsNAg==
Date: Wed, 6 Oct 2021 14:36:43 +0200
From: Daniel Wagner <wagi@monom.org>
To: Thomas Green <TGreen2@Sorenson.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Removing old service directories
Message-ID: <20211006123643.txym4njkm7pqnken@carbon.fritz.box>
References: <DM6PR04MB700338BA0F2EBF84D07EF5759FAE9@DM6PR04MB7003.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB700338BA0F2EBF84D07EF5759FAE9@DM6PR04MB7003.namprd04.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Oct 04, 2021 at 07:50:11PM +0000, Thomas Green wrote:
> In connman I would like to be able to get a list of all wireless services
> that have been previously connected, whether or not they are currently
> in range, and be able to optionally remove or 'forget' that service.
> I've tried to manually remove the the directory
> /var/lib/connman/wifi_xxxxxxxx but when I shutdown and restart my
> system, that service and related information has been restored.  How,
> at this point can I do this?

There were a couple of attempts to add a D-Bus interface to expose the
known services and allow them to be removed. I gave some feedback
on those patches but never got any new version. I didn't find the latest
attempt, but IIRC it was based on this one here:

https://lists.01.org/hyperkitty/list/connman@lists.01.org/message/4RJBOEEVYDAWFDT4PJ64FJ3PSAQ2SBMM/

Daniel
