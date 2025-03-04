Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204924EAB3
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108156; cv=none; b=NOLb0TE/xtgrhksvArENkbXPHtLnEsSnDTdCU+fL6KiecdxMnC4DY6PPATCbvd0eJgASwGg7O86zGQERzehriJzotjjKvq/MCl6TCftyC5zq28lS+J5f3xEniZngPrcfC68qpfcdGuuUCPxKLpcNa8ZU87Us8+jA1MmdwXgQyQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108156; c=relaxed/simple;
	bh=z/zUhJg6GTHCsXjwyw17Ak8x4c6WYvmK8xnUAp8K9UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ksU8A5WxT7v4Ag8rVWu6MXGb/J6QTxwAYEidiCRr7HxkkXjPsdvm9eM/O07xzksINR3MZvqw6BdkrL11rGEzaCeX8K+tyIsIHL/LL7JxBfTcNVLgChAznZF6x4MVwxXK/Kkrc0fye02dTJwohISLqTj/Zx86zckOBxMewwPdRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9qeIrrU; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9qeIrrU"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcee9dfcb3so2469208eaf.0
        for <connman@lists.linux.dev>; Tue, 04 Mar 2025 09:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741108154; x=1741712954; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jh5J3dK0o3QwIKuUUBFn9wX0P95t7ho4x9i5PfW/xys=;
        b=f9qeIrrUIfHffJv21CIzHdIvPTocl3xE8MB/ZjN/vHq6nTxCkYI9Coa9e6Euem8SGZ
         Q6Op72rCsnbsG/Xg0OZEzuVIz+Xs9i5EPb3fc2tumNg0MvbuGGfnN/rc87B6o+EilMte
         JUtqfa6OOt7fgl6Dbof3SXLZf4Ecwg7eXsIn3fi1K6AXYxxo/Gi9zB2dWyTWw61I6PK1
         gWs/RfkXhdesqVYZOB8CO/M4IDyfKCOMK9LLXMukK4FQuOVI3aKphuuY61ijaQZwP258
         jw3rrZgScCVvJjeyo8v+Py/lsaK5sbxhcXFIuLCpByL7PYscnQyzBeZLjGBtLcIQEbbL
         75Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108154; x=1741712954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5J3dK0o3QwIKuUUBFn9wX0P95t7ho4x9i5PfW/xys=;
        b=WTlzpzFIVnzEWOGexP0rNgJBWH4nriB7Me2WS2qoZBa3yFjR/tvIMuTa08Ddig/XHw
         XJ8cMl/E4NPT8agy3Rc6SGbgPjyEdWrvIZYiwAmwJDcmmj9dK4Oa3ypEG4BJs6QFYMOY
         8Qww9Vu8/yAyMVQZCTZLP2m6OcLSnHJu1cYOaQ6msbW6juOM30OfNCL4YelRJiy58C5e
         5gjWl9o//1WiJIbK3hfa0DaIIQMjKC/A2iHWhwu1eWWQtIoGdiJ5aTUbUwUCXLfl6o54
         TES1M8ykYJ81+ZAp1+bW0MfzIw/oVVgl642dr8WBcAKZ2S82Lyn46SbELmr8FeCml9Xk
         fp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe7TGZi8p4TwMSf23CyRaRXsTW8Q8uXsVCUwvcpA+g2uUaihSf+O5z2sHWhwdfINHrdDDBqWgh@lists.linux.dev
X-Gm-Message-State: AOJu0YxKSMRLsYJKM0AaQ38wOu87gjcK/MKLBFKv+cUKtI0fdU/5TzrU
	OefecLVjnzcGem02EgFf9iI2wGvckqFs5TgLQkxQSI766hCxwSIP
X-Gm-Gg: ASbGncvWAmwiaH6eo0efXk/mgrWOAxeofuH5ELTC3NMUj417sm2I4tMrZ56asbmMWKN
	fThshm6MNqJHdss+gHn7QvY/aSKZQVmTYC5Q8UmwnNYUHYHJUHztDluQWq2ne/SZgi4EBDI/pN3
	nSORlRgAAMrxdlLIZSulT86WUMPEa/7BhO/ZlXxeBDA6tG5WnpAx2OtGQk2ifyURaEWqxHwI51v
	NGETJGuk9lGRrcekR5P70R6EMOBORZXiM4d9DptgEjfc+POLsW54dS1xtma+S15xng4z2lRNZLT
	zayrPU7FD9hjx4pOeTdsEz4pS1u1nalwUey624P9gwpnGDCt2kObtGrVK+ipgxO27BMy/Zjksfe
	Pk7fst6aYPQ==
X-Google-Smtp-Source: AGHT+IEOk6QEpfrQd3Ydunz2NvOjAqkCFsNNJwxvFHnnXf9cAvAKssW0lbkCj9EDcxyioZ5njaSOEg==
X-Received: by 2002:a05:6820:260d:b0:5fc:e57e:77b8 with SMTP id 006d021491bc7-5feb35cb8e1mr10197380eaf.3.1741108153980;
        Tue, 04 Mar 2025 09:09:13 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5feaad45259sm2088112eaf.38.2025.03.04.09.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:09:13 -0800 (PST)
Message-ID: <f835fe52-3ae5-45ea-afca-f39c02cca08a@gmail.com>
Date: Tue, 4 Mar 2025 11:09:11 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] service: Leverage 'service_set_proxy_method'.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <20250221155653.760046-1-gerickson@nuovations.com>
 <20250221155653.760046-9-gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250221155653.760046-9-gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/21/25 9:56 AM, Grant Erickson wrote:
> Leverage 'service_set_proxy_method' for
> 'connman_service_set_proxy_method', the first of two call sites.

Could this commit description be clearer?  E.g. mention 
connman_service_set_proxy_method() instead of 'first of two call sites'?

> ---
>   src/service.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/src/service.c b/src/service.c
> index e58958635992..5c94c2962de8 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -5617,19 +5617,14 @@ static void service_set_proxy_method(struct connman_service *service,
>   void connman_service_set_proxy_method(struct connman_service *service,
>   					enum connman_service_proxy_method method)
>   {
> -	DBG("service %p (%s) method %d (%s)",
> -		service, connman_service_get_identifier(service),
> -		method, proxymethod2string(method));
> -
> -	if (!service || service->hidden)
> -		return;
> -
> -	service->proxy = method;
> +	const bool donotifier = method != CONNMAN_SERVICE_PROXY_METHOD_AUTO;
> +	void * const context = NULL;

What's the point to this variable?

>   
> -	proxy_changed(service);
> -
> -	if (method != CONNMAN_SERVICE_PROXY_METHOD_AUTO)
> -		__connman_notifier_proxy_changed(service);
> +	service_set_proxy_method(service,
> +		method,
> +		donotifier,
> +		NULL,
> +		context);

Just use NULL here which is clearer?

>   }
>   
>   enum connman_service_proxy_method connman_service_get_proxy_method(

Regards,
-Denis
