Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43528373
	for <connman@lists.linux.dev>; Sat, 25 Nov 2023 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 849AFCECD0;
	Sat, 25 Nov 2023 17:31:56 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2] service: Make DBG in
 '__connman_service_ipconfig_indicate_state' consistent.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <53F8288B-E003-477D-862D-B6F6F48DF434@nuovations.com>
Date: Sat, 25 Nov 2023 17:31:46 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B238BC9-900D-4CEC-9D48-018809C26EE4@holtmann.org>
References: <20231117210336.699149-1-gerickson@nuovations.com>
 <20231117210514.699193-1-gerickson@nuovations.com>
 <53F8288B-E003-477D-862D-B6F6F48DF434@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> Any thoughts on this patch?

it just got lost in my inbox :(

Patchwork is tracking patches now, but the commit-bot is not fully =
functional yet. Hopefully soon we have this all automated.

Regards

Marcel

