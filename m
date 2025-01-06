Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7515958A;
	Mon,  6 Jan 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177172; cv=none; b=GH7bjnUg4o01OkY7pb8WgWm9Dsj8z9V0efs2aKe+7aBiwnDCnLeTZGQlNZ8br1hmWUbeNIvl+Wlk8TqbLJdeHmndmwFMUciNijw0wr8DC9VkmsESiMqYJsvp5HJwZ78jmtKyBTLO2w8QMB11lEWoEoMWnjF/eBNHj8xFw2Cil2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177172; c=relaxed/simple;
	bh=KCkkRlVbjVi4Vx9XDK5pTirJMVCASqOtoXMm3a6MOIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i55HO6CJRftu1vibtVnuGzyHBp6z9yDUmHJHH9+YHc3puuXx4/w0osn9DKXe3SygV4eKJBQa1ImQz1grztyrXekO4YTz1KoUxGTFiOAfaJG0/cx5e3SwA1NKVcuq1czhhz029QWfgzCvTOBI3jHxvupsixmCSJG6hEs4loWwgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL8t+ZCI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL8t+ZCI"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba0f09c3aso4865745b6e.1;
        Mon, 06 Jan 2025 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177170; x=1736781970; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vF9TfLGeGkzRHyrFY2OJFn48HlFLx2qhDAYMa9X6qtE=;
        b=KL8t+ZCIbjxcBu9KmXbIJAUeiYRApz8SXbcIzU0PmOD+VySn+qCjyesqlhcV2Q525y
         h1zDrVwOn/BbdKQyKnogz4YSpzbF8B1Pdw87FeRp4dVOQbfnwHNwnYKh3m2W5ySsBJms
         A6rgj+jQ7z64MvarGcS6sqzr3TwepjozfV/tELJH4LrRcpit9mgFiyDVySiz/0uDtalV
         bnRSoWv0Z1GZONROwF4vIRQ6Ie84N4jOGMB3etqBoLJyb/jzKxJhgBveHpmBakByZkEi
         QG8i8s0jxTO/8JFLDvKkVY3qdxM0+fuU+lYgjD3ZyH0/qlzH1DOWYYjv9NEWgKz8zIWM
         phrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177170; x=1736781970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF9TfLGeGkzRHyrFY2OJFn48HlFLx2qhDAYMa9X6qtE=;
        b=PuXFI0X8N4XPwld1rn6FnysqAlnZwLDlEuDOgqezsDN5RdBkGhTL2AsL3Edc9qxmQx
         YbboUsn9IXP/5v6bQi6tbiMxyGOsn3i86oWafQETY/eVQgODljNn1XfQzdZUBYPc4bez
         0xdrO1yVQkZPiBxvpNbj+HrOVUCfTXIbF96mOT4I2b0mPWi21scVPWpDtrZdI9Q9KqZw
         eojB1GyR+lFIlBly4EVGMapXfJf7xpVlorVW+EfTH2gVmL6SVyyza5qA1yUXMDvb3/CQ
         N5MtO+Bn7FUZrEsMBW+MG5LSyWgcdXaZ5c4DgpHWkPkgN6kGN4pz7LuNO3b5C7x+bFhP
         yHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVWRxwvY2hi88bYnVgYekIxr8ylpCMZJj4V40FbdF0iYzzmxwiWXLX7wgp/2omZls8TM6THCk+5nM=@lists.linux.dev, AJvYcCXINXoMbQ/CnoaQIziWKw/MeAzWQKhEB26iURgTwuZHmucg7AFtV+X57JsFhzvxnYP3AbGth8pMLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze5LpNEfNblTb3KfCSEf2p2JNWixHBgITJkC++2vrlBYTD9X9P
	XGDdfsKXdE1J3bO9hcehWq6k/LlnHGQSO6O1fUFas7qF/pzdvs3h
X-Gm-Gg: ASbGncuefl/4BT3KGlG51BCAwPjLmZrDZH4zZhpRH8BobyYcFNmL/e92dLolfSqXdQM
	RN9BaThd+8bGxGZW4Aqz81++rmGtgZauwYoMTCPQZfgauAP+E3hSdJ9T3mMYd3MbtKJA/KyBwL5
	eNfFhiXk1kpieyfjq3D0SIOe4waVRL7sQviJr+TFVu53Yp4JxzqnetAyk75ETbkv/CIhur867aH
	Nzhh3UOQvM0t5aU1TGMq0HVtRWkpbbULcfjBrr4AU4os9/Cr91i5YvfD+QUqCosA7aLqHi0376T
	PyzbJ4LTYcNrpbFyCTyGdw==
X-Google-Smtp-Source: AGHT+IEDsf+Mbmc864QWHbpcygNhlrEJQXEcL036nHAtw3bukK6uUa5WVwWpRd61Ht2ZgWmFa/t3Rg==
X-Received: by 2002:a05:6808:18a0:b0:3e6:1ea5:6b30 with SMTP id 5614622812f47-3ed88fa6f1emr31032951b6e.24.1736177170113;
        Mon, 06 Jan 2025 07:26:10 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3ece25014a7sm9980594b6e.28.2025.01.06.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:26:09 -0800 (PST)
Message-ID: <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
Date: Mon, 6 Jan 2025 09:26:08 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: KeithG <ys3al35l@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: James Prestwood <prestwoj@gmail.com>, connman@lists.linux.dev,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com>
 <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com>
 <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 1/5/25 6:41 PM, KeithG wrote:
> I am looking at the iwmon logs for a successful wpa_supplicant
> connection versus one from IWD. Both connect and both pass data and
> both grab a DHCP address. I do note one difference in the connection,
> though.
> 
> Request : Connect
> through the responses RTNL
> wpa_supplicant knows it is dynamic

wpa_supplicant doesn't manage network interfaces.  I assume you're using ConnMan 
for this? If so, ConnMan sets the IFF_DYNAMIC flag.  See
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/inet.c#n372

> 
> Whereas the iwd log does not:

iwd doesn't use IFF_DYNAMIC in its DHCP implementation at the moment.

According to 'man netdevice':

               IFF_DYNAMIC       The addresses are lost when the interface
                                 goes down.

I doubt this is the cause of your DHCP / connection problems.

Regards,
-Denis
