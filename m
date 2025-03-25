Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD278F24
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914816; cv=none; b=jO6MNvI0NnimKc5kbdr6eSjcteJVEx4+LQj/vCTpEaIM9l5Ng8vSm3r99HQ5kFrZXV+7uEKFAS6IOwNvEQVCPD3bc3pMqi7xoAqRgIIHGaN3W3oqPURDHK3kV4ldmzBtkIebe5Pqq/se3uAMPKzfR9qgkO3JyMBsGYrjpCv1C1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914816; c=relaxed/simple;
	bh=dlLV8JUaANH6xg3KROWWbiLevCHcuwGcHWkp57T0jYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nNXpTvxka/sp9GQqUSEvcgLQnxat3ZNSw0bHKUHzcTLHFwy3pwtMKlMc50ZIabH0wwGT3legbs+DTDy9/3v60biRlvb9fSXlf6FE1jFWr5A++v6E6MesBh4+L31hq9Sz73srGsBewR7KNKABDQwZ0DwdU5nn2RD9nwG2EgnErE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/Lc27Sz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/Lc27Sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD063C4CEE4;
	Tue, 25 Mar 2025 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914815;
	bh=dlLV8JUaANH6xg3KROWWbiLevCHcuwGcHWkp57T0jYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/Lc27SztF3Tr906j/RigPxIWZy6+oWSzhS8npeqKrqb1flBBR60VSpMQTEFQ3rJ3
	 B5SFdnM58kNiH3C4wHtSOd5ldC7Um8MgKz4m4O6kCs6xNO4PxWvi4XBd+kOAUJO0+4
	 /WAkFpDUrW0urmrlbALJ3eE+S/WDZLGOQw2qmYVzLISjbYMFCYRA6xnB1z0K9feHbi
	 1ykdbqQtE1Hl+tT2duPGkJNefwCfOGY9GdwG2mc1sXT4O+XjCpeYTzQcqQ8oLFJ8jM
	 IWxusge5Y9Ow/2kHU7rkMocNE15vBEEN8ODPyvpgztB7f4R4CfuK4Z7XTnI8ZLhjZ1
	 EWBt0yRSDgqIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342EC380CFE7;
	Tue, 25 Mar 2025 15:00:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/9] Close Two GWeb Request "Bookend" Failure "Holes"
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174291485176.606159.9417085935121920378.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:00:51 +0000
References: <cover.1742878567.git.gerickson@nuovations.com>
In-Reply-To: <cover.1742878567.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 24 Mar 2025 21:59:18 -0700 you wrote:
> There existed, prior to this set of changes, two "holes" in the
> finalization of web request sessions that can (for example, in a client
> such as WISPr) leave one or both of IPv4 and IPv6 "online" HTTP-based
> Internet reachability checks "dangling" and non-renewing such that an
> expected active, default network service failover does not occur when
> it should.
> 
> [...]

Here is the summary with links:
  - [v4,1/9] gweb: Adopt optional, immutable GError instance for GWeb result errors.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=8d0117f5ffed
  - [v4,2/9] gweb: Added and leveraged 'call_result_func_{failure,success}' wrappers.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=32d7fcb1f1e4
  - [v4,3/9] gweb: Close web request session finalization 'hole'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=6975c4b8a3bb
  - [v4,4/9] gweb: Add documentation to 'received_data_{finalize,continue}'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=4c8e985e296b
  - [v4,5/9] wispr: Refactor 'wispr_portal_web_result' to leverage 'GError'.
    (no matching commit)
  - [v4,6/9] wispr: Document 'wispr_portal_web_result_failure'.
    (no matching commit)
  - [v4,7/9] wispr: Document 'wispr_portal_web_result_success'.
    (no matching commit)
  - [v4,8/9] wispr: Document 'wispr_portal_web_result'.
    (no matching commit)
  - [v4,9/9] wispr: Add an optional 'message' parameter to '__connman_wispr_cb_t'.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


