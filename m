Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130FBA4C
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id C70A3CECD0;
	Wed,  8 Nov 2023 15:40:43 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Don't add route for invalid dst and gateway address
 combinations
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20230828111846.2170668-1-zboszor@gmail.com>
Date: Wed, 8 Nov 2023 15:40:33 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <7FB0902E-D466-4630-8868-080BEE66B75A@holtmann.org>
References: <20230828111846.2170668-1-zboszor@gmail.com>
To: =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Zoltan,

> Don't add route for link-local or unspecified destination address
> coupled with unspecified gateway address.
> 
> When the machine has multiple interfaces, it may occur that some
> of them don't have a DHCP server behind them, and there is no
> fixed address assigned to them either.
> 
> Such interfaces get a link-local address assigned by Connman and
> routes are added to them with 0.0.0.0 gateway address on IPv4.
> 
> Adding such routes breaks networking because these routes behave
> exactly like the default route but they take precedence over the
> default and are the equivalent of /dev/null for network packets.
> 
> Observed with virtual veth* interfaces created by docker where
> only the bridge interface has a DHCP assigned address.
> ---
> src/inet.c | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)

patch has been applied.

Regards

Marcel

