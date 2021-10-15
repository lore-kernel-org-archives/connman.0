Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07242C82
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 07:18:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 043A760DC0;
	Fri, 15 Oct 2021 09:18:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634282304; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Me/qXF47b/17yZoMcy80aeJfTh+jbrTecWaSjDSORi4=;
	b=i8KWkOUleqjrfr+GTnMcHExibbNcg5FV35unPy1WM5M2ypH+GsqaW/CDilD8EhiT66ztGk
	yBnw8qNMjwoLkMvSAkKI7PL+mK7OJJ4AFan5VDWE4H5EdrdmxGL6v5Od6rMSjRGIjbuL5Q
	m1KGFuQedlGMbFHP+Mg12839SCKneaBWirtFW2nSOVD0AgZ70Wjvq9/cfVbzcwrqMSZikc
	6C+zvAiQ5nkhCACSlJVb1WZ/jwgYRM3XJiZ4/2NF1mspFH/+O1n4K7q3Pz29PTufn+AL5+
	vZvp96qxM0XgbCnABIIbTbav6GJrrRawyII/tdIOCHvTmvUFNQ1Oyhb+fonbHg==
Date: Fri, 15 Oct 2021 09:18:23 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 2/4] tethering: Add possibility to configure the access
 point frequency
Message-ID: <20211015071823.5zmkgwcvzu7bcjwl@carbon.lan>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <20211007213021.58712-2-michael@amarulasolutions.com>
 <20211015065250.nt2bprsnsrpdfeoq@beryllium.lan>
 <CAOf5uwkB6FYrpzs0djVB8EYe3-rG8C0o+JfzoV7+3B_YtU1OrA@mail.gmail.com>
 <20211015070401.of3ybrtbt2p2vm2o@beryllium.lan>
 <CAOf5uwkQWf8e4Tj-FaW4Us7iHzGa+uz=roFpp+NQyHsXMBoozA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwkQWf8e4Tj-FaW4Us7iHzGa+uz=roFpp+NQyHsXMBoozA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Oct 15, 2021 at 09:09:32AM +0200, Michael Nazzareno Trimarchi wrote:
> Can we move the tethering in iwd when the plugin is activated?

Not sure if I understand your question correctly. Do mean the changing
the parameters like the frequency when the AP mode is enabled? I've
checked what the iwd docs says and if I am not mistaken it can't be
set (at this point).

> I have done some test and we can support AP+STA using iwd.

Nice! Good to hear that we start to get some traction with iwd :)
