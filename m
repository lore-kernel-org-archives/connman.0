Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408272
	for <connman@lists.linux.dev>; Fri, 13 Aug 2021 07:09:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3C965E2F1;
	Fri, 13 Aug 2021 09:02:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1628838176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RtcqHfwWtRv1fls3J3Aqe3tTUZ/KyTFk8D2vEt4k9os=;
	b=DjbmP3b7itZtSgSlotOU2VaUD0WdfKbKyqrV9nkB/A0CDMrGvN6RIeJBRHh2aieZjH6aR8
	3OM4WrL/+vrtdEzePzVEZHdB1O1fnMpWhSDOUxY0vvHgDPkYwgG1uWL1eO80VOazAOuYbO
	m4tww4cwcf03bjWZMtb/om0Q6ZsfE/dn6sO82MhrgXQUyUoTNzlTs9m/NBmqQV2NBxmZ7A
	6ALCResRSqOEqKuta6lU1TekSdh1LUagdCPzx1IXrJKRStjDIUdOSe3xVgRBlE9Ky9MBNP
	rTYLLjLyRN7NMoROvaU4p3oA+OtrbXNX7H3vV9bCtEXw8v6R0729WINHHzniCA==
Date: Fri, 13 Aug 2021 09:02:53 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michal Zatloukal <myxal.mxl@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: IPv6 Online check broken/down?
Message-ID: <20210813070253.ebpxxyupaa7c5v7m@carbon.lan>
References: <CAKKZj2B6uwmwpAtAFgW7Av1Qasb6Yg1h2q-pHW17svwdQJE_Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKKZj2B6uwmwpAtAFgW7Av1Qasb6Yg1h2q-pHW17svwdQJE_Rg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michal

On Thu, Aug 12, 2021 at 02:52:42PM +0200, Michal Zatloukal wrote:
> Hello.
> (Please Cc me into replies, I'm not subscribed)
> 
> I recently got IPv6 connectivity at home and soon noticed that connman
> on LibreELEC is continuously (every 3 minutes) trying to reach
> http://ipv6.connman.net/online/status.html - an "online connectivity
> check", as described by the documentation. The IPv6 host from that URL
> (currently 2001:8d8:8b4:c861:5826:fa5f:6690::, hosted by IONOS)
> appears to be completely dead (no response to ping, or TCP_SYN on port
> 80). Curiously, the hostname also resolves to an IPv4 address (also
> hosted by IONOS), where the HTTP server responds with "502 Bad
> gateway" (and ping responds as usual).

I get the same response here. Marcel said he is looking into it.

Daniel
