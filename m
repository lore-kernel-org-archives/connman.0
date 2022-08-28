Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6A4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:29:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76B935E062;
	Sun, 28 Aug 2022 20:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661711349; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=88W3s15NNWsU8j6hKQ+qvQ9EwZ/19+gCaAwZcB+2uOE=;
	b=RMUf7TIeYtjIsMZD0GjyLYGvtQDH/vMT1D5xhsZ0O+K4xC6g8BP75RyxsztQJsW0tBkFT+
	wMcM0Ois0e2BzaSJz2zGLrZLsBOsOFhOHYKA1Nj/ibQ/7gU5jTUMHsadjs7xSOh4XHQf5O
	K2hXfX2z/IalEohSR4y7tmoA5w2fOeXYN0x3DALz4HXzCgep9RUr80cBs+7XjMv0ra8QVq
	9c0mee0+Vo/ZKrUhHwr75/tKIoxxsnxH13CsAQU3Y3eVdzMaGwVpm9zG8rI68VCSueTSRR
	rw9W8BZj7Y6T2DMiKEY6aLFYTGdyv+Ql7XBDw785GIzQzszh2EGczsxioW4czA==
Date: Sun, 28 Aug 2022 20:29:08 +0200
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Link always ready and don't pass online
Message-ID: <20220828182908.kiv4ilf7uxoxrmcb@beryllium.lan>
References: <CA+iibzBCG+F5P4q4T4wTwONcCzR5doDpzz=t-SgvFR0eqzKeKw@mail.gmail.com>
 <CA+iibzBU-cYMgLHD98nB-jBhnH-gG0V6n8Z1SkSkmJFrudCHBA@mail.gmail.com>
 <20220828140926.etfebtezdel5nvu4@beryllium.lan>
 <CA+iibzBE3sgRcZF+U-kPZV96ocFyRFy9g=XE=d9q=rc4DfH+Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+iibzBE3sgRcZF+U-kPZV96ocFyRFy9g=XE=d9q=rc4DfH+Rw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 06:35:52PM +0200, daniel antoine wrote:
> I have tried the patch but without success . I hope that I have
> written the contents of the patch well in the patch file. I send you
> the log and the patch file I used.

Can you also try [1]. And if it still not working please add the output
from

 ip r
 ip a

thanks


[1] https://lore.kernel.org/connman/20220828181052.27467-1-wagi@monom.org/
