Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA433C6
	for <connman@lists.linux.dev>; Thu,  8 Sep 2022 14:22:49 +0000 (UTC)
Received: from [IPV6:2803:9800:98cb:8db7:4252:e928:3623:abff] (unknown [IPv6:2803:9800:98cb:8db7:4252:e928:3623:abff])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: adalessandro)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 81E616601F95;
	Thu,  8 Sep 2022 15:22:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1662646967;
	bh=TJfB+bo/eYsCceftyzYJ0122DIPtVZf5gDdnLRvJM+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bAWdZ0e3cKq9Et+SQWblKfyVqS0QC8fkkCRZFPuaJxDWA99FkyUKkQ7rN/PyjgUJZ
	 u83YfKQw1xXN5MbCDXLLPId1RgxCYqEkoHwm0VeKxh4ZgAMGsVwhISBVkK6921iFsq
	 jDkfa6cE4dGeNXJ+znXvXChRLvRFdJkZUM52ALeqwvjMYQTwGLzVqcyxzWFnCzTj5F
	 FVL754tamRCHnjEbasLU//K/2DRGxwXSjwhFD3WmNHmOiqqw+HKPDiSUs9LNbz4O95
	 GFhJ/+CZ2zgTn6+ewn95xr+/GIdAuVN5pMuNdIejC5RWcSdNuLrH5G1lGdh9qCnWeU
	 JykPdBWFWhPeA==
Message-ID: <e3c2ebb9-9f63-19bc-4969-e892c8aca433@collabora.com>
Date: Thu, 8 Sep 2022 11:22:41 -0300
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: No password prompt after wrong entry
Content-Language: en-US
To: John Keeping <john@metanate.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <ef8ef3d5-3786-6064-605b-7d668a8d92bb@collabora.com>
 <20220908151241.3fb95a89.john@metanate.com>
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20220908151241.3fb95a89.john@metanate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi John,

On 9/8/22 11:12, John Keeping wrote:
> On Thu, 8 Sep 2022 10:52:11 -0300
> Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> 
>> I have a question regarding the expected behavior on connmanctl.
>>
>> After trying to connect to a network using a wrong password, connman
>> returns `connect-failed`. Further attempts to connect won't prompt for a
>> new password, so it will use the same old wrong one and keep returning
>> `connect-failed`.
>>
>> After manually removing the network, re-connecting will prompt for a new
>> password and the connection will succeed. Is this the expected behavior
>> or it should automatically prompt after a wrong password entry?
> 
> What version of connman are you using?
> 
> There is a bug in 1.40 which was fixed by commit fe5c1436 ("agent:
> Always inform upper layer via callback") that has precisely the symptoms
> you're describing.

That's what I also thought. However, I'm using v1.41 which includes that
fix:

```
$ /usr/sbin/connmand -v
1.41
```
