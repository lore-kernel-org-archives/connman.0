Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4F28EF
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:33:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A09A2DE3C9;
	Tue, 11 Apr 2023 09:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681198422; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YV8cYEAdS6DX4ccpjQ4ppICFtWzOKYWCROd+kBBzKGg=;
	b=UMwhxkd+ZMJ4ZxgZBKgq0OD7E+nGUjoZrKGermDfTIZIrdgWJpFNlP7E0aNS+G+W5ZuBe4
	YanfXT11QNOqLUjaKbB9ctglhGxxHPd5jOHZW6uUXbsDg4v6DB5JsGEqT9xWZs9ATsMZIh
	z9Z5b1wUAzWnidKtiZax8afq6JD6wz8LTiP7XqrKjko7W+cwUBi7ZQ+zBBC38+R8IdrJ4U
	lG9YJI/GMhZfxrGVo+ILd2K0e62G5on2DU319jiz/l12S+3wimyy3NO8bZexuqN6wqd8lt
	9eiA5rNTMTqua7YSHv4qFtvNP+Wh6jrVcmBIR2aeQyXK+ebN4cOLepcgwsUl5g==
Date: Tue, 11 Apr 2023 09:33:41 +0200
From: Daniel Wagner <wagi@monom.org>
To: Eivind Naess <eivnaes@yahoo.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] Support for compiling against pppd 2.5.0/master
Message-ID: <20230411073341.uptx4xr3d7dz7ebu@beryllium.lan>
References: <384208306.398673.1679778274112.ref@mail.yahoo.com>
 <384208306.398673.1679778274112@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384208306.398673.1679778274112@mail.yahoo.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Eivind,

On Sat, Mar 25, 2023 at 09:04:34PM +0000, Eivind Naess wrote:
> Attached is a patch for compiling connman-vpn to latest pppd 2.5.0 / master branch
> Enjoy- Eivind

Nice! Patch applied.

Thanks!
Daniel
