Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355F12C872
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 3805DCECEB;
	Tue,  7 Nov 2023 16:36:20 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Be consistent about debug logging service and IP
 config type.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1943BE4D-CEA9-4BA2-8815-F0F8D7BD2177@nuovations.com>
Date: Tue, 7 Nov 2023 16:36:09 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <16C43B08-AF56-4928-93EE-B8C8A61074F1@holtmann.org>
References: <E8C09CE8-DE8A-46EA-BE67-F9F1B11211D2@nuovations.com>
 <1943BE4D-CEA9-4BA2-8815-F0F8D7BD2177@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> In a number of DBG log instances, there are inconsistencies in what and
> how a service and its IP configuration type are logged. In some places,
> it is just pointers and enumeration values. In other places, it is
> pointers, identifiers, and strings without enumerated values.
> 
> This makes several such instances consistent, logging the service
> pointer, the service instance name, the IP configuration type enumerated
> value and its string equivalent.
> ---
> src/proxy.c   |  4 +++-
> src/service.c | 27 +++++++++++++++++++--------
> src/wispr.c   | 14 +++++++++-----
> src/wpad.c    |  2 +-
> 4 files changed, 32 insertions(+), 15 deletions(-)

patch has been applied.

Regards

Marcel

