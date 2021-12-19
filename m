Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB412CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:28:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C61075CD17;
	Sun, 19 Dec 2021 18:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639934907; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ytW9ro3a0rJVd4YoH9Kos8rkc5/zXUpdor2LKjNTYfA=;
	b=Hc6GQFSIYNWZ/vX4aZcpcBlCbw8KD1c36ObWiPf4dvNLzQOMQWlzKCJGQixxeDOMHacz1W
	HmeIIa9a1axIcPblfKDszjopyZYNI7pj2kfWJ27KW50OXdKPQJ9/DEHMmXtJNt715tagF8
	mfkQpvaYAuWpp3dDGDLtWGWUIC8usZXPhaILR0UoIL3FeE7+EDZRSSTCutCL+0ouwXX65H
	SuPdk4tshmE/Q//kELHze/6eZfJUI3FIrmyIL4p5C6peCV0EL7R/WXMXcCMMJP4QDWotJi
	vTKxqeHrMJ/XbLg8fq7Rj/fOnYi0IHHBxgj/GqIN+BvlCpjI7dArCZgfZIcD7w==
Date: Sun, 19 Dec 2021 18:28:27 +0100
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] Add ObjectManager interface to connman
Message-ID: <20211219172827.xdu6zatihgt73bba@beryllium.lan>
References: <20211211135028.11355-1-michael@amarulasolutions.com>
 <CAOf5uwkatFgqV+YT+s5_rKg_xRYzq6QE7xBQv_N_Ud=Rd8ydoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwkatFgqV+YT+s5_rKg_xRYzq6QE7xBQv_N_Ud=Rd8ydoA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Sat, Dec 11, 2021 at 05:58:18PM +0100, Michael Nazzareno Trimarchi wrote:
> Sorry Daniel for the signed-off. I will try to adjust my policy here

No worries, was easy to fixup.

Patch applied.

Thanks,
Daniel
