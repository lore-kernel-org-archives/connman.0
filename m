Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD41C03
	for <connman@lists.linux.dev>; Tue, 20 Sep 2022 12:08:38 +0000 (UTC)
Received: from [IPV6:2803:9800:98cb:8db7:4252:e928:3623:abff] (unknown [IPv6:2803:9800:98cb:8db7:4252:e928:3623:abff])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: adalessandro)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id ADFFC6601F6E;
	Tue, 20 Sep 2022 13:08:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1663675716;
	bh=F1rAPQXJZU2gJ8IFLP5LR4+1CDmbaWrXW9lKfk/VS9s=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=LJK0/H5h1/1u45RzP1zvU5hAry5K5OuNrmDwU0NSOJga1kApLqj93Iipir1TrE1D6
	 H5O2hX0glZ0Q/eugrRcMjOsUAsdcPrOiyuYapi4sUQ55RdAefxnzkrodDtf7PxnRdR
	 YlmtvBu9B/d502TMLxmsVrHowVz4rF4aGYr+3xOHOJnllY34epj/Ct+O/xdrRGuWay
	 +EAJ2tRzYeqnvvmdbn9Hm57ZwTzARg/l69mBoW21Of2JJ0QROz4+2T2VrLtKyihQfI
	 WwF0LRu5gtY4s4vBnsr3VeNCPB9bR34TsfgyVt4cZT46hfOjBd2G23omDeOP9XY/eK
	 9T+aGnXQnmCYA==
Message-ID: <ee0c2aa7-1d4e-e18c-562c-56bc20744bcf@collabora.com>
Date: Tue, 20 Sep 2022 09:08:29 -0300
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] wifi: Handle invalid-key case on WPA-SAE authentication
 failure
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: connman@lists.linux.dev
Cc: john@metanate.com, wagi@monom.org
References: <20220914184610.258763-1-ariel.dalessandro@collabora.com>
 <20defbe5-b144-ff2b-8bfb-1621368be5d9@collabora.com>
Content-Language: en-US
In-Reply-To: <20defbe5-b144-ff2b-8bfb-1621368be5d9@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+cc Daniel, in case you have any possible feedback :-)

On 9/14/22 15:57, Ariel D'Alessandro wrote:
> Hi all, John,
> 
> This patch is a follow up of my question e-mail with subject "No
> password prompt after wrong entry".
> 
> There's currently a difference on the state transitions between WPA2-PSK
> and WPA3-SAE, which makes the latter not to prompt for a new password
> after an invalid key has been sent and rejected. Note that on the former
> case (WPA2-PSK) that works as expected and the client agent asks for a
> new password if the key was invalid.
> 
> The issue comes from the state transitions on each case.
> 
> For the WPA2-PSK wrong-key case, connman goes through states:
> * G_SUPPLICANT_STATE_AUTHENTICATING
> * G_SUPPLICANT_STATE_4WAY_HANDSHAKE
> * G_SUPPLICANT_STATE_DISCONNECTED
> 
> So, the invalid-key error is handled and reported here:
> 
> https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/wifi.c#n2526
> 
> However, for the WPA3-SAE wrong-key case, connman goes through states:
> * G_SUPPLICANT_STATE_AUTHENTICATING
> * G_SUPPLICANT_STATE_DISCONNECTED
> 
> So, the invalid-key error never gets reported. Instead, connect-failed
> is reported by connman, which makes the client agent never prompt for a
> new password.
> 
> Any feedback is welcome, specially if the proposed solution should be
> implemented in a different way
> 
> Thanks in advance :-)
> Ariel D'Alessandro
> --
> Collabora Ltd.
> https://www.collabora.com/
> 
> On 9/14/22 15:46, Ariel D'Alessandro wrote:
>> On WPA3-SAE authentication, wpa_supplicant goes directly from
>> authenticating to disconnected state if the key was invalid.
>>
>> The above is currently not handled and the `connect-failed` error is
>> reported on such cases. In order to make the client agent prompt for a
>> new password, we need to handle this transition and report the
>> `invalid-key` error.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>  plugins/wifi.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/plugins/wifi.c b/plugins/wifi.c
>> index 2a933708..ed7437f5 100644
>> --- a/plugins/wifi.c
>> +++ b/plugins/wifi.c
>> @@ -2528,6 +2528,25 @@ static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
>>  	return false;
>>  }
>>  
>> +static bool handle_sae_authentication_failure(struct connman_network *network,
>> +					      struct wifi_data *wifi)
>> +{
>> +	struct wifi_network *network_data = connman_network_get_data(network);
>> +
>> +	if (!(network_data->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
>> +		return false;
>> +
>> +	if (wifi->state != G_SUPPLICANT_STATE_AUTHENTICATING)
>> +		return false;
>> +
>> +	if (wifi->connected)
>> +		return false;
>> +
>> +	connman_network_set_error(network, CONNMAN_NETWORK_ERROR_INVALID_KEY);
>> +
>> +	return true;
>> +}
>> +
>>  static void interface_state(GSupplicantInterface *interface)
>>  {
>>  	struct connman_network *network;
>> @@ -2625,6 +2644,13 @@ static void interface_state(GSupplicantInterface *interface)
>>  						network, wifi))
>>  			break;
>>  
>> +		/*
>> +		 * On WPA3-SAE authentication, wpa_supplicant goes directly from
>> +		 * authenticating to disconnected state if the key was invalid.
>> +		 */
>> +		if (handle_sae_authentication_failure(network, wifi))
>> +			break;
>> +
>>  		/* See table 8-36 Reason codes in IEEE Std 802.11 */
>>  		switch (wifi->disconnect_code) {
>>  		case 6: /* Class 2 frame received from nonauthenticated STA */
> 
