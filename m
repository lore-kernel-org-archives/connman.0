Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C8D264
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id E56C5CECD8;
	Sat, 23 Dec 2023 13:20:54 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/2] Add Service Identifier to a Couple of 'DBG'
 Statements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231220020544.2272820-1-gerickson@nuovations.com>
Date: Sat, 23 Dec 2023 13:20:44 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <57CFDC15-6B4F-4DD4-8FCF-A7D67561F660@holtmann.org>
References: <20231220020544.2272820-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This adds the service identifier to the 'DBG' statements in
> timeserver.c:'ts_reset' and session.c:'service_state_changed' to aid
> debugging in a multi-technology environment with
> "EnableOnlineToReadyTransition" asserted and for consistency with
> other DBG statements in other modules.
> 
> Grant Erickson (2):
>  session: Add service identifier to 'DBG' in 'service_state_changed'.
>  timeserver: Add service identifier to 'DBG' in 'ts_reset'.
> 
> src/session.c    | 4 +++-
> src/timeserver.c | 3 ++-
> 2 files changed, 5 insertions(+), 2 deletions(-)

both patches have been applied.

Regards

Marcel

