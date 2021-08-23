Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088FF72
	for <connman@lists.linux.dev>; Mon, 23 Aug 2021 09:02:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 816315E30B;
	Mon, 23 Aug 2021 11:02:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1629709331; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KEa8sInfd8rGLaMwVN5JSSIXYG+mmaMWl6F6Rak3SIg=;
	b=PkHE7g3bw0X4NzPzLyh7f+ZrcSvjwQg0e1C7/CqJLCIbz8fyYkH1UzVE60xwUy/IrwcUAL
	HxZMxGEVrghn7Mx28hWD8CKo8srWVsqoluIigvQk4eQMgnren1fyyG1bSSvkxfZFEhx37L
	qg/nM3WbXzKL0woCdkxzvHAusAgrC7vQBi2TFar/7h7pICrO7SroMFrDa44OUPuYhaePXq
	pP/uJhEDcz2aQ+iH80hcEyQ3X+73OGehEo0FWjIEyZqYymoeyODG5M+FL4/92TLGiPCoZ4
	7CRT0SaLn/xAPS9NIZ1zT341hIA0OfMzPsIJYPqofT3PlgWosSyhOhACkLZ/Bw==
Date: Mon, 23 Aug 2021 11:02:08 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jupiter <jupiter.hce@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Problem in connman 1.39
Message-ID: <20210823090208.qgh62abb7mpixeih@carbon.lan>
References: <CAA=hcWT3cdBXkCRggDAHTGN1Xn2fXtp+UPfJm6YCsPLZeYoOYg@mail.gmail.com>
 <20210823075549.dsdxfwgebhdnjlqi@carbon.lan>
 <CAA=hcWTN66MwJBpo7zZeSpRQy3ei7oc-sodEvRrTrnF33o1_rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWTN66MwJBpo7zZeSpRQy3ei7oc-sodEvRrTrnF33o1_rQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jupiter,

On Mon, Aug 23, 2021 at 06:08:07PM +1000, Jupiter wrote:
> Hi Daniel,
> 
> Thanks for your response. Someone responded to me that version 1.39
> messed up some library, asked me to update to 1.40, but I could not
> find that email anymore.

Ah okay. Checking latest version is always a good idea anyway.


> BTW, I got email bounce from connman@lists.01.org because the address
> couldn't be found, what is the current connman mailing list address?

The new mailing list is hosted on lists.linux.dev. Unfortunately, we
lost access to the old one before the new one was up and running. The
README should always be up to date as we don't have any official web
page for ConnMan. I was pondering if we should ask for a wiki space on
korg, similar to iwd.

Daniel

> On 8/23/21, Daniel Wagner <wagi@monom.org> wrote:
> > Hi Jupiter,
> >
> > On Sun, Aug 22, 2021 at 08:41:40PM +1000, Jupiter wrote:
> >> I could run connman 1.37 well built from Zeus, but it did not work on
> >> connman version 1.39 after upgrading from Zeus to Hardknott, it could
> >> not display a WiFi interface :192.168.0.x, but instead of a fault IP
> >> 169.254.133.101. Let me know if you need more debug information.
> >
> > 169.154.0.0/16 IP address range is from the link local address
> > range. That means ConnMan was not able to get an IP address via DHCP
> > IP. Check what the logs for DHCP messages. It might give you a clue
> > what's going wrong.
> >
> > Daniel
> >
> 
> 
> --
> "A man can fail many times, but he isn't a failure until he begins to
> blame somebody else."
> -- John Burroughs
