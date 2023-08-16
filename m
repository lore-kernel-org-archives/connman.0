Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3717F7
	for <connman@lists.linux.dev>; Wed, 16 Aug 2023 07:31:13 +0000 (UTC)
Received: from smtpclient.apple (p4fefcd6d.dip0.t-ipconnect.de [79.239.205.109])
	by mail.holtmann.org (Postfix) with ESMTPSA id E3EE9CED0C;
	Wed, 16 Aug 2023 09:31:12 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] iwd: Fix invalid-key error on user reconnection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <MRZP264MB1544B4C51B01525FE4CBA6C19358A@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Date: Wed, 16 Aug 2023 09:31:04 +0200
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: 7bit
Message-Id: <627E763A-B53D-40D0-B807-AF5FC41BD3DE@holtmann.org>
References: <MRZP264MB1544B4C51B01525FE4CBA6C19358A@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
To: "VAUTRIN Emmanuel (Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
X-Mailer: Apple Mail (2.3731.700.6)

Hi Emmanuel,

> Connecting to a WiFi network under disconnection leads to an
> invalid-key error, when the disconnection callback tries to reset the
> connected status and the network is still connecting or associating.
> In this case, connman_network_set_connected() sets a
> CONNMAN_NETWORK_ERROR_CONNECT_FAIL error, which shall be ignored.
> ---
> plugins/iwd.c | 118 +++++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 106 insertions(+), 12 deletions(-)

patch has been applied.

Regards

Marcel
Merl
