Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564B31A6F
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id B53B9CECD4;
	Wed,  8 Nov 2023 19:31:36 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 2/2 v3] service: Add documentation to proxy-related
 functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BBD188EE-25C1-4129-9F35-C42BA73CC055@nuovations.com>
Date: Wed, 8 Nov 2023 19:31:26 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <4D22D6C2-B5EA-4655-A3EC-A55E9A5D23FE@holtmann.org>
References: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
 <B5EF6141-E568-42FF-80CD-B010B5ABA14C@nuovations.com>
 <142A53C6-7DB5-49AA-8B7C-763412123A9D@nuovations.com>
 <BBD188EE-25C1-4129-9F35-C42BA73CC055@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Add documentation to the proxy-related functions, 'check_proxy_setup'
> and '__connman_service_set_proxy_method'.
> ---
> src/service.c | 41 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

patch has been applied.

Regards

Marcel

