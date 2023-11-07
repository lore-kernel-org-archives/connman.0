Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C7168BC
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMjgqIBS"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so3572784fac.3
        for <connman@lists.linux.dev>; Tue, 07 Nov 2023 08:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699376236; x=1699981036; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wRQTxxfxLhTWAfmrEr07O3En0il79VuVPlNMF3OTM0=;
        b=lMjgqIBSyos4wfCChoGlyMUFhShWxmNxKWlEMetCg5er/6Fdsc3+sc1KeorNHtscjd
         lHEv00IP4IgSpK5cr8P1EIiH/GCv+COm7Zk6pDHDEgMxlAudcDpCBUZjSLIRA+gg0Imp
         yn0fBPkstQLUG6G/i4nWJrhcnLb1l9lM9e5SaQHZ+fxelwjE9x7CYlBeqcwRHpLhlOlX
         ghpmsNM759rBnbLcVmauTaiSmqI9XTfEbn8OiRA/mDDwc9r5bG7Gg3ehuQ7yrrAVzzM5
         7nPrcAit9bvLHZt71sud16uN6Hpg6vN//xvw1yL6XfM2ViQHepN0utKhbYBUV0+sdlV1
         c7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376236; x=1699981036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wRQTxxfxLhTWAfmrEr07O3En0il79VuVPlNMF3OTM0=;
        b=N29jmlTjyzKv8xE7LeVzoeBrCBcZoRDaDgsz3WqC2o8EXZXfN7IMOxZaKvmovMZ0hj
         z0ZAziVAk7qnizM74ZWpY3V+ymEyyFivI2Sh2aahL4M/vG05kzwxqZRyW5tP0soD3+Qd
         7PuqRUb/LYOIz4gtqlz8sHCaohGAn/LJelShULBlHDdNkX8+k3ULlXfsR3GmIkOc+Gzu
         qFKkG52mAALWIESK+U5d/uuRcFJO5xKgHxRIbwZrYUyUM2U3P3Gm2r39er2Lk4W4RCRv
         +X7GOzrmA5JNIPkVLeAveTub3uyPXwQpMIJgKoAPKCr2bHPXlehN2AhMHt6kOfjrb8bf
         JR4A==
X-Gm-Message-State: AOJu0YxWPg8X89lC9H2MhNjiKLsE73PmOvtpy+Dke82vFySj2ilzuCL8
	7RwVNMcW8ctG/6Z5QeSjuFfiSt2BmwI=
X-Google-Smtp-Source: AGHT+IGpg769sROw4XBdBDxj9tmxPP01Ko1UjNvVQBn3E4QhlZQgASqOhoRvn9X5BvlEHAkKRUDIPw==
X-Received: by 2002:a05:6870:9193:b0:1ef:f14e:6f0a with SMTP id b19-20020a056870919300b001eff14e6f0amr3689017oaf.0.1699376236404;
        Tue, 07 Nov 2023 08:57:16 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s10-20020a056870628a00b001cc9bc7b569sm1814346oan.27.2023.11.07.08.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 08:57:15 -0800 (PST)
Message-ID: <a936fc23-1af2-467b-aeb4-317314370a12@gmail.com>
Date: Tue, 7 Nov 2023 10:57:14 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gweb: Refactor 'parse_request_and_proxy_urls'.
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <321bbd59-0a7b-4624-8e7f-71f94356d14e@gmail.com>
 <FD6AA3D4-E59E-47A4-BEA1-578BC55F30D7@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <FD6AA3D4-E59E-47A4-BEA1-578BC55F30D7@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

>>> +			if (scheme) {
>>> +				*scheme = g_strndup(*cursor, scheme_length);
>>
>> g_strndup does not fail.
> 
> It’s based on malloc and if I run rlimits (such as with monit) or other infrastructure, malloc will fail and consequently, g_strndup will fail, correct?
> 

No.  All glib functions that do not use g_try_ will not fail at runtime. 
Instead they will abort:

https://github.com/GNOME/glib/blob/main/glib/gmem.c#L87

In the case of g_strndup/g_strdup, it uses g_new.

> I struggled with this one. There seems to be countervailing style on this front. In some places, malloc-backed allocators are checking for null and returning -ENOMEM, in other places they are checking and are returning -EINVAL (including the prior implementation of parse_url), and in other places, there are no checks.
> 
> Is there a preferred, go-forward style?
> 

So the guidance in other projects (oFono, iwd, ell, and maybe BlueZ) is to avoid 
using g_try_* for allocations less than 1 page.  Small allocations simply do not 
fail on Linux.

For any functions that use g_new/g_malloc/etc, checking for out-of-memory 
conditions is simply wrong and shouldn't be done.

> 
>>> +	// Since it's the easiest to detect, first rule out an IPv6
>>> +	// address. The only reliably way to do so is to search for the
>>> +	// delimiting '[' and ']'. Searching for ':' may yield one of the
>>> +	// other forms above (for example, (2), (5), or (7).
>>
>> This is not the preferred comment style for a multi-line comment.
> 
> Will update these. Should checkpatch.pl be updated to cover this since it did not flag it?
> 

I'm surprised checkpatch does flag these.  Maybe there's some command line 
option missing?

>>> +	result = (const char *)memchr(*cursor, port_delimiter, remaining_length);
>>> +	if (result) {
>>> +		tmp_port = strtoul(result + port_delimiter_length, &end, 10);
>>> +		if (tmp_port == ULONG_MAX)
>>> +			return -ERANGE;
>>> +		else if (tmp_port < 0 || tmp_port > UINT16_MAX)
>>> +			return -ERANGE;
>>> +		else if (result + 1 == end)
>>> +			return -EINVAL;
>>
>> I wish we could use ell's l_safe_atou here.
> 
> Agreed. In just about every package I’ve ever done, I wrap strto* and family and eliminate the need to callers to handle this sort of detail.
> 
> ELL would be nice to leverage, except that it doesn’t appear to work (compile) with linux-4.9.212 and the glibc-2.28 I need to leverage for the current project.

Hmm, lets fix that.  Can you start a thread on ell mailing list?

>>
>> Why not make a temporary to hold scheme using g_autofree and only assign *scheme on success?
> 
> I’m not previously-familiar with g_autofree and do not note any current uses of it in the code base. Happy to take a look.

Somewhat recent addition.  Also equivalent in ell is _auto_(l_free)

> 
>>> +	// Attempt to handle the host component.
>>> +
>>> +	err = parse_url_host_and_port(url, total_length, &p, host, port);
>>> +	if (err != 0) {
>>> +		if (scheme) {
>>> +			g_free(*scheme);
>>> +			*scheme = NULL;
>>> +		}
>>
>> Removes the need for this ugliness.  Or use a goto.
> 
> My preferred style is single points of return at the end of a function with gotos from non-happy-path exceptions. This seems to be counter to the preferred style across the rest of the code base (though there are some exceptions).
> 
> Happy to revisit and reformat.
> 

Then I think you'll like _auto_ and l_steal_ptr.  But gotos are the preferred 
cleanup mechanism compared to nested ifs and repeated statements.

Regards,
-Denis
