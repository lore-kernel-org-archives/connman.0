Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43F72
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 16:32:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BB6460E52;
	Mon, 30 Aug 2021 18:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630341146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=E0wo7umUOfxSb3ZielsQKskCiAybqPKSuH3FYxPNLWQ=;
	b=FBrqYpgwhcn8dwurwp3NlnFJYAVsA6asem0xCsyyx+eIY5Ufkzf+yNKBp7NTfhiLBzCTJm
	oiErqAI/OLZKySk5uJZBOooUD4XVORp+JmDGcX0/sZWQubg9WU3bBEqpOI/FoabdbrvJum
	dp90NX1g+N74xJfoBwLQKEQT7WzhCRM+l2foEpQCRNgw1Hzg1O5xIk5BzgzPFxlDO1b8YN
	l8pw6gTjX66fJhTNqszVOL4WjLc2dx0WKwcsLwK88uV+JZF7PoqCjz0rZLmp4NWtDbhhpd
	xFPEH6N77rWZtPyMlFKZsbIfdxfzf5J8SxXDv4wlAGQvc2r7KLm8PSPyAoOcdg==
Date: Mon, 30 Aug 2021 18:32:24 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
Subject: Re: [PATCH v1 0/2] Disable online check for real
Message-ID: <20210830163224.f34s75enbfx6uiun@beryllium.lan>
References: <20210829195321.23396-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210829195321.23396-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 29, 2021 at 09:53:19PM +0200, Daniel Wagner wrote:
> Страхиња reported we still do some online checks even though
> EnableOnlineCheck is set to false. Let's move the
> __connman_service_wispr_start() code to helper and add a check there.
> 
> Cc: Страхиња Радић <contact@strahinja.org>

Patches applied.
