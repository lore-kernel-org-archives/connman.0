Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0627A
	for <connman@lists.linux.dev>; Mon, 16 May 2022 06:50:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3BA75CDE8;
	Mon, 16 May 2022 08:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1652683835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3UYZ+RiytpkdDitspbeidxAiEIrrNCGr+GsdOkz4WAU=;
	b=lGQbtODo5Pwz4PLOxc3Bnr4RYCyNoVgxKUxzjpa+Z3U2JR8eol5LdbvBJFkKNtFnPgl3K3
	+cnN13Nj6vqdsYQT/n7wlz85fElVACuhfPRHtucJmKu57EWZhd+9A2LkLCTcoHO4J4Cg3h
	17I3uQHSvo92bwbN2zyu6ayaiALExjsN+84v9K7A+c8+M3BFFZaqV2xlCH19XYIP+qnMtK
	R/y538dRIi/MEroC/X7EGOFO6Bl6HPaSdNpexhQxaRZfsz9KyQIm0F1J0Q+b9ZDKXEdrcj
	bQ36KvioAfvJxRmRuOe1TXwS+oVSjwvbY6n50FskupOEseJpItjfcXZ6Cim+IQ==
Date: Mon, 16 May 2022 08:50:34 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ryan Smith <ryan.smith@density.io>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v2] clock: fix time update transition auto->manual
Message-ID: <20220516065034.uah235dzq7hbstkf@beryllium.lan>
References: <20220418193440.524442-1-ryan.smith@density.io>
 <20220418194038.525068-1-ryan.smith@density.io>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418194038.525068-1-ryan.smith@density.io>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ryan,

On Mon, Apr 18, 2022 at 01:40:38PM -0600, Ryan Smith wrote:
> When the TimeUpdates property is changed via D-Bus from auto to manual,
> the change is written out to the settings state file. However, it does
> no modify the current service. This causes the service to continue to
> synchronize time even after TimeUpdates being set to manual. This patch
> updates the service whenever any change is made to the TimeUpdates setting.

Seems reasonable to do. Patch applied.

Thanks,
Daniel
