Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C72C87
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 12:40:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C99F2616D8;
	Wed,  6 Oct 2021 14:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633524045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cz2WBxlZ+VmlRtTU0G7cvVTGx98Wq7N+Ul/AWJ78Uuk=;
	b=sYX1LADIoTLT+7UsveqZKMRLLXlHWRFvczTut+Yvprg14OWV/CEWMsuu947nU9B1pcXpUS
	W/kM5Q0ts31MIWxhFFPedDtiz0Oqa7xUhmIGM3w7S4DqO15O6Jl2GOPQX2kjs+XgD7JtQa
	5VLGB+8bwcGqLI2excig15h9Mdd4e2+c7U4UCW/Y28wQ7YCO5li5hxilJCOR1/268C0ev3
	uy6adU425D9eQ1w3d9igDEZrFkK9W3zlGbwTbcfZPCvVy1yHy5ZL70o6zz9bApE9dkekCQ
	fWHQ065OtAU8WJTFPe+rsy42YnP3jFO3J5GhZAa9dZj9JKn/c7pVMSNbTAlWkw==
Date: Wed, 6 Oct 2021 14:40:43 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [RFC PATCH] tether: Add a way to define a tethering frequency
Message-ID: <20211006124043.l7nlcqciqk5wc6ef@carbon.fritz.box>
References: <20211004210016.1579481-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004210016.1579481-1-michael@amarulasolutions.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Mon, Oct 04, 2021 at 11:00:16PM +0200, Michael Trimarchi wrote:
> Add an optional parameter to set the frequency of access point. Need to
> be splitted in multiple patches. This is used as initial idea.

Nice, this is what I had in mind.

> TODO:
> - split

Yes please.

> - add freq constraints
> - move to unsigned int

Daniel
