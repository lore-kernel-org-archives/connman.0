Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287A125C8
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id CC5B1CECFF;
	Sat, 11 Nov 2023 11:12:43 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/3] Add and Leverage HTTP Status Code Mnemonics
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
Date: Sat, 11 Nov 2023 11:12:33 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <935CE0EA-6BEC-45F6-8071-5E686DEDC289@holtmann.org>
References: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This patch series adds and leverages IANA HTTP status code mnemonics
> for improved code readability and self-documentation.
> 
> Grant Erickson (3):
>  gweb: Add HTTP status code mnemonics.
>  gweb: Leverage GWebStatusCode mnemonics.
>  wispr: Leverage GWebStatusCode mnemonics.
> 
> gweb/gweb.c | 23 ++++++++++--------
> gweb/gweb.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> src/wispr.c | 22 ++++++++---------
> 3 files changed, 94 insertions(+), 21 deletions(-)

all 3 patches have been applied.

Regards

Marcel

