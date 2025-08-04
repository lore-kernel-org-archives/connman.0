Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2933225408
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335372; cv=none; b=GF4UU59CfmMyYKMUPtj7urEee0+sygZrk0H/n//PwyEkiMHCqNI0C85JOCTYs4YgZ9Z4pK/r6w9Cdq/Lvwv7XClqEY0gZvA7ANx6DxdqST5qzkHngOcwRtOPntI3kqJTH5nUDac2qKK1Dn622on8YXBbbGE18EFIHyTwb7q/+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335372; c=relaxed/simple;
	bh=LWxp8hCSwOI88q7cSKYCeGR8XDYkralndI/7HlpVYwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RSxsA6Oq7Yl19uVy5a0RS2Ku+uPx6eEPn6SUXLEZSrBAEgLV++YrYZRqUbG5OD+jSd083HN5PfbD4VWD0VUOyQgj76btVWprbD3oFotJcVHRn06K3bRw8hBGn+gjRxNNPMqZ6GDL2CZygibiR7BiKun7AO6y8zxcHrWVq9P1MO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut6FJ2Jv; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut6FJ2Jv"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30b6bd0a352so1534985fac.1
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754335370; x=1754940170; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLHIfRkGSmUqnWWWz2itZVwAHK5RJ5bBHJ4cdgExLiA=;
        b=Ut6FJ2JvFSxpkYUzr2sHgE9TNQWOgiJ5iCMVO4mBFrbx8R8qavqFVtYZ6KIcyVi6b3
         ZMiJyXi46F8XAlsFi1wtXoqfKXJ/vVBtQyzgaMZd/1oHluajqsYVA3SrWaTzqHnzKpRX
         m6Vbd+1W6zXbZP4Dai8+vZ/mf2sn1ui4DR9rPRfjMg4kP+l0qY3exMm1FqLVTQhiXXC7
         3GU5eZ9vYlSxepMUMQsnWlYtBGvBrhAlN8Ugm6If/2Pg5xJxk0/P901EGkul2Oscjlkn
         IG9mCHxYI16bxI0tcNiiGXgLLBmQCtd90g5kZgMz5rr5b22Md/9DAfEGMivSOhhsOd4n
         ch4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335370; x=1754940170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLHIfRkGSmUqnWWWz2itZVwAHK5RJ5bBHJ4cdgExLiA=;
        b=E8HsYiKS9RlfclC+H219Yiv8FWheDeqkwru8sIoZi6YDp7NPxxBXIZsThRkDJzr/fJ
         hYatfxAducHZ3Y2VWcKxdAHJqITtVfzXJqLf2R5TtFanwDzahsqqMkYp14t6GKRLWx5i
         IGo6CwoBJlyg9eJCyHxUUXzxHM2Kap4DaMxkB6z5Od9HzYZLuneG1+gEs9DEwBIZq+st
         cZIIjewNLoiw9KXAkAtitbNepELcDRpiylZypMcywmVrjwhQ8HvRqvXjjYgunL5HHO4Z
         F0ssa1E7Sj4zUiHxyJISN8nHhAfmBJgWrY4d9T+u1tGXhsrPUp9xmVEiBWjMSdy5hLzJ
         QqVw==
X-Forwarded-Encrypted: i=1; AJvYcCVc8WCdIjVHR1rusbq/tsXhdbhcTK9qyWGBpXKKmu18Kszplt0/xXCxfl8tyUMnUloeVRuf4hyF@lists.linux.dev
X-Gm-Message-State: AOJu0YwnI/j91YTfv+GiH7Km+5CjGi2kz7Vsm2MguMk4s+Kzrq93bYEl
	Bul5IHjOWCz2jTQOJDUW7WtQ7ByOsJMeV8c2NEGq8Vl11Rd9CChGVHHf
X-Gm-Gg: ASbGncsdbEp8mHXQxHDW4KHygf0K9J8sq4XNRcr6gYZDx24/I87n/UZpU/9mqsUaDVJ
	7OtWStH5RutSVedLBag7xF/dXTKr9EkNfZ60k6uEeKyw6kx7k9ratdz4uHCA/x/THNEybiBdVLX
	0RU4/FYzRMPP+A8FXeIJDr5x/Zaqqin9XzrzYG90r+YVNmnSsH+1xX/puFOCzSyqXG32VpTyn3p
	K58G2QMBfhelWSWZJOjCWiok12Cqz5wM2qHen7AWyxM63sNOEvMw1c5yF06czPKR8yLjtXFMxzZ
	oYnooBExGNQCEe/Q7EFiKF0CcVEtdPLGTvqd8FwE6hUzij4ibOxe9B0Lp03gM8vcgyKs8+8IQ3f
	eTNZCZnuaAEWVu/JTrkrnrg6EnL8HXzwRK6+KJygU8i4tgm5WRPP2ANi9eOjs0V2b7Idy5D/w7f
	ZHJwd6WiMH9w==
X-Google-Smtp-Source: AGHT+IGOA6hluswZsVOj8ESa0rmTnYZwyCIC52oI4s39f4oywkUForZna/UPqWaMlhLvngRQBxvadQ==
X-Received: by 2002:a05:6870:d68d:b0:2d5:4f4:e24d with SMTP id 586e51a60fabf-30b676a10f3mr5615868fac.6.1754335369913;
        Mon, 04 Aug 2025 12:22:49 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7418bee2201sm2179689a34.18.2025.08.04.12.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 12:22:49 -0700 (PDT)
Message-ID: <bbc08b0d-2e1a-4c45-9501-60b08211d029@gmail.com>
Date: Mon, 4 Aug 2025 14:22:48 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix comparison of services of same preferred type
To: Johannes Emerich <johannes@dividat.com>, connman@lists.linux.dev
References: <20250801110412.203290-1-johannes@dividat.com>
 <20250801110412.203290-2-johannes@dividat.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250801110412.203290-2-johannes@dividat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 8/1/25 6:02 AM, Johannes Emerich wrote:
> The service_compare_preferred() function is called twice in
> service_compare(), once with a guard to only use it on services with
> differing types, but once without any such guard. In the latter case,
> when comparing two services of the same preferred technology, it always
> returns -1 because it checks service_a first and exits immediately, when
> one would normally expect that comparison to result in a tie (return
> value 0).
> 
> This causes the parent service_compare() function to terminate its
> comparison early instead of applying appropriate tie-breakers like
> online status, Strength or Name. The result is an unstable sort order
> that depends on the initial order of services.
> 
> This patch adds a condition to service_compare_preferred() so that
> the preference logic is only applied to services of different types,
> without relying on calling contexts to make such checks.
> 
> I ran into this issue when reading sources to understand how ConnMan
> would sort two connected Ethernet services, when one is 'online' and one
> is 'ready' and 'ethernet' is in the preferred technologies list. It
> seems that their online state would in fact not matter at all, instead
> the service that happened to appear first in the list would win.
> 
> The issue may have been introduced in
> 31d9ce64a06743cc69b92c47a36e5ace0f9cb030, when
> service_compare_preferred() was extracted from its original context in
> which the comparison was only applied to services of unequal types.
> 
> Signed-off-by: Johannes Emerich <johannes@dividat.com>

No Signed-off-by tags used by ConnMan.

I went ahead and applied this with a slight tweak to commit header / description.

Regards,
-Denis

