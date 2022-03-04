Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E53A22
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 08:05:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49C145D1CA;
	Fri,  4 Mar 2022 09:05:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646381144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IqEGJLgwQlPrqXXyUOTwlSQJEoWDAzS5ee5wv0NKZZ0=;
	b=Mzw4LOZPF2fDcJHaV+On+V98CsVUauPXLo0oR9gouNqGanx7hnDx1bWq+zNpGZr2NOylyW
	kN3Nj3D9mrsjKoIBC4V85YeKuwm0dL6sIVkSfOXzitwNYKX1RZObkl93ZUPfrsgqouUA+F
	yNKNV/P5szV5JeIdoGS0rW/D7A2OGMF62UxTJQeti5gId1oFyFLjgF60kxFc+aa0p4Q3Jq
	XihzchuetKyDs62MOhBJFJMmhP2jCqk5Rl3BA9TDZ7bj7UwFBGxp2FiseQG0+DYruHX0Z2
	vLhvxluJGBrXsa+5GT/bEhHo140/SBVNu3vpCYlMRcKcK6RtJWNF0i3cfHxJNA==
Date: Fri, 4 Mar 2022 09:05:42 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Denis Kenzior <denkenz@gmail.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Message-ID: <20220304080542.j4j6jvttcovyqu6s@beryllium.lan>
References: <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220221164442.gsg6krtdalemte62@carbon.lan>
 <MRZP264MB1544515AF83263F7E4DDC918933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220227180930.ruqnmsgtei26zq4n@beryllium.lan>
 <MRZP264MB154417BCA30F1C47EDE6DAC793009@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154417BCA30F1C47EDE6DAC793009@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Feb 28, 2022 at 11:21:44AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > If I understood it correctly, you are saying ConnMan receives a
> > Disconnect call via D-Bus, it is forwarded to iwd and wait for iwd to
> > respond that the network is disconnected. Then ConnMan replies the
> > initial posted Disconnect call to the user back. The user posts then
> > Connect() which is too fast?
> I switch between 2 known secure networks.
> I have retried this morning with the following sequence:
> gdbus call --system -d net.connman -o $PATH1 -m net.connman.Service.Disconnect
> ()
> gdbus call --system -d net.connman -o $PATH2 -m  net.connman.Service.Connect
> ()
> gdbus call --system -d net.connman -o $PATH1 -m net.connman.Service.Connect
> Error: GDBus.Error:net.connman.Error.Failed: Input/output error

Thanks for this example. It really helps understanding what you want to
fix. Is the PATH2 Connect necessary for triggering the error?

> I think that the D-Bus reply of the Disconnect is immediate and does not wait for
> the network to be really disconnected or on error, contrary to the Connect, which
> really waits for the connection to be effective before replying.
> I thought it was on purpose.

IIRC, Disconnect was designed to return immediately. This might be the
source of the problem here.
