Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB63158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 09226CECEE;
	Tue,  7 Nov 2023 19:59:59 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] service: Enhance DBG in
 '__connman_service_indicate_default'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0B51F2F9-E96E-4C79-B757-EC697EE5CAF8@nuovations.com>
Date: Tue, 7 Nov 2023 19:59:48 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <9135D071-A82D-4F43-A595-E60D0D797268@holtmann.org>
References: <0B51F2F9-E96E-4C79-B757-EC697EE5CAF8@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This enhances the DBG statement in '__connman_service_indicate_default'
> by adding the service identifier. In addition, it aligns the content and
> format with other DBG functions in the module to make debugging and at-
> a-glance correlation easier, especially in a multi-technology environment
> with "EnableOnlineToReadyTransition" asserted.
> ---
> src/service.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

