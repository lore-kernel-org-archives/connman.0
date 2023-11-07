Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA130CF5
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 4C379CECEB;
	Tue,  7 Nov 2023 17:05:05 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] service: Introduce and leverage 'is_online'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <F37E2A4E-0C6D-4C97-B8EE-9BDDB4DB4816@nuovations.com>
Date: Tue, 7 Nov 2023 17:04:55 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <874CFF36-5D1D-41DE-8863-6D4EDCB05A61@holtmann.org>
References: <F37E2A4E-0C6D-4C97-B8EE-9BDDB4DB4816@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This introduces and leverages, where appropriate, the file-scoped
> 'is_online' service state introspection function as a peer to similar
> 'is_*' introspection functions.
> ---
> src/service.c | 25 +++++++++++++++----------
> 1 file changed, 15 insertions(+), 10 deletions(-)

patch has been applied.

Regards

Marcel

