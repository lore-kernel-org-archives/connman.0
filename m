Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16970
	for <connman@lists.linux.dev>; Thu,  5 Aug 2021 06:15:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63F965E354;
	Thu,  5 Aug 2021 08:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1628144098; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AVBwOXSE1M+5hmBwp0MVfxlczCKfxu/j4K0S7salY9s=;
	b=SD/99bzfKKbZib7KfnKqaWgtNfdQALM3BLi2HnUDiwYOrVBpXNAdVHCmx5SrjmK3jK9tui
	H4yU0mI8IsLV+s6GKL43ol+CAuuilN/wzU3AUOQGQKdFXQY33y13EuJVtQ0tCOIwRpSa/O
	idGE+IuAwCjG7OLwuO7Ix1kxDMlEo6qhA19z23IhY/douj9JOT67ESYcItI4XFVAuXa6HA
	QAlqE1GW6UC0kTzCQNcESisqdaQt1YdDaIDWpKHMZbok+t3itfgvBGsAc5UZ2Z0615qBmN
	EGwR3Gdv4As7Y28w+1z/cFmw7ASgCyHM7A1Cis3CJfwt5Zy9kMAstIUNmPTbIA==
Date: Thu, 5 Aug 2021 08:14:57 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
Cc: connman@lists.linux.dev, Santtu Lakkala <santtu.lakkala@jolla.com>,
	Jussi Laakkonen <jussi.laakkonen@jolla.com>
Subject: Re: [PATCH] make possible to use alternative auth group with 2nd
 password
Message-ID: <20210805061457.abhvax5ow55z4hwt@beryllium.lan>
References: <1666033.JRX4bv1jlI@latitudemachine>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1666033.JRX4bv1jlI@latitudemachine>
X-Last-TLS-Session-Version: TLSv1.3

Hi Lukas,

On Wed, Aug 04, 2021 at 06:39:39PM +0200, Lukáš Karas wrote:
> Some servers are configured with multiple authentication groups.
> OpenConnect request just authentication entries that are valid
> for specific group (process_auth_form method). So, authentication
> group have to setup first, and new form have to be requested then.
> 
> Some authentication groups may require secondary password.
> For example one-time password from Google Authenticator app.

From my quick glance it looks reasonable.

@Santtu, as you have done some serious work recently on the plugin, do
have any objections?

Daniel


