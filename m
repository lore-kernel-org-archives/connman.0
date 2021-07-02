Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FC168
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 08:03:04 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id EE731500587;
	Fri,  2 Jul 2021 10:03:02 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id BA1A3500289;
	Fri,  2 Jul 2021 10:03:02 +0200 (CEST)
Date: Fri, 2 Jul 2021 10:03:02 +0200
From: Daniel Wagner <wagi@monom.org>
To: "Athimoolam Rajkumar (XC-CI1/ECP1)" <Rajkumar.A2@in.bosch.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: multiple APN contexts activation failure
Message-ID: <20210702080302.aw432py4fycmitld@beryllium.lan>
References: <d718d3f0a1914197944ab05cc43a3b90@in.bosch.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d718d3f0a1914197944ab05cc43a3b90@in.bosch.com>

Hi Raj,

On Thu, Jun 24, 2021 at 12:56:06PM +0000, Athimoolam Rajkumar (XC-CI1/ECP1) wrote:
> I am wondering why the different networks/APN contexts of the same
> modem device has to be disconnected instead of moving to "ready state"
> before initiating the connection to the new network/APN context.  Is
> it then not possible at all to have multiple APN contexts activated
> via Connman?

It's been a while since I looked at the ofono plugin, but this sounds
like a bug to me. I didn't see any special logic in the plugin from a
quick glance. The plugin should expose per context a new network object
which is independent from the core's perspective.

Hmm, what are you main.conf settings? Do you happen to do have

  SingleConnectedTechnology = true

set?
