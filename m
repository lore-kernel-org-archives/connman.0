Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110672
	for <connman@lists.linux.dev>; Thu, 18 Nov 2021 21:08:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BC8A5E368;
	Thu, 18 Nov 2021 22:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1637269360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=B32PrmDQU9inDJQ8oVZdYV6NRFukhZUoG81cRbqEpho=;
	b=p0KiHRS8sXsrlVO8cGsrHd7pyGaT3p7O3G7Zp2ixQ3PWu6yLfADJiJpImYj57P9gKB1FZs
	blHLJvmTmanhPOYoyE1U+/Ek6FEAcia3B04NdBSF+eBTlKAZ463aJ+9MgldDwae8sOZ3fC
	v8BH6sYMkOvrDuL9orRupLENIZNDOPJuBGrsZdKCYnt4uFPVpBJooygmX5Kys+7T6hgnGZ
	e6yyPYiA4hDuaWZ+pQp4W0KSJ+z4Z6+XVrSA3RcGFNHJFDAtNAWzNSL98v9bCX6xt3qNzl
	QpWn14xprPrDApksXgOwHIL7A8mGAq4sy14IU1TLq62ofQgLuXV/PnzoywaJzw==
Date: Thu, 18 Nov 2021 22:02:39 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v1 0/2] Improve OpenVPN configuration value processing
Message-ID: <20211118210239.syttg5jfgbdmgfzm@beryllium.lan>
References: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Tue, Nov 16, 2021 at 05:14:15PM +0200, Jussi Laakkonen wrote:
> Rework how OpenVPN processes the configuration values by introducing a
> more clear way to classify different types of options. This makes it possible
> to add options that may have a value or can be used without a value thus,
> resorting to default value set for the option. Also the --auth-user-pass
> and alike options having a special value are handled in cleaner way.
> 
> Motivation for this was that the --comp-lzo option was not processed
> correctly with its value, and even though being listed as deprecated some
> OpenVPN providers use the value. Omitting this option even though it was
> required caused issues with both UDP and TCP VPNs:
>   write to TUN/TAP : Invalid argument (code=22)
> after which OpenVPN silently restarts itself.

Both patches applied after fixing up a warning:

vpn/plugins/openvpn.c:394:25: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]                              
  394 |                         const char *opt_to_null = ov_options[i].ov_opt_to_null;                                                             
      |                         ^~~~~                                                                                                               

Daniel
