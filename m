Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE860A56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 07:14:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEEF75D9F6
	for <connman@lists.linux.dev>; Wed, 25 May 2022 09:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653462892;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=2X3+NAd/LwajeygSG7UZB6ntciBZYk6/6L0hekmL0lE=;
	b=eyxeYQ9s15gtfs7vbISDrXHapeXAZ+KXjkmLkBPprAsNSjueuA+jYcP2nTfOysP+0HEUOG
	Upyb3+8ZwHubPBUk1arCtv6bBNJF19qTsH/gRKgOIINYtO1xIki1oVQN2Re8v89+hj3kor
	FyHT6yoCrVzBcSwa3uAFzH0PXF9ixjJeLnoVNfwJtcATstKxf6+5aHOHcF+QwQuysK+9Gm
	NAN4oJT/BsSp9idItTa/WdTJr4YbHphOcGDcO9a58vuFwe4sVlWbW4craLdHLQJtEGsXek
	uSqo6rVl7eyCotx3+yoJHnGeTYWGn7+RPSVtH39plSHAxPmakgVrf5O5NBXnRg==
Date: Wed, 25 May 2022 09:14:52 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH] doc: Add note SingleConnectedTechnology can't be used
 with VPN
Message-ID: <20220525071452.zwjcovlb6xnuweb4@beryllium.lan>
References: <20220516061436.5180-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516061436.5180-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, May 16, 2022 at 08:14:36AM +0200, Daniel Wagner wrote:
> SingleConnectedTechnology can't be used with VPNs. VPNs rely on a
> transport which is from a different technology group.
> 
> Reported by Thomas Bartosik.

Patch applied
