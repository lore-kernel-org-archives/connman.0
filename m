Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B272
	for <connman@lists.linux.dev>; Mon, 20 Sep 2021 07:13:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D43A75F1AB;
	Mon, 20 Sep 2021 09:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1632121974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Qb9RPFimI87I9oUZRrEW8Z+eRG1MXJM2C5r3ZqaLlNI=;
	b=RgEdy7wztKPgxxsHmeq3E+UMjeTu9DoWnHG6L0LR+VIh/ZZl8xeaGd+HlQvS8itckqvfJf
	u8Ha9QUpq/SQZqec5R5+ahH/r7ff/kwWBXIBpu1dmEaOCe5M69rYvT/OJ5V5p/PdgWjETL
	WywAusW0XiDrzHhfoOQDGiezICNWmpvdZL9XU/dzEyKGK41q1w5yOtCyvUh0tW9SPvuK7Y
	oPHmaSzPyGLDJr1oZ1IgYBBLNv1q9nZk5275JJt0nP4gjSq/nVEolkUsFKU9vlXWIckoWh
	VHFMljJlmjJ5hn2mTY/nlfPhxPVBOuq51YntuuwTrbQDurKm04WlPKdyyTCu4Q==
Date: Mon, 20 Sep 2021 09:12:51 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jupiter <jupiter.hce@gmail.com>
Cc: connman <connman@lists.linux.dev>
Subject: Re: Connman stability degraded upgrading new versions
Message-ID: <20210920071251.qwix47owh7ybajdc@beryllium.lan>
References: <CAA=hcWQTDvN-vh+UgXx8jpV--NPBrXWWsd1O6Sg=FVufPapDWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWQTDvN-vh+UgXx8jpV--NPBrXWWsd1O6Sg=FVufPapDWw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jupiter

On Tue, Sep 14, 2021 at 04:58:15PM +1000, Jupiter wrote:
> When I used connman v1.35, it was very stable, it could switch to 4G
> LTE automatically and reliably when the WiFi was not available.
> 
> After upgrading to version 1.37, that network automatic switch is
> gone, I have to restart connman to make it work.

Right, did anything else change in your setup? 1.37 is pretty outdated,
it was released early in 2019.

> After trying to upgrade to version 1.39 in the Hardknott branch, I
> cannot not even get WiFi and 4G LTE work, the WiFi network was
> assigned with a fake IP address 10.x.x.x, it could not get the 4G LTE
> interface.

An 10.x.x.x is not something ConnMan would do. It only auto assigns link
local addresses if the DHCP does not work. This IP seems to be handed
out by a DHCP server.

> I have to abandon the upgrading. I was told that connman
> 1.39 did not work well with Hardknott libraries, I have no idea who is
> managing the connman release on OE Yocto build.

I don't know either. This is the first time I hear of it.

> What has been changed in connman new versions?

Between 1.35 and 1.37 there a lot of changes. I really urge you to
update the latest version of ConnMan. I don't have time to debug older
versions of ConnMan.

> I must miss something,
> I was told that connman uses WPA supplicant for WiFi, I have used WPA
> supplicant v2.6 for the connman v1.37, could it be WPA_supplicant
> problem, or Yocto build problem or connman problem?

wpa_supplicant might be a problem but as we had a lot of changes between
the two version I really don't know.

> My apology, I don't have good debug skills to debug it, but if you
> could instruct me debug technique I'll provide more testing and debug
> information.

I see two option what you could try to do:

- Try to bissect the offending commit. This is pretty simple to do but
  takes awhile.

- The first step is to enable the logs and try to match this with the
  source code. This is hard and takes a long time.

Hope this helps,
Daniel
