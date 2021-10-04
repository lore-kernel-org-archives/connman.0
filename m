Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF73FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 07:46:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7916860E0C;
	Mon,  4 Oct 2021 09:46:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633333587; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1F9OYu8mmPxl9aCYdI2zuZDLWpWFqEWpbC8e9EL6jqY=;
	b=QlD5E1GJaKzyD5WGScNHc7jVR2RUiv4oiDu8zlMaeOdHFgu3rTTVshZIPc6NpNANaMbPlk
	F6A0bg26VtEs8n2tXqNvuGxDYF5xv6210GQAx2hnbxNRwCobv43rlkhSoZNY8bVVFoUXNL
	qcrwnNINiTr9FK/IcvvDPVVXVgJubrHhwL4/RNYG6MycV2OKIwoi8orI47I6azPH03bU42
	k8rCO88/UzBsDZ6PVzAww0jLgb7UKhzvCU0ZsiLpQg+fTOrZAtEExHuSww5LcR5XpMWDOj
	IQX6/fLgitMXQzLhVRZu6acNhCqUsa0ce9oQ1FleGZA5T3k+Pe1m6P8Yqt15ag==
Message-ID: <6f009b7c-d7ef-6800-f0d8-67f045d6ae4f@monom.org>
Date: Mon, 4 Oct 2021 09:46:27 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] wifi: Choose a random channel when opening an ap
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: HENRIET Vivien <vivien.henriet@overkiz.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <20210923124429.1123-1-v.henriet@overkiz.com>
 <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
 <20210929091641.fg4v7pbol2nysgrd@carbon.lan>
 <CAOf5uwmft+2ToGW8cOVF9_5S-S4G6Jc5CgjgZk=VtJPBd0aAQg@mail.gmail.com>
 <20211004070906.625dlmzqv57r7mac@beryllium.lan>
 <CAOf5uwnB3QQYRiMG5HtKVVeE8cL-MWh_5G94RM7FmZ+NeLpf=A@mail.gmail.com>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <CAOf5uwnB3QQYRiMG5HtKVVeE8cL-MWh_5G94RM7FmZ+NeLpf=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 04.10.21 09:34, Michael Nazzareno Trimarchi wrote:
> I can create a function to get
> 
> ident = technology->tethering_ident;
> passphrase = technology->tethering_passphrase;
> freq = technology->tethering_freq;
> 
> connman_tethering_get_params(techonology, &ident, &passphrase, &freq);

Yes, that is what I had in mind. We need to retrieve these values from
the core/config somehow.
