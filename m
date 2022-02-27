Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B854A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 18:09:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 805EE5D428;
	Sun, 27 Feb 2022 19:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645985371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5g5euUnmewIqxIliIq07tTUvJcfBpV66KmBLHuJY0o0=;
	b=qLT85rRuRZRJKLB16Pghp7ztQtX3j2g6GfzDKyNfj8ZUT7yxfGMTb3kZXHheJB7nXAIF40
	wjyIHojTQnh1fvuK/swLCc6fy5FQnXIhxVQAh+ljFzxUttnsFGSUh9ukjFUPrpWTmEf1ER
	S3ynn5n+cweaOehLaJV1cyoDfDJHeNHDtzfcCniHreX196sE1XdDnCCP3FQnbNaRn0ejgV
	/hHZb2nuRJYx8wacSKEypLt1BtBANTMaQmfu0rWGvjZ+kArhEW/roJY6mxxJtONGv9jIlB
	WRBKM83uhGcvXRilzZwsu5k1Htuip2QHFPzEVnIpMyarD14+jw/vv+l77mVnKg==
Date: Sun, 27 Feb 2022 19:09:30 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Denis Kenzior <denkenz@gmail.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Message-ID: <20220227180930.ruqnmsgtei26zq4n@beryllium.lan>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220221164442.gsg6krtdalemte62@carbon.lan>
 <MRZP264MB1544515AF83263F7E4DDC918933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544515AF83263F7E4DDC918933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Feb 21, 2022 at 04:53:05PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> In fact, I have already proposed a specific scenario on last mail:
> It is easy to reproduce the issue, by switching quickly between two known
> Wifi networks (W1 & W2), via the Service api. By quickly, I mean: one call shall
> immediately follow the reply of the previous call.
> In this case, the following steps happen:
> 1. Disconnection of current network (W1).
> 2. Connection to the new one (W2) failing with "net.connman.iwd.Failed"
> dbus error in cm_network_connect_cb, probably due to the fact that W1
> disconnection was not already completed, aborting connection to W2.

If I understood it correctly, you are saying ConnMan receives a
Disconnect call via D-Bus, it is forwarded to iwd and wait for iwd to
respond that the network is disconnected. Then ConnMan replies the
initial posted Disconnect call to the user back. The user posts then
Connect() which is too fast?

Or does the application post a Disconnect call via D-Bus and immediately
post a Connect() call?

Daniel
