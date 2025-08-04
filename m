Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877419343B
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318863; cv=none; b=syYjWepGLN7pMmQz30yRHs/HVUxYTzUralayz7QmzoeYzq4bTZrHX6JKgmQcaxC2564dv69IDcUY5ltpBXp1G2axwEjf+y9ZGU3W3L7A6zdGMe7+Xj7fbCR1oDSHNYl77blsTP8wTvtWvc4+BdlIRr6Whq0MCYnTKyxsJ9djJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318863; c=relaxed/simple;
	bh=75kr64T4DZS4QUX5t96tekAef0jW66ExHhpeAAzcSFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hzsa1yByckZGtJtp18BhAkRyDwlemTyhChvG3KMFdWPOkFDuEFV5RrEOo9iV19h7L2pCh3YaQ9EMFyzCD8bqkPY1oqCHN/S5Mtaz6eLX4LAL05p2HmU3RBkLALEEQ7cfgfVZ1CSFIVa1F4AeG03FLLxn2XdqxWRTwek2dqdFTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqnkWb+B; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqnkWb+B"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-306ab1b63fdso2068401fac.1
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318861; x=1754923661; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r714A9saYb6vU+0LjA2j9PfdNM8ytBTvOPPMVhOJMLU=;
        b=gqnkWb+BEkKJurjpiZ81ok6A6HN78caOm28v6j9pI8S5RoPSLG5FrIspDkZfZsOk8f
         QW+OoSBf3w3aJZWQx/nNiCC72wTHKzZIJ8R3h+scGfkisKaW/pNZmtwOpDkLBDyw6SFT
         GlNmer1J8mpn9X+rxh6DZMf/4862cA43zOxXvvIBL+JixYsKnwWnJTxlBBVaHasbeue7
         ETAa4El/qsEp/SBsiguFX+mGcufueHJQeJywuANodjP49q2J9cAK768I0O2RPO33wfsj
         H+Tb7fIPBky9duuXswhBU5zQWUisc4WUXV2/PntaIYKtC2CSjH2te9dq/vz6fuvzokND
         mXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318861; x=1754923661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r714A9saYb6vU+0LjA2j9PfdNM8ytBTvOPPMVhOJMLU=;
        b=wpjUe6Mk8Xugf5gCnu06nTK0bSP+UhOQJtZIN4Moz9X2x8TkDFXv7UsmfgIPK8c7T2
         +WlYjgfHYKkat3vph4BuVAdtdJOdSAuyxpbd2DMg00LLyb8k9exc/gzFK5oZnFMP4+YT
         LWIuXoD66OhCr5L2+4zukw58b3NymIfI4Ls/DY5vgEtZyUWgrf6YJFP7lxp0+xcG3TkX
         QvT/l/7lAquEfzZx51OBcCSrgpAHwWsskCH66x/YEC6cbJi8fdItPdf/Agyvu9FjIYsQ
         dGx8JKQVez9qd0OU4jqyjNR1SDrXApPyBWZmT3eXjG+5VV6cwixc/juNkhTpKckFbKH+
         8NgA==
X-Forwarded-Encrypted: i=1; AJvYcCVqEdT6Aim6ArwGU57l5vrNrtQDnYHT2VSTM4lG8a1FD9mTYB6paiaGCqVt6BWHUkkyW8nri5Wm@lists.linux.dev
X-Gm-Message-State: AOJu0YwHlM7v53Z6oV1UbipqpEsthZxSKtKOJLRyHvqu5mLeIbNMwk+a
	2n5AwyKMUE5okGwuM5/fNmns6wwEvJF4uc/4FKfH4Vz0oQzZhYyXYaLdrtTolQ==
X-Gm-Gg: ASbGnctDr0PO1hoe2+DqltH6/ThEDmKLPO+BXG8vZ//qRgomqaOildZklevksgWNkxZ
	11/6gYrn6yfzXqj7tPW8TlSTPnoPxfoJSplctjoaM4iFVF4ICXkVUzPRUjKw8Nj3OzRbSVFA5E7
	/YnEUmuEP2zRSfy2WB5WgOxE1tx94oIrpA34hekhw3/b04YwOF41FmjRwV4yL8LyoutczzMg3M7
	5yYZ4WiIHsnSCM2Sq4o3Nb3/ujjL2IqdjzSeYHfsKhGVVVIm2P7d+CBtWew35UGFl9U6IBvx1XR
	HqqwwZNu7yBxqcmfipFRPbgVSbdvygydCxODohTzOnHDjkiQwq2o5Xh5fPdayUlrX1s1WNZ9Oum
	YnNSrd7Cd1Wk6py8NI/CvAfMb31H5xtpUgBg5vQFXlfF6AcN58YcZ2BYGyJCxOQCUrC3GW0y/Rk
	g=
X-Google-Smtp-Source: AGHT+IE4YTKGVUOw/kSlnqon1xCv3VD/PbYG9QRoBKnzBAhJq/86idIe6ugqn+ASNpXJsZrfmrW/7A==
X-Received: by 2002:a05:6870:d8d0:b0:2cc:3523:9cd5 with SMTP id 586e51a60fabf-30b67723e3emr5712537fac.17.1754318861123;
        Mon, 04 Aug 2025 07:47:41 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-30b93b644d9sm947791fac.30.2025.08.04.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:47:40 -0700 (PDT)
Message-ID: <94f9fdd1-944c-444c-8b1e-49fb0333c740@gmail.com>
Date: Mon, 4 Aug 2025 09:47:39 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/45] util: Add address family set/get/reset helpers
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-24-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-24-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
> [util] Add address family set/get/reset helpers. JB#62713

I don't know what this is.  Please drop any references to internal tickets when 
submitting and spell out what the commit is trying to do in the commit description.

> 
> Add address family (af) helper functions to be used with a boolean array
> defining which address families a provider has. Supports AF_INET and
> AF_INET6 as set/get parameters. The array must be of AF_ARRAY_LENGTH
> size.

Ugh, seriously?  Maybe:
bool support_ipv6 : 1;
bool support_ipv4 : 1;

?

> ---
>   src/shared/util.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   src/shared/util.h | 11 +++++++++++
>   2 files changed, 51 insertions(+)
> 

Regards,
-Denis
