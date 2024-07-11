Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184512B171
	for <connman@lists.linux.dev>; Thu, 11 Jul 2024 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729331; cv=none; b=BrX1qCkxRmeLRv/1zhJdekoU1c+9fI5rwaeWI12jp8rsZ/26d+oL4xITsORkSkmrbgodsZCLel5Jo3Tj4hTcyRyXKmqNBkDhv8ctRzLgj6ktChprn+SCXzVufijBn4i/T2XsoYw4o0yskdtKU1pOQvOwffb6CXAO30QrjLQz4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729331; c=relaxed/simple;
	bh=K0qKMB8MObIY6dlYGba7muBGYwODNn/VripdM3JZSrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JzPyl2E+lO5aUoHlBKl/dOjVjlMhviBu5923wFzu8c93yCbHgapZt/5qx8r+xOSiwYwBTxrNSriUbKukTkHRqFhezVJEvhr/e3n0ynOhsLw0zBioA+/PKDTSc9zGHlUIbjUU8GUZPx+HSAkldWbF6FcZDIdRJ3IiP5IQPJjxJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzZDsSed; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzZDsSed"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e31d0a753so693726fac.1
        for <connman@lists.linux.dev>; Thu, 11 Jul 2024 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720729329; x=1721334129; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MujnM3DrG0NNba6uPD5123kdaZtAHHWTT91HZCMBVVU=;
        b=DzZDsSedxZvS/7EXD9dno+LCpp+dxTWpFZZfYOXqUGDWlWzgJ+XkBSrnhyxM4tSESm
         UM6qo8uXJlomXJPFit2FAFLc5B8G4eBy2uVdyl5xSVT/bpjI+qCK/3pbsYvune3lzVKF
         GCns89WUyaPWDeOZmDgXPTlx6Hcdwrp4s/jKkDGGgWd95vXqg/KMSothRR7kLWwW3OIO
         kycSwHL4MyIuo2MXqufCmjAekb2qCSbmn1Dkb9uSLbleUZzGxbEbY9LNSwJeNzxK10V1
         4VREgnaTwuU/gAq159kIvxwKiNYUavqzlMV03/QhbyCD0uL5WmScH9AredPZ9qcPCSac
         JIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720729329; x=1721334129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MujnM3DrG0NNba6uPD5123kdaZtAHHWTT91HZCMBVVU=;
        b=FOO0NAiJkwAEbEMD0iibWt9vsfzcpf/CNLHyom/5lx5kJ4IdMbHbvAwjYuYRmuUZaW
         rooFdKjVdeQ/10hXYRJyGNV8sC8NF63xXhVtc+YnHWclJH1tBWTuP1ywuIxgL5Ja5OVM
         OeuFi7bLSLbB1F1LF7TwebB9/F+IXey5tq0ebPmRzXrpaNVfSCjOia3ROcDWRF0ysbs2
         /t2mOPYH5901JWicZt4XFHJP9SZfzV+98fhRRyIL5muK3/RP5xygfi5+FhutJohDFz9B
         tjWryQGWgXqn5xMKfL9DfrcT02E3UvcSwlKEt+XaP2rE/BGj8QQlQfev39B8Ct84o1xw
         qHAA==
X-Forwarded-Encrypted: i=1; AJvYcCVt+vGmBBLFGm6TeVb3ei3pQs9YgwM/bbFKYkyZmjMs1Nx7KFUkE2hhEKaZaVJDAt/1RUq9+ML4xuBmtyEtG+KMzz6p2J3Snw==
X-Gm-Message-State: AOJu0YxOQSzDSYoD0f7vRtmWDUJtldBU12RUsxFl5EDcmh12mNBUAmr9
	Aj8j4eMDgdd3Mu8lUpHjOjsltuwrY3IczWgp41c1TNytETap3mYqeeIm+g==
X-Google-Smtp-Source: AGHT+IFlb7qR8/0TIY+ELXb1+LCckm5oxaRfOm4ujWmuKjKS5X2onvUAzprCSRxfTNZYgvKqurENIg==
X-Received: by 2002:a05:6870:8194:b0:259:ae64:9234 with SMTP id 586e51a60fabf-25eae7c7203mr8229640fac.13.1720729328889;
        Thu, 11 Jul 2024 13:22:08 -0700 (PDT)
Received: from ?IPV6:2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3? ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-25eaa082ca9sm1817589fac.34.2024.07.11.13.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 13:22:08 -0700 (PDT)
Message-ID: <58c3866d-60f1-47ec-b4c0-89be1c4fd9be@gmail.com>
Date: Thu, 11 Jul 2024 15:22:07 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] manager: add support for changing
 'PreferredTechnologies' over DBus
To: Alexandru Ardelean <alex@shruggie.ro>, connman@lists.linux.dev
References: <20240705040204.58337-1-alex@shruggie.ro>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240705040204.58337-1-alex@shruggie.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

On 7/4/24 11:02 PM, Alexandru Ardelean wrote:
> This change adds support for reading/modifying the 'PreferredTechnologies'
> over DBus.
> This can be extended to 'DefaultAutoConnectTechnologies',
> 'DefaultFavoriteTechnologies' & 'AlwaysConnectedTechnologies' as well.
> However the interest (so far) was in changing the 'PreferredTechnologies'
> order (at runtime) between cellular and wifi.
> Also, 'PreferredTechnologies' was the only that was tested.
> 
> Changing 'PreferredTechnologies' seems to yield the desired result, as the
> switch between cellular/wifi does not need to be super-fast.
> And it changes the routing table (as desired) when cellular is preferred
> over WiFi (and vice-versa).
> 

Can you elaborate?  If setting the property doesn't trigger service re-ordering 
immediately, how does it happen?

> On some boxes that have both cellular & WiFi, it's often desired to prefer
> cellular (over WiFi) in case WiFi is not able to connect to the internet.
> The logic (for this switching) can be determined outside of connman.
> Setting 'PreferredTechnologies' helps in this case.
> ---
> 
> Changelog v1 -> v2:
> * v1: https://lore.kernel.org/connman/20240704204732.56553-1-alex@shruggie.ro/
> * removed 'tools/ip6tables-test'
>    * added to .gitignore via https://lore.kernel.org/connman/20240705035028.57697-1-alex@shruggie.ro/T/#u
> * added a bit of documentation in 'src/main.conf' for the 'PreferredTechnologies'
>    property now also being accessible over DBus
> 
>   doc/connman.conf.5.in |  2 ++
>   doc/manager-api.txt   | 13 +++++++++
>   include/setting.h     |  2 ++
>   src/main.c            | 22 ++++++++++++++
>   src/main.conf         |  4 +++
>   src/manager.c         | 67 +++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 110 insertions(+)
> 

<snip>

> diff --git a/doc/manager-api.txt b/doc/manager-api.txt
> index 6eaa0a38..3be9cffc 100644
> --- a/doc/manager-api.txt
> +++ b/doc/manager-api.txt
> @@ -319,3 +319,16 @@ Properties	string State [readonly]
>   			and does not affect ConnMan in any way.
>   
>   			The default value is false.
> +
> +		array{string} PreferredTechnologies [readwrite] [experminental]

Typo 'experminental'

> +
> +			This property is the same one that is defined in
> +			/etc/connman/main.conf. It controls the order of
> +			preferred technologies (e.g. wifi, cellular) at
> +			runtime.
> +			Changing it here will not have an immediate effect.
> +			It's only when connman gets triggered via service changes
> +			that this gets taken into consideration. Or, when it's
> +			triggered via manual connect/disconnect of services.
> +
> +			The default value is defined in /etc/connman/main.conf.

Have you considered looking into how the Online check is implemented?  Perhaps 
if the interface is not Online, it should not be prioritized ahead of one that is?

> diff --git a/src/main.c b/src/main.c
> index f5da979b..7858b967 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -1122,6 +1122,28 @@ unsigned int *connman_setting_get_uint_list(const char *key)
>   	return NULL;
>   }
>   
> +int connman_setting_set_uint_list(const char *key, const unsigned int *lst,
> +				  int len)
> +{
> +	unsigned int *new_list;
> +
> +	new_list = g_try_new0(unsigned int, len + 1);

General advice is that for small allocations g_try_new0 is not necessary.

> +	if (!new_list)
> +		return -1;
> +
> +	memcpy(new_list, lst, sizeof(unsigned int) * len);
> +
> +	if (g_str_equal(key, CONF_PREFERRED_TECHS)) {
> +		g_free(connman_settings.preferred_techs);
> +		connman_settings.preferred_techs = new_list;
> +		return 0;
> +	}
> +
> +	g_free(new_list);
> +
> +	return -1;
> +}
> +
>   unsigned int connman_timeout_input_request(void)
>   {
>   	return connman_settings.timeout_inputreq;

<snip>

> diff --git a/src/manager.c b/src/manager.c
> index 892d3a42..62f34c50 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -34,6 +34,27 @@
>   static bool connman_state_idle;
>   static dbus_bool_t sessionmode;
>   
> +static const char *tech_property_names[] = {
> +	"PreferredTechnologies",
> +	NULL,
> +};

How would this be extended in the future?


<snip>

> @@ -64,6 +86,13 @@ static DBusMessage *get_properties(DBusConnection *conn,
>   					DBUS_TYPE_BOOLEAN,
>   					&sessionmode);
>   
> +	for (i = 0; tech_property_names[i]; i++) {
> +		const char *name = tech_property_names[i];
> +		unsigned int *lst = connman_setting_get_uint_list(name);
> +		connman_dbus_dict_append_array(&dict, name, DBUS_TYPE_STRING,
> +						append_tech_list, lst);

This logic seems pretty specific to PreferredTechnologies?

> +	}
> +
>   	connman_dbus_dict_close(&array, &dict);
>   
>   	return reply;
> @@ -110,6 +139,44 @@ static DBusMessage *set_property(DBusConnection *conn,
>   
>   		dbus_message_iter_get_basic(&value, &sessionmode);
>   
> +	} else if (g_str_equal(name, "PreferredTechnologies")) {
> +		unsigned int techs[MAX_CONNMAN_SERVICE_TYPES] = {};
> +		DBusMessageIter entry;
> +		int cnt;
> +
> +		if (type != DBUS_TYPE_ARRAY)
> +			return __connman_error_invalid_arguments(msg);
> +
> +		dbus_message_iter_recurse(&value, &entry);
> +
> +		cnt = 0;
> +		while (dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING) {
> +			enum connman_service_type type;
> +			const char *val;
> +			dbus_message_iter_get_basic(&entry, &val);
> +			dbus_message_iter_next(&entry);
> +			int i;
> +
> +			if (!val[0])
> +				continue;
> +
> +			type = __connman_service_string2type(val);
> +			if (type == CONNMAN_SERVICE_TYPE_UNKNOWN)
> +				return __connman_error_invalid_arguments(msg);
> +
> +			if (cnt >= MAX_CONNMAN_SERVICE_TYPES)
> +				return __connman_error_invalid_arguments(msg);
> +
> +			/* check for duplicates */
> +			for (i = 0; i < cnt; i++) {
> +				if (type == techs[i])
> +					return __connman_error_invalid_arguments(msg);
> +			}

There's a few lines > 80 chars.  Have you run this through checkpatch?

> +
> +			techs[cnt++] = type;
> +		}
> +
> +		connman_setting_set_uint_list(name, techs, cnt);
>   	} else
>   		return __connman_error_invalid_property(msg);
>   

Regards,
-Denis
