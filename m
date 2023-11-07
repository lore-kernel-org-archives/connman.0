Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1694130D1E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id E1DA1CECEB;
	Tue,  7 Nov 2023 17:01:18 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Expand DBG content in WISPr
 'wispr_portal_request_portal'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D8647202-2777-4F06-A248-6CD97629D3E1@nuovations.com>
Date: Tue, 7 Nov 2023 17:01:08 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A0811B54-1CC7-4677-91B5-556D7B9949F1@holtmann.org>
References: <98B224A1-A428-4C45-BB8C-4C2679C65706@nuovations.com>
 <D8647202-2777-4F06-A248-6CD97629D3E1@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> As the functionality for "EnableOnlineToReadyTransition" is further
> developed and there are multiple online checks in flight for multiple
> services and IP configuration types thereof, the expanded content in
> this DBG statement becomes critical to successfully tracking these
> unique online check operations.
> ---
> src/wispr.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

