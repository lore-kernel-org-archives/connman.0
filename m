Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F8C2C872
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id EF7CBCECEB;
	Tue,  7 Nov 2023 16:37:28 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Const-qualify service leaf getter functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <90BDDD2B-F715-4301-97A8-1B11BE65915F@nuovations.com>
Date: Tue, 7 Nov 2023 16:37:18 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <2D6F56DC-BBAF-4A1C-9AC2-5EDBAFFF8120@holtmann.org>
References: <F972A4C7-98B0-4667-B919-41A692B22C22@nuovations.com>
 <90BDDD2B-F715-4301-97A8-1B11BE65915F@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Const-qualify the network service arguments in service leaf getter
> and introspection functions to make it clear to the compiler, static
> analyzers, and human readers that the function is strictly a getter
> or introspection function with no network service mutation side
> effects.
> ---
> include/service.h | 18 +++++++++---------
> src/connman.h     | 24 ++++++++++++------------
> src/service.c     | 42 +++++++++++++++++++++---------------------
> 3 files changed, 42 insertions(+), 42 deletions(-)

patch does not apply cleanly.

Regards

Marcel

