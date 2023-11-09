Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685545257
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 03:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3kbYRJ2"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f03db0a410so216359fac.1
        for <connman@lists.linux.dev>; Wed, 08 Nov 2023 19:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699499675; x=1700104475; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KplTtPKn5zllPm6uMSqXcX+XtTnbnE6D4uOppxBkdBQ=;
        b=N3kbYRJ2vUU1fV8DlBN5XNmlfPDmt3IV8bcuVd9FpuXDXXjzyGv1HmhFpGqD51Xn4o
         mVusesa2Zs2K5Nz2XGA0FphL5Uu6OxDeAn6fkCD9gUHz+dbrzxWFTLJLYME6dkwpI879
         2kTz0iIjvQkPACj7wY4UgRL5PviAVZaeqzc/KawqndyoHCBldT59mA7edRIfSak1h2ZV
         TNd9lC0o0zhsusHqGKe4O9TZTnwZWHyKER+hB4D6HzTtee9NYo55HNphovQxSjIgyJSp
         QOnQrMF60UqOZ6p0NbElTi7yMESkpmrxlglkQH3qoUJ03aV80a8NvMWfSwfacj1UZkix
         EFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699499675; x=1700104475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KplTtPKn5zllPm6uMSqXcX+XtTnbnE6D4uOppxBkdBQ=;
        b=ix5rgAM3LgRcorq+b1TadZbAxe0MF3c98/0HjM+8IdU6rGpPxXkmm/aIugVIdDHtwd
         4AgUjUZ6LvdzObphDX1qYW9uByRcpne1tAJAyqhFxS27uit45MtMU70IVSirsAXY6Gfp
         qSZX63hBg3k7+XhDqV1rLkzobGNk42Kf++VrqjcgSk10ebM/9pHPM2d5HR8kYBuzQ8/F
         tsvI6ROV6Su5eAs0VtNpDLMHlkIlewDMX2j5uiA9LbdvoZCmqPVM0MulnQZHegkNqDiO
         MWisT4/M5XPQUBPGSMF3Q6MSQG44QlPdm42y8Z8TpCB8U+6SQY0+cp99yNc2s6aTROnZ
         zfBw==
X-Gm-Message-State: AOJu0YwSmjh+z1vQb0DJ7UZ61xwX13AkwregMM52rKv2Towa+m7NDZPT
	uu3cKiJxX5DI0yjl9IH7dZP8Pqccr9s=
X-Google-Smtp-Source: AGHT+IHlYk3z0ktTAIHF53WfhKsHWJVrYNboDmn05wRxx+8CiYkqId1gFTTt59/cXxpdzvwXpBe/2Q==
X-Received: by 2002:a05:6870:80d1:b0:1ef:b109:b8ca with SMTP id r17-20020a05687080d100b001efb109b8camr4112137oab.34.1699499675315;
        Wed, 08 Nov 2023 19:14:35 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a2-20020a9d3e02000000b006ce2db9e6c4sm2158655otd.36.2023.11.08.19.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 19:14:34 -0800 (PST)
Message-ID: <04317b94-6243-40c5-a852-01461f803f97@gmail.com>
Date: Wed, 8 Nov 2023 21:14:31 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v4] gweb: Refactor 'parse_request_and_proxy_urls'.
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <F9934E45-7ABB-40D7-9631-9BC6D1406EAC@nuovations.com>
 <B19D916B-9B73-4BBD-8373-971BBC13AE91@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <B19D916B-9B73-4BBD-8373-971BBC13AE91@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 11/8/23 12:36, Grant Erickson wrote:
> Prior to this change, 'parse_request_and_proxy_urls' failed to correctly
> handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:
> 
>      http://[2001:db8:4006:812::200e]:8080/online/status.html
> 
> Such bracketing is necessary when using IPv6 addresses to disambiguate
> the host component from the port component due to the presence of the
> colon (':') in IPv6 addresses. As such, prior to this change, such URLs
> resulted in the brackets and the IPv6 address being passed to gresolv
> which, unsurprisingly, failed to successfully forward resolve since the
> resulting host was neither a valid host name nor a valid IPv6 address.
> 
> As a result, support for such RFC 2732-compliant bracketed IPv6 addresses
> has been added with this change which refactors the previously-monolithic
> 'parse_request_and_proxy_urls' into several, focused functions:
> 
>      * parse_request_and_proxy_urls
>          - parse_request_url
>              o parse_url_components
>                  + parse_url_scheme
>                  + parse_url_host_and_port
>                      * parse_url_host
>                      * parse_url_port
>                  + parse_url_path
>          - parse_proxy_url
> 
> In particular, 'parse_url_host' is the new function responsible for parsing
> the host and correctly handling one of seven possible combinations of host
> and port, two of which include bracketed IPv6  addresses.
> 
> In addition, 'parse_url_host' will now return an error on an empty, non-
> existent host and 'parse_url_port' will return an error on invalid, out-of-
> range ports.
> ---
>   gweb/gweb.c | 455 ++++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 390 insertions(+), 65 deletions(-)
> 

You still have some lines > 80 characters in this patch and patch 3.  Also 
there's a couple of comments which are not tab-indented (in 
parse_request_and_proxy_urls).

Other than that, for all three:

Acked-By: Denis Kenzior <denkenz@gmail.com>

Regards,
-Denis
