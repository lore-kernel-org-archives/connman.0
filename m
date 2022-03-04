Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD59A33
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 08:58:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 245B35D458;
	Fri,  4 Mar 2022 09:58:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646384331; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9IJGqRN3iYFEWKzm/nQa+CRJjpfOh0M6waqei1I5GAE=;
	b=XwahCVIYyDKHUIRw+4K4mYQv/7SZ79bjWBZJUhcO/vQaKV5IqZ/TueTfY+L0uE0sXM7gvO
	f3ClkADdB3LJ/buRk0441c64OgSSd0AO0MGbnUzNUG6ISgu+ZBqg0igzlaWGDQiw7RjjRx
	p9JZvIy72dzwzzgP9B4MkMXnOzpaeKkc3edRZ7K+8LFJDRxy40uOVCzAGZsAtIX0zSQ7+t
	lRP4UAX0MC0oeTXVtsyzA7UDNlIkOdYJ4nGa24HbNMmfwvJP1PLxB2bIFoMNYHdFAnRivH
	82uCtAW+2Kwr1SWiVI5sW1g9i6r5AX6RHQMRiHkchY9u60Fm78J86ZL8pXrcKQ==
Date: Fri, 4 Mar 2022 09:58:50 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Forget network on service removal
Message-ID: <20220304085850.sio5brshuyvbh4gz@beryllium.lan>
References: <20220228145743.2110055-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15447BECF20D7463FD6EA9C693019@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB15447BECF20D7463FD6EA9C693019@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Feb 28, 2022 at 03:03:40PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> When a service is manually removed, the associated network, at driver
> side, needs to be forgotten, to remove the corresponding known network.

Nice one! Patch applied.

Thanks,
Daniel
