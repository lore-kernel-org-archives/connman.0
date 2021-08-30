Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C03FC1
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 14:29:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 022905E30A;
	Mon, 30 Aug 2021 16:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630333783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aHEYT1ng3iuIbIbFKQgJV+7M9WtBeM7TWwno+GbHuRc=;
	b=1Q2Z81VQgdH5qjcvW/YdUZqdO9+gyeQp9sYDLE9VboJN5QbAYssE1DSZwqopS8op4X+wz7
	iDzz2qDfycYALjhRjpBiYNRqqvsDWagqR6uL2S5w78wECvoB0T0NjA2PQC2Bn/SNj6Niv2
	H2xTPV2/9Ew752Iu3QKlw6hSGB/pATrN97wbEtZpKk7Q0DcNHglmdqPOt7WXmXJg0McBpj
	D6TW8wpiM/nu4Yu905NpVFnpk27lZ95OcceWxuJA6oQHX7mK/dxJPGF/egmFMh/U3XpV3I
	DjAUvlFJp1tI/0XUwVx3c1H3HOUUN2MuuypKfa6kbmQACGnZf7WgmOfqXIFXgQ==
Date: Mon, 30 Aug 2021 16:29:40 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
Cc: connman <connman@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] service: Do not trigger wispr start when
 EnableOnlineCheck is disabled
Message-ID: <20210830142940.xfk2bpwsaw2wqx74@carbon.lan>
References: <20210829195321.23396-1-wagi@monom.org>
 <20210829195321.23396-3-wagi@monom.org>
 <20210829200849.6ttu3udd65fk7lt3@prancingpony>
 <20210830064403.5r3szonne7baipa2@carbon.lan>
 <20210830103411.f33oibwwmk2sqmkl@prancingpony>
 <20210830110219.4iuqzhymsbbccnrv@prancingpony>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830110219.4iuqzhymsbbccnrv@prancingpony>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Aug 30, 2021 at 01:02:19PM +0200, Страхиња Радић wrote:
> On 21/08/30 12:34, Страхиња Радић wrote:
> > I tested the patch with tcpdump, but unfortunately, it seems the connections are
> > still being made, even with EnableOnlineCheck=false, Enable6to4=false and
> > EnableOnlineToReadyTransition=false in /etc/connman/main.conf.
> 
> I found the culprit -- when built from source, default prefix is /usr/local, so
> connman was looking for main.conf in /usr/local/etc/connman instead of
> /etc/connman. When I symlinked /etc/connman/main.conf to
> /usr/local/etc/connman/main.conf and repeated the test, there were no
> occurrences of ipv4.connman.net in the log. I also repeated the test using only
> your two patches, without my patch, and got the same result.
> 
> Your two patches combined look ok.

Perfect! Thanks for the testing. In this case I'll queue them up this
evening.

Daniel

