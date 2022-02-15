Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE741376
	for <connman@lists.linux.dev>; Tue, 15 Feb 2022 09:26:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BF185CE2D;
	Tue, 15 Feb 2022 10:26:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644917160; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kg/bMVlYyRj1NclySpd5r48Q/i6IG1EYvHcPh1y7nV0=;
	b=iJb7q3ni8/GH4/1iZptQo4dhN7o+qL50RHhCZNdxPb8UiW2MXixHQZ6kLFB5OiOoj5iGcF
	Tj6CLBJD0fpNDDiZwv8nQ9JjD2i6Uekia0DAjkFXAkReTspJT5sP6SdpsbSstwuFKB6GDV
	Nh7SVegV3dmX8JMFvTC7fPUP7yugfElSTW54gclK4Q71r2e9w3EX59v5/58o1ZkniwUaGo
	0JiRIe29IZ3tSW6+kwdwj6qxmyiPMxpy8P6RtIwF0lL99vcDWIwK3suNMjrB3Uk7VaunKf
	RXAClu71XEUZyUZZirZFu1+Ko1rcLd6nazeQ5M6+hW6+XRvWD1b4yK+50NZ1TQ==
Date: Tue, 15 Feb 2022 10:25:59 +0100
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: connman issues with enlightenment since last upgrade to version
 1.41
Message-ID: <20220215092559.hyguybu6tyhvmtxx@carbon.lan>
References: <CA+iibzDUEYihPT=odxjLrggdHTNBeDqh4KAYbCCMX+Tn5BkPKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+iibzDUEYihPT=odxjLrggdHTNBeDqh4KAYbCCMX+Tn5BkPKw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Mon, Feb 14, 2022 at 08:47:51PM +0100, daniel antoine wrote:
> I send you two logs one when the wifi interface is ready
> (cm-log_bad.txt) and one when the interface is online
> (cm-log_good.txt)

You mentioned in the other mail that you remove the main.conf file for
the bad case. Is there anything else in main.conf?

Daniel
