Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C351944C
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id A0E83CECD1;
	Wed, 29 Nov 2023 14:20:02 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 1/3] connection: Introduce and leverage
 'ipv[46]_addr_any_str' constants.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231129015253.1254116-2-gerickson@nuovations.com>
Date: Wed, 29 Nov 2023 14:19:52 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <5225FCB7-A3BB-4E45-B057-FFCA0BA278A6@holtmann.org>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
 <20231129015253.1254116-2-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> The IPv4 and IPv6 any / unspecified address string literals, "0.0.0.0"
> and "::" respectively, appear often enough throughout the code where
> they warrant referencing through file-scoped constants.
> ---
> src/connection.c | 28 ++++++++++++++++------------
> 1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/src/connection.c b/src/connection.c
> index 3749d3a59196..66a3bd656db0 100644
> --- a/src/connection.c
> +++ b/src/connection.c
> @@ -57,6 +57,9 @@ struct gateway_data {
> bool default_checked;
> };
> 
> +static const char *const ipv4_addr_any_str = "0.0.0.0";
> +static const char *const ipv6_addr_any_str = "::";
> +

explain to me the double const. And why a variable and not just a #define.

Regards

Marcel

