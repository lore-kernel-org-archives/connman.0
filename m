Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B373158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 6E321CECEE;
	Tue,  7 Nov 2023 20:01:37 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] service: Add DBG statement to 'start_wispr_if_connected'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <91BE5C97-387C-4DF5-A576-BA67CA479688@nuovations.com>
Date: Tue, 7 Nov 2023 20:01:27 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <5481E4A0-C39D-4E29-87D0-139D092A3B00@holtmann.org>
References: <91BE5C97-387C-4DF5-A576-BA67CA479688@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This adds a DBG statement to 'start_wispr_if_connected' to aid in
> debugging and correlating WISPr online checks in flight in a multi-
> technology environment with "EnableOnlineToReadyTransition" asserted.
> ---
> src/service.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied.

Regards

Marcel

