Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F74AF93
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 7F284CECD5;
	Fri,  8 Dec 2023 00:36:44 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2] connection: Rename 'ipv[46]_gateway' gateway config
 field.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231129195237.1296695-1-gerickson@nuovations.com>
Date: Fri, 8 Dec 2023 00:36:33 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <3117AF44-8A91-4B39-8959-ECF85D3737E9@holtmann.org>
References: <20231129000816.1230451-1-gerickson@nuovations.com>
 <20231129195237.1296695-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This renames the 'gateway_data' structure 'ipv[46]_gateway' fields as
> 'ipv[46]_config' to:
> 
>    1. Better align the fields with their type, 'gateway_config'.
>    2. Disambiguate the fields from their type field, 'gateway'.
>    3. Align with and mirror 'ipconfig'.
> ---
> src/connection.c | 352 +++++++++++++++++++++++------------------------
> 1 file changed, 176 insertions(+), 176 deletions(-)

patch has been applied.

Regards

Marcel

