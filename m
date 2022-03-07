Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218C38E2
	for <connman@lists.linux.dev>; Mon,  7 Mar 2022 09:06:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22B295CD07;
	Mon,  7 Mar 2022 10:06:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646643974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mHUiwqAANRy71oX9XJW1uij/M4bj18+2hLy0vbC+Ch0=;
	b=z9TvMJTy2/9vZW275L01P8n0W25AZvDbuBl9EVBuOzaILhYSdDjBRVbso45huhWFV5uu9Y
	29jW3ZBhTSFqg4S7Tl7dnjKBNJAzDpboMUv41KhoIkDOVQJruRjiVZUL3OpK4kShV50YLj
	c+1/V+9h8UXnJDcIlBBJz9yTr8ry7R119YON/cEOzvwrGQCrf3JLQOxKwrbKiwPTp60GDR
	G4vvX72atqQy1JVEvWgrCai6ZT/xrl24VnujaTJD97Jerqeb01LQ7bbLMhh7E0A8g2N2d3
	V+sFi3eUBZX42D8G/KltngcdADKiwMeXHIeVgoIe9TjOF8aOOrUhOJtw+vr9Qg==
Date: Mon, 7 Mar 2022 10:06:13 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: request for feature
Message-ID: <20220307090613.bf7ddi4qsevmqorb@beryllium.lan>
References: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
 <20220304091104.g5lbeu55z4oubyej@beryllium.lan>
 <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Mar 04, 2022 at 10:13:01AM +0100, Daniel Wagner wrote:
> > +	} else if (strcmp(iwdd->mode, "AP")) {
> 
> and here too

and it's "ap" not "AP". I was not able to test it as my USB stick seems
not to support this feature. Though if you issue an scan from the cli it
ends up here and the proxy is called here. So in theory this should work
now. Give the patch I just send out another test run please. Thanks!
