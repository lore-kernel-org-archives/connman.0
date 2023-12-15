Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF216404
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 75FD9CECC3;
	Fri, 15 Dec 2023 09:45:38 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/2] inet: Add and Document '__connman_inet_rtnl_recv'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231214172712.2083929-1-gerickson@nuovations.com>
Date: Fri, 15 Dec 2023 09:45:27 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A7DBC6AC-01FA-45BD-AA57-4A41D1CE2606@holtmann.org>
References: <20231214172712.2083929-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This refactors the private, file-scope interface 'inet_rtnl_recv' into
> a separate semi-public, project-scope interface
> '__connman_inet_rtnl_recv'.
> 
> Currently, 'inet_rtnl_recv' is intended to be used as a glib runloop
> helper in conjunction with '__connman_inet_rtnl_talk' for longer or
> multi-phase Routing Netlink (rtnl) interactions.
> 
> However, for short, concise open/send/recv/close Routing Netlink
> (rtnl) interactions in which there is a single request/response phase
> or the complexity of an asynchronous run loop interaction is not
> needed, there is not an appropriate 'recv' interface to peer with
> open/send/close.
> 
> With this change, the core of 'inet_rtnl_recv' is factored out into
> that missing 'recv' interface, '__connman_inet_rtnl_recv' with
> 'inet_rtnl_recv' invoking it.
> 
> Grant Erickson (2):
>  inet: Add '__connman_inet_rtnl_recv'.
>  connection: Document '__connman_inet_rtnl_recv'.
> 
> src/connman.h |  3 +-
> src/inet.c    | 87 ++++++++++++++++++++++++++++++++++++++++++---------
> 2 files changed, 75 insertions(+), 15 deletions(-)

patch has been applied.

Regards

Marcel

