Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578B125C3
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id E0CD7CED00;
	Sat, 11 Nov 2023 11:22:58 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/4] wispr: Address reference counting heap-use-after-free
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
Date: Sat, 11 Nov 2023 11:22:48 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A74F5EC3-295C-47DD-B134-534063AF6850@holtmann.org>
References: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This patch series adds documentation, 'DBG' statements, and balances
> WISPr/portal context reference counting with proxy handling that leads
> to a heap-use-after-free fault.
> 
> Grant Erickson (4):
>  wispr: Add DBG statement to 'free_connman_wispr_portal_context'.
>  wispr: Document 'wispr_portal_hash'.
>  wispr: Add documentation about reference counting.
>  wispr: Address unbalanced reference counting with proxy handling.
> 
> src/wispr.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)

all 4 patches have been.

Regards

Marcel

