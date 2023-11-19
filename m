Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3F8101FC
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 7D678CECCF;
	Sun, 19 Nov 2023 15:08:39 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: libppp-compat.h missing in tar file
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b0e1c8ab-4157-4153-bc7c-529a54fbcd65@monom.org>
Date: Sun, 19 Nov 2023 15:08:29 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A339003-F2B6-4BA5-A80D-2211979BEB64@holtmann.org>
References: <b0e1c8ab-4157-4153-bc7c-529a54fbcd65@monom.org>
To: Daniel Wagner <wagi@monom.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Daniel,

> I noticed that the scripts/libppp-compath.h header file is missing in
> the tar file. The file is added to EXTRA_DIST variable but this seems
> not to be right. Where should it be listed?

in general EXTRA_DIST is correct. Why a C header is in scripts/ however =
is total different question. Can you give some more details here. I =
didn=E2=80=99t even realize we included a PPP header since pppd was =
something we never preferred and even oFono brings in its own PPP =
implementation.

Regards

Marcel

