Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F82C872
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id D3773CECEB;
	Tue,  7 Nov 2023 16:35:09 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Leverage 'connman_service_get_identifier' in DBG
 calls.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <FCD706D1-6338-4ABF-9D72-A167C034F7C9@nuovations.com>
Date: Tue, 7 Nov 2023 16:34:59 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <9721AB5C-08C2-4F0B-83ED-A0DF47FF1598@holtmann.org>
References: <524C84BA-DC40-4292-A8DE-BA45E9E18DA6@nuovations.com>
 <FCD706D1-6338-4ABF-9D72-A167C034F7C9@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This leverages 'connman_service_get_identifier' in DBG calls rather
> than re-creating the same logic from 'connman_service_get_identifier'
> in those same calls.
> ---
> src/service.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

