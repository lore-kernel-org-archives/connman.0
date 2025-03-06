Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656225A358
	for <connman@lists.linux.dev>; Thu,  6 Mar 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282201; cv=none; b=u+wFWF84HuOdDQ7DKTpcHAQL0ijIGmJ2k2X59JkCigVuQf0k+LI321G+D8umnuOrj8ri/s17Yl4KmfEDclxl4d9o4n5jU/UBN7HsWJBYna0ydHNqOafJ8XLkW4+8CDJCOK09Hhi49xlkB4JWCbR1/YDkfVrIxKboJTzFg54jHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282201; c=relaxed/simple;
	bh=eduaIziawSfeBuAZevA7NIEkLNu71LeDz5Ks7GEK0C4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ev71qlE2h0rzzOD/iyjM87pqnYkwLEDIAC1ppPjFWzWAZTmI4rHchT2LdKkxEeIknWgCQL/SyZHCr7Yzuobaa8YVuSQfBdcOsSzjI0yQnkk9xLkCS6Q46lH1yYQyebftAr3tYpT37prYiatBPNC5JUPPjmVLmu8b84JXCJOJ0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzXvTdVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzXvTdVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B12EC4CEE0;
	Thu,  6 Mar 2025 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741282201;
	bh=eduaIziawSfeBuAZevA7NIEkLNu71LeDz5Ks7GEK0C4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DzXvTdVRUd5s4ZFJjA2JqfCgkVlA5A7Bj/1IxNyV+yxUkEd4DSBY/E9VdJfvvgKoh
	 T9D+q1v572nPWl2/hTan5Fna8W2mGzEReDG+hlGgmyLH1MrXxTvmnSsI9TVS9om2Mr
	 lXT1OIL/mMvq0QIHsm08O72sXdx5R23yI8O5MxkAZIb/xUX2xIC6NEMcH+IMYIEErg
	 VguTv7USmRZk0Dtmg5zgcb/Chsf95rGDdOEGUah8eMptX47jnhWGPtGALHSTGCWTTs
	 cBT9mAanDlhBdxiQMuX5cFEPboU2x+bpEFwyACPDwHfYh5HOhsiJ5YfxcpzdKFJlLO
	 +P8TlS/sMS5pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE18380CEE6;
	Thu,  6 Mar 2025 17:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/22] Close Two GWeb Request "Bookend" Failure "Holes"
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174128223450.1681242.11293580893014602782.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 17:30:34 +0000
References: <cover.1741059516.git.gerickson@nuovations.com>
In-Reply-To: <cover.1741059516.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  3 Mar 2025 19:39:22 -0800 you wrote:
> There existed, prior to this set of changes, two "holes" in the
> finalization of web request sessions that can, for example in a client
> such as WISPr leave one or both of IPv4 and IPv6 "online" HTTP-based
> Internet reachability checks "dangling" and non-renewing such that an
> expected active, default network service failover does not occur when
> it should.
> 
> [...]

Here is the summary with links:
  - [v2,01/22] gweb: Leverage 'GWEB_HTTP_STATUS_CODE_UNKNOWN' mnemonic.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=f4ac0112dd7c
  - [v2,02/22] gweb: Refactor 'received_data' into 'received_data_{finalize,continue}'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=3820ccb51238
  - [v2,03/22] gweb: Added 'g_web_result_has_headers'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=f9cd89636deb
  - [v2,04/22] gweb: Add documentation to 'g_web_result_has_headers'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=8883288a058a
  - [v2,05/22] gweb: Added 'g_web_result_get_err'.
    (no matching commit)
  - [v2,06/22] gweb: Add documentation to 'g_web_result_get_err'.
    (no matching commit)
  - [v2,07/22] gweb: Add an OS err parameter to 'call_result_func'.
    (no matching commit)
  - [v2,08/22] gweb: Add documentation to 'call_result_func'.
    (no matching commit)
  - [v2,09/22] gweb: Add documentation to 'g_web_result_get_status'.
    (no matching commit)
  - [v2,10/22] gweb: Add documentation to 'received_data'.
    (no matching commit)
  - [v2,11/22] gweb: Close web request session finalization 'hole'.
    (no matching commit)
  - [v2,12/22] gweb: Add documentation to 'map_gerror'.
    (no matching commit)
  - [v2,13/22] gweb: Add documentation to 'received_data_{finalize,continue}'.
    (no matching commit)
  - [v2,14/22] gweb: Document 'struct _GWebResult'.
    (no matching commit)
  - [v2,15/22] wispr: Add and leverage 'portal_manage_failure_status'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=c312e2abc318
  - [v2,16/22] wispr: Refactor 'wispr_portal_web_result' to leverage 'g_web_result_get_err'.
    (no matching commit)
  - [v2,17/22] wispr: Document 'portal_manage_failure_status'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d4da8dfd2382
  - [v2,18/22] wispr: Document 'wispr_portal_web_result_err'.
    (no matching commit)
  - [v2,19/22] wispr: Document 'wispr_portal_web_result_no_err'.
    (no matching commit)
  - [v2,20/22] wispr: Document 'wispr_portal_web_result'.
    (no matching commit)
  - [v2,21/22] wispr: Fix documentation typo in 'portal_manage_success_status'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=0dc3b6a81f67
  - [v2,22/22] service: Capture and propagate '__connman_wispr_start' return status.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=31f4ef8cdf98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


