Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546F48DC
	for <connman@lists.linux.dev>; Fri, 18 Feb 2022 12:50:43 +0000 (UTC)
Received: from [192.168.0.6] (unknown [62.91.23.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: lusus@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5ACFE838A4
	for <connman@lists.linux.dev>; Fri, 18 Feb 2022 13:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1645188635;
	bh=6Rxq526ZtccCAX6u3Uz+BJi7TSeRLbVM/ffMVS/i09g=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aSkO9yrCKN681dQ0qNJ+OrXEurPx5jozm9tlS/kohPaeHLBw2ITa4VW1KFBw78w/a
	 IMwtpnCjshVxax/q7jjnTZD3wiW+uxsyEalO18F41biKBNy206od1pj8IYeaIvvm/B
	 xodn2gw2V3vzeBekXka7C3pEHnosyFZ2STh/TgsSE6bO3nCQmmc0N32eNWw5VWIBEv
	 yvzXVjo/5ucdO6cuWCuSz5uF4E4o70r+HNMvkpjsbvEOaBd7A+phNCjDdP7SHgwCis
	 rFTwMJxXk5+YomZiikkOQo5ukbY39p6q55ovRfAGsATVtH2gXdocUqcVUC5NGoMAXu
	 bDTHnbk1v3dVQ==
Message-ID: <c383f67f-899e-a3de-a963-0d0cf5d0a9a3@denx.de>
Date: Fri, 18 Feb 2022 13:50:34 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] wifi: Duplicate GSupplicantSSID pointer members
Content-Language: en-US
To: connman@lists.linux.dev
References: <20220211134518.3601268-1-lusus@denx.de>
From: Niel Fourie <lusus@denx.de>
In-Reply-To: <20220211134518.3601268-1-lusus@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean

Hi everyone,

On 11/02/2022 14:45, Niel Fourie wrote:
> In ssid_init(), the pointer members of GSupplicantSSID *ssid was
> initialised to point to members of a connman_network, which get
> freed and replaced, causing ssid's pointers to point to freed heap
> memory. To mitigate this, these members are duplicated and then
> freed and along with ssid when no longer needed.
> 
> Signed-off-by: Niel Fourie <lusus@denx.de>

Perhaps some background about this patch. I got tasked to hunt and fix a 
bug which caused Connman 1.37 to crash when automatically switching 
between APs, where the APs are alternately disabled/powered off to force 
the switch. After backporting all relevant patches, and the problem 
still occuring, I linked Connman against AddressSanitizer, which then 
highlighted the bug addressed in this patch.

The issue still exists in 1.41, but it is significantly more difficult 
to trigger after about 1.39. As this would now be a rather difficult bug 
to find, I decided to contribute the fix anyway.

Here is an excerpt of a failure found with AddressSanitizer:

root@imx8mm:~# connmand -n --debug='*'
connmand[3302]: Connection Manager version 1.41
connmand[3302]: ../connman-1.41/src/dbus.c:__connman_dbus_init()
... <snip> ..
connmand[3302]: ../connman-1.41/plugins/wifi.c:network_added() 
436176656e6574_managed_psk
connmand[3302]: 
../connman-1.41/src/device.c:connman_device_get_network() device 
0xffff8aa00340 identifier 436176656e6574_managed_psk
connmand[3302]: ../connman-1.41/src/network.c:connman_network_set_name() 
network 0xffff8a8064c0 name AP1
connmand[3302]: 
../connman-1.41/src/network.c:connman_network_set_available() network 
0xffff8a8064c0 available 1
=================================================================
==3302==ERROR: AddressSanitizer: heap-use-after-free on address 
0xffff8c21d590 at pc 0xffff913848a8 bp 0xffffff91b1d0 sp 0xffffff91b258
READ of size 7 at 0xffff8c21d590 thread T0
     #0 0xffff913848a4  (/usr/lib/libasan.so.5+0x8d8a4)
     #1 0xaaaaaf1e6d98 in memcpy /usr/include/bits/string_fortified.h:34
     #2 0xaaaaaf1e6d98 in store_network_information 
../connman-1.41/gsupplicant/supplicant.c:441
     #3 0xaaaaaf1e6d98 in interface_add_network_result 
../connman-1.41/gsupplicant/supplicant.c:4505
     #4 0xaaaaaf1eb3f0 in method_call_reply 
../connman-1.41/gsupplicant/dbus.c:475
     #5 0xffff9116cf70  (/usr/lib/libdbus-1.so.3+0x13f70)
     #6 0xffff91170d88 in dbus_connection_dispatch 
(/usr/lib/libdbus-1.so.3+0x17d88)
     #7 0xaaaaaf24b584 in message_dispatch 
../connman-1.41/gdbus/mainloop.c:72
     #8 0xffff9120e700 in g_main_context_dispatch 
(/usr/lib/libglib-2.0.so.0+0x51700)
     #9 0xffff9120eaac  (/usr/lib/libglib-2.0.so.0+0x51aac)
     #10 0xffff9120ee10 in g_main_loop_run 
(/usr/lib/libglib-2.0.so.0+0x51e10)
     #11 0xaaaaaf1cc538 in main ../connman-1.41/src/main.c:972
     #12 0xffff90dce114 in __libc_start_main (/lib/libc.so.6+0x24114)
     #13 0xaaaaaf1cc7d0  (/usr/sbin/connmand+0x1c7d0)

0xffff8c21d590 is located 0 bytes inside of 7-byte region 
[0xffff8c21d590,0xffff8c21d597)
freed by thread T0 here:
     #0 0xffff913e49f8 in __interceptor_free (/usr/lib/libasan.so.5+0xed9f8)
     #1 0xaaaaaf1f9ca8 in connman_network_set_blob 
../connman-1.41/src/network.c:2323
     #2 0xaaaaaf1df620 in network_added ../connman-1.41/plugins/wifi.c:2882
     #3 0xaaaaaf1e166c in callback_network_added 
../connman-1.41/gsupplicant/supplicant.c:582
     #4 0xaaaaaf1e166c in scan_network_update 
../connman-1.41/gsupplicant/supplicant.c:2472
     #5 0xaaaaaf1eb4e8 in supplicant_dbus_array_foreach 
../connman-1.41/gsupplicant/dbus.c:106
     #6 0xaaaaaf1e1b00 in scan_bss_data 
../connman-1.41/gsupplicant/supplicant.c:2481
     #7 0xaaaaaf1eb2a4 in property_get_reply 
../connman-1.41/gsupplicant/dbus.c:273
     #8 0xffff9116cf70  (/usr/lib/libdbus-1.so.3+0x13f70)
     #9 0xffff91170d88 in dbus_connection_dispatch 
(/usr/lib/libdbus-1.so.3+0x17d88)
     #10 0xaaaaaf24b584 in message_dispatch 
../connman-1.41/gdbus/mainloop.c:72
     #11 0xffff9120e700 in g_main_context_dispatch 
(/usr/lib/libglib-2.0.so.0+0x51700)
     #12 0xffff9120eaac  (/usr/lib/libglib-2.0.so.0+0x51aac)
     #13 0xffff9120ee10 in g_main_loop_run 
(/usr/lib/libglib-2.0.so.0+0x51e10)
     #14 0xaaaaaf1cc538 in main ../connman-1.41/src/main.c:972
     #15 0xffff90dce114 in __libc_start_main (/lib/libc.so.6+0x24114)
     #16 0xaaaaaf1cc7d0  (/usr/sbin/connmand+0x1c7d0)

previously allocated by thread T0 here:
     #0 0xffff913e4dc4 in __interceptor_malloc 
(/usr/lib/libasan.so.5+0xeddc4)
     #1 0xaaaaaf1f9cb0 in connman_network_set_blob 
../connman-1.41/src/network.c:2324
     #2 0xaaaaaf1df620 in network_added ../connman-1.41/plugins/wifi.c:2882
     #3 0xaaaaaf1e2eb4 in callback_network_added 
../connman-1.41/gsupplicant/supplicant.c:582
     #4 0xaaaaaf1e2eb4 in add_or_replace_bss_to_network 
../connman-1.41/gsupplicant/supplicant.c:1687
     #5 0xaaaaaf1e4bb4 in interface_bss_added_with_keys 
../connman-1.41/gsupplicant/supplicant.c:2118
     #6 0xaaaaaf1e4bb4 in signal_bss_added 
../connman-1.41/gsupplicant/supplicant.c:2753
     #7 0xaaaaaf1e3af0 in g_supplicant_filter 
../connman-1.41/gsupplicant/supplicant.c:3651
     #8 0xffff91170edc in dbus_connection_dispatch 
(/usr/lib/libdbus-1.so.3+0x17edc)
     #9 0xaaaaaf24b584 in message_dispatch 
../connman-1.41/gdbus/mainloop.c:72
     #10 0xffff9120e700 in g_main_context_dispatch 
(/usr/lib/libglib-2.0.so.0+0x51700)
     #11 0xffff9120eaac  (/usr/lib/libglib-2.0.so.0+0x51aac)
     #12 0xffff9120ee10 in g_main_loop_run 
(/usr/lib/libglib-2.0.so.0+0x51e10)
     #13 0xaaaaaf1cc538 in main ../connman-1.41/src/main.c:972
     #14 0xffff90dce114 in __libc_start_main (/lib/libc.so.6+0x24114)
     #15 0xaaaaaf1cc7d0  (/usr/sbin/connmand+0x1c7d0)

SUMMARY: AddressSanitizer: heap-use-after-free 
(/usr/lib/libasan.so.5+0x8d8a4)
Shadow bytes around the buggy address:
   0x200ff1843a60: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fd
   0x200ff1843a70: fa fa fd fd fa fa fd fa fa fa fd fa fa fa fd fa
   0x200ff1843a80: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
   0x200ff1843a90: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
   0x200ff1843aa0: fa fa fd fa fa fa 00 fa fa fa fd fa fa fa fd fa
=>0x200ff1843ab0: fa fa[fd]fa fa fa fd fa fa fa 04 fa fa fa 00 01
   0x200ff1843ac0: fa fa fd fa fa fa fd fd fa fa fd fa fa fa fd fa
   0x200ff1843ad0: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
   0x200ff1843ae0: fa fa fd fa fa fa fd fd fa fa fd fd fa fa fd fa
   0x200ff1843af0: fa fa fd fd fa fa fd fa fa fa fd fd fa fa fd fa
   0x200ff1843b00: fa fa fd fa fa fa fd fa fa fa fd fd fa fa fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
   Addressable:           00
   Partially addressable: 01 02 03 04 05 06 07
   Heap left redzone:       fa
   Freed heap region:       fd
   Stack left redzone:      f1
   Stack mid redzone:       f2
   Stack right redzone:     f3
   Stack after return:      f5
   Stack use after scope:   f8
   Global redzone:          f9
   Global init order:       f6
   Poisoned by user:        f7
   Container overflow:      fc
   Array cookie:            ac
   Intra object redzone:    bb
   ASan internal:           fe
   Left alloca redzone:     ca
   Right alloca redzone:    cb
   Shadow gap:              cc
==3302==ABORTING

As the backtrace suggests, in this case the SSID gets allocated and 
freed in connman_network_set_blob(), after which a new SSID gets 
allocated again, which then leaves ssid->ssid still pointing to the 
freed SSID.

I have also previously observed similar alloc/free issues happening in 
connman_network_set_string(), but I noticed I do not have a stack trace 
at hand for that happening in 1.41. I am not convinced that they cannot 
occur though.

Where these dangling pointers then gets accessed can happen all over the 
place, which is why it was decided to rather duplicate the blobs/strings 
and to clean them up thoroughly.

If nothing else, I did manage to plug a couple of extra leaked 
GSupplicantSSID *ssid allocations, which were previously missed.

I hope this email could clarify the purpose of this patch somewhat.

Best regards,
Niel Fourie

> ---
>   gsupplicant/supplicant.c | 41 ++++++++++++++++++--
>   plugins/wifi.c           | 80 ++++++++++++++++++++++------------------
>   2 files changed, 82 insertions(+), 39 deletions(-)
> 
> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> index 470d99eb..e140b825 100644
> --- a/gsupplicant/supplicant.c
> +++ b/gsupplicant/supplicant.c
> @@ -810,6 +810,32 @@ static void remove_peer(gpointer data)
>   	g_free(peer);
>   }
>   
> +static void remove_ssid(gpointer data)
> +{
> +	GSupplicantSSID *ssid = data;
> +
> +	if (ssid) {
> +		g_free((void *) ssid->ssid);
> +		g_free((char *) ssid->eap);
> +		g_free((char *) ssid->passphrase);
> +		g_free((char *) ssid->identity);
> +		g_free((char *) ssid->anonymous_identity);
> +		g_free((char *) ssid->ca_cert_path);
> +		g_free((char *) ssid->subject_match);
> +		g_free((char *) ssid->altsubject_match);
> +		g_free((char *) ssid->domain_suffix_match);
> +		g_free((char *) ssid->domain_match);
> +		g_free((char *) ssid->client_cert_path);
> +		g_free((char *) ssid->private_key_path);
> +		g_free((char *) ssid->private_key_passphrase);
> +		g_free((char *) ssid->phase2_auth);
> +		g_free((char *) ssid->pin_wps);
> +		g_free((char *) ssid->bgscan);
> +
> +		g_free(ssid);
> +	}
> +}
> +
>   static void debug_strvalmap(const char *label, struct strvalmap *map,
>   							unsigned int val)
>   {
> @@ -4151,6 +4177,7 @@ done:
>   	if (data->callback)
>   		data->callback(err, NULL, data->user_data);
>   
> +	remove_ssid(data->ssid);
>   	dbus_free(data);
>   }
>   
> @@ -4469,7 +4496,7 @@ static void interface_select_network_result(const char *error,
>   	if (data->callback)
>   		data->callback(err, data->interface, data->user_data);
>   
> -	g_free(data->ssid);
> +	remove_ssid(data->ssid);
>   	dbus_free(data);
>   }
>   
> @@ -4525,7 +4552,7 @@ error:
>   	}
>   
>   	g_free(data->path);
> -	g_free(data->ssid);
> +	remove_ssid(data->ssid);
>   	g_free(data);
>   }
>   
> @@ -5030,7 +5057,7 @@ static void interface_wps_start_result(const char *error,
>   		data->callback(err, data->interface, data->user_data);
>   
>   	g_free(data->path);
> -	g_free(data->ssid);
> +	remove_ssid(data->ssid);
>   	dbus_free(data);
>   }
>   
> @@ -5070,7 +5097,7 @@ static void wps_start(const char *error, DBusMessageIter *iter, void *user_data)
>   	if (error) {
>   		SUPPLICANT_DBG("error: %s", error);
>   		g_free(data->path);
> -		g_free(data->ssid);
> +		remove_ssid(data->ssid);
>   		dbus_free(data);
>   		return;
>   	}
> @@ -5159,6 +5186,7 @@ int g_supplicant_interface_connect(GSupplicantInterface *interface,
>   			 * type is 802.11x).
>   			 */
>   			if (compare_network_parameters(interface, ssid)) {
> +				remove_ssid(ssid);
>   				return -EALREADY;
>   			}
>   
> @@ -5184,6 +5212,7 @@ int g_supplicant_interface_connect(GSupplicantInterface *interface,
>   
>   	if (ret < 0) {
>   		g_free(data->path);
> +		remove_ssid(data->ssid);
>   		dbus_free(data);
>   		return ret;
>   	}
> @@ -5234,6 +5263,7 @@ static void network_remove_result(const char *error,
>   	} else {
>   		if (data->callback)
>   			data->callback(result, data->interface, data->user_data);
> +		remove_ssid(data->ssid);
>   	}
>   	g_free(data->path);
>   	dbus_free(data);
> @@ -5287,6 +5317,7 @@ static void interface_disconnect_result(const char *error,
>   							data->user_data);
>   
>   		g_free(data->path);
> +		remove_ssid(data->ssid);
>   		dbus_free(data);
>   		return;
>   	}
> @@ -5299,10 +5330,12 @@ static void interface_disconnect_result(const char *error,
>   	if (result != -ECONNABORTED) {
>   		if (network_remove(data) < 0) {
>   			g_free(data->path);
> +			remove_ssid(data->ssid);
>   			dbus_free(data);
>   		}
>   	} else {
>   		g_free(data->path);
> +		remove_ssid(data->ssid);
>   		dbus_free(data);
>   	}
>   }
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index e947b169..2a933708 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -2163,21 +2163,29 @@ static GSupplicantSecurity network_security(const char *security)
>   static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
>   {
>   	struct wifi_network *network_data = connman_network_get_data(network);
> +	const char *ssid_blob;
>   	const char *security;
>   
>   	memset(ssid, 0, sizeof(*ssid));
>   	ssid->mode = G_SUPPLICANT_MODE_INFRA;
> -	ssid->ssid = connman_network_get_blob(network, "WiFi.SSID",
> -						&ssid->ssid_len);
> +	ssid->ssid_len = 0;
> +	ssid_blob =
> +		connman_network_get_blob(network, "WiFi.SSID", &ssid->ssid_len);
> +	ssid->ssid = g_try_malloc(ssid->ssid_len);
> +	if (ssid->ssid)
> +		memcpy((void *)ssid->ssid, ssid_blob, ssid->ssid_len);
> +	else
> +		ssid->ssid_len = 0;
> +
>   	ssid->scan_ssid = 1;
>   	security = connman_network_get_string(network, "WiFi.Security");
>   	ssid->security = network_security(security);
>   	ssid->keymgmt = network_data->keymgmt;
>   	ssid->ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
> -	ssid->passphrase = connman_network_get_string(network,
> -						"WiFi.Passphrase");
> +	ssid->passphrase = g_strdup(
> +		connman_network_get_string(network, "WiFi.Passphrase"));
>   
> -	ssid->eap = connman_network_get_string(network, "WiFi.EAP");
> +	ssid->eap = g_strdup(connman_network_get_string(network, "WiFi.EAP"));
>   
>   	/*
>   	 * If our private key password is unset,
> @@ -2186,42 +2194,44 @@ static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
>   	 * cert may have to be provided.
>   	 */
>   	if (!connman_network_get_string(network, "WiFi.PrivateKeyPassphrase"))
> -		connman_network_set_string(network,
> -						"WiFi.PrivateKeyPassphrase",
> -						ssid->passphrase);
> +		connman_network_set_string(network, "WiFi.PrivateKeyPassphrase",
> +					   ssid->passphrase);
>   	/* We must have an identity for both PEAP and TLS */
> -	ssid->identity = connman_network_get_string(network, "WiFi.Identity");
> +	ssid->identity =
> +		g_strdup(connman_network_get_string(network, "WiFi.Identity"));
>   
>   	/* Use agent provided identity as a fallback */
>   	if (!ssid->identity || strlen(ssid->identity) == 0)
> -		ssid->identity = connman_network_get_string(network,
> -							"WiFi.AgentIdentity");
> -
> -	ssid->anonymous_identity = connman_network_get_string(network,
> -						"WiFi.AnonymousIdentity");
> -	ssid->ca_cert_path = connman_network_get_string(network,
> -							"WiFi.CACertFile");
> -	ssid->subject_match = connman_network_get_string(network,
> -							"WiFi.SubjectMatch");
> -	ssid->altsubject_match = connman_network_get_string(network,
> -							"WiFi.AltSubjectMatch");
> -	ssid->domain_suffix_match = connman_network_get_string(network,
> -							"WiFi.DomainSuffixMatch");
> -	ssid->domain_match = connman_network_get_string(network,
> -							"WiFi.DomainMatch");
> -	ssid->client_cert_path = connman_network_get_string(network,
> -							"WiFi.ClientCertFile");
> -	ssid->private_key_path = connman_network_get_string(network,
> -							"WiFi.PrivateKeyFile");
> -	ssid->private_key_passphrase = connman_network_get_string(network,
> -						"WiFi.PrivateKeyPassphrase");
> -	ssid->phase2_auth = connman_network_get_string(network, "WiFi.Phase2");
> +		ssid->identity = g_strdup(connman_network_get_string(
> +			network, "WiFi.AgentIdentity"));
> +
> +	ssid->anonymous_identity = g_strdup(
> +		connman_network_get_string(network, "WiFi.AnonymousIdentity"));
> +	ssid->ca_cert_path = g_strdup(
> +		connman_network_get_string(network, "WiFi.CACertFile"));
> +	ssid->subject_match = g_strdup(
> +		connman_network_get_string(network, "WiFi.SubjectMatch"));
> +	ssid->altsubject_match = g_strdup(
> +		connman_network_get_string(network, "WiFi.AltSubjectMatch"));
> +	ssid->domain_suffix_match = g_strdup(
> +		connman_network_get_string(network, "WiFi.DomainSuffixMatch"));
> +	ssid->domain_match = g_strdup(
> +		connman_network_get_string(network, "WiFi.DomainMatch"));
> +	ssid->client_cert_path = g_strdup(
> +		connman_network_get_string(network, "WiFi.ClientCertFile"));
> +	ssid->private_key_path = g_strdup(
> +		connman_network_get_string(network, "WiFi.PrivateKeyFile"));
> +	ssid->private_key_passphrase = g_strdup(connman_network_get_string(
> +		network, "WiFi.PrivateKeyPassphrase"));
> +	ssid->phase2_auth =
> +		g_strdup(connman_network_get_string(network, "WiFi.Phase2"));
>   
>   	ssid->use_wps = connman_network_get_bool(network, "WiFi.UseWPS");
> -	ssid->pin_wps = connman_network_get_string(network, "WiFi.PinWPS");
> +	ssid->pin_wps =
> +		g_strdup(connman_network_get_string(network, "WiFi.PinWPS"));
>   
>   	if (connman_setting_get_bool("BackgroundScanning"))
> -		ssid->bgscan = BGSCAN_DEFAULT;
> +		ssid->bgscan = g_strdup(BGSCAN_DEFAULT);
>   }
>   
>   static int network_connect(struct connman_network *network)
> @@ -2246,12 +2256,12 @@ static int network_connect(struct connman_network *network)
>   
>   	interface = wifi->interface;
>   
> -	ssid_init(ssid, network);
> -
>   	if (wifi->disconnecting) {
>   		wifi->pending_network = network;
>   		g_free(ssid);
>   	} else {
> +		ssid_init(ssid, network);
> +
>   		wifi->network = connman_network_ref(network);
>   		wifi->retries = 0;
>   

Niel Fourie

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-21 Fax: +49-8142-66989-80  Email: lusus@denx.de
