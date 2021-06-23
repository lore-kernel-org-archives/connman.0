Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64902FB3
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 07:39:29 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 1D3F850064D
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 09:39:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id DF298500412
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 09:39:27 +0200 (CEST)
Date: Wed, 23 Jun 2021 09:39:27 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Do not try to handle out of memory fails
Message-ID: <20210623073927.ip5umr7uxhv7gaku@beryllium.lan>
References: <20210623072254.30338-1-wagi@monom.org>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623072254.30338-1-wagi@monom.org>

On Wed, Jun 23, 2021 at 09:22:54AM +0200, Daniel Wagner wrote:
> There is little point in trying to handle out of memory
> situation. Most GLib function do fail with calling abort() when memory
> allocation fails, e.g. g_strdup(). So fail hard when allocation the
> iwd data structures.

Patch applied
