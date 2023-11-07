Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951C31581
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 24720CECEB;
	Tue,  7 Nov 2023 16:19:48 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Move online check settings initialization to service
 init.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <63D885EB-FBE7-4C5B-BEA7-84288CF076DA@nuovations.com>
Date: Tue, 7 Nov 2023 16:19:37 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <698A55D4-D2DC-4A8A-926B-D1F7000B2F1E@holtmann.org>
References: <63D885EB-FBE7-4C5B-BEA7-84288CF076DA@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> The connman settings "EnableOnlineToReadyTransition",
> "OnlineCheckInitialInterval", and "OnlineCheckMaxInterval" do not vary
> across calls to 'start_online_check'. Consequently, they can be read
> and set once in '__connman_service_init'.
> ---
> src/service.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)

patch has been applied.

Regards

Marcel

