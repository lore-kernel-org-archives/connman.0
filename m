Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73B72
	for <connman@lists.linux.dev>; Thu, 18 Nov 2021 21:05:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 066C360F75;
	Thu, 18 Nov 2021 22:05:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1637269515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NTBxjAItzixiCxcUiRc13nVxhuaTlvlYL7OoQ0V4uvo=;
	b=XKEKwvz6eOVrMiOq94ru2l6UHRqlI5/kL0ZFMu77TnNBHg+Z8VtMh4hIh2QISSBqMOaKB9
	rgjqO81n7i+wphV4nsWmJ/Yb3efy6q0/lQcIZFVb/xKsqoxbdGPhICJCAWhYpOSozwLJ+P
	Cfg6557LGSqLE8JKErj7LDK04qkceYuvILB5TUWIxHzgm0yg8Honufb3ChJfoLnMW8PT4s
	78gKzGN+bo2HQy61l9dHJyuGriIUxzAOxXLUFW1Vnr6g5hy4QajttOpExcfc2JPvAEbiKV
	cbv7KZBjKWFon6wubOp2wHycNmfPXHhx5r16FeJ+esOy7eY+r6sJc4WpM1K8PQ==
Date: Thu, 18 Nov 2021 22:05:14 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] service: Support hot-plug of technologies by updating
 ipconfig index
Message-ID: <20211118210514.bvd4i7erdjn53erq@beryllium.lan>
References: <20211116153435.17073-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116153435.17073-1-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Tue, Nov 16, 2021 at 05:34:35PM +0200, Jussi Laakkonen wrote:
> It is important to update the index of the ipconfig belonging to the
> service that is to be created from network after re-inserting a
> technology that supports hot-plug (e.g., an USB ethernet adapter). The
> service does exist in such case but the interface index is not updated
> which results in DHCP failing to start. This is because the old index
> would be used.
> 
> With this change index update is always done regardless of the existing
> path for the service.

Patch applied.

Thanks,
Daniel
