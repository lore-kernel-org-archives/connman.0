Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096B3158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 6A65ACECEE;
	Tue,  7 Nov 2023 20:03:25 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Terminate all online check handling in one function.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <C0F0B144-2996-4453-B7CF-CF4E87A81FB1@nuovations.com>
Date: Tue, 7 Nov 2023 20:03:15 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <246656D9-38A0-4F68-B829-62369D2DB109@holtmann.org>
References: <C0F0B144-2996-4453-B7CF-CF4E87A81FB1@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This modifies 'portal_manage_status' by moving the unconditional
> transition of the service to the 'online' state for which a HTTP-
> based reachability check was successfully completed to the callback
> provided to '__connman_wispr_start', specifically,
> 'complete_online_check'. This places all handling, both failure and
> success, of HTTP-based reachability checks in a single, auditable
> location in a single function in a single source file.
> ---
> src/service.c |  9 ++++++++-
> src/wispr.c   | 10 +---------
> 2 files changed, 9 insertions(+), 10 deletions(-)

patch has been applied.

Regards

Marcel

