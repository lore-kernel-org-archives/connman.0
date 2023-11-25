Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1728E09
	for <connman@lists.linux.dev>; Sat, 25 Nov 2023 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 0C039CECD0;
	Sat, 25 Nov 2023 17:22:25 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2] service: Make DBG in
 '__connman_service_ipconfig_indicate_state' consistent.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231117210514.699193-1-gerickson@nuovations.com>
Date: Sat, 25 Nov 2023 17:22:14 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <DC39C4BB-3396-43C3-B21B-F66A64E43B17@holtmann.org>
References: <20231117210336.699149-1-gerickson@nuovations.com>
 <20231117210514.699193-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This makes the DBG statement in '__connman_service_ipconfig_indicate_state'
> consistent in format of 'service <service_pointer> (<service_name>) type
> <ipconfig_type> (<ipconfig_type_name>)' with that of other DBG statements
> in the module.
> 
> This makes at-a-glance, columnar correlation and comparison of service
> activities easier.
> ---
> src/service.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied.

Regards

Marcel

