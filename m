Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0956B1C6BE
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 035D8CECD1;
	Wed, 29 Nov 2023 13:54:36 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] ipconfig: Return a unique string for
 'CONNMAN_IPCONFIG_TYPE_ALL'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231128181551.1149522-1-gerickson@nuovations.com>
Date: Wed, 29 Nov 2023 13:54:26 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A466F688-5620-4015-A606-4F3EAEA2697F@holtmann.org>
References: <20231128181551.1149522-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> At commit 89f70d225df6 ("ipconfig: Define unique value for
> CONNMAN_IPCONFIG_TYPE_ALL"), a unique enumertion value was provided
> for 'CONNMAN_IPCONFIG_TYPE_ALL' to make it semantically different from
> 'CONNMAN_IPCONFIG_TYPE_ALL'; however, a unique string returned
> from '__connman_ipconfig_type2string' was not, leaving it to misleadingly
> return "unknown" for 'CONNMAN_IPCONFIG_TYPE_ALL'.
> 
> This addresses this oversight by returning a unique string for
> 'CONNMAN_IPCONFIG_TYPE_ALL', "IPv4 + IPv6".
> ---
> src/ipconfig.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

