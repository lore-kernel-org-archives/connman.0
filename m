Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A911C6BE
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id E6F22CECD1;
	Wed, 29 Nov 2023 13:53:53 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/2] ipconfig: Add DBG and Documentation to
 '__connman_ipconfig_gateway_{add,remove}'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231128192304.1179479-1-gerickson@nuovations.com>
Date: Wed, 29 Nov 2023 13:53:43 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <2DE070AC-2294-49DD-A591-4B766D75CB57@holtmann.org>
References: <20231128192304.1179479-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This not only expands and harmonizes the initial 'DBG' statements in
> '__connman_ipconfig_gateway_{add,remove}' to aid debugging in a
> multi-technology environment with "EnableOnlineToReadyTransition" but
> also adds function documentation to these functions.
> 
> Grant Erickson (2):
>  ipconfig: Expand and harmonize 'DBG' in
>    '__connman_ipconfig_gateway_{add,remove}'
>  ipconfig: Document '__connman_ipconfig_gateway_{add,remove}'.
> 
> src/ipconfig.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 61 insertions(+), 3 deletions(-)

both patches have been applied.

Regards

Marcel

