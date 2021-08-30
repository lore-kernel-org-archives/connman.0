Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AA3FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 08:16:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC9185E3F1;
	Mon, 30 Aug 2021 10:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630311391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MORu4ehnv30Wq7UWXKjbQ8tR6vqOOLxYadiVzFfEPn4=;
	b=aNwzolMN/7R1K0S9KusXnjErvxcOLwhD/GxKAtmE4GTJLorL9UKkrjoEG4QzhqpFKYBWCz
	Vdnp8oIbbX/h8jadGnD5o7kKhqhVfbVx8MPppQlm76L8FPT5yb/l/rrEQCzv0zzDkDG49S
	rlqpT9K/P1dND1GlpvqGkxTUNv6CrX2X3yONnq5sOHGw8Bin8ABVcl9sVcCSk0/ffuw7Wh
	J06Kqe6iTSVLZuKK4TMU2Hf9J6xl5na8yZRxx0M/WrzTGYTeXi33HbgCuqnLM9ceLSuhPG
	hVtruuDASx2uphvT1DEYI1a1LgWxPdpRspzqgIXCXjCQFARwHyI9/qPRqB2qrw==
Date: Mon, 30 Aug 2021 10:16:30 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
Cc: connman@lists.linux.dev, Santtu Lakkala <santtu.lakkala@jolla.com>,
	Jussi Laakkonen <jussi.laakkonen@jolla.com>
Subject: Re: [PATCH] make possible to use alternative auth group with 2nd
 password
Message-ID: <20210830081630.2b2btz3ijhjlnj5m@carbon.lan>
References: <1666033.JRX4bv1jlI@latitudemachine>
 <20210805061457.abhvax5ow55z4hwt@beryllium.lan>
 <15534700.KoKU9GZOxT@latitudemachine>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15534700.KoKU9GZOxT@latitudemachine>
X-Last-TLS-Session-Version: TLSv1.3

Hi Lukáš,

On Mon, Aug 30, 2021 at 08:52:01AM +0200, Lukáš Karas wrote:
> Did you find some time to look at this patch? It would be great to support 
> openconnect with second factor authentication and alternative groups.

Ah completely forgot about this patch. Thanks for the reminder.

IIRC, I had no objection on the patch, just asked for a second
opinion. There was enough time to complain, I'll queue it up tonight.

> Btw, if I understand the code, connman form API doesn't support updating 
> of form fields dynamically right? (After change of openconnect group)

No idea, I haven't done anything with openconnect so far.

Daniel
