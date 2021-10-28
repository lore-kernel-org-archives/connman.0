Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547442C82
	for <connman@lists.linux.dev>; Thu, 28 Oct 2021 06:31:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 064615E361;
	Thu, 28 Oct 2021 08:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1635402691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KNKUhFExAriPphYLjraHuJIxJgafcGKb65sind7chRU=;
	b=aAcQKEAkhqPaMKYP9HTsxg+9oLg/3KV4vfsE432/GjwOzpMULnX7e1rjCqZkpe61wuBkzS
	Z7xdOPl+5YNK8ke1gldBGmFLmKyzVoCHWWepjQKuiz4jOUJVo4RSrYAlDupUn3iuoBWpF1
	kOeyEf992oGUvHU6nYo9AgQkE+H4SOj+O7TrVaouyN6EcOS9lH5/CERDbndGm4IlHjqYKz
	nZINdpDCo2mwD/zTXOQBm3W8QTqgCwbaA1lwgMHhhXRMOPKd4Gi/o+ZqocD1sGW2l6Odbw
	1Fwiv1khPDXInR0UOjxxHqspyxaUU17fsRMnB3lLj7QUPsFr3ldO3Ly81igyeA==
Date: Thu, 28 Oct 2021 08:31:30 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev, Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Subject: Re: [PATCH V2] Add GetKnownServices api to connaman
Message-ID: <20211028063130.wwz44zuqjuoatksx@beryllium.lan>
References: <20211027140141.9267-1-michael@amarulasolutions.com>
 <CAOf5uwmcmkUNO0P3mZOC94bWRpodqLeJ4kmBTSu2N0j9xw_WQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwmcmkUNO0P3mZOC94bWRpodqLeJ4kmBTSu2N0j9xw_WQQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Wed, Oct 27, 2021 at 05:25:32PM +0000, Michael Nazzareno Trimarchi wrote:
> Hi Daniel
> 
> I even have the patch to remove known-networks. I have few question:
> 
> - what should be the behavior for an ethernet on?

I might not understand you question correctly, I assumed we don't
differentiate between types. Return the complete list and let the user
decide what to do with it.

> - for wifi, it's removed and if you are connected it's disconnected is
> that correct?

I haven't tested this but I would assume nothing will happen. These
files are all considered under control of ConnMan. So if you remove
those while ConnMan is running, it wont notice it. Hmm, to get this
working correctly we might need to add a RemoveKnownNetwork call. I want
to avoid to have ConnMan monitoring the storage directory (it's fragile
stuff and difficult to get right).

If we go down the road with RemoveKnownNetwork, then I suggest the
GetKnownNetwork call returns the object path, not the storage path.

Sorry for this late enlightenment from my side. I didn't realize all the
impacts when we started the discussion.

> Apart of that:
> 
> I'm working on a patch that allow to store network configuration using
> the config storage
> but I have few questions:
> 
> - I have added autoconnect as a configuration option. I would like to
> store networks but not have them
> in auto connect mode. This should allow me to connect when they are
> visible. (ethernet??)

I can't remember all the details around AutoConnect. It's a difficult
feature as it set on the first successful connect attempt. If
configuration files are involved there are other rules.

> - I have add an option to store if I want it immutable or not. The
> stored configuration should be applied

Immutable is derived from the fact if there is a config file, the
service immutable. It doesn't really make sense to make this
configurable.

HTH,
Daniel
