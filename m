Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129A570
	for <connman@lists.linux.dev>; Thu,  5 Aug 2021 06:03:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A58C260D9D;
	Thu,  5 Aug 2021 08:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1628143405; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=e8vNenvuZtIIr+9sDoZDlIEBpHOdE+ZRYn79XezEk/w=;
	b=arDhvjzf8xAWeX8E9eeIZn4XEF0span7zXBoKEMO41hkWYF6fl/ITIv0tPbQDZKyjTMpbQ
	JZKaxg4n3VjOK4VnYlHnaAa3YsJR3fEQW3zoJd15HzZ06T4k8i3CJb9ewMjCCf7tSzY7qW
	DIkLLjcM+G3iYcHO+w+9cvXoE5LiWBCqjuua7+apsVqqgV+Ij+I+2WE4D5znaywXflJ/WS
	6DHwHhnhNOD/WxcJEg+IUWRe70ZM2aLXnbS7Md31EQd1B1gxUM0GhetX5eFh2i7mCUe3y+
	oGoDfEnMXi5QsWOMBzxtDWnbFgO54xYofd1NdGlVeqa8iSD2+LrJvl7EzolsXQ==
Date: Thu, 5 Aug 2021 08:03:21 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com
Subject: Re: [connman v1] wifi: Set ieee80211w as required for
 WPA3-Personal-only mode
Message-ID: <20210805060321.sb63yfi42qzcuydf@beryllium.lan>
References: <20210802151006.28183-1-ariel.dalessandro@collabora.com>
 <20210803074104.dawii3v3bknovg2e@beryllium.lan>
 <39fccc8f-4f53-ccff-97ba-194258f07923@collabora.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39fccc8f-4f53-ccff-97ba-194258f07923@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ariel,

On Wed, Aug 04, 2021 at 06:17:20PM -0300, Ariel D'Alessandro wrote:
> > Should we check the keymgmt is SAE and only then set the ieee80211w
> > value?
> 
> Thanks for asking that, two answers:
> 
> * `ssid->ieee80211w` only gets sent if key management is SAE, so that'd
> be redundant. See this code block [0]. So, there's no real need to check
> the keymgmt is SAE here, and `required` could be the default value.

Ah yes, that filters out the ieee80211w settings if it's not SAE. Didn't
see it :)

> * On the other hand, my concern now is about supporting SAE transition
> mode. Let's *drop* this patchset and I'll send an RFC patch implementing
> WPA3-Personal transition mode.

Okay :)

Daniel
