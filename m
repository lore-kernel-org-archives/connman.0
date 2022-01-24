Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3E29CA
	for <connman@lists.linux.dev>; Mon, 24 Jan 2022 08:21:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 639EB5CFD1;
	Mon, 24 Jan 2022 09:21:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643012505; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QW/gtJ1s4Y/yabwZPdCxKwrcFoUNMa2yFi0yFY7xs0I=;
	b=HjvI6l5XwsMzLJLXT0po4MDtV9RjGdG1fkz8AtePqO+KrXDY11iX5RspSIv8EoYQuulyr5
	vy7vZmDDM6lWlCQXwGud0Jc1B6C2SvOsZAv4DZzt+h/ZNkkUKcHrF1Spu85VuDXpzyJBgC
	HCu5g6iLEywPj8TbGA/PgYIrWBocE2QcawqhFzxabOlt20g9ixWjvoIu2yM6KY0prLl7ot
	QQ21B8Avz0yNglrYPGtlsEnkkRux2OWk+LPFKA2qWWZzjcOKCGs+/sN5FMONSU51kaFDX4
	BL+bE8asN4XgonmmB1g7w5OZOeFrzP6xrqu6xlWS+hw5eLzFBww65Sa58YhAKA==
Date: Mon, 24 Jan 2022 09:21:42 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Always disconnect connection completely
Message-ID: <20220124082142.slbsbfuhnisll4bn@carbon.lan>
References: <20220119133927.1245607-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15449D2CB5CB2656550C629A93599@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220121074740.axzlpaj55xtzeg5s@beryllium.lan>
 <MRZP264MB154465E0619D397C2859ABA6935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123131808.x7vvxmkhbu3jieiz@beryllium.lan>
 <MRZP264MB1544816EE2A3ECBCC2347C80935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544816EE2A3ECBCC2347C80935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Jan 23, 2022 at 05:40:45PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> For your information, it seems that some other code does
> not compile with this option (xt_match_parse, xt_target_parse in 
> unit/test-iptables.c & reset_xtables with no void argument in src/iptables.c).

I don't have any fallouts in there. This could be just because I use a
different compiler with different settings. Please report those
failures. It's not good to paper over them in the long run.

> > BTW, please check your formatting
> What do you mean by that? Do you have some link with associated
> guidelines to follow?

There was the curly bracket on the same line as the function name. It
should be covered in doc/conding-style.txt

Daniel
