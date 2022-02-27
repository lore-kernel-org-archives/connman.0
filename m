Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9FF4A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 17:58:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D4735D41F;
	Sun, 27 Feb 2022 18:58:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645984736; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hNjDDuk8BaZLo0N6nQnK6kHz/TAPzqSFvmlS2AM0Et0=;
	b=hLP4R6i/vOcSixygtzHedZcMAAw12gi4yxk4IXwmh56YPeYa0NCGGPFrHnSAG2LdgDSoMG
	XTbbbH10lbkFFUVmsU7hX3SfoJFdL+8O6rH9n/4epwjTtIbSXgKG2WfJAn5JnfvAQP8kET
	6Q/7/W68NbjP/t4+ia+xNDnFwUTRSpzJCgysB7aqXsYOs1EvE2BDZ2z/+fbTW9AH0koSKS
	1RSU6Z5Y3eSJGYwXR6ASJYbB4tI3HinbV31qEqLVJWRrRjEwIU+uCeHRjevtxENlTrwPEI
	+pncAhtMQvGGdRHuPmc3ZjIKV5kETAo2KWpUrgI5hqqPgqyFMkGLtUreYa53Ww==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 0/2] Check for active pending requests from agent when connecting hidden WiFi
Date: Sun, 27 Feb 2022 18:58:54 +0100
Message-Id: <164598467954.27707.8531824439804720368.b4-ty@monom.org>
In-Reply-To: <20220225105800.501005-1-jussi.laakkonen@jolla.com>
References: <20220225105800.501005-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 25 Feb 2022 12:57:58 +0200, Jussi Laakkonen wrote:
> Hidden services do not keep the pending call when connecting as that is
> forwarded for agent to handle, if present. This patch set adds simple search
> to agent.c that can be used in service.c via agent-connman.c to check if the
> hidden service has a pending connect request.
> 
> It was noticed that two consecutive connect requests for a hidden service was
> possible and this resulted in adding two separate requests when agent was
> present. First requests was placed as the pending request on the agent and the
> second one was allowed as well but it was put into the queue. And when time-out
> happened on the first one then the duplicate request would have been sent.
> 
> [...]

Applied, thanks!

I've removed the DBG() as they really looked like development DBGs.

[1/2] agent: Add support to check for active pending requests
      commit: 3d9b90e89f1ee44e3d8b1bcf52c9bd12f9078334
[2/2] service: Check if hidden service has a pending request on agent
      commit: a2d238c7bc515f2ce3113feb31d6c0e9067550b7

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
