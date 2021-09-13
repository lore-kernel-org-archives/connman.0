Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08033FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 06:52:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB34C5E4FC;
	Mon, 13 Sep 2021 08:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1631515970; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vrrNbPXgcDEQeiZnDvdMSutw/sqYp0WtF5BYRKSfjUw=;
	b=pUys+1o6xhPqOXdwcJXDgj5pcC5l7gSwndtSR1cLgVJVTkcIZqZcv1CKZ7HW5Vk7ZtecJ+
	ERuvnI0WQ9pzlrLlyBE8rANUB2qJLsNDej9p2j2YkZtK/D5i5tWhSCr2iVtj6XVGWvnmFa
	gHKquQLLdedD2iNu59BDBHAPVmbXkW5+BBR574XL10SGQ9RDQyTN8gm7EiuSAfRZqgG7d7
	w5XchDBaVgl20vHrDZzvrmIxD0BBDQUOAlmfYCBSdJj6QfZhzjI/iB12TJKkEQ9/j2DnIC
	8TieUybVW68bb0jQ7JyXfkAzyhvdltXDAo1ZsSxzLw8kQzAXn3GoJ/q19X7c7Q==
Date: Mon, 13 Sep 2021 08:52:49 +0200
From: Daniel Wagner <wagi@monom.org>
To: "Then Kit Sen (XC-CI1/ESS1-Pg)" <KitSen.Then@my.bosch.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Managing Wifi Network Interface with connman
Message-ID: <20210913065249.furgu555hkbxcv4v@beryllium.lan>
References: <HE1PR10MB15463985825D31A494396897CDD39@HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM>
 <HE1PR10MB154607B2A38761302711B505CDD39@HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR10MB154607B2A38761302711B505CDD39@HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi KitSen,

On Tue, Sep 07, 2021 at 08:16:47AM +0000, Then Kit Sen (XC-CI1/ESS1-Pg) wrote:
> I had an own application to setup the WIFI client and Access Point,
> and would like to check with you whether connman capable to manage
> this Interface by setting up this interface IP address with DHCP
> client, DHCP server for AP, and DNS for this interface?

ConnMan has very limited supported for setting up and controller AP use
case. The only supported AP related use case is the tethering one,
e.g. the device creates an AP to share it's LTE uplink.

> For eg, my application will bring up wlan0 and uap0 network interface
> and would like to use connman to configure DHCP server for uap0 and
> static IP address for wlan0.

One of the design decisions in ConnMan was not to expose individual
devices, instead only classes of devices are controllable via the D-Bus
API. While this could be changed no one has stepped up to do the work.

Without this kind of interface you can't really put one device into AP
mode while the other stays in STA.

> Due to some requirement, i would need to configure :
> 1. Static IP
> 2. Dynamic IP 
> 3. DHCP server start address, end address, lease hour and gateway
> 4. DNS
> 
> Or is it suitable that we develop a new plugin to only manage this
> network interface configuration which not setup by the wifi or iw
> plugin in connman? Or this is not recommended?

In this scenario the recommendation way is to control the AP device
independent of the STA interface (which can be controlled by
ConnMan). You can tell ConnMan to ignore the AP device. For the AP
device I would recommend to do look at iwd and see if this project would
fit your needs (highly recommended).

Hope this helps,
Daniel
