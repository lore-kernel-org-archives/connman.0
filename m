Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F80285C8D
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668655; cv=none; b=VFPsBftt42Q4KgPkqgeCXF+xoiFSm4qkc10j+yFEB7C3TQIMIMwZBRdeieqYsjI6wqgr5b3GJBhxKUytpu33AIXj+Rn+8BASyex3YiWT4xfVBYNoowvu2F96y3v3Uj4XGeUzOEPTMJIpQVf0xsT2njsOPg+KAluQ3ygI3Rx9zVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668655; c=relaxed/simple;
	bh=2i4XoO2CYDHdgeBVkCDQoWf9LNzMGR5TfdZlRGvjIb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e3nHlzGGul3M/TBobwBEoIpvvj9T3/CYgATkrJB0yn7daG4gKdzLQuK9h0i1KZvKyd+vobO5zeM5LmSyoWPhGrIpn2WEFzD3K+G7/H0qfQ39DbnPN8mZF+jlVzTFg4cI9vdhcyIh2bilrEN9XdD8xy8PYSDFG+ituBoewVKTz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afIAA5Ky; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afIAA5Ky"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2eb6c422828so2367980fac.1
        for <connman@lists.linux.dev>; Fri, 08 Aug 2025 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754668652; x=1755273452; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfqolgOrzv4N2yHGhCGyssz87t6uqovDHhFu5Jrc3hE=;
        b=afIAA5Ky9yp9xe1TgIp5veXMTcMxOsOtO+QLM20EPKuYG6yBKf8aQU59iFUeT+SW8z
         qOL87wCkV3gV+9xbAvr3RIe1hin7OmQsxdW3vc35RwhkNDmukSnXqcdO0+tT2xSNqnUE
         7Ambpjz3OYRCZeiuGzbMiJsx+iOHoglVT4TyO2XoolvBkeD5MexnS+FSID8gTzWgMxb4
         1b/GT03YYTAzMuha3pQ9QSTn04ARo3bZnIImwMluYZjrEcHTS+WAHS9q04/NuJAp6/Vj
         QlD1lUZkhBR6pZ8d0uBYtNngzfxlyP7PqISUjYcab+uXdNSXZei/u92Zzuv0KFu1Dqf8
         J6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754668652; x=1755273452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfqolgOrzv4N2yHGhCGyssz87t6uqovDHhFu5Jrc3hE=;
        b=CrGEe8Y0LUEUC97rsbp2O1YYuk2fo8LjVDcI+XAUCIgkZ9XcZHZecFXmdwIu/u/LWv
         goY7Yy15sqbQ7PkcmW23rbg3fYl+qBLt/j/qDJY1gCrOsNEE93LfrK+rh3s/ouuXEblN
         D8vCx1HBmmYy69EBI2S4yU4uDtpEttnPjXM9jv9qxzuHR6X2kGTABB1TJhA107mDVx4w
         vWgO0jkyZQ4EQBmiuBUfQ4m0mtVJ/mTK0IKDu0jxxHJfnd9SoavpNMl/bC0NyWwlemZY
         jUtJGyG96cSCD9wNqfubHtTqffzDhCOFFsjD2rDub7WZE2s6o9yIhLrGKWd3Sk4v9AxZ
         ZSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVABkQM4KWlo+IFBLF4dSBjxELVPnzYQGT2+KJ4PcvTDtXXVq4W/4/KFsGmrv9JXZEWfIERX4oH@lists.linux.dev
X-Gm-Message-State: AOJu0YxLCl0mz8qIWJYWkDqZFP8TGWSvwNwNZraHY+t7MUROXSgJbsAO
	GxOcOaimlNbU1j9mMPdiqW7OB5JRUUfX4LjShNAuaWCBukxXTXSUxe2GFHaFFg==
X-Gm-Gg: ASbGnctpcOVd3u5G22gIUW334beeNKP+8QSnE11XeHnWpiZAGSzrIjEuL9h8CO+DQnW
	HQKCgNBoJaHHAvKAlKw/H9FizwQvbrmBqapOxibr5aHcRz2/vjI5K7gSc9Ln9vmkOnuQehNXUwy
	d3cjO45DlDblDL1zwb5y1nahtstSE8/C4Eq8+abvatCaxXhYHIlPoVvak7ZKwsIoZB0xAvAjty/
	rT9BquQuh6P4D+x5d1sItb9cxJMih4+tosGZqSmnIFxwnElOMZrjzOr5TTgxHlbMH+yLvWKMnfa
	y3LJFC+ieJKklCGgsoctfh54ar5SxXamXgeFYM/PrHPTJ2ddXk73lNRBj1aqQSSMXci4SJBFxSY
	Ur20QcqKiIL5MWLMPq/giYeuYub0z23K7Lm6cr34dT+qAs5xc0HSJnaNYjRtj6v2LxYALRjBGHj
	s=
X-Google-Smtp-Source: AGHT+IH1E2KwYLoXI2kp8l5e1LouGenivDai1Bsj6S6M/KDnmbwbh6gW2qzVKnbDRfZgzcLWQieiVA==
X-Received: by 2002:a05:6871:cc87:b0:2e9:925b:206f with SMTP id 586e51a60fabf-30c005467e1mr4790023fac.17.1754668652649;
        Fri, 08 Aug 2025 08:57:32 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-30c122c342dsm982883fac.34.2025.08.08.08.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 08:57:31 -0700 (PDT)
Message-ID: <67c4b880-4980-4c1d-a67a-a81b9941516c@gmail.com>
Date: Fri, 8 Aug 2025 10:57:30 -0500
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
 <4810774e-ef89-4b55-a393-356ea8b78c20@gmail.com>
 <cd769d53-45c0-4b77-93a4-26afc74d5fa1@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <cd769d53-45c0-4b77-93a4-26afc74d5fa1@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 8/8/25 7:28 AM, Jussi Laakkonen wrote:
> Hi Denis,
> 
> On 8/1/25 22:39, Denis Kenzior wrote:
>> Hi Jussi,
>>
>> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>>> Add callback that can be used by the VPN plugins to tell the vpn_driver
>>> whether it uses VPN agent or not. Default to using VPN agent if the
>>> function is not defined.
>>>
>>> This is done to accommodate the state transition in vpn-provider when
>>> the VPN does not utilize VPN agent.
>>
>> What about the case where previous credentials are cached?
> 
> This does not have anything to do with caching of credentials? It just makes it 
> possible to tell if the plugin uses or does not use agent. If there are issues 
> with caching it should be addressed elsewhere and in separate patch I think. 
> Sorry for not really understanding what you mean now.

So maybe I didn't fully follow the logic, so apologies if that's the case.  By 
my reading we have two possibilities:

1. driver has to ask for credentials.  So when .connect is invoked, core 
automatically puts the state into 'Association' and lets the driver report back 
when the credentials are obtained.
2. driver will never ask for credentials.  Core automatically puts the state 
into 'Association' and then 'Connecting' or whatever.

Are there situations where the driver might cache the credentials and not ask 
for them again on subsequent connects?  The core could then treat this as case 2 
above.

<snip>

>>
>> The only user of this would seem to be wireguard which blankly returns false. 
>> Can this be made into a boolean of a set of flags instead?
> 
> I simply followed the approach that is used by the VPNs in general. Seemed 
> simplest and most readable way to do it.

Hmm, but we already have:

#define VPN_FLAG_NO_TUN     1
#define VPN_FLAG_NO_DAEMON  2

Wouldn't this fit the existing pattern?

Regards,
-Denis
