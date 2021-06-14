Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A182FB8
	for <connman@lists.linux.dev>; Mon, 14 Jun 2021 11:50:24 +0000 (UTC)
Received: from [IPv6:2803:9800:98c0:8379:a5b:d6ff:fec4:f8bf] (unknown [IPv6:2803:9800:98c0:8379:a5b:d6ff:fec4:f8bf])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: adalessandro)
	by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3A0391F425FB;
	Mon, 14 Jun 2021 12:50:14 +0100 (BST)
Subject: Re: [RFC connman v2 1/1] WIP: Add wpa_supplicant WPA3-SAE support
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com,
 andrew.shadura@collabora.co.uk, niraj.g@samsung.com, n.chaprana@samsung.com,
 marcel@holtmann.org
References: <20210527214134.33792-1-ariel.dalessandro@collabora.com>
 <20210527214134.33792-2-ariel.dalessandro@collabora.com>
 <20210614070042.mtst3o4utquyzfkq@beryllium.lan>
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Message-ID: <d7977fbd-3d03-e9d9-8a5e-1222707eb285@collabora.com>
Date: Mon, 14 Jun 2021 08:50:10 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210614070042.mtst3o4utquyzfkq@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 6/14/21 4:00 AM, Daniel Wagner wrote:
> Hi Ariel,
> 
> On Thu, May 27, 2021 at 06:41:34PM -0300, Ariel D'Alessandro wrote:
>> Implement WPA3-SAE authentication on connman side using wpa_supplicant
>> backend.
>>
>> Initially based on Tizen project:
>>
>>   https://review.tizen.org/git/?p=platform/upstream/connman.git
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> 
> We don't do the SOB, so I just dropped.

Ok.

> 
> I applied the patch, there were small style issues which I fixed it
> directly.

Great! Thanks a lot for your help.

> 
> Probably we should update the documentation which wpa_supplicant version
> is needed to support WPA3.

Which doc files should be updated? I can take a look at that and put
some notes together.

Regards,
Ariel
