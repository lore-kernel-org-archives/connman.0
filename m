Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33D22EFF
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id A5599CECFB;
	Thu, 23 Nov 2023 12:22:21 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2] service: Leverage 'connman_service_set_proxy_method'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231116045908.638483-1-gerickson@nuovations.com>
Date: Thu, 23 Nov 2023 12:22:11 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <B5678C0B-C53B-46F6-8044-3140CCC19ABE@holtmann.org>
References: <20231116045404.638187-1-gerickson@nuovations.com>
 <20231116045908.638483-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> Previously, inside 'check_proxy_method', if WPAD failed for any reason
> the code would explicitly manipulate the 'proxy' field of the service
> object and then invoke '__connman_notifier_proxy_changed'.
> 
> However, when 'method' is 'CONNMAN_SERVICE_PROXY_METHOD_DIRECT', which
> is the case in 'check_proxy_method', this is 2/3 of what
> 'connman_service_set_proxy_method' already does. The 1/3  difference is
> that 'connman_service_set_proxy_method' calls 'proxy_changed'.
> 
> Consequently, since there does not seem to be a well-documented or
> compelling reason to avoid the call to 'proxy_changed', simply leverage
> and call 'connman_service_set_proxy_method' from 'check_proxy_method' to
> set the service proxy method to 'CONNMAN_SERVICE_PROXY_METHOD_DIRECT'
> when WPAD fails.
> ---
> src/service.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

