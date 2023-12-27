Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBC446AC
	for <connman@lists.linux.dev>; Wed, 27 Dec 2023 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 92F87CECC3;
	Wed, 27 Dec 2023 12:49:27 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] doc: Remove 'Experimental' designation from
 'EnableOnlineToReadyTransition'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231223190339.2389588-1-gerickson@nuovations.com>
Date: Wed, 27 Dec 2023 12:49:17 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <45D6EE07-6C37-4491-9994-1E711665C29C@holtmann.org>
References: <20231223190339.2389588-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This removes the "Experimental" designation from
> "OnlineCheckMode=continuous" / "EnableOnlineToReadyTransition=true" as
> it is functional, verified, and no longer experimental.
> ---
> doc/connman.conf.5.in | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied.

Regards

Marcel

