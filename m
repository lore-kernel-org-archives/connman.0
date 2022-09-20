Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844806135
	for <connman@lists.linux.dev>; Tue, 20 Sep 2022 17:08:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD33D5E13E;
	Tue, 20 Sep 2022 19:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1663693713; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OS0fexBO+yobKstwYLtaPf70BN7SRs5JWlD6PIlCqXA=;
	b=AOzRocqpSBhOB+gGbaGttulrFsRpYHxFJXvWmx5oyjnJaOwxtz4xun2/4qOjI8e4zB3LYz
	EdRDZ+b6M/nQ7MgWGUv0hhvtf7NvfGiRJ50RTKQ92zDn2i7EtfFig2Hdm8VPLPjAmYSgE/
	X4nykus0mk9IpWATWK+QPN9zsAOEqbBi0xNAUrvL8/FUZg7AGPtj74eOinPqxI/rmyDKJI
	eN0CDdVtlWQ8pH7QlVdSrjnIZxkZoaSlsrh8GCh+5+YsrajPahQ9viQ4JnuJXZ+59xlBya
	uywWrEF97EF41QBPZX8gT0HNLFZ+RKqFR6l47STnAZ+JmOPJFigyLaoneH3W3Q==
Date: Tue, 20 Sep 2022 19:08:32 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, john@metanate.com
Subject: Re: [PATCH] wifi: Handle invalid-key case on WPA-SAE authentication
 failure
Message-ID: <20220920170832.aej23gkl6kpros3i@beryllium.lan>
References: <20220914184610.258763-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914184610.258763-1-ariel.dalessandro@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Sep 14, 2022 at 03:46:10PM -0300, Ariel D'Alessandro wrote:
> On WPA3-SAE authentication, wpa_supplicant goes directly from
> authenticating to disconnected state if the key was invalid.
> 
> The above is currently not handled and the `connect-failed` error is
> reported on such cases. In order to make the client agent prompt for a
> new password, we need to handle this transition and report the
> `invalid-key` error.

Patch applied.

Thanks!
Daniel
