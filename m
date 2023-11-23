Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31322F0C
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 732EACECFD;
	Thu, 23 Nov 2023 12:22:23 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/3] service: Minor address_updated Changes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231116030912.636756-1-gerickson@nuovations.com>
Date: Thu, 23 Nov 2023 12:22:12 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <E616460C-EC81-4598-B4FE-B5510E81980B@holtmann.org>
References: <20231116030912.636756-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This makes some minor changes to 'address_updated':
> 
>    1. Leverage 'connman_service_is_default'.
>    2. Add 'DBG' statement.
>    3. Add documentation.
> 
> Grant Erickson (3):
>  service: Leverage 'connman_service_is_default'.
>  service: Add DBG statement to 'address_updated'.
>  service: Add documentation to 'address_updated'.
> 
> src/service.c | 35 ++++++++++++++++++++++++++++++++++-
> 1 file changed, 34 insertions(+), 1 deletion(-)

sadly this doesnt apply cleanly anymore.

Regards

Marcel

