Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0FA56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 07:12:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2BAF5D9D9;
	Wed, 25 May 2022 09:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653462723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wY6oXpGafN3jndWABl/mVNKsstZKNvGlLfHGkI86KOg=;
	b=TzTrjc4THaPSxO2w69MnHaSxchBvU7CWpWYAG1Q4olP3d1tvH3hXEWauVh7mQGni0FvM0Z
	Ndfy2cXLqGUY4Wf2xparXRrRIIbFJCFOLWg2bb1TmDYfByZKaoOIJoK+b8Ie88VCYc2cmx
	K7SVFMPOx5NJ0b37a3rd2aw+ouU8MMWpFvIj/gi0Zj/m01GEnJ3/c4T0DI//L5eC89jsq4
	XKMwU5GP2/z1NNcJwsTI1r4W/0qh04Nl9Vafv1zwY8QLS5rsc+fdTfmgwGmCZPa0Hf7S0A
	Inr1aFU+/qVrEJ0LRNTG7qqQ5ZzUKPWRylzJ83Htx5wDdp+4MP+fi4Kl9yuzWw==
Date: Wed, 25 May 2022 09:12:02 +0200
From: Daniel Wagner <wagi@monom.org>
To: Thomas Bartosik <Thomas.Bartosik@goeg.at>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Issue with connman.service
Message-ID: <20220525071202.kr7kyl7z5wm47vaz@beryllium.lan>
References: <CADEpph=wc+bN3kMDCYtV5b=mjaB81-V2CW2hfzZJJJ1shXXAEg@mail.gmail.com>
 <AM5PR0901MB16332C6B48D658CA0BC03626F2C19@AM5PR0901MB1633.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0901MB16332C6B48D658CA0BC03626F2C19@AM5PR0901MB1633.eurprd09.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, May 02, 2022 at 10:05:02AM +0000, Thomas Bartosik wrote:
> If I try to connect to a service with the "human readable" name with connmanctl, I also get
> 
> Method "Connect" with signature "" on interface "net.connman.Service" doesn't exist
> 
> I need to use the ID in the second column (don't know how to call it, no column title) of the "services" command. That's something I mentioned in a recent thread, I think this could be improved.

Yep, the connmanctl tool could use a proper refresh... Anyway, if you
use the D-Bus interface all the IDs are based on the D-Bus paths and
names.

> That should be something like
> "wifi_<macaddress>_<hexencodedessid>_managed_psk".

Correct, this is how the service is identified. It's also the identifier
you need to use in the config file though prefixed with 'service_'.

> But maybe that's totally unrelated to your problem :-)
> 
> Best,
> th
> 
> On 29.04.22 21:07, Matthew Austin wrote:
> > Hi, I'm using dbus to try and connect to wifi access point. I've made a provisioning file in /var/lib/connman as suggested by the documentation. However, when I make the call to the endpoint Connect for the service that I'm trying to connect to, I just get Operation Timeout or I get that the signature doesn't exist. This happens when using my c program to do this as well as doing this through d-feet. I'm not sure but it's like it ignores the provisioning file that I have. Attached is the file that I've created as an example. Any help would be appreciated.

Maybe enable the debug log and look out of there is some 'Unable to
load...' or so. To avoid being spammed reduce the debug log scope to

connamnd -n -d src/storage.c:src/config.c

Daniel
