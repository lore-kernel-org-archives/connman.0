Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8942E22F1A
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2DB32CECFB;
	Thu, 23 Nov 2023 12:27:38 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/2] service: Add and Leverage 'clear_error'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231120215329.786768-1-gerickson@nuovations.com>
Date: Thu, 23 Nov 2023 12:27:27 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <3F401339-13B4-47D2-9FDB-9AEEDE23EB4A@holtmann.org>
References: <20231120215329.786768-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> There are a suffient number of instantiations of the following
> implementation pattern:
> 
>    set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
> 
> to clear or reset the "Error" service property where it makes sense to
> embody this in a single function.
> 
> This introduces and leverages the 'clear_error' function to embody
> this pattern.
> 
> Grant Erickson (2):
>  service: Add and leverage 'clear_error'.
>  service: Document '{clear,set}_error'.
> 
> src/service.c | 56 +++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 50 insertions(+), 6 deletions(-)

both patches have been applied.

Regards

Marcel

