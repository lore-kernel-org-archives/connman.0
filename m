Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741801DFD1
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 4F251CECFB;
	Thu, 23 Nov 2023 12:26:01 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/2] service: Bifurcate 'complete_online_check' handling.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231118002244.723157-1-gerickson@nuovations.com>
Date: Thu, 23 Nov 2023 12:25:51 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <E9E383EE-7B9A-4B1A-84A2-45B44EDA8ACA@holtmann.org>
References: <20231118002244.723157-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This bifurcates 'complete_online_check' closure handling into a
> success and failure handler: 'handle_online_check_success' and
> 'handle_online_check_failure'.
> 
> Both at present and as the continuous online check mode (also known
> as, 'EnableOnlineToReadyTransition') evolves, the closure handling of
> online checks is both more tractable and easier to reason about when
> partitioned into success and failures rather than co-mingling both
> into the same function. Moreover, this simplifies
> 'complete_online_check' itself.
> 
> Grant Erickson (2):
>  service: Bifurcate 'complete_online_check' handling.
>  service: Document 'handle_online_check_{failure,success}'.
> 
> src/service.c | 199 ++++++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 168 insertions(+), 31 deletions(-)

both patches have been applied.

Regards

Marcel

