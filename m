Received: from web-bm.overkiz.com (web-bm.overkiz.com [92.222.103.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D92C8B
	for <connman@lists.linux.dev>; Fri, 22 Oct 2021 15:27:44 +0000 (UTC)
Received: from [10.0.1.160] (unknown [185.81.55.234])
	(Authenticated sender: julien.barrault.external@overkiz.com)
	by web-bm.overkiz.com (Postfix) with ESMTPSA id C84561BF29D;
	Fri, 22 Oct 2021 17:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=overkiz.com;
	s=202003; t=1634916035;
	bh=CBMuchQfku2OBfsklFSlvflhqoqFckNWhVJecb1OMpo=;
	h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
	b=CZdk6TXD/PTsXsa5dQr0RcYDgoOVlu2c3s0gJSv+ic8NACRDOwWIglgaiN4wIL6+P
	 VSnauzNbkGyOQIk5wC3JjS6W2qk5uQoQD5wToGGfHQ70SuxV/H0QYC2rVuEwLyFLPU
	 JYwDLoXLX3Zu/CKvH3y0eOJbdmXfdMtefKuUIDeBK6YAgIs5uPDocpQZ3GL9Spr2pU
	 0cADRFWlPahxAksVge2htv5Nrfr9+oCmazFge3KXHBP/WGn69zuw7DSs71uQtT9lpg
	 PhBaWJ0wDMds4nmcuzzz/IPbo/qxTUCCtVC6FSM3tYSqwm1YAuaxX1ji1GazWYi9wo
	 7E2HW15UEVAjQ==
Subject: Re: [PATCH 1/4] tethering: Reduce the number of parameters of
 tech_set_tethering
To: Daniel Wagner <wagi@monom.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, connman@lists.linux.dev
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <65509ce0-a5d9-9161-7454-a93b8147c4ed@overkiz.com>
 <20211015065350.wpf6qqcdfsmvt3q2@beryllium.lan>
Reply-To: 20211015065350.wpf6qqcdfsmvt3q2@beryllium.lan
From: Julien Barrault <julien.barrault.external@overkiz.com>
Message-ID: <aac98118-9caa-25a9-e41d-eac205624cbb@overkiz.com>
Date: Fri, 22 Oct 2021 17:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20211015065350.wpf6qqcdfsmvt3q2@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Bm-Milter-Handled: f125012e-72d2-4729-b87c-a5ab9341072c
X-Bm-Transport-Timestamp: 1634916035897

Hi Daniel,

I am using the version 1.39 on which I applied the patch

> Thanks for testing. Could you retest the current HEAD. I've done some
> stylistic changes, they should not change the patches but who knows :)

I've applied the 4 patches committed on master, but it does not work anymore

There are probably few typos in the patch ("Tethering.Freq" instead of 
"TetheringFreq" in the second patch), but not only (correcting 
Tethering.Freq twice didn't solve the problem)

Unfortunately I didn't have time yet to investigate further, I keep you 
posted if I find what went wrong

Julien

