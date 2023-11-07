Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A0AD52
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2130FCECEB;
	Tue,  7 Nov 2023 17:07:35 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Leverage 'connman_service_get_identifier' in 
 'default_changed' DBG.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D1539454-13B0-4650-986C-ED334D1CE8CA@nuovations.com>
Date: Tue, 7 Nov 2023 17:07:24 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A3865488-7642-48CB-8048-7E328DBA134C@holtmann.org>
References: <D1539454-13B0-4650-986C-ED334D1CE8CA@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This leverages 'connman_service_get_identifier' in the 'default_changed'
> DBG call rather than re-creating the same logic from
> 'connman_service_get_identifier' in that same call.
> ---
> src/service.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied.

Regards

Marcel

