Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF05C2C9
	for <connman@lists.linux.dev>; Fri,  1 Aug 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076670; cv=none; b=WpydLYu7KGhu9FY9W8fThu+8fRwWS/KGaF8/2lGd7mOH1KEuvg9ufMf77JhWI+uO3q3wnfkvR/gPy0vtejEzlZs0n2C2Cq4WsJAi7etyFsODuvzyBqKnrZEvPd41N8oN374lG+bMAIROavjiUMGPiFYFa7n+CojzYVHBBgRBoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076670; c=relaxed/simple;
	bh=VGPMcaSFJ7yu2RTM9bCQ7AqNXOzLZNrKgEXCfxyPLvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bmi13lxt/oVfDggw5uTWUkFcvKkCc2+W38UsseI9LHqt8MV1Pl5cInCXD4mZ9G+paPpve4wq5zg43XG9KQDje+3+QMGLjNw2ngmn2GryxIbXH1MzRyFHcTqm2yt/9NW184JuH6kj/hv7i1YIgwUWEPjpMQdddz0DfLJN0VxV/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np73+G35; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np73+G35"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2ffa8e58654so1322265fac.3
        for <connman@lists.linux.dev>; Fri, 01 Aug 2025 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754076667; x=1754681467; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQYmeZbBLWjP5+Ml/2ObUBgV2ncr7Iaw1SPDXcZFhU8=;
        b=np73+G35YVgQ77VgAm++5SqKxGqxcqbJo4QmyEdpZiVojfce3B3OLxQpUoBVBWZm+g
         ZqGv9eFKdu/eoFrLAypIOi0T81uZPrrpTKH4YGIdPGoLAVPi2XjyEI4rxAi8FSuHag6L
         sTYzSkRdWUIsrgTEzHaEu64JuJVAeYm2wr8QkFuku6U3csTosfueu662ghvpnRq7jpOJ
         xlGGNXFNJ6NrJKCGBA84a5E+Pq0vPNX3jFWjdkoHBmMa1eaKCmeO4JgpNdCQFlSrRqzq
         DTV/mkCKAIm0erHFDpAbiXxtWTfdqlb38GcUGts3VxXtIwpAPGh7LqyTC1v4c8y/shrf
         T9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076667; x=1754681467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQYmeZbBLWjP5+Ml/2ObUBgV2ncr7Iaw1SPDXcZFhU8=;
        b=crlDHm7kat0oAnI29H+6dK7RwJAS9CJQVzkuOnlcbtGamy7lfDq7GWie5JkBIezRca
         976iIOU1wWXf+Hrly3RmtR7rh/lz9PHXGGxKRDpUjxyY6qhfqJaxCYSXstDK5LpzDZDO
         g/WfXIXjIkpnhqVjIWccvejz/HLkeXady5oBtmzpEBwEps61bTiWtNrtSlvjmjP2HTCU
         XjT35maQKZhlc9W0Kn8/qfBYDCkwJ0QLgRZPLjM+eDdKzNyAIFdJfP/NWoKv3HYfhIKc
         +N86qN/MvkDyq34GlXG0UDFdrAJOU9Y2kwvNv8tyo7vtrOXO4fkeckcuq4vLpVKNVt/0
         662Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyLwTgYOielmD8FRV3ZeZwxKeRvB16WX4FGP0SpWNpvUmqyUw3AfTfVtP0rJ5kOtgtOOf/5rLT@lists.linux.dev
X-Gm-Message-State: AOJu0YxBQsf6cPb7CCcZqeOAhbdglFPxwDOjCzPGkMijVNdTKa3ngsDE
	8BQD1TP859IVWdD6+PlBWMXDvW1n5Q9M1XcE3ND5BD7xaXEz6mq1jspo2sqSPQ==
X-Gm-Gg: ASbGncsDHyipQZ5QOV+WMSm8ExtrBhxtazsJkR2kzhF9ybO9jsqnlYOIwSpvJqhm+CK
	ossCigPrK5i0kBfywIajgObz/eSlI/BYYbto+4aPxce74X9egzh8yaFNLtz6ar33ObpMcDFmBA6
	WIdQveJc9U8grA+RIGImhENXA2IKQuBs4lq6VrvTB4n7q8Jk41vJBb5+vPFlIKlzr618dnKsTSZ
	ZVKl9Zj4h0hzaZv1dwvoT9dMvDMZGVkIEF0Im/IykrR0lWfDgUw027lywqlQp9C1ntgOl0tRC60
	DIa4QTqR97bYNMpN9kkSuT9ZlbG9v/8CrdxF6aFgdk6XAHBbX4JSkoxZJGNCLd3bqPNfeplQhSy
	bn0Xsf4wcAaor+c7SaZwmRZ7KYli/VRyfy1DzbZPyzZJjsNtdMMjsyjzQW+vC9jPN/uDnkyGgX/
	U=
X-Google-Smtp-Source: AGHT+IEI69hHXAPAbDAJxIBY0+QuXi2WF8BPknqmfLH91w0tRPk3wo6P+Hl/kuAh5fjzTPEb3SUwfA==
X-Received: by 2002:a05:6870:208:b0:2ff:9fee:b341 with SMTP id 586e51a60fabf-30b67970f7bmr484452fac.25.1754076667426;
        Fri, 01 Aug 2025 12:31:07 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-307a71200b4sm1074148fac.7.2025.08.01.12.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 12:31:06 -0700 (PDT)
Message-ID: <06df3300-c462-4294-85f6-b90315ef012b@gmail.com>
Date: Fri, 1 Aug 2025 14:31:05 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/45] service: Explicit VPN connect timeout, ignore in
 VPN agent wait
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-6-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-6-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:26 AM, Jussi Laakkonen wrote:
> Ignore the connect timeout autostarting when connecting a VPN service
> because initially the VPN is in association state in which the VPN is
> waiting for the VPN agent. Separate the starting of connect timeout into
> its own function __connman_service_start_connect_timeout() so provider.c
> can call it when it enters configuration state.
> 
> When a VPN is waiting for user input it should not be affected by
> connect timeout as the connection is not yet attempted. This may happen
> if VPN resumes to association state when requiring the VPN agent for
> other, e.g., encrypted private key input after credential input.
> ---
>   src/connman.h |  2 ++
>   src/service.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/src/connman.h b/src/connman.h
> index 7ebda7af..1a8952e4 100644
> --- a/src/connman.h
> +++ b/src/connman.h
> @@ -788,6 +788,8 @@ int __connman_service_connect(struct connman_service *service,
>   int __connman_service_disconnect(struct connman_service *service);
>   void __connman_service_set_active_session(bool enable, GSList *list);
>   void __connman_service_auto_connect(enum connman_service_connect_reason reason);
> +void __connman_service_start_connect_timeout(struct connman_service *service,
> +				bool restart);
>   bool __connman_service_remove(struct connman_service *service);
>   void __connman_service_set_hidden_data(struct connman_service *service,
>   				gpointer user_data);
> diff --git a/src/service.c b/src/service.c
> index f73f42eb..9fd8fdb1 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -7322,8 +7322,27 @@ static gboolean connect_timeout(gpointer user_data)
>   
>   	if (service->network)
>   		__connman_network_disconnect(service->network);
> -	else if (service->provider)
> +	else if (service->provider) {
> +		/*
> +		 * Remove timeout when the VPN is waiting for user input in
> +		 * association state. By default the VPN agent timeout is
> +		 * 300s whereas default connection timeout is 120s. Provider
> +		 * will start connect timeout for the service when it enters
> +		 * configuration state.
> +		 */
> +		const char *statestr = connman_provider_get_string(
> +					service->provider, "State");
> +		if (!g_strcmp0(statestr, "association")) {
> +			DBG("VPN provider %p is waiting for VPN agent, "
> +						"stop connect timeout",
> +						service->provider);
> +			return G_SOURCE_REMOVE;
> +		}
> +

I'm a bit confused why this entire block is needed?  If the service is a VPN, 
then the timeout isn't even started, and thus connect_timeout() shouldn't even 
be called?

>   		connman_provider_disconnect(service->provider);
> +	}
> +
> +
>   
>   	__connman_stats_service_unregister(service);
>   
> @@ -7351,7 +7370,27 @@ static gboolean connect_timeout(gpointer user_data)
>   				CONNMAN_SERVICE_CONNECT_REASON_USER)
>   		do_auto_connect(service, CONNMAN_SERVICE_CONNECT_REASON_AUTO);
>   
> -	return FALSE;
> +	return G_SOURCE_REMOVE;
> +}
> +
> +void __connman_service_start_connect_timeout(struct connman_service *service,
> +								bool restart)
> +{
> +	DBG("");
> +
> +	if (!service)
> +		return;
> +
> +	if (!restart && service->timeout)
> +		return;
> +
> +	if (restart && service->timeout) {
> +		DBG("cancel running connect timeout");
> +		g_source_remove(service->timeout);
> +	}
> +
> +	service->timeout = g_timeout_add_seconds(CONNECT_TIMEOUT,
> +				connect_timeout, service);
>   }

Given the above, I question the need for this function?

>   
>   static DBusMessage *connect_service(DBusConnection *conn,
> @@ -9975,9 +10014,12 @@ int __connman_service_connect(struct connman_service *service,
>   		return 0;
>   
>   	if (err == -EINPROGRESS) {
> -		if (service->timeout == 0)
> -			service->timeout = g_timeout_add_seconds(
> -				CONNECT_TIMEOUT, connect_timeout, service);
> +		/*
> +		 * VPN will start connect timeout when it enters CONFIGURATION
> +		 * state.
> +		 */
> +		if (service->type != CONNMAN_SERVICE_TYPE_VPN)
> +			__connman_service_start_connect_timeout(service, false);
>   
>   		return -EINPROGRESS;
>   	}

Regards,
-Denis
