Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DFA292B59
	for <connman@lists.linux.dev>; Mon, 30 Jun 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299907; cv=none; b=inY3NaPiOEOLQWCUEWk5RFLME6ohnu06MINziCrNJSvQXywOXGGP2/ypgFnb69y1wHVjFAIZaeO4koZACfh2+SOJdtAUMY1ovlr3JSrChE9k8JDB7RrKZZ7MWwiBkAK5oMMSR0PbOvl6pfJZFGlJitQcaxZ1p3ruZPGsrg2cBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299907; c=relaxed/simple;
	bh=o7uRReg6vvjlnhzNSgXCny/Qvzulfgch+jWf+IHai6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIywR19Aysf2rIUjfAuYPOsF5lxT4SpxDGpIsrSDJq3IjX0UqH9IBD2b1iu5t3csER2FNVayTMRgwFeGRFOJOfu71wXekhnX7yqEPxEz/QHBVTFAbhiNOrrzVNPN7rzESSbV2OCv54/6s+YtJn8Pa7Wtqej8heCFk5Oo7H/0U5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYcOCML/; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYcOCML/"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c13802133so712458a34.3
        for <connman@lists.linux.dev>; Mon, 30 Jun 2025 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751299903; x=1751904703; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNTxMSduaKwi7RLDvZmID35bPFY3MPJE0DHUTJ1zOwQ=;
        b=OYcOCML/YRXLhOofGRyTGpNv/rPetl3e4lidSOH6DYmJOCmndneY8oA8BHrqOJrE/D
         6DT7XXFp1qFGa3+7tu+B35wEEst8KTLv1hHRt1NGbKZmeTCxiV1qzr2r2gE5XKD1N03c
         9wCn8pT8IcnRkrMnVPewaV1fR5lhLj9a3i022fr7+SzC9xxplKnMZDdex1cVHOlBegWd
         sdMylflpnk/HiWB0lUnqu4tB6jkLk99tK+Yc7IMh7oexjmKQQ5+MJc33xNDrYkuMTpJr
         E2+AhMHCBa4azIk5yz+pjiOPDuYcFnpyKkrJWHmsDgz+61QuV+VaMVyLyR/844Tvwhvz
         mh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751299903; x=1751904703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNTxMSduaKwi7RLDvZmID35bPFY3MPJE0DHUTJ1zOwQ=;
        b=DXqcyMBbTNVvWUq8guWmHcxA/nbL6igHI0sLQRAIM2cr6byNnAf6l/w45oiQxtbduB
         dKrMLRILU6z848I/84gtx/PkRlYl3Vd9ibTXVd19R266lQ963/MV+SWEbW7I6ojjNIeH
         jO41gkKYNaFWR8KRDKzryew9PqDJzbLAvoP53o3w3xabHJ2+yMgOYbhfq33O81ZgWkCV
         KrLaL16yoI3qnkq2fg4ztEfNf2f7lzENZrJC/M6PXUPcMU7r2jCJKXzJuWkJYowztHLi
         hByFHtnqkEffbmy8ypRLPLZVSU1U/hklXhL2CfPVCflrxFUgXMwvmxECTKnLaM8CH0FZ
         pN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfTh0KyQONhawofHEttxIjwX/h1ugbx+lDJb87PqJE3N8BbmHCHDCHJx/CwXnSFTi+Qrx578Qi@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5EyddXIrcWnne5Gjv7w3CDu9p+Jav1IZxzDbB5UK6J0hHfT3M
	CyokBot8AaFf36BxrlwuhqzpGir4NfnzqxIR4hUjHgr72Z2SLmmgwdni
X-Gm-Gg: ASbGncsatsAF4RvGk8D7L9AmOKOXlzAsL5kUUN5bfPFOe7ZFnbQKyodAOoillx2j0U/
	Z3Tl6HeeQlH1VHpKpI5d9MxYxF9zWFbsK8H9mYcnjANpWyiW8loeB4zxnGxYMRvZy/jOeIjkxX4
	7bbQLEmk32FWWbdZgxI5o1Oo6sI0YaOAw4AKNY9l4rzsrfudQEmesRzik9HgPqHU6uIb0fu5i/T
	cqzTLaQLs5DxJr5yFB0n0+6djzuBesdugSrWeTYhQ0j/PXHAbxlpZ0awpOMhqmJbOs6zRjWwaD4
	iYCYRqaoVd2DMA+K/lQ0NPfFxSs/vaxAss0Y8vRz+5YZkPpXB6LLynG3WwInFnA98WDxQ1k6+kM
	JgcI+sn8xCws5lBSUyXjV+4s8ZOU=
X-Google-Smtp-Source: AGHT+IEIbuaiC8Bud8GkEgiKBauDo6t2slbiBVMRhcccOnD+p9NvkrBxawdW5xgSrjmkrKpPYm6NeA==
X-Received: by 2002:a05:6830:2116:b0:72b:943f:dda8 with SMTP id 46e09a7af769-73afc6d2153mr11317759a34.26.1751299902658;
        Mon, 30 Jun 2025 09:11:42 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-73afb103ff4sm1713029a34.55.2025.06.30.09.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 09:11:42 -0700 (PDT)
Message-ID: <7b9ed62f-d2ae-4e01-ae66-f669285925b7@gmail.com>
Date: Mon, 30 Jun 2025 11:11:40 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Add GetKnownServices api to connaman
To: =?UTF-8?Q?Roman_Smr=C5=BE?= <roman@amarulasolutions.com>,
 connman@lists.linux.dev
Cc: Michael Trimarchi <michael@amarulasolutions.com>
References: <20250626072822.1941-1-roman@amarulasolutions.com>
 <20250626072822.1941-2-roman@amarulasolutions.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250626072822.1941-2-roman@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Roman,

On 6/26/25 2:27 AM, Roman Smrž wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add a way to retrieve all the networks that were configured
> using connman and not all the ones visible

Is this still about removing WiFi credentials?  Have you considered using iwd 
where this would be exceedingly trivial to do?

> ---
>   client/commands.c    | 14 ++++++++++++

Please separate the client part into its own commit

>   doc/manager-api.txt  | 11 +++++++++
>   src/connman.h        |  1 +
>   src/manager.c        | 23 +++++++++++++++++++
>   src/service.c        | 54 ++++++++++++++++++++++++++++++++++++++++++++
>   tools/manager-api.c  | 30 ++++++++++++++++++++++++
>   tools/session-test.h |  1 +

Ditto for 'tools/' bits.

>   7 files changed, 134 insertions(+)
> 

<snip>

> diff --git a/doc/manager-api.txt b/doc/manager-api.txt
> index 6eaa0a38..f36ff813 100644
> --- a/doc/manager-api.txt
> +++ b/doc/manager-api.txt
> @@ -39,6 +39,17 @@ Methods		dict GetProperties()
>   
>   			Possible Errors: [service].Error.InvalidArguments
>   
> +		array{object,dict} GetKnownServices()
> +
> +			Returns a sorted list of tuples with dictionary of service

Sorted how?

> +			properties. Those are all the services, including the ones
> +			that are registered, but not visible or not in use.
> +
> +			This list will not contain sensitive information
> +			like passphrases etc.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +
>   		array{object,dict} GetPeers() [experimental]
>   
>   			Returns a sorted list of tuples with peer object path

<snip>

> diff --git a/src/service.c b/src/service.c
> index f73f42eb..bcda5076 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -5441,6 +5441,60 @@ static void append_struct(gpointer value, gpointer user_data)
>   	append_struct_service(iter, append_dict_properties, service);
>   }
>   
> +void __connman_known_service_list_struct(DBusMessageIter *iter)
> +{
> +	struct connman_service *service;
> +	char **srv_id_parts;
> +	char **services;
> +	unsigned int i;
> +
> +	services = connman_storage_get_services();
> +	if (!services)
> +		return;
> +
> +	for (i = 0; i < g_strv_length(services); i++) {
> +		struct connman_service *srv;
> +
> +		service = connman_service_create();
> +		if (!service) {
> +			connman_error("connman_service_create() allocation failed");
> +			return;

You can't just return here, you're leaking 'services'

> +		}
> +
> +		service->identifier = g_strdup(services[i]);
> +		service->path = g_strdup_printf("%s/service/%s", CONNMAN_PATH,
> +						service->identifier);
> +		srv_id_parts = g_strsplit(services[i], "_", -1);
 > +> +		service->type = __connman_service_string2type(srv_id_parts[0]);

This looks exceedingly horrible.  I don't see an equivalent type classification 
anywhere else.  Is there a way to use the information present in struct 
connman_config_service instead?

> +		if (service->type == CONNMAN_SERVICE_TYPE_WIFI) {
> +			char *id = srv_id_parts[g_strv_length(srv_id_parts) - 1];
> +			service->security = __connman_service_string2security(id);
> +		}
> +
> +		srv = find_service(service->path);
> +		if (srv)
> +			service->state = srv->state;
> +
> +		if (service->type == CONNMAN_SERVICE_TYPE_ETHERNET && srv)
> +			service->name = srv->name;

That looks dangerous since 'name' is dynamically allocated.

> +
> +		if (service_load(service)) {
> +			connman_error("service_load() returned error");
> +			g_free(service);

This looks completely insufficient given what connman_service_create() does.

> +			g_strfreev(srv_id_parts);
> +			g_strfreev(services);
> +			return;
> +		}
> +
> +		append_struct_service(iter, append_dict_properties, service);
> +		g_strfreev(srv_id_parts);
> +		g_free(service);
> +	}
> +
> +	g_strfreev(services);
> +}
> +

Regards,
-Denis
