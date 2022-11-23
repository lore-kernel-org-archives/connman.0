Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FB4699
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 17:36:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23104E2FF0;
	Wed, 23 Nov 2022 18:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1669225016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+Dh9ixpXYBdNbgLZfFedcDTmVbpoD3Au2pvIo0XI/gc=;
	b=I9Wq2e0pSOW1h802Szggf6rytaLJZ5xBP8RSmYBGpKlmlKroq0XeAUe0KJgj8XNd6dQGEN
	o7r/XG8WcB5RYPEqkDwSuwGR5G8YnGtcJff08FUPs72EgajMYB04FcdPPBCqrqLivyOF70
	oy2245BZfYAbry3PfgzheadBm+/RNjx7rM0mKm3vJ9Om9B7OU4nRbkCOLPxZVXd0Kc2mvU
	7wgVZWy9kuyu82meqsJD496ZCaDLDuVzRM+UM1sCZNehJnWh5GYrKBcDyE2XvOYR+oP8Il
	3D2gz32iQ4sDp/tXS5LUrGJ+dnz6BtPmCfZiEc/SJJ3uAaJuAIQ353S55GciQA==
Message-ID: <39363d0c-2928-b5a1-d108-1213149fa7ea@monom.org>
Date: Wed, 23 Nov 2022 18:36:55 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: autoip address set/reset loop
Content-Language: en-US
To: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Cc: connman@lists.linux.dev, john@metanate.com
References: <152f062c-7c16-c6cb-c8e8-c6f82902e40b@gmail.com>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <152f062c-7c16-c6cb-c8e8-c6f82902e40b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 23.11.22 18:12, Geoffrey Van Landeghem wrote:
> Subject: Re: autoip address set/reset loop
> 
> 
> Hi Daniel,
> 
> 
> Well, as said it autoip (APIPA) was not working because of this because it seems to not have assigned any gateway at this stage. This get's assigned in the __connman_connection_gateway_add() function which is called after this DBG(...):

My patch fixes a bug but introduced a regression. If you want to fix the 
regression you need to figure out how to address the original problem: 
cb05780d86c3 ("ipconfig: Don't add invalid gateway routes")

Just reverting is not okay.
