Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B911D264
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 1FA98CECD8;
	Sat, 23 Dec 2023 13:23:38 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] doc: Correct 'OnlineCheck{Initial,Max}Interval' units.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231222224711.2371812-1-gerickson@nuovations.com>
Date: Sat, 23 Dec 2023 13:23:27 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <73A2D030-AF9C-480F-A028-D5F8F34E2319@holtmann.org>
References: <20231222224711.2371812-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This corrects the 'OnlineCheck{Initial,Max}Interval' units from 'secs'
> to 'interval'.
> 
> Ultimately, in conjunction with a function associated with
> 'OnlineCheckIntervalStyle', 'OnlineCheck{Initial,Max}Interval' can be
> translated into seconds; however, the values themselves are simply
> unitless interval indices.
> ---
> doc/connman.conf.5.in | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

