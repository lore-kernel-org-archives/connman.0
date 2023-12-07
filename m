Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E62481BC
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id DB2DFCECD5;
	Fri,  8 Dec 2023 00:46:10 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2 0/3] connection: Introduce and Leverage IP Any /
 Unspecified Address String Constants and Functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231129204156.1298225-1-gerickson@nuovations.com>
Date: Fri, 8 Dec 2023 00:46:00 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <4BBFCA9A-B3DC-47B4-B110-241D5489617B@holtmann.org>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
 <20231129204156.1298225-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> The IPv4 and IPv6 any / unspecified address string literals, "0.0.0.0"
> and "::" respectively, and comparisons against them appear often
> enough throughout the code where they warrant referencing through
> file-scoped constants and introducing and leveraging introspection
> functions to encapsulate the comparison patterns.
> 
> This introduces and uses such constants and 'is_ipv[46]_addr_any_str'
> introspection functions to encapsulate these comparison patterns.
> 
> Grant Erickson (3):
>  connection: Introduce and leverage 'ipv[46]_addr_any_str' constants.
>  connection: Introduce and leverage 'is_ipv[46]_addr_any_str'
>    functions.
>  connection: Document 'is_ipv[46]_addr_any_str'.
> 
> src/connection.c | 92 ++++++++++++++++++++++++++++++++++++++----------
> 1 file changed, 73 insertions(+), 19 deletions(-)

all 3 patches have been applied.

Regards

Marcel

