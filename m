Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919C28F946
	for <connman@lists.linux.dev>; Tue, 13 May 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145532; cv=none; b=mq+F7Szu8rqMk2sIHwu5vudnkHmrE9hCikk2At1tsYkWtJ4oI06dfU283aHC3n1mERvM7RFVUTGvjm8HvoFplf6qRRZXhg2e0WKBWr7dOJX1vGEjf+CQyvDZ69YrNFtTaoeuVzY67/51+nbByDDRaXXC8dleEGMshwkMGHTJCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145532; c=relaxed/simple;
	bh=DhKXRKWY0quhHIQURPJrOM7qN1GPrByE6hQOTqaedis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmiGO2Onx7C3i/OMcWNKhEK+lnbE1MgSCBzSMT8baFJO/hen+PBLp1WX2iPM3XrlM+OWyukEytcMdYtZCidYypn0RUFnVzlAUR6QxbI9g3Hf8kVET9XV81yDqDhG5SBFbuC13yGireUloQQeXaAsMsw6zn0i9fNfncs5OVFIyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOW1C0yc; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOW1C0yc"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c2504fa876so2300001fac.0
        for <connman@lists.linux.dev>; Tue, 13 May 2025 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747145529; x=1747750329; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jm5sQz37pz6HJVf0ItQneWztR0N2QLlkN+FsvNds+z0=;
        b=LOW1C0yc5pTh/GG2KerVyAp1kszvaYAQAc84WZB7ZdDt/wUewWNUfmfcNzMPJoBiEL
         jIgR+Np2+8pJ4nUPGe/5SVBGi9n8Iu1hJUAoLN65NAQ2F9VZvNHCSlsYMiq623qEnL8o
         sFsNfxEIG6yiLLZomWl1+2QsEBgtm3gwed0os3/OqvcUbIOQGi3FbYLD2OwvOdruOIY6
         HN5g3GDQtLVIuwCDjxP1+kviSD1uI+ZlCtLsUY+b+lIyNDgnieYSxbc99uT439zx2AGT
         nXtZFwTlaTRRaIE/IAANBNyNdB5N0uCsUXySEgrXIPmIx7XnSCXzfdrBFIW4LRvyLq/c
         qAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747145529; x=1747750329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm5sQz37pz6HJVf0ItQneWztR0N2QLlkN+FsvNds+z0=;
        b=i+AwUtJqgrjObnALs9CF/3rTL0jLrQGHfqHf1XVsL2sVblnYRVkpcPk7Ye1G/QFFYt
         GLqQJnVkPo8427Z3Gm4YudoPQcvrYclIGmNOdocAXDGRL1KPeklnOm3GlJwqLDTdrXo7
         5XyPFcUfR7alHP2Mtaob6xrwFOKeYDwDmoZ2pSTbSEwb5Lt0E6bLtTZ+m/9opTZ3J4Qd
         1MCn798rCOpZ7GZTgOyD6qJ6135mGCsLolZ7+QLztcQkoHLA1TS06v6zHJDQGyfts6QD
         GrJ0RNBw6dFh41jDHJ/R5ghGtKfZOW+U8N3xLB0pGb6mZ7Tld0i97dyXJ7T6Vc2mduYj
         usmA==
X-Forwarded-Encrypted: i=1; AJvYcCULyeMf1FpNdqEt2bb+9SUL7sNKIh+OrGejitlCHqwk2vQFoGe9uKtq1uWD9/BXm7UPkMZumTBy@lists.linux.dev
X-Gm-Message-State: AOJu0YzvyngDjNGQZRjYizbJ7/Mq+fUjiB6tWepkNBQ0RBo3mET6cBmt
	TQqXNowXCY7SzJcXwiVrwRAQEvXZtdiom1eZlvfeDY2ccIEhv3dD
X-Gm-Gg: ASbGncv2QfWesaAeMpsX+r63IC9Z/GxRfNrANxj834fDjAK6ec/xwNsUkQ1qguHWMt0
	gWL0zokiLxs3mw5idau3z3hHWu65LXtYv/qY7RGNk/VqNttbnrnSUKz21Mrh5WJuoPYoIxGLAw9
	qlqu8MV7aZ6/0ivOkNQSLyzuQb0J+9VNljsvE1deNciwLSluTR5H8T7nBE3aXwS2JEj9NjKNym7
	c+nscCozM7k49yoAZjERLEEUfugNp0RHDP26X1HXt/0Zh0kNHwVNhLwlPBkZ1f8+/ZXJGk+wAea
	iC+6VabFTOb8aNLWK8WTEpnlmTdlCnJdJWcB6LZdghaAE+GG2SU0c2+YtPm3dWD7v+YKxPUsmR4
	o+hYrnTywHGngYu4YWTHGZrKC9tk=
X-Google-Smtp-Source: AGHT+IHBrTbsngAtf1BQJ9rYDUCe4uKO6ghQ9PZH/ENsBmeWnphBYfH6OsKCeP5EwsXUEwMlYw1iTg==
X-Received: by 2002:a05:6870:8908:b0:2d5:817a:9dfa with SMTP id 586e51a60fabf-2dba453d18cmr9869941fac.38.1747145527269;
        Tue, 13 May 2025 07:12:07 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba061c1d0sm2255571fac.2.2025.05.13.07.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 07:12:06 -0700 (PDT)
Message-ID: <23b09a8a-0397-4479-a5e5-671e1861ea91@gmail.com>
Date: Tue, 13 May 2025 09:12:05 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH] gsupplicant: MFP optional for WPA2-Personal
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Cc: "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>
References: <20250512085223.411606-1-michael@amarulasolutions.com>
 <95264365-13b3-47bf-8443-078aab4082d6@gmail.com>
 <AS4PR10MB5575CAF121D8981792BD1B28F496A@AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <AS4PR10MB5575CAF121D8981792BD1B28F496A@AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sven,

On 5/13/25 6:42 AM, Dembianny Sven (BSH GDE-EDSD7) wrote:
> Hi Denis,
> 
>> -----Ursprüngliche Nachricht-----
>> Von: Denis Kenzior <denkenz@gmail.com>
>> Gesendet: Montag, 12. Mai 2025 21:22
>> An: Michael Trimarchi <michael@amarulasolutions.com>; connman@lists.linux.dev
>> Cc: linux-amarula@amarulasolutions.com; Dembianny Sven (BSH GDE-EDSD7)
>> <sven.dembianny@bshg.com>
>> Betreff: Re: [PATCH] gsupplicant: MFP optional for WPA2-Personal
>>
>> Hi Michael,
>>
>> On 5/12/25 3:52 AM, Michael Trimarchi wrote:
>>> From: "Dembianny, Sven (GDE-EDSD5)" <sven.dembianny@bshg.com>
>>>
>>> Previous MFP support was restricted to WPA3, however it is also
>>> possible to set MFP to mandatory on APs with WPA2.
>>
>> Yes, assuming your device supports it.  But I'm not quite sure how this description corresponds to the
>> actual patch?  It looks like the intent is to always set ieee80211w=1 (MFP Capable set, MFP Required
>> not set) which enables the use of MFP by wpa_supplicant even on WPA2 networks.
>>
> Yes, MFPC hast to be set always also on WPA2 networks in terms of security requirements by WFA, independent from AP configuration.
> See "Wi-Fi CERTIFIED Protected Management Frames Test Plan v1.9.pdf", 3.3.2 "STAUT requirements".

Okay, thanks for confirming that this is indeed about setting MFPC.  When I read 
the original, the verbiage '... set MFP to mandatory ...' made me think that 
MFPR was somehow involved.  Lets make this clearer in the commit description for v2.

>>>
>>> wpa_supplicant config:
>>>
>>> * WPA2-Personal: key_mgmt="WPA-PSK-SHA256" ; iee80211w=1
>>>
>>> It is important that the default value of MFPC bit is 1 on the final-commercial
>>> version of the device. It is a mandatory WFA requirement.
>>
>> Which 'device'?  I think you may be referring to something specific to your use
>> case here.
>>
> See above statement, "device" was referring to any device under test for current WFA certification.

Okay, thanks for that explanation.  Makes sense now.  For the next version's 
commit description, could you make it clearer that you're quoting an external 
document?

Also, have you checked that wpa_supplicant will accept 'ieee80211w=1' for legacy 
devices that do not support MFP at all?

Regards,
-Denis
