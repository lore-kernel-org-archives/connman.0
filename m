Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A5143895
	for <connman@lists.linux.dev>; Mon, 24 Mar 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854804; cv=none; b=HBN7IUj0BRdKmTyu3so3zZieMbWCcYDdsVjA9wlgTuFLscpEfgeCMdIvsd9K1qZkxEJaUAGFC/0QjZbKbQrB6+LQoOVJptPPhuMdXa+17lY6XNIpGs55CLm4IyU4utbbeSl2FiUeAl9ldK9d9IRoFPKH/VRjhH9G+wa6U5F5p/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854804; c=relaxed/simple;
	bh=AsoQDgv0aD/utmYX99XrtZ3pNbJ/N4aVjNQfqzJcwyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lbPXAAQS+ftGFYUVDZmF8QSq1jX0KI04ygf+dpGiHA3DrpxhbpzPuIueF/T3ztGHO0e0gCY1TJ2xIOI6WHFUH+dXw1mfhPuuxusOkutjw4WD8NKMiIsB1K8Px+TJMZnZI8+S6CB8lZA2T2aoUwcy77Z4w2XLK2zYlUzazZXD638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NftlzDC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NftlzDC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDBEC4CEDD;
	Mon, 24 Mar 2025 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742854803;
	bh=AsoQDgv0aD/utmYX99XrtZ3pNbJ/N4aVjNQfqzJcwyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NftlzDC53RJynh10ymBNFu2nHII7H28eVivCZtbXKuwNtg+dUhUAJQjMBUKcv+mR8
	 i1Ea+RDotTjP/SSRVv95AH0KUqOgRSM2ZWgdw0SFoOPXMitridg7HgU0R0Ob/SYz2U
	 9kOF86+dFzTz5ZucVWTNjdGceXFptWt04MHVd6waUBjDa9nl4+J4vcNjMcTDv9CxMz
	 noS8BZcXVCFynqrPMiVS6HLS0tNIRFKcZMMwNilxTH6YlJg7GppHqFzdJ0a23fpl6K
	 FEV34+a3q0fv7BFg4sEGmV35F14pjvbCOx1XrBMF15Z6Nkd07B5v83+iI/DlZ+QL82
	 2LAOy97xshlfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4D380664F;
	Mon, 24 Mar 2025 22:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/18] Close Two GWeb Request "Bookend" Failure "Holes"
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174285483950.3937.11504535789693689780.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 22:20:39 +0000
References: <cover.1742513884.git.gerickson@nuovations.com>
In-Reply-To: <cover.1742513884.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 20 Mar 2025 16:38:51 -0700 you wrote:
> There existed, prior to this set of changes, two "holes" in the
> finalization of web request sessions that can (for example, in a client
> such as WISPr) leave one or both of IPv4 and IPv6 "online" HTTP-based
> Internet reachability checks "dangling" and non-renewing such that an
> expected active, default network service failover does not occur when
> it should.
> 
> [...]

Here is the summary with links:
  - [v3,01/18] build: Require gio >= 2.40.
    (no matching commit)
  - [v3,02/18] build: Add @GIO_LIBS@ to clients of GWeb.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=102589024ed8
  - [v3,03/18] gweb: Add 'G_WEB_ERROR' and 'g_web_error_quark'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=cfa99db4f71e
  - [v3,04/18] gweb: Add 'G_WEB_ERROR' domain status codes.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=3bd76c5b400c
  - [v3,05/18] gweb: Leverage 'g_autofree' for 'port' local in 'handle_resolved_address'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=31230cab01f1
  - [v3,06/18] gweb: Add documentation to 'call_result_func'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=4c342f33d22d
  - [v3,07/18] gweb: Add documentation to 'g_web_result_get_status'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=95db0a2c0adb
  - [v3,08/18] gweb: Add documentation to 'received_data'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d104ac6f0f71
  - [v3,09/18] gweb: Adopt optional, immutable GError instance for GWeb result errors.
    (no matching commit)
  - [v3,10/18] gweb: Added and leveraged 'call_result_func_{failure,success}' wrappers.
    (no matching commit)
  - [v3,11/18] gweb: Close web request session finalization 'hole'.
    (no matching commit)
  - [v3,12/18] gweb: Add documentation to 'received_data_{finalize,continue}'.
    (no matching commit)
  - [v3,13/18] gweb: Document 'struct _GWebResult'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=acb4bb421530
  - [v3,14/18] wispr: Refactor 'wispr_portal_web_result' to leverage 'GError'.
    (no matching commit)
  - [v3,15/18] wispr: Document 'wispr_portal_web_result_failure'.
    (no matching commit)
  - [v3,16/18] wispr: Document 'wispr_portal_web_result_success'.
    (no matching commit)
  - [v3,17/18] wispr: Document 'wispr_portal_web_result'.
    (no matching commit)
  - [v3,18/18] wispr: Add an optional 'message' parameter to '__connman_wispr_cb_t'.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


