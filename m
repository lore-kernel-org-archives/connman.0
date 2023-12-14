Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8972A3C473
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 11E96CECD9;
	Thu, 14 Dec 2023 12:33:13 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/3] connection: Rename 'connection.c' to 'gateway.c'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231213200001.1994492-1-gerickson@nuovations.com>
Date: Thu, 14 Dec 2023 12:33:02 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <5C79A24E-6791-4753-AE10-A3D2E0B10706@holtmann.org>
References: <20231213200001.1994492-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> While historically, "connection.c" might have been a contextually-apt
> name, today it might be better named "gateway.c" since its primary
> focus is gateway routes and gateway route management.
> 
> Reflective of that, this renames "connection.c" to "gateway.c" and
> updates public and private symbol names accordingly.
> 
> Grant Erickson (3):
>  connection: Rename 'connection.c' to 'gateway.c'.
>  gateway: Updated @file comment to reflect recent rename.
>  gateway: Rename public and private symbols after file rename.
> 
> Makefile.am                     |  2 +-
> src/connman.h                   | 14 +++----
> src/dnsproxy.c                  |  2 +-
> src/{connection.c => gateway.c} | 65 ++++++++++++++++-----------------
> src/inet.c                      |  2 +-
> src/ipconfig.c                  |  8 ++--
> src/main.c                      |  4 +-
> src/network.c                   |  2 +-
> src/provider.c                  |  4 +-
> src/service.c                   | 22 +++++------
> 10 files changed, 62 insertions(+), 63 deletions(-)
> rename src/{connection.c => gateway.c} (98%)

all 3 patches have been applied.

Regards

Marcel

