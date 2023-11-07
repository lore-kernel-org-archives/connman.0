Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35BF30D0B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 7C4E1CECEB;
	Tue,  7 Nov 2023 16:24:49 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Add self-documenting Linux rp_filter enum.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <A838BEF3-E296-4B5A-9B84-8D5D0805FB67@nuovations.com>
Date: Tue, 7 Nov 2023 16:24:39 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <13D118CA-3C69-43FC-86E8-D22B1C10B3D0@holtmann.org>
References: <A838BEF3-E296-4B5A-9B84-8D5D0805FB67@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This improves self-documentation of the Linux reverse path filtering
> (rp_filter) validation setting values by introducing a file scope
> enumeration for the possible valid values
> ---
> src/ipconfig.c | 23 ++++++++++++++++-------
> 1 file changed, 16 insertions(+), 7 deletions(-)

patch has been applied.

Regards

Marcel

