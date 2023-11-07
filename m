Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58231581
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 651C6CECEB;
	Tue,  7 Nov 2023 16:16:12 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Add documentation for 'start_wispr_if_connected'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1D6BAD07-EBE1-4D5C-8C26-F89AB34FEE03@nuovations.com>
Date: Tue, 7 Nov 2023 16:16:01 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <5DA2B8EB-242D-481E-9E0B-4C860DDF39DF@holtmann.org>
References: <1D6BAD07-EBE1-4D5C-8C26-F89AB34FEE03@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This adds function documentation to 'start_wispr_if_connected'.
> 
> ---
> src/service.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)

patch has been applied.

Regards

Marcel

