Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B33A56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 06:51:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EE9B5D995;
	Wed, 25 May 2022 08:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653461504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eCiT5tM4Gq2aB/3oPYIOlXdBnM2dx3EgNfiyXZybxWg=;
	b=IS0jkIXz3U7g4oAo2BDG+tepoZFiYn9zsz8m7uG9eDbtXf4SFzltEl0GrmD9HIHmVmo2uI
	nzIcfHkhzRirOlFRnLS6YBnNRle/PjJPWWV3nqsoLQu7WpyAyHrq33saqhthhbxGSzh2y9
	6QyZd1E7ERizPEF3JYW5XT2WZW6mVqwxMooFeOeFuTxwgrZ7KSxWvJSMFDQq0r7BlI9Vwe
	n4e6fbB8SppxfgkMviGegyneX3DzUcxGtB3HL/gbFiXL4W03+VulllCK8A7rv1HaDWEx8k
	hP9aQ0UUQzXwIZD509Q7QwD77L35yLso1qe8QlAB7gwd45maHI7zPgdTEKUgvQ==
Date: Wed, 25 May 2022 08:51:43 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 05/12] dnsproxy: further refactoring of cache_update()
Message-ID: <20220525065143.jqidgxcuvg2pb574@beryllium.lan>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
 <20220419103501.30553-6-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419103501.30553-6-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Generally a few words what the aim of the refactoring wouldn't hurt (also in
the previous patches).

