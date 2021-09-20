Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564772
	for <connman@lists.linux.dev>; Mon, 20 Sep 2021 07:22:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B6E461756;
	Mon, 20 Sep 2021 09:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1632122544; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gymkvu06rE6sqd4n5A9MG79kMzA22CJaIvZbAdWc/ac=;
	b=lvxIisbNxXthRZRMmuXDKl3JTpV7+NsDuV7bSK8+i4cJd7Xo1AhNWOSFSCpqVcDECovzTs
	6EKMaxXUYwC4h/MolDEa9MqngljhQV0jOswMQ5A6Vgm0Fpu0MHxJ0yxLqjwNAZ+GwxfHYh
	qGwwo3pSFxMjFmAeHzJZ6jlbYXk30a/jmpZrRmP1Y5I5QNo03zMxmX9PUs8hM2XQHcCB8A
	h4dN/RIGCslhzFYm+OLnteTbd5lDNnW85qb2boXP+4v2aVxkNi6IBeW4kcfzsyKF+jEOp0
	VS7vlaYXjhFUuj2w6KZzhwOKSA21wq6exdx/mQEtSIJGzmj1jaYYqnRmyapEDA==
Date: Mon, 20 Sep 2021 09:22:23 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] build: Fix compiler maybe-uninitialized warnings
Message-ID: <20210920072223.l4pgmhaqsfgee6m6@beryllium.lan>
References: <MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210913072719.3qlnsqjzplntm265@beryllium.lan>
 <MRZP264MB1544BB065A7FADD9BC38F69693D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB1544BB065A7FADD9BC38F69693D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Sep 13, 2021 at 07:45:19AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > > -             provision_service_wifi(config, service, network,
> > > -                                                     ssid, ssid_len);
> > > +             provision_service_wifi(config, service, network);
> 
> > Could you split this into cleanup patch with a commit message?
> In fact, all my modifications are fixes of maybe-uninitialized warnings.

My compiler doesn't report them (gcc11). What compiler do you use and
what are the compile flags?

> In this case, ssid is not initialized.
> I thought title was explicit enough, what can I had in my comment?

Something like

"""
config: Remove unused arguments from provision_service_wifi()


gcc-10 complains with:

  ...

Remove the ssid and ssid_len argument from provision_service() as they
are not used.
"""

I know it's pretty obvious right now, but having ten commits in a row
with 'fix foo' and 'fix bar' without any explanation makes any 'git
blame' 'git log' operation really painful in two months from now. Been
there done that.

BTW, I tried to trigger the warnings and I was not able to. Now I am
trying to fix up clang compile errors...

Daniel
