Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D831A7F
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 179E7CECEB;
	Tue,  7 Nov 2023 16:56:00 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Added function documentation for ipconfig getters.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0366A3BC-9F03-470C-82AB-6273EF43B8D3@nuovations.com>
Date: Tue, 7 Nov 2023 16:55:49 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <BAB821BC-9980-40FC-9DA0-7DA2AC5952CB@holtmann.org>
References: <44B8A3FE-B61B-4295-8028-DF49DE56FDED@nuovations.com>
 <0366A3BC-9F03-470C-82AB-6273EF43B8D3@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This adds function documentation for:
> 
>  * read_conf_value
>  * read_ipv4_conf_value
>  * read_ipv6_conf_value
>  * get_ipv6_privacy
>  * get_rp_filter
> 
> ---
> src/ipconfig.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 149 insertions(+), 1 deletion(-)

Patch has been applied.

Regards

Marcel

