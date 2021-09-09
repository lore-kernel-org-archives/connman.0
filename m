Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406283FE1
	for <connman@lists.linux.dev>; Thu,  9 Sep 2021 11:18:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: adalessandro)
	with ESMTPSA id BC32A1F41FE2
Subject: Re: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com
References: <20210804212315.265376-1-ariel.dalessandro@collabora.com>
 <20210805060704.maeaww6q75x4obqy@beryllium.lan>
 <d4e6e9ee-0f0b-1fa2-c814-4eebaac304ce@collabora.com>
Message-ID: <9186c76b-f2e7-03ec-55ad-2bc5c3177db2@collabora.com>
Date: Thu, 9 Sep 2021 08:10:10 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d4e6e9ee-0f0b-1fa2-c814-4eebaac304ce@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 8/5/21 8:15 AM, Ariel D'Alessandro wrote:
> Hi Daniel,
> 
> On 8/5/21 3:07 AM, Daniel Wagner wrote:
>> Hi Ariel,
>>
>> On Wed, Aug 04, 2021 at 06:23:14PM -0300, Ariel D'Alessandro wrote:
>>> Hi all, Daniel:
>>>
>>> WPA3 support has been recently added to connman (wpa_supplicant). As
>>> we've been discussing on a previous thread, this only supports
>>> WPA3-Personal-only mode.
>>>
>>> This RFC patchset adds support for WPA3-Personal transition mode, which
>>> supports both WPA2-Personal (PSK) and WPA3-Personal (SAE).
>>>
>>> Based on the AP accepted key management protocols, connman configures
>>> wpa_supplicant as follows:
>>>
>>> * WPA3-Personal-only mode: key_mgmt="SAE" ; ieee80211w=2
>>> * WPA3-Personal transition mode: key_mgmt="SAE WPA-PSK" ; ieee80211w=1
>>>
>>> This patch applies cleanly on top of current master branch (commit
>>> e36a38d8).
>>>
>>> I'd like to hear any thoughts you might have about this.
>>> For reference, see wpa_supplicant configuration [0].
>>
>> This looks good. If no one speaks up I am going to apply it.

Any other feedback on this one? Can we merge it?

Thanks,
Ariel
