Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF472
	for <connman@lists.linux.dev>; Fri, 26 Nov 2021 16:37:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AF885E368;
	Fri, 26 Nov 2021 17:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1637944243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=09gKllLy/Dv0ia7M0hI3nzH26CHJgiktaoLbobROTXA=;
	b=YIcAYth2Hqx8Gu0oBL9UfpNSlFlrS2tb98SMGtYCAwjdiAhT8E7bJRRXRkRjIxfA8gtFOa
	97YjLqC006/6YBDTZAfbDY2XWwdXv8DefiAkPuRdP2iMbU9G/pQElBLq2Vg4HQg6L4UhXJ
	MRRHXWBK7qQPYgVqn02m5vkNKihRnk4Vs3CrD0OJTx7wWApYuR+kYKuy1HpbqXO19sOTD3
	fvYHDT+rt5UUG6goRqdnNw/2lC/xy9kdBe3MAonsrHg+kJI4ryEHgntkOdToj/ZyB58H/D
	xFmBVaS6RWNFxlAEjvd+mRTAJJZS1MI4MHoqS3fsZpm3pUxvRXT0wTf+MVEalA==
Date: Fri, 26 Nov 2021 17:30:40 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jupiter <jupiter.hce@gmail.com>
Cc: yocto <yocto@lists.yoctoproject.org>, comman <connman@lists.linux.dev>,
	Armin Kuster <akuster808@gmail.com>
Subject: Re: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
Message-ID: <20211126163040.ai2euhv6yf4esnhn@carbon>
References: <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Fri, Nov 26, 2021 at 10:03:10AM +1100, Jupiter wrote:
> Please correct me, but it seems to me the connman is moving to a
> direction to ditch out wpa_supplicant and to use iwd, but the Honister
> still configure connman with wpa_supplicant by default, appreciate
> your advice:

Indeed, I recommend to use iwd instead of wpa_supplicant. There is no
active development happening in ConnMan on the wpa_supplicant
plugin. That means the wpa_supplicant plugin might work perfectly fine
for your use case and there is no need to use iwd. But don't expect any
big help if there are problems with wpa_supplicant.

> - Is connman with iwd stable enough?

Hard to answer as there is not definition of 'stable enough'. The best
advice is to test your use cases and figure out if it fits your
requirements.

> - How can I create a connman_1.40.bbappend  to replace wpa_supplicant
> by iwd configure?

This is a question for the Yocto mailing(s) list.

> - Where are the documents for configuring and building connman with
> iwd?

There is none, but there is not much you need to do. During the
configure step you do something like

./configure --disble-wifi --enable-iwd

That's all.

> Where is the operational guidance to run connman with iwd? Can I
> use the same connman dbus APIs or are there any dbus API changes to
> run connman with iwd?

There is no change in ConnMan's D-Bus APIs. Depending on your use cases
you might be able to remove the ConnMan from your design and only use
iwd. This is the case when you are only interested in WiFi networks. I
know some project went this way as it makes their system simpler and
more robust.

> My apology for FAQs.

No worries, I still hope someone with writing skill steps up at one
point and helps out at this front.

Daniel
