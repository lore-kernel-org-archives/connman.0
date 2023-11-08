Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658219440
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIE/vKYJ"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5845a94dae1so497013eaf.0
        for <connman@lists.linux.dev>; Wed, 08 Nov 2023 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699460441; x=1700065241; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHgBm8852Fc0APiPhMjX7K5F6Xeo+lf3ztI/k9D9z74=;
        b=UIE/vKYJB3rEAip1pCpz8AbPE398VZcRiFXypHEJ/G3YO57cmis6qXiAE0xwv7t5Cy
         sNWd34QNkMP/wjJ6WObLchaZ/mrbjc3+z2zMDnP4pK2COhmyq0qVBlCKo5ge7b0S7mc3
         ERcrUsVlG3k1P/Zo1UsRDRKYmRWwelVzQQtU5OqCC0GL8nzAC7JMUGUutkDaQHHoy4h7
         mANzYf/6agwL7vFCL2QMaXFdtaouF5KV8ORGVEB7wuwiLdu6P1ZhyglKbXVhhQtxqNhm
         KMSIa7ZADq7idMTuV3ojIf/JthRLamWF9SX8VEa6SOa+WfmvMtXQnIUjKJNHgRZs0/jz
         RiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699460441; x=1700065241;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHgBm8852Fc0APiPhMjX7K5F6Xeo+lf3ztI/k9D9z74=;
        b=LOx1ub5oRW3pVlh1ZD/CwHRI5NLNWILeOZKfFXbzHDy8jRuLHLt13D5z7FalCOV4mF
         1PPhS25pgZBwhF3LfL1NJmi0xiTNlISlegI2kQ09jy24h+wzF3NgfNuFTANyteCq9A5h
         J//i9aKWtVlO8/ZOvX56HgmXXZYruAmHUeZ6SL8vrirO2GVDklR/+Rtm2rw+AS/X4oX/
         gkksUYn/2IWrSIe9O54MJLwi7MMpSdEwtuCRZogYbevPaA/+PTOQ3UAWqiP3FF2nXoTP
         Tkn3+18othiqUjQgucmxCdRhb6RGD22VnRZtdbkFqvbwLQ6NoKY7v52UohF34/TPGzJM
         AXYg==
X-Gm-Message-State: AOJu0YyrkPjrGyCPDd+qidFvNUEX7BZG215XxJXM0Q1mk7cfvhVCnYac
	KFUYF44UGiAYwnqlWoFwma8MrrK3/3g=
X-Google-Smtp-Source: AGHT+IHQnJOTj1iPRcz+FAJ9d4XrUNl/NqQTrUV9nT+++z/U4cpyR/+InsebJIFSS+WqcyX76kgfxQ==
X-Received: by 2002:a4a:d003:0:b0:581:ecd4:c2bd with SMTP id h3-20020a4ad003000000b00581ecd4c2bdmr1268320oor.4.1699460441101;
        Wed, 08 Nov 2023 08:20:41 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id c11-20020a4aaccb000000b005879d3aa1bfsm1749763oon.5.2023.11.08.08.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 08:20:40 -0800 (PST)
Message-ID: <863b1d50-7001-44ed-b3d2-45bb7ffe29db@gmail.com>
Date: Wed, 8 Nov 2023 10:20:39 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Added support for setting preferred IP for WiFi
 tethering
Content-Language: en-US
To: Miroslav Cuvar <miroslav.cuvar@kistler.com>, connman@lists.linux.dev
References: <20221108071820.14101-1-miroslav.cuvar@kistler.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221108071820.14101-1-miroslav.cuvar@kistler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miroslav,

On 11/8/22 01:18, Miroslav Cuvar wrote:
> Hello,
> 
> This patch is to enable the user to set a preferred IP when enabling WiFi tethering, if the preferred IP is not available, the closest next available IP will be used.
> The preferred IP is set using DBus and it works by explicitly setting the starting block in static uint32_t get_free_block(unsigned int);
> Would a feature like this benefit the connman project?
> 
> Signed-off-by: Miroslav Cuvar <miroslav.cuvar@kistler.com>

No Signed-off-by in connman.

> ---
>   doc/technology-api.txt |  8 ++++++++
>   src/connman.h          |  6 +++++-
>   src/ippool.c           | 19 +++++++++++-------
>   src/peer.c             |  2 +-
>   src/technology.c       | 45 ++++++++++++++++++++++++++++++++++++++++++
>   src/tethering.c        | 11 +++++++++--
>   unit/test-ippool.c     | 20 +++++++++----------
>   7 files changed, 90 insertions(+), 21 deletions(-)
> 
This patch doesn't apply cleanly:

denkenz@archdev connman]$ git am foo.patch
Applying: Added support for setting preferred IP for WiFi tethering
.git/rebase-apply/patch:26: trailing whitespace.
			optional. Default value is 0, which means no preference for IP.
.git/rebase-apply/patch:86: space before tab in indent.
        		block = preferred_ip;
.git/rebase-apply/patch:87: space before tab in indent.
     	else if (last_block)
.git/rebase-apply/patch:225: trailing whitespace.

warning: 4 lines add whitespace errors.

> diff --git a/doc/technology-api.txt b/doc/technology-api.txt
> index cdf30396..4492a7f6 100644
> --- a/doc/technology-api.txt
> +++ b/doc/technology-api.txt
> @@ -107,3 +107,11 @@ Properties	boolean Powered [readwrite]
>   
>   			This property is only valid for the WiFi technology and it's
>   			optional. Default frequency is 2412 Mhz.
> +
> +		int TetheringPreferredIP [readwrite]

Maybe uint is more appropriate?  Network order or host order?  But is this an 
actual IP address?  If so, why is this not a string to be consistent with the 
rest of the ConnMan APIs?

> +
> +			Preferred start IP for WiFi tethering IP pool. If the IP is not
> +			free, closest next free IP will be chosen.
> +
> +			This property is only valid for the WiFi technology and it's
> +			optional. Default value is 0, which means no preference for IP.

As far as I can tell, ConnMan sets up a single tethering subnet.  How do you 
ensure that the preferred IP is only used by WiFi?

<snip>

> @@ -229,6 +239,9 @@ int connman_technology_tethering_notify(struct connman_technology *technology,
>   	if (technology->tethering == enabled)
>   		return -EALREADY;
>   
> +	if (technology->type == CONNMAN_SERVICE_TYPE_WIFI && technology->tethering_preferred_ip != NULL)
> +		__connman_tethering_set_preferred_ip(ntohl(inet_addr(technology->tethering_preferred_ip)));
> +

This method is global? It doesn't distinguish between technologies?

>   	if (enabled) {
>   		err = __connman_tethering_set_enabled();
>   		if (err < 0)

<snip>

> @@ -1011,6 +1032,29 @@ static DBusMessage *set_property(DBusConnection *conn,
>   					DBUS_TYPE_INT32,
>   					&technology->tethering_freq);
>   		}
> +	} else if (g_str_equal(name, "TetheringPreferredIP")) {
> +		const char *str;
> +
> +		dbus_message_iter_get_basic(&value, &str);
> +		if (technology->type != CONNMAN_SERVICE_TYPE_WIFI)
> +			return __connman_error_not_supported(msg);

So it is a string after all, and the documentation is wrong?

> +
> +		uint32_t preferred_ip	= ntohl(inet_addr(str));
> +		if (preferred_ip != 0 && !__connman_ippool_is_private_address(preferred_ip)) {
> +			return __connman_error_invalid_arguments(msg);
> +		}
> +
> +		if (g_strcmp0(technology->tethering_preferred_ip, str) != 0) {
> +			g_free(technology->tethering_preferred_ip);
> +			technology->tethering_preferred_ip = g_strdup(str);
> +			technology_save(technology);
> +
> +			connman_dbus_property_changed_basic(technology->path,
> +				CONNMAN_TECHNOLOGY_INTERFACE,
> +				"TetheringPreferredIP",
> +				DBUS_TYPE_STRING,
> +				&technology->tethering_preferred_ip);
> +		}
>   	} else if (g_str_equal(name, "Powered")) {
>   		dbus_bool_t enable;
>   

<snip>

> diff --git a/src/tethering.c b/src/tethering.c
> index f930a26b..05958ddd 100644
> --- a/src/tethering.c
> +++ b/src/tethering.c
> @@ -63,6 +63,8 @@ static GHashTable *pn_hash;
>   
>   static GHashTable *clients_table;
>   
> +static uint32_t tethering_preferred_ip = 0;
> +

Global variable and not WiFi specific?

> @@ -691,3 +693,8 @@ void __connman_tethering_cleanup(void)
>   
>   	dbus_connection_unref(connection);
>   }
> +
> +void __connman_tethering_set_preferred_ip(uint32_t preferred_ip){
> +    DBG("Setting prefered IP: %d", preferred_ip);
> +    tethering_preferred_ip = preferred_ip;
> +}

Wrong coding style?

Regards,
-Denis
