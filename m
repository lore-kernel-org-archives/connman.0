Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B96FCE
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id BEFC9CECEF;
	Wed, 22 Nov 2023 19:49:32 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Wired 802.1x support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DM4PR17MB606221C32530180BE1CD1BCCACBAA@DM4PR17MB6062.namprd17.prod.outlook.com>
Date: Wed, 22 Nov 2023 19:49:22 +0100
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <355F1A85-6F3B-406E-ABF4-41EF6598F4DE@holtmann.org>
References: <DM4PR17MB6062156344D8310C1353BC28ACBAA@DM4PR17MB6062.namprd17.prod.outlook.com>
 <DM4PR17MB606221C32530180BE1CD1BCCACBAA@DM4PR17MB6062.namprd17.prod.outlook.com>
To: =?utf-8?B?IkRvdW1lbmMsIFLDqW1pIg==?= <RemiDoumenc@eaton.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Remi,

> As far as I can check out in the code, connman does not seem to =
support wired 802.1x.
> Is there any plan to add this support in a near future ?
> The implementation seems very similar as Wi-Fi by leveraging the =
wpa_supplicant.
> In case there is no yet plan to support it, would you accept an =
external contribution to add this support ?

actually we have 802.1x wired support in iwd. It is just not in the iwd =
and instead in the wired/ directory with the daemon being called ead.

What wpa_supplicant is doing with mushing WiFi Enterprise together with =
Wired 802.1x is actually a total mess. These two are independent =
features (even while there share the EAP portion of it). And so with =
split these two.

Contributions to ead are more than welcome since it is clearly =
underdeveloped compared to iwd.

Regards

Marcel

