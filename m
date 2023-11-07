Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723AC3158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 3610ECECEE;
	Tue,  7 Nov 2023 20:02:33 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] service: Deduplicate online check config query and log.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <C6B61007-3C60-43AC-86FC-9C3412A5613A@nuovations.com>
Date: Tue, 7 Nov 2023 20:02:22 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <5BA54FB2-84F4-447E-B303-5D50D019E62E@holtmann.org>
References: <C6B61007-3C60-43AC-86FC-9C3412A5613A@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Identical logic with an identical log statement was used in both
> 'start_online_check' and 'start_wispr_if_connected'. This deduplicates
> that code into a single common, file-scope function,
> 'online_check_enabled_check', and leverages it in the two locations it
> was previously duplicated in.
> ---
> src/service.c | 42 ++++++++++++++++++++++++++++++++++--------
> 1 file changed, 34 insertions(+), 8 deletions(-)

patch has been applied.

Regards

Marcel

