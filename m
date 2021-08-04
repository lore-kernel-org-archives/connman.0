Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069470
	for <connman@lists.linux.dev>; Wed,  4 Aug 2021 21:25:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: adalessandro)
	with ESMTPSA id B0E3E1F43A8D
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [connman v1] wifi: Set ieee80211w as required for
 WPA3-Personal-only mode
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, iwd@lists.01.org, Sven.Dembianny@bshg.com
References: <20210802151006.28183-1-ariel.dalessandro@collabora.com>
 <20210803074104.dawii3v3bknovg2e@beryllium.lan>
Message-ID: <39fccc8f-4f53-ccff-97ba-194258f07923@collabora.com>
Date: Wed, 4 Aug 2021 18:17:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210803074104.dawii3v3bknovg2e@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 8/3/21 4:41 AM, Daniel Wagner wrote:
> Hi Ariel,
> 
> Thanks for tracking this! Just a stupid question:

Thanks for the quick feedback :-) see below.

> 
> On Mon, Aug 02, 2021 at 12:10:06PM -0300, Ariel D'Alessandro wrote:
>> From wpa_supplicant docs [0] section "ieee80211w":
>>
>>   "WPA3-Personal-only mode: ieee80211w=2 and key_mgmt=SAE".
>>
>> This means that the parameter ieee80211w has to be set to 2 (required)
>> if SAE is used. Fix it.
>>
>> [0] https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
>> ---
>>  plugins/wifi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/plugins/wifi.c b/plugins/wifi.c
>> index 578b4be7..02603e85 100644
>> --- a/plugins/wifi.c
>> +++ b/plugins/wifi.c
>> @@ -2174,7 +2174,12 @@ static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
>>  	security = connman_network_get_string(network, "WiFi.Security");
>>  	ssid->security = network_security(security);
>>  	ssid->keymgmt = network_data->keymgmt;
>> -	ssid->ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
>> +	/*
>> +	 * From wpa_supplicant docs:
>> +	 * "WPA3-Personal-only mode: ieee80211w=2 and key_mgmt=SAE".
>> +	 * Set ieee80211w as required, which is sent if SAE key is used.
>> +	 */
>> +	ssid->ieee80211w = G_SUPPLICANT_MFP_REQUIRED;
> 
> Should we check the keymgmt is SAE and only then set the ieee80211w
> value?

Thanks for asking that, two answers:

* `ssid->ieee80211w` only gets sent if key management is SAE, so that'd
be redundant. See this code block [0]. So, there's no real need to check
the keymgmt is SAE here, and `required` could be the default value.

* On the other hand, my concern now is about supporting SAE transition
mode. Let's *drop* this patchset and I'll send an RFC patch implementing
WPA3-Personal transition mode.

Thanks!
Ariel

[0]
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/gsupplicant/supplicant.c#n4908
