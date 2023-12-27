Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421F446AF
	for <connman@lists.linux.dev>; Wed, 27 Dec 2023 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 7841ACECC3;
	Wed, 27 Dec 2023 12:51:46 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/2] service: Improve Logging and Event Visibility at the
 Info Level
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231223185812.2389541-1-gerickson@nuovations.com>
Date: Wed, 27 Dec 2023 12:51:35 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <360C94AE-8710-4109-84C2-F4809D5250C0@holtmann.org>
References: <20231223185812.2389541-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This improves service logging and event visibility at the info level
> by making the following additions and changes:
> 
>  1. Make log output of online_check_is_enabled_check consistent,
>     resulting in log entries similar to "Online check disabled;
>     interface wlan0 [ wifi ] remains in ready state."
> 
>  2. Log service default, error, and state changes, resulting in log
>     entries similar to:
> 
>       Interface eth0 [ ethernet ] is the default
>       Interface wlan0 [ wifi ] error "online-check-failed"
>       Interface wwan0 [ cellular ] state is online
> 
> Grant Erickson (2):
>  service: Make log output of 'online_check_is_enabled_check'
>    consistent.
>  service: Log service default, error, and state changes.
> 
> src/service.c | 69 +++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 61 insertions(+), 8 deletions(-)

both patches have been applied.

Regards

Marcel

