Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C722F0C
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id D98A3CECFB;
	Thu, 23 Nov 2023 12:24:15 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] service: Document the 'current_default' global.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231117214923.706301-1-gerickson@nuovations.com>
Date: Thu, 23 Nov 2023 12:24:05 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <56C03646-A578-4C75-B760-203425C6CCCF@holtmann.org>
References: <20231117214923.706301-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This documents the 'current_default' global and includes "see also"
> references to related functions.
> ---
> src/service.c | 9 +++++++++
> 1 file changed, 9 insertions(+)

patch has been applied.

Regards

Marcel

