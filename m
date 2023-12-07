Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227A4AF93
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 91540CECD5;
	Fri,  8 Dec 2023 00:44:22 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/4] connection: Harmonize Search Function Names and
 Document Search Functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231207234130.1093617-1-gerickson@nuovations.com>
Date: Fri, 8 Dec 2023 00:44:12 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <6C3A23A6-16F5-40C0-8DB3-B1300E379651@holtmann.org>
References: <20231207234130.1093617-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This colocates service/gateway search functions, harmonizes their
> names, and documents them.
> 
> Grant Erickson (4):
>  connection: Colocate search functions.
>  service: Const-qualify 'lookup_gateway_data'.
>  connection: Harmonize search function names.
>  connection: Document search functions.
> 
> src/connection.c | 161 +++++++++++++++++++++++++++++++++--------------
> 1 file changed, 115 insertions(+), 46 deletions(-)

all 4 patches have been applied.

Regards

Marcel

