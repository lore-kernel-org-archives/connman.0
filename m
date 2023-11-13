Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206D1DDDE
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="dDsZLS0P"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50A79E1A09
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 15:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1699886010; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=d0g8ZCqfOC5l2VcfJH04sG5cSYtHKCHmygTpJ5IYFcI=;
	b=dDsZLS0Peuz+sNSVzIlCkX0zfBnreYMPNsSPfheuR7HRGh/8qCDn8vag23cIPmSiGQCx7f
	Eyd/+RAonCA9WXCSt8VtZzOdry+Hl6qSBwvEtE4gw2tJIOHZ3dTdtbVn9Yt5twr5OCZKAf
	Jm04uKoaiWizi6pca7xEeRh2YwPWPEMr7AjIHpe2mUb9CgJ+fKxmUkNQLxIOlwGxUbTz7X
	h2GnRylEExLj1O66vuYmHFLAu62f0V1TEDNkDPDfvkFX3qElsCeUjAuh2/zzddwI0UgHal
	x2Vb2fFbcy1y7JQqBVrF0UdKKpYrvW5ZSPkNjKOqLzd3yi7yJgAju8kgLnTy2Q==
Message-ID: <b0e1c8ab-4157-4153-bc7c-529a54fbcd65@monom.org>
Date: Mon, 13 Nov 2023 15:35:22 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: connman@lists.linux.dev
Content-Language: en-US
From: Daniel Wagner <wagi@monom.org>
Subject: libppp-compat.h missing in tar file
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

I noticed that the scripts/libppp-compath.h header file is missing in
the tar file. The file is added to EXTRA_DIST variable but this seems
not to be right. Where should it be listed?

Thanks,
Daniel
