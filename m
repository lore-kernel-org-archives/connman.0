Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F12FAD
	for <connman@lists.linux.dev>; Thu, 19 Aug 2021 12:30:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E4D860F5F;
	Thu, 19 Aug 2021 14:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1629376205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NE+OdANGxbzZFUoFopcWiS72x4fWSq7fYRmoMMu3G8c=;
	b=Z13zurGi5yeOgVygj9a+aFZTAS8lvfqcDkofcFXp0OG8HDGD7YWWJQvn5cQVRpVTGb3uLV
	k9ouZqG+J+qxiD2RhgkXHI6cKTFFG3assQwXyPwNgKIqfnlEDeOUU08Y1vZ0G4Fw/dYXoZ
	K3KHWAOldjKIG7l+8gow0hPUAsrio3q4uExY+NCNAJMqRegoWR5rXy3YmspNN41Q8xP+5/
	B2FEv1H0BCA3LLHhX7hskScZi6x6zgkvCQqqqgbaueibUxWHD+TrXHxjO7pRozfYzT91Rz
	ykWuCZDf4xE4+ZWRRnD9T2Q8l4LexuK5/vglSJzjDxUziTdEH0UiPR5DrYanVg==
Date: Thu, 19 Aug 2021 14:30:03 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
Message-ID: <20210819123003.r4sqio2pquco5qph@carbon.lan>
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
 <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Thu, Aug 19, 2021 at 03:11:21PM +0300, Jussi Laakkonen wrote:
> Sorry, I spotted some error with this as apparently our fork has something
> again done differently somewhere. I'll send another version when I find the
> cause. Does not seem to function correctly on top of 1.40.

No worries.

BTW, the question on the busy loop. I am pretty sure there is no timeout
involved if you just return 'continue'. This tells the caller to queue
up the callback again without any delay. At least this is how I remember
it.

Daniel

