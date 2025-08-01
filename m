Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991D28C845
	for <connman@lists.linux.dev>; Fri,  1 Aug 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754077160; cv=none; b=iexgvxAPwUMghAaP09g3Fln6zt0v4YoX396XgXe4hCkG0dE9cOqADNvUKNwuzrys1odW4NJsqzvAkFmL+shyZAiEt8yMPMGHKHVYgsHNUoD8z52GytcAeSUe0ieoDLgFODp8LFZdxc8OdqLwhbfJwFxtRCwLAgYTB8tA5G5nrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754077160; c=relaxed/simple;
	bh=k8nmOa/XW1LkPkSXk72IqotSHeV0z+feimyuccT9/5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kg2O2mSTSZYKx+gn11Hpq34xzjNKObecDCkvvEXRtfrdVg+HqoP1A/yuNmVzYp0kT2oWFHbXCEazRI41joekbRLZlKBmh0ZB8PwPFndmpdaP8WRz7tCUxU9b7+EDdGSzFyhGIkqf7ydI82dPW+cswvlIZmGqIqGax4LhX4aNBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVQ9L/KJ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVQ9L/KJ"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41b309ce7d5so510786b6e.0
        for <connman@lists.linux.dev>; Fri, 01 Aug 2025 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754077158; x=1754681958; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Iaz/3xZAXzcL0TB7LK7DgtaMQr74ewcIroKeIrLGRw=;
        b=SVQ9L/KJOXWBW8hAo08PYCVbn8Rzdk1h/tgT+tVypNom/Qm4f1pCNSijwwcvL9gxQ1
         DAm0TfFnuwOdr8XWEUiwiycM3q9X8njg53p280vIiuuxWA5Lzl+Grleaz8uM8RRBr6kR
         fhiXVWs/EDiSbl+jyQM9BpIsOjZnfSAmWs7ohNhk4LNZYa6xxl8ak3lIx1O/sWxWY9U1
         1b4LSRlAQAl3Ea7+bLaIyUtEpjQd/x8kEa6cbKItucqzSFDGA2wt0M9j3gsbk07QAh5H
         lR5fiYQc7eryRZAeIKilFsKqpzQ/VqmiIjYiU91hb0SeCHKQZ+Jf8aci77g470zNQzTZ
         rakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754077158; x=1754681958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Iaz/3xZAXzcL0TB7LK7DgtaMQr74ewcIroKeIrLGRw=;
        b=Kb8E+By3XXBCYDoZo083scBnDnkqyqVoUQG2L0FJ3Fl9jKfqi8+J3JBLSC1OAH4Bu9
         uzgk2FEXMW/360kIM+KPt01pKOQg4AebCE1UOPc1oaqSTq8UmA0q9JpZj4sqifhSTMSF
         DD1Ir4MGp9nFyatAYXQb4xbG5BtgZdKYkmfpFEJobik8IAqtEeS3G6vxGvSycgtgf5Tb
         haS7+1PHjm4unYMowcK4UQMFqtKZMaP0S/VKZG4lLCabB0QEbs35OikQIEYl+x2dlvlr
         ZQ32Zr1tS1N8X/oge8TMBHbYBOStifKqZDiLBbGNjXe6STCNlJ6ZCdYs1NuNT9WtSo+R
         fp+g==
X-Forwarded-Encrypted: i=1; AJvYcCURkiQsv+TJ+1pnNpNpHBTNgjL47g/Pmy62gJ8rAqtc9IDH8JcE4w9PqpRAeBkqVsGjo4TzqtQ/@lists.linux.dev
X-Gm-Message-State: AOJu0YwHqEBuMFZFJ1mVUR6vWkyEW8Zklr20O5m4I1ML2hdwm2MsSN87
	J2NVtTNWQhmz4RCXGW7aY2FPocp8ApSIbNHsS5svFPyibm6ap1zJZc3U
X-Gm-Gg: ASbGncsVzRC+pEkI5JAdkZIBYBUW4lVvhfNdQRsf3zT5BivMPG3WvMboj77V66LyDSl
	6AzYDgbVt81jxqxb9yzw3gPWmPAYHZWHdR+dMVC6D3J3JmmVRBCY6mrjUh1w3f6u8z+KEZ8c9z/
	WZrVdxhqqWoL3cAiLBMv1vcsMLnkgLWSqpTxtbW8qE+uP6W/SHKQPqJoQq70QYEySN9HG8BOPFZ
	BLv/VD+uAt2bmld/uLIdBhHVnYTxTLYpigFtz032K7yuWfhTJUMnH/9tadHQNl9uNpYMLhiGkwD
	k4+FvJSli2nECSgk5kk4nwBzZaVq6hGEvt5DF+QQ9n2HGoNdr9mwEmqpjTPryNbHkvWUoTmvu9h
	o6ZJ3aNPXeC7a1+0uWW87oQyre42bc7xwlY9WwJUgZMwy51hYEBo95X+nqSrwbXfPFL0ZrhNzHf
	A=
X-Google-Smtp-Source: AGHT+IF7/0nkguCk708UMmmkMIGhtOYclAS/KkEwZK8dQm5McG2rWk1DYRd9KjHR9w92EyMuzjw50Q==
X-Received: by 2002:a05:6808:524a:b0:42a:3636:115d with SMTP id 5614622812f47-433f0368faemr795405b6e.31.1754077157987;
        Fri, 01 Aug 2025 12:39:17 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-61970528732sm674614eaf.13.2025.08.01.12.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 12:39:17 -0700 (PDT)
Message-ID: <4810774e-ef89-4b55-a393-356ea8b78c20@gmail.com>
Date: Fri, 1 Aug 2025 14:39:16 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/45] vpn: Add VPN agent use callback for plugins
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-10-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-10-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
> Add callback that can be used by the VPN plugins to tell the vpn_driver
> whether it uses VPN agent or not. Default to using VPN agent if the
> function is not defined.
> 
> This is done to accommodate the state transition in vpn-provider when
> the VPN does not utilize VPN agent.

What about the case where previous credentials are cached?

> ---
>   vpn/plugins/vpn.c  | 22 ++++++++++++++++++++++
>   vpn/plugins/vpn.h  |  1 +
>   vpn/vpn-provider.h |  1 +
>   3 files changed, 24 insertions(+)
> 

<snip>

> diff --git a/vpn/plugins/vpn.h b/vpn/plugins/vpn.h
> index a8d24fc3..b24cbf9b 100644
> --- a/vpn/plugins/vpn.h
> +++ b/vpn/plugins/vpn.h
> @@ -57,6 +57,7 @@ struct vpn_driver {
>   	int (*route_env_parse) (struct vpn_provider *provider, const char *key,
>   			int *family, unsigned long *idx,
>   			enum vpn_provider_route_type *type);
> +	bool (*uses_vpn_agent) (struct vpn_provider *provider);

The only user of this would seem to be wireguard which blankly returns false. 
Can this be made into a boolean of a set of flags instead?

>   };
>   
>   int vpn_register(const char *name, const struct vpn_driver *driver,

Regards,
-Denis
