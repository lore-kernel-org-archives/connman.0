Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7C3214
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 14:10:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 453885E024;
	Sun, 28 Aug 2022 16:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661695826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qxiExTAPUG/Ov6wsDzYyNAblW1y4WbzUZqjPdpSJyCU=;
	b=r5S+2lIjCEpMocCyUsjBLJEso4epU0KziwN0HjpnOnT6cD6YJeKUOumEvBbrT1Ok/cqbi5
	Jqaxe9P1OJV4sCVWT2Z4iP1L1AtJaiG2ktu9pRH28B3z792cdzCPd42ntJTpxm61fiIlVW
	yEZbIuB4Zn1INC4RIVs3PsWZr0bITCT8cU+TOWBUFv2h377G+6jOkdMCd1fI9ljdVKPjkw
	DwutgHvuRxZ7u5mNVDA8pXkJTt3Qht65qCHPO7CVx5IhQp4wYS7czG588zCs/0jJcPVy7a
	bKkyT1uGu0CyOK6xZ4+OffwqCrTws9wzzHpB/4qNWWRNKbRRavnLEe1rZC4Bmg==
Date: Sun, 28 Aug 2022 16:10:25 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Aug 18, 2022 at 07:29:54PM +0200, i.Dark_Templar wrote:
> I've found a regression in connman commit:
> 
> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=416bfaff988882c553c672e5bfc2d4f648d29e8a

It looks like the wispr fix unrevealed some other bugs. Could try if
this patch [1] helps?

[1] https://lore.kernel.org/connman/20220828135322.21582-1-wagi@monom.org/
