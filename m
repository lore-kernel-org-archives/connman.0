Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51E33D5
	for <connman@lists.linux.dev>; Fri, 11 Mar 2022 13:15:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D92825D3D4;
	Fri, 11 Mar 2022 14:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1647004546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TihWeGsdF6ByTJvoz2PbPzamHYnshrD4y2EltcSrgPY=;
	b=TuweW/VkY9HlSBxs0+G2SeVnhPRTqt1L6orIB3aZD9BAYEMGj/pFuEMIrsQJ1uup0VF/os
	MsDRKEVNFDzcvQg5Xq/Q0a3fzlbEqdonXBYySyL4u8OzGvRYlPdfmnvEBEEU7kdpQIgZHe
	jkZrq9Kt9iyS+dgVv5NxgXgxtm+MMO8fXTlnayOrPFH+dHOZxtR/UIDjzNSMJLofIUt6xq
	vBvf2Lhn4amS/A8QwlHJpDE96nWwfvGiFQl9OV4eWoohGtsmPZrpI7b2V8ROqF2J6JsOap
	gs81IL44bIs33YioBhQ5gGblrOjFIw9GwD33EsErNVMFGSAh/+lmNhaMg71jpQ==
Date: Fri, 11 Mar 2022 14:15:44 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Add scan support in access point mode
Message-ID: <20220311131544.ezj2neqjxqktqp2a@carbon.lan>
References: <20220307090321.27204-1-wagi@monom.org>
 <CAG17S_MqNzp1n8qHmWkLS918uSUYdEqWS-CHrHMg6uC0Xr-auw@mail.gmail.com>
 <20220309074838.jbshxixcues4bqxx@carbon.lan>
 <CAG17S_NonoANXzrvAcgUpPbUKx4qXwFb2m3Dx2T3=_8_V1En_A@mail.gmail.com>
 <20220309124408.clmtdktitls52wcp@carbon.lan>
 <CAG17S_MyFW=BCBiVxj-oX85R8tGWgRPNq5_JhMa=1vpx_j9BBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_MyFW=BCBiVxj-oX85R8tGWgRPNq5_JhMa=1vpx_j9BBg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Mar 09, 2022 at 09:39:39AM -0600, KeithG wrote:
> # connmanctl scan wifi
> Error /net/connman/technology/wifi: Did not receive a reply. Possible
> causes include: the remote application did not send a reply, the
> message bus security policy blocked the reply, the reply timeout
> expired, or the network connection was broken.

That might happen because no scan was started. I followed the error
message in your last email and saw that we have a bug in the iwd device
creation code path. The core already creates a device for use
(connman_device_create_from_index()) and we should use this device which
is handing in via the probe function.

Also there is a dangerous index lookup via the device name. Needs to be
fixed as well.

> # connmanctl services
> *AO Wired                ethernet_b827eb079985_cable
> # connmanctl technologies
> /net/connman/technology/ethernet
>   Name = Wired
>   Type = ethernet
>   Powered = True
>   Connected = True
>   Tethering = False
>   TetheringFreq = 2412
> /net/connman/technology/wifi
>   Name = WiFi
>   Type = wifi
>   Powered = True
>   Connected = False
>   Tethering = False

Here it should be Tethering. How did you set the wifi device into the AP
mode? Via iwctl? In this case reset everything and let ConnMan do
that.
