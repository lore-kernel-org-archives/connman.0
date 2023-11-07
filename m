Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC530D1E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 48F52CECEB;
	Tue,  7 Nov 2023 17:04:15 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] service: Leverage 'is_connected'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <7F1AE24F-502C-4A3C-95A8-13602CDB0048@nuovations.com>
Date: Tue, 7 Nov 2023 17:04:05 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <4E9DA3BD-4F0A-43B9-A193-5B9E890192A4@holtmann.org>
References: <7F1AE24F-502C-4A3C-95A8-13602CDB0048@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> In all instances but one where there are checks to see whether the
> IPv4 or IPv6 service state is 'CONNMAN_SERVICE_STATE_READY' or
> 'CONNMAN_SERVICE_STATE_ONLINE', the 'is_connected' function is used.
> This leverages 'is_connected' for the only instance where that was
> not the case.
> ---
> src/service.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

