Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2EA2569
	for <connman@lists.linux.dev>; Thu, 24 Nov 2022 11:45:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49CC0E3027;
	Thu, 24 Nov 2022 12:45:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1669290332; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rmlC9icNRpSLihmFVPwiib1aPhCJ3ahkFtiFLDjyEQs=;
	b=zrH4+xlCcXR9jDDIBafFOWmZGoosSfJR44DrjQ8/x9pBrLGwc8GDgHWo/ipUWOgznInku3
	j+ISsdZ9c/hcHqnqNBMIobF9Vyp4t13S1in1wq/XQYdDZLm2WTn/LRAhlm0YWbREezFGKN
	x+T0B6JDCFLwH9m/KJ0Zut5mQm+J60b2oGK4MARAmIphcAz7pICHj9kWqCPYAQR0+6DsGH
	kLsBoEkUt5XAq33AzrdGn6GDXiCi+qBrs+HtArWb/9OC5a8+C3pqd9U0cir0O/plHFuCJP
	S8V8x+hJXMtL0A5KC5q+xtUtBjlwFIPpC/foROHIvCTnhzvakACMIxYQ9xRSlg==
Date: Thu, 24 Nov 2022 12:45:29 +0100
From: Daniel Wagner <wagi@monom.org>
To: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Cc: connman@lists.linux.dev, john@metanate.com
Subject: Re: autoip address set/reset loop
Message-ID: <20221124114529.w33mrgo26s5b7qgw@carbon>
References: <152f062c-7c16-c6cb-c8e8-c6f82902e40b@gmail.com>
 <39363d0c-2928-b5a1-d108-1213149fa7ea@monom.org>
 <ef0bc60e-2833-9e72-c4ff-5d7fa3838ce0@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0bc60e-2833-9e72-c4ff-5d7fa3838ce0@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Nov 23, 2022 at 07:27:49PM +0100, Geoffrey Van Landeghem wrote:
> I did watch your commit earlier, but because you say "It's propably a
> safe bet to say NULL is never a valid GW, so let's filter it out for
> all callers", that for me seems to be guessing it could have been a
> bug and it just didn't seem to fix much or anything you saw at
> runtime. It would have been better to see what runtime issues you
> fixed with it, because there is nothing for me to hold.

My commit fixes the problem that the function inserts a non routable
route and things break as the kernel doesn't route correctly. My commit
message just expresses that I am guessing that is safe to bail out
early. I am not guessing if there is bug.

> Regarding assigning the invalid /non-routable 0.0.0.0 gateway IP: it
> basically means there is none, so I don't see the issue. See
> https://unix.stackexchange.com/questions/94018/what-is-the-meaning-of-0-0-0-0-as-a-gateway#:~:text=on%20this%20post.-,0.0.,there%20is%20no%20intermediate%20hop.

Again, 0.0.0.0 as gateway address is a bug:

https://lore.kernel.org/connman/b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net/
