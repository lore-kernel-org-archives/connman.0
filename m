Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D87AD52
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 80501CECEB;
	Tue,  7 Nov 2023 17:08:30 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Add documentation to the service default functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <FCE44C9C-69FC-4328-B02E-43BF5259C934@nuovations.com>
Date: Tue, 7 Nov 2023 17:08:20 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <1EF1FFF4-DBB9-4593-8AC3-CF6D2926FD2D@holtmann.org>
References: <FCE44C9C-69FC-4328-B02E-43BF5259C934@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This adds documentation to the service default getter and introspection
> functions.
> ---
> src/service.c | 35 +++++++++++++++++++++++++++++++++++
> 1 file changed, 35 insertions(+)

patch has been applied.

Regards

Marcel

