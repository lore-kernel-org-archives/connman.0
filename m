Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08506366
	for <connman@lists.linux.dev>; Tue, 30 Aug 2022 07:13:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 830905E079;
	Tue, 30 Aug 2022 09:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661843613; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oPphYceeFLAnvkkosDzhs+v9bnswPHDNBuhrREg0ukw=;
	b=Vlxt74yjZ4w2pAqzbshxP2XkzLO7hMkrv/3e9jIO6Hi5DMSeJmXwolAz99gRrHTOb7mRbR
	JDrFQERtftA8nAVzHeURwHLxGevVT8HYcFQRw5Fgum5B/Iyx79gioxaciEbfEd7ekFb5Z9
	3jGXY+HgIyBMsjJLXpod8H2TM9ZXJ5Ilt/7pv9AipZ8mjkNceo+sFmqWKsmqSGQSRstj3D
	fzrS/AGjqXdhwDd8pZO6cWgzqThg0uW912/l0ZuymJscUcteggllVKtKUzQ63QWyy9M7Pc
	GFagE1yYhu61pZ3m6Of9Bq0ehjFqIbEAsRrXTLs/3utNsH7LIoWdPXrz+jThDQ==
Message-ID: <7a856bef-fb46-d85d-f24b-eb4f5c69d9d6@monom.org>
Date: Tue, 30 Aug 2022 09:13:32 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Link always ready and don't pass online
To: daniel antoine <univac55@gmail.com>, connman@lists.linux.dev
References: <CA+iibzBCG+F5P4q4T4wTwONcCzR5doDpzz=t-SgvFR0eqzKeKw@mail.gmail.com>
 <CA+iibzBU-cYMgLHD98nB-jBhnH-gG0V6n8Z1SkSkmJFrudCHBA@mail.gmail.com>
 <20220828140926.etfebtezdel5nvu4@beryllium.lan>
 <CA+iibzBE3sgRcZF+U-kPZV96ocFyRFy9g=XE=d9q=rc4DfH+Rw@mail.gmail.com>
 <20220828182908.kiv4ilf7uxoxrmcb@beryllium.lan>
 <CA+iibzCXXwAETXPNOy81Sjc_GDY_U8cCXU7AA6eU_f-uX8LoxA@mail.gmail.com>
 <CA+iibzD7kNDV2zcdmoSngbsz=t84KGVJyM3iHDMkis4jqfobCQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <CA+iibzD7kNDV2zcdmoSngbsz=t84KGVJyM3iHDMkis4jqfobCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 29.08.22 10:10, daniel antoine wrote:
> I have installed the last patches from the git and I am always in ready state.
> 
> root@yaolinux2:~# ip r
> default via 192.168.1.1 dev wlan0
> 192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.16
> 192.168.1.1 dev wlan0 scope link
> 192.168.122.0/24 dev virbr0 proto kernel scope link src 192.168.122.1 linkdown

This looks reasonable. The 'Failed to find URL' is likely caused by 
running the online check too early. E.g. the gateway is set after the 
URL lookup. Can you try with this setting again?


EnableOnlineToReadyTransition=true

in /etc/connman/main.conf

Thanks
