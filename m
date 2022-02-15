Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D11376
	for <connman@lists.linux.dev>; Tue, 15 Feb 2022 09:27:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 209305D381;
	Tue, 15 Feb 2022 10:27:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644917271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kzGEdajjA46MAl1KzaablKFSA+VIh328sASrzrDfnHc=;
	b=jOpFwjuc/rcqnwVt7QvYV2RyLpV37eszMKb/u37SxD3RPa0m9fJReTq+tNONIT1zdncgrT
	cLAYEMGaOMq+NV9jF5BgxBWv84K/eK85SbHcsMWUE5YPlWPbMw3uodjL87kMBCwqOqaB4j
	mB3sdjY3wETnz41SRttzM4lAHvVuiYUR5mtosIvBoiaS7AnyG9+sVSrrzE/BKdk+DoXIZZ
	eU/rMGc7AaRS8aksC5fDNuRaO9fQ3f9iTQZU/2N8yqrdnt/ZD8lt5VAzgxH7fjzxBMTtjc
	3fNUvRWHT3KCoEDP6HwsYER16HuREkbYdxuy/ztzp3UY5cN3z6R/rUxCoNGkUQ==
Date: Tue, 15 Feb 2022 10:27:50 +0100
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: connman issues with enlightenment since last upgrade to version
 1.41
Message-ID: <20220215092750.npu4prptazpxygna@carbon.lan>
References: <CA+iibzDUEYihPT=odxjLrggdHTNBeDqh4KAYbCCMX+Tn5BkPKw@mail.gmail.com>
 <20220215092559.hyguybu6tyhvmtxx@carbon.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215092559.hyguybu6tyhvmtxx@carbon.lan>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Feb 15, 2022 at 10:26:00AM +0100, Daniel Wagner wrote:
> You mentioned in the other mail that you remove the main.conf file for
> the bad case. Is there anything else in main.conf?

BTW, this is missing in the bad case:

connman_proxy_lookup() interface wlan0 url http://ipv4.connman.net/online/status.html

I have an idea what could be wrong.
