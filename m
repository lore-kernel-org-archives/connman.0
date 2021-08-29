Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546323FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:15:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F0B25E30A;
	Sun, 29 Aug 2021 21:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630264503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Oleu0ELxeaY15fTI9zcJcYSE/oqpJGnKANjTLSuYxQ8=;
	b=XlifqiIhbDyPwsoSJRE34ve1i8IIeBSVB+w8pveS1jTL4DLX5GqDYlxv0eHO6AAs07BuX6
	skw96X0sqQ14EaV8/zBVgtiuk6FO6Rh7CwOlGKgDS83X9AlUczgq8vsjoXaamIhpdR7x9M
	BgyCTNbpRD4qL1h0bpWMd4+ymIYM5zmjhPxbB55jJOvxYgfC7kTihyV8lwqCc8/Gb75G3P
	b9pRfysH+mqqVbSAeZu8rX9QpQNIhSlDauFKHLc0xA8dknm4QP/N5R5kMeAbdZBeP1gg9l
	2epKV5mGy1WOxs37nB79wKMP/SJ79/+OzoB3sdAliOFPRvyjx3OTajEIqXb81Q==
Date: Sun, 29 Aug 2021 21:15:03 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] wispr: Add online check url config options
Message-ID: <20210829191503.pt5jkevne4gbzyrq@beryllium.lan>
References: <PR1PR02MB479412B2989FCCF93E4AE58F93309@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <PR1PR02MB4794EE1A5F2F997AF8032BB893309@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <MRZP264MB1544E68164633E412919730493C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544E68164633E412919730493C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Wed, Aug 25, 2021 at 12:45:38PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Was there any progress on this subject? Does it still require some
> clarification?

Patch applied.

Thanks,
Daniel

