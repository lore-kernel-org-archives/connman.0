Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667C2C81
	for <connman@lists.linux.dev>; Thu,  7 Oct 2021 15:04:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A36E660E52;
	Thu,  7 Oct 2021 17:04:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633619050; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MUjbUL5O7ZEYIpnUfwfjH7yZwcKjJYQAX4MRCJ+qRhk=;
	b=JLBlsty234S9c68jS4eNRxfOxfDKUyBXTGmfYxGAACR1wgcRHfIN34qSuv38tezoOJT72g
	xSwdwqk5HbmrhHN2KbfDqHnKnVaYpFLDp+pxRa/urgxbKhXnEb6gbM0xFiH+ztERjI3bTK
	IUHGQmZtT7uL3PHi2kwPomjGe8+W+E3Ufg/zFhGAscgoXreK2HHQGhw6/g04oaIEUdWpJz
	TbDIfySQrvc4wRFSEYlcD+S5EQaJhm77K3oidNRAD0s0OG4iDsk53e0ceO451X+3EXdNaH
	LmZrplQHWpLalDzzdWzqyap6hD7NYkSBixSNqX8g9yp+6Oga4Nw5O6MZcvnwVw==
Date: Thu, 7 Oct 2021 17:04:08 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [RFC PATCH] tether: Add a way to define a tethering frequency
Message-ID: <20211007150408.rnfvzb56o6vthk7w@carbon.fritz.box>
References: <20211004210016.1579481-1-michael@amarulasolutions.com>
 <20211006124043.l7nlcqciqk5wc6ef@carbon.fritz.box>
 <CAOf5uwkPSxGygWi1EM+7BbqVJ_t_fK00exdcAyHO5nAFCOYJwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwkPSxGygWi1EM+7BbqVJ_t_fK00exdcAyHO5nAFCOYJwA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Wed, Oct 06, 2021 at 11:55:17PM +0200, Michael Nazzareno Trimarchi wrote:
> The best thing here is to add libnl in connman. This allows us to read
> some wifi properties, like

As far I remember the main problem is the way libnl is that it uses
blocking calls. So far we did avoid to adding the libnl & co libraries
for this.. I rather would add ELL (from the iwd project).

Daniel
