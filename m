Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFB27817E
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108224; cv=none; b=tOE+V7q3MBnaI/uD1sddTiOhz5BqHo+yLEItskiJHeG8WiTyMoFDim9JILxeKm7H5uGTHAI3eWpLuKOrOZ+Q/ywkDT+aVA0/4C+/4/fC8ZefYRk9jgMUA2DKGmDEWPQXMney4kOaD/DgmYuVixymU9xv2Ey3lLei2bfLFA3eF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108224; c=relaxed/simple;
	bh=0NgGzqQKeMABuI173419WKoXT2Pxx5/4341HeEngl/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bldxivYJ8QUGC1b5Zcqws17ckh1oVPniMaMssW2uDt+eEpGLw1AOo2TM1s3iebSiqoxeauAZSLoCWcKWa8coKBjfkrlur3iiIRTw/VSFYGaalY9d5dmo2yHWcUjG1z4aui0DvObmtxrc56hLCNXOX2JW8m1YQXEltDixf6IvwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcA/lPtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcA/lPtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E6BC4CEE5;
	Tue,  4 Mar 2025 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108223;
	bh=0NgGzqQKeMABuI173419WKoXT2Pxx5/4341HeEngl/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VcA/lPtDVTOqo0PX9pl6MbpIXN4jbNk4jj1MRr+ZJ0cuFd3PloAa2muGrkFpO3PCW
	 APQGLIfYa9K0hwdmFQZapvMq3SmCh//pKAeJt6ah904PU5Dy7vMsi6rt0DuGIZVf+a
	 k4bAiDNBGgkfsUsAKXvKrupuWSQsegYH7K4CJqA3yLHXQkJqcuS4vq38EvXOqHojXi
	 KTFyDCEIB7o9mf8+tnueGKUpShIboORJzZ0VsM5LlkUgjqgJzXmVUcxAuVvIkK6ORn
	 mGyVHR9s/P3SCy7yG1fmIfYU8FsMMfgllxxLvIwpQoFYVR705aN01xwny6l+4AKD03
	 5F90A04PbLhFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD4380AA7F;
	Tue,  4 Mar 2025 17:10:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/15 RESEND] Improve PAC URL Mutation and PAC URL and WISPr
 Proxy Failure Logging
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174110825641.224349.157835284965304497.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:56 +0000
References: <20250221155653.760046-1-gerickson@nuovations.com>
In-Reply-To: <20250221155653.760046-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 21 Feb 2025 07:56:38 -0800 you wrote:
> There appear to be a population of premises ISP equipment (some
> possibly correlated with Spectrum Communications in Southern
> California, United States) in which the ISP equipment sporadically and
> incorrectly emits DHCP Option 252 ("Web Proxy Auto-Discovery (WPAD)")
> with an invalid proxy auto-configuration (PAC) URL (such as
> 'http://wpad.lan/wpad.dat'), even when neither the customer nor the
> ISP has such an option actively configured on the equipment.
> 
> [...]

Here is the summary with links:
  - [01/15] service: Add 'service_log_pac' function.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=b0ea957e1973
  - [02/15] service: Add 'service_set_pac' function.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=298a1a8c2806
  - [03/15] service: Leverage 'service_set_pac' function.
    (no matching commit)
  - [04/15] service: Ensure the PAC URL is set in '__connman_service_set_proxy_autoconfig'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=a73f053de112
  - [05/15] service: Document 'service_log_pac'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=8f281ed058b0
  - [06/15] service: Document 'service_set_pac'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=34855234cc6d
  - [07/15] service: Add 'service_set_proxy_method' function.
    (no matching commit)
  - [08/15] service: Leverage 'service_set_proxy_method'.
    (no matching commit)
  - [09/15] service: Leverage 'service_set_proxy_method'.
    (no matching commit)
  - [10/15] service: Document 'service_set_proxy_method'.
    (no matching commit)
  - [11/15] service: Document 'service_set_proxy_method_auto_handler'.
    (no matching commit)
  - [12/15] service: Document '__connman_service_set_proxy_autoconfig'.
    (no matching commit)
  - [13/15] wispr: Add 'wispr_log_proxy_failure' function.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=58c9eb5ab1f9
  - [14/15] wispr: Leverage 'wispr_log_proxy_failure'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=0f26b82712c1
  - [15/15] wispr: Document 'wispr_log_proxy_failure'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=81d651b269f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


