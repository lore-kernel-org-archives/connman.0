Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8649D505
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 66235CECD8;
	Sat, 23 Dec 2023 13:20:31 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] service: Qualify call to '__connman_timeserver_sync' with
 default check.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231220012437.2259325-1-gerickson@nuovations.com>
Date: Sat, 23 Dec 2023 13:20:20 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <B3B1E61A-267E-4A6F-BF3A-AD5A63B86A4E@holtmann.org>
References: <20231220012437.2259325-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This qualifies the call to '__connman_timeserver_sync' in
> '__connman_service_ipconfig_indicate_state' with a check against
> 'connman_service_is_default'.
> 
> In a multi-technology and -service environment, there may be a senior,
> default service that is providing the network service for time-of-day
> synchronization.
> 
> Without the 'connman_service_is_default' qualification, in a
> multi-technology and -service environment, as junior services
> transitions to the 'ready' state, each of those service usurp the
> senior, default service and start trying to provide time-of-day
> synchronization which is NOT what is desired.
> 
> So, in a configuration with Ethernet, Wi-Fi, and Cellular in which
> they are preferred in that order and in which Ethernet is the default
> and becomes 'ready' first, Ethernet will provide the network service
> for time-of-day synchronization. Then, once Wi-Fi becomes 'ready', it
> will usurp time-of-day synchronization from Ethernet. Similarly, when
> Cellular becomes 'ready' it will usurp time-of-day synchronization
> from Wi-Fi. In all of those cases, time-of-day synchronization should
> have remained with Ethernet until such time as it was/is no longer the
> senior, default service.
> ---
> src/service.c | 21 +++++++++++++++++++--
> 1 file changed, 19 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

