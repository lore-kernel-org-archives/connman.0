Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799D173
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:50:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05EBC5CF96;
	Tue, 25 Jan 2022 10:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643104215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZiQZuLkViqDgPP+6avmOrV7wZRlAWuTzVD9+HIRy7rk=;
	b=XHzi7Dds3BBZWI9+hHW7bN2j8lQY+r4lHouCezHXdwybQeNCwTXJjqo2+CI/X69P8iZYfG
	hrfCSgWgJ9VQoT99cxXvAyKS4KEIvvftFgq/L/qhUO3qub3oZKHwHHGUPAwod7V38cBmlV
	tSpBEaAMaEJom8DLkPVggXv1B9ywd3iVKQBvQU1C8I5p1wAwcH6HBxZzCAEsZsD0KKD5+H
	BSWykzLLOqI8u9pChIMCJdTngXhlBVKnhkGkYDeNc5EZ+ACaM/0yYietCF/Dak9u+VfdxH
	ApYgoDujei/r5tX2098Ynd8dbIwmM0AMZNqDFEr0RA9tALOuAGLE/8zBcRU8NQ==
Date: Tue, 25 Jan 2022 10:50:14 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Message-ID: <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Jan 24, 2022 at 09:06:27AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Before being able to connect to a new network, finish disconnecting
> the old connection. The network can change while the
> cm_network_disconnect_cb is scheduled.
> 
> Commit 024309a9e04a ("wifi: Reset disconnecting status of any network")
> Commit 795883e98eba ("wifi: Check valid network in disconnect callback")
> Commit dd86f09107e8 ("wifi: Always disconnect connection completely")

I haven't made my mind up yet on this one. The problem I see with this
is that we start add glue logic which is hard to follow and I am not
sure if this is the right place for it. If you have some more info
what's happening I would love to hear.

Daniel
