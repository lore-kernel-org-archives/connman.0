Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AB20EB
	for <connman@lists.linux.dev>; Wed,  7 Sep 2022 18:57:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35F535E080
	for <connman@lists.linux.dev>; Wed,  7 Sep 2022 20:57:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1662577037;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=+mwst0WdeEXGIwbmO11Tm2PbUmG7HZis0J94EBQfK7A=;
	b=nyWCUE0inANUQVq/YlPIyw17Llp9Npa89vZznbWQ4PAhTQLpSuGqGfYaY0X+m0Tof0KOku
	WwHvlBWtheozRgFw2D5KEPdOrFcTih16naYZVcvnOo5hHVZiAaPff0J+GY9R1nZ5SEkmIN
	Ef+ijelwBkeKme+U0NHEwHjt/tBxEsAlTZzQP8PLQiRSYdFGz4/AUCfvnTukAPx2LaButL
	O0khBxpdTzQiqpu+Z925L1qxKtHEWiRZWX/7V92k47lzPR+E+jjNbYjXR5jbu9R1xVFXqV
	zaIDy7s0ooYmat678gMMEHnO5AJbLDhoyILNyMVC/KZ6RoKGUzdzD3p0OJ9XZQ==
Date: Wed, 7 Sep 2022 20:57:16 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH v2 0/3] Fixes wispr refcount and cleanups
Message-ID: <20220907185716.r62trrmha3knnrj2@beryllium.lan>
References: <20220907185221.2981-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907185221.2981-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Sep 07, 2022 at 08:52:18PM +0200, Daniel Wagner wrote:
> Fixes and cleanups from the introduction of the wispr refcounting.
> 
> Daniel Wagner (3):
>   service: Track online check for IPv4 and IPv6 separately
>   wispr: Fix context refcounting in wispr_portal_request_portal()
>   wispr: Simplify the IP version check

Patches applied.
