Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49452C80
	for <connman@lists.linux.dev>; Fri, 14 Jan 2022 11:17:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4E095CEB8;
	Fri, 14 Jan 2022 12:17:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642159045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2c9ROxelaBzF6th22IP63aPViAl17UWviPblBwoXPUM=;
	b=j+T8jmDDsdETV3yJ/pndObsYGCk6fQyCFIPouXFbLQACYogzqOH+uxE2A70H6kZidPNBjp
	Cy+x5AMPjars6At/OjUWIhfL+t8Qi2QMK1fAikanJ4V3CkY8PG0rbAOqCikcpENECfPMJL
	/wQ74yYweJL5paTC9tavSKNHFZx19Q2p7xkJ69zBf6ay45ZB4Go3qLTrL6moVLF2YSqnKk
	qTRns8UsFxGQN8xO7u4oxARjXxoh5roxCoHoynVRLcwpZDZkIi6NexbKPNimhY7vcrpyW1
	uEx4DIBA2pafYlQaek81HeZPHs9eZ489ombaShG1s85b84VQvAn7PudCdo+U3g==
Message-ID: <03304641-cc5c-4150-277e-3ac77732f9f1@monom.org>
Date: Fri, 14 Jan 2022 12:17:20 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Network with same ssid question
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
References: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
 <55549edc-f52b-0552-2134-d87c6dc71416@monom.org>
 <CAOf5uwkGg_XA2Wc00hKMYAxTVW8QAZfEUT0NcZJbmFR2QnJKBw@mail.gmail.com>
 <CAOf5uw=319J8Dewg8_j575kBsp0pEkh=bpTaS0jiBb5imemNfw@mail.gmail.com>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <CAOf5uw=319J8Dewg8_j575kBsp0pEkh=bpTaS0jiBb5imemNfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On 14.01.22 10:50, Michael Nazzareno Trimarchi wrote:
> suppose you have 3 access point with different signal strength on a
> network, the best will be connman select access point in the area

This selection is done by the wpa_supplicant/iwd, not by ConnMan.

>>> IIRC, ConnMan merges those together and only exposes it one Service.
>>
>> is_duplicated the one that merges them? I think that in scenario when
>> multiple access point
>> are present we should not do it. I have seen that even iwd does not
>> show duplicated. Is that correct?

wpa_supplicant or iwd? I can't remember the wpa_supplicant details here. 
For iwd, all these stuff is done in iwd. Not ConnMan.

HTH,
Daniel
