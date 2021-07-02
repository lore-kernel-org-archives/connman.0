Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6C168
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 13:11:43 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 95E8F500587;
	Fri,  2 Jul 2021 15:11:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id 5ACE7500289;
	Fri,  2 Jul 2021 15:11:41 +0200 (CEST)
Date: Fri, 2 Jul 2021 15:11:41 +0200
From: Daniel Wagner <wagi@monom.org>
To: "Athimoolam Rajkumar (XC-CI1/ECP1)" <Rajkumar.A2@in.bosch.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: multiple APN contexts activation failure
Message-ID: <20210702131141.gymts4rkt7zal5my@beryllium.lan>
References: <d718d3f0a1914197944ab05cc43a3b90@in.bosch.com>
 <20210702080302.aw432py4fycmitld@beryllium.lan>
 <514b0b8a2acd48c8b1df03436ce2ceca@in.bosch.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514b0b8a2acd48c8b1df03436ce2ceca@in.bosch.com>

On Fri, Jul 02, 2021 at 10:16:24AM +0000, Athimoolam Rajkumar (XC-CI1/ECP1) wrote:
> All the network object belongs to same modem device and hence while
> connecting to second APN/network the previous one is disconnected via
> call to __connman_device_disconnect(network->device);

So there is only one __connman_device_disconnect() and this was added
via 3b6dd9aa9030 ("Add support for disconnecting networks first").

> May be separate setting needed to allow multiple networks of same
> device to be connected at the same time

Hmm, it might be that we have here an artifact. The original commit did
the following:

+		mode = connman_device_get_mode(network->device);
+		if (mode == CONNMAN_DEVICE_MODE_NETWORK_SINGLE)
+			__connman_device_disconnect(network->device);

and eventually the mode stuff got dropped but the disconnect stayed.  So
we might just want to drop it. Though this needs some testing first :)
