Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A215A7
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 18:51:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF0055D7D8;
	Thu, 14 Apr 2022 20:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649962300; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HjFfh4G7PcX0E5di5kDuEUpb/g8gtd77wYoNx8Ogal4=;
	b=iDiaf3xZ37AQ6gFLVbnc2Ip6MOjSNCtY5THrz36zbj6pFeoIwx+piBRlaJPcoauM+MOxPT
	vPQ7gmy8RyPXZ88oQ8WOhUZmKsySkeGLOI6v84PHrZpm+W308ZWjjklkTVTz4VQqJlrobj
	UKUKIaQpWqYuerzsUxz7F8ZOWb6PNe1Yk91xCYZ1aKKTF1x2fIx+4ioD7i3QrVnZdnDtNs
	rbawRa20ePX5NJLqQy9pDFhQb9JyC2axV6gekFnWy10lAANRm1cSHfSrBkuG02gs9nnLfr
	NorXETMENYFu8fhRvlB6Usy0agg2eNCNcVYH8AqjsJ2Nw0uASZf+1GZsE0vWsg==
Date: Thu, 14 Apr 2022 20:51:39 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ryan Smith <ryan.smith@density.io>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v1] dnsproxy: fix debug logging
Message-ID: <20220414185139.eq5w2jirf4e7fy35@beryllium.lan>
References: <20220411165821.501633-1-ryan.smith@density.io>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411165821.501633-1-ryan.smith@density.io>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ryan,

On Mon, Apr 11, 2022 at 10:58:21AM -0600, Ryan Smith wrote:
> This fixes the debug logging by compilation unit just as it
> is done with all of the other files in src/.

This is on purpose: 3977a250624c ("dnsproxy: Disable noisy DBGs")

It really spams the logs and these are in my opinion left overs from
the development phase. If you want logs please figure out which of those
are actually making sense and just enable those.

Thanks,
Daniel
