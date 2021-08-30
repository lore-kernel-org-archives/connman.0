Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EA3FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 06:44:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BAD15E30A;
	Mon, 30 Aug 2021 08:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630305845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p3qNNlXKMjafLpPxSGVrW+h44Kz7rEYsIm/UK774f8k=;
	b=MKDcu68JoNgTwBT6Arz70KcNtKmf/n06w24olki+vK7QJN1jE7iQWPxPaGr1E3cMCK1mlj
	NLf12xN/SeOoA0k0lIMlmu+i9KiHHEL/bbR7IFf6tW+v7lyW2W2mnvdXogz3gMNCpZSG4Z
	kQu1XXk5w1J5HZ1nZ3wLpDvfBLSX/5jhAhsFFsoGB04KuMPiZvpm5j0Bey6EJq+kSdBFmo
	psxlr7b8sG8rTOknuilYANk/h+6Kzz9Jq0uB5UgW/bZsn4iZycGCrPap/ob8tTkS6JgtAT
	tkCzA3DWgBX+qW3AOhOD17bbulR8al9o+7Rc6TSbwy2LMPP5pQAbAntq0r23nQ==
Date: Mon, 30 Aug 2021 08:44:03 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
Cc: connman <connman@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] service: Do not trigger wispr start when
 EnableOnlineCheck is disabled
Message-ID: <20210830064403.5r3szonne7baipa2@carbon.lan>
References: <20210829195321.23396-1-wagi@monom.org>
 <20210829195321.23396-3-wagi@monom.org>
 <20210829200849.6ttu3udd65fk7lt3@prancingpony>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210829200849.6ttu3udd65fk7lt3@prancingpony>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 29, 2021 at 10:08:49PM +0200, Страхиња Радић wrote:
> On 21/08/29 09:53, Daniel Wagner wrote:
> > Do not try to use wispr when the user has disabled the online check.
> 
> The patch you proposed seems fine to me. The gist is to let the user control if
> the online check happens or not.

Could you give them a quick test if they work for you? Thanks!
