Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686C4B5D2
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id D6F56CECA3;
	Tue, 28 Nov 2023 10:55:19 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Query about ipv4 connman web page
From: Marcel Holtmann <marcel@holtmann.org>
X-Priority: 3
In-Reply-To: <20231128064603epcms1p425b92ba530ab3632c5763bb901118105@epcms1p4>
Date: Tue, 28 Nov 2023 10:55:09 +0100
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DDBBC01D-39D0-4A03-8BB8-DBC3E375F3A7@holtmann.org>
References: <20231128062351epcms1p15c1bd5c840503579f22a7d9887c49606@epcms1p1>
 <CGME20231128052502epcms1p4a229137cf6d9bb65b8e463a873688e69@epcms1p4>
 <20231128064603epcms1p425b92ba530ab3632c5763bb901118105@epcms1p4>
To: wy1115.lee@samsung.com
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Lee,

> I am testing connman on Tizen platform with the following URLs
> "http://ipv4.connman.net/online/status.html"
> "http://ipv6.connman.net/online/status.html"
>=20
>=20
> But when I test CURL GET request to those URLs, the response is CURLE =
28 (Connection timeout)
> Could you help to fix those web service?

should be all back to normal now.

Regards

Marcel

