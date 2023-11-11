Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD11863
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 781F2CECFF;
	Sat, 11 Nov 2023 11:10:14 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] iptables: Address unit test regression.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ABC03FB9-2E73-45C7-8109-0BE545B46E02@nuovations.com>
Date: Sat, 11 Nov 2023 11:10:03 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <7247B8AB-571D-4158-B483-AD9EE4D69850@holtmann.org>
References: <ABC03FB9-2E73-45C7-8109-0BE545B46E02@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This addresses a regression in iptables and unit tests introduced
> at commit 49d53688ae8f ("Address -Werror=implicit-fallthrough
> compilation errors.") when v1, rather than v2, of the patch for
> that commit was integrated.
> 
> This commit applies the correct, intended v2 content for the newly-
> introduced 'connman_iptables_entry_is_valid' function.
> ---
> src/iptables.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)

patch has been applied.

Regards

Marcel

