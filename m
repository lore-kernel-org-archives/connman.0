Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892634C6F02
	for <connman@lists.linux.dev>; Tue, 12 May 2026 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580568; cv=none; b=kWDEC4Kd2xhHvYm/QcyZB6p6TYfjB41RE2IEnZWXKaQeChbigf54YmAwcKxap9O+I98MobyZ6A/cF2VDQTqPNTJfcOhwVZXZ1D0t09+aOjZk0c2w3bSU8+qaocCm6oPJYOlLMZHEU5fKS69x0G3W1BCMYDpm4C1L/zAvRPeAOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580568; c=relaxed/simple;
	bh=GgwBFBPvVBsOafZKfvBDpGaJLL/MSkICR+QgPH2sPvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3Y6EOBlrBV3tQCyNfWQUGXWMbaEw6EfWzB/FD9U5caVxyksTivzblsTdEu5t6fcH4ck5Fq/psBGkXqzVc+vveUDBnRUKsATIQifxTCsAAwjsWicuGt9XKlntxeUhbNSi+Se2004Uo+zT4T28CjHXIeWjkN4Kse5vyK6eFptq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Yr8r4pd8; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Yr8r4pd8"
Received: from [IPV6:2a02:8428:e480:3f01:98de:b597:d87e:64d] (unknown [IPv6:2a02:8428:e480:3f01:98de:b597:d87e:64d])
	(Authenticated sender: fgalea@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 74B0F2003C3;
	Tue, 12 May 2026 12:09:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778580563;
	bh=GgwBFBPvVBsOafZKfvBDpGaJLL/MSkICR+QgPH2sPvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yr8r4pd8FdJ1IleZUh82QaXZ03Yuv/F3fazL5f/mY8S0a4yqa7N3FIA6qU0Fa4Ov3
	 pIRinr5+GUBYcnyPIAPhXblgDqMJyRlEYAVXYOV1qtlcjM82ZpTaPNQx+Ju/DTnRJc
	 7sC7x1dICoDLGLmpXtlLzzXlskoZL+vJx2dnACMz1/SSdsMp11zQCznApcFhCZCbW5
	 AJhYYzRu7//ha+3hKlVoQyIS4xftgYwTEw86tybz69z+mJj49h/gKJuknt5l3393A+
	 mKem7Wi89WMb+xglZATLsbyx+TiG56tUIpkIpv+oT6bs1teC5WVs/1fN8ju2xtBx3j
	 sVcvgKi3qyiPA==
Message-ID: <05f70e9a-2bb1-49be-8da9-bdb1927ba588@free.fr>
Date: Tue, 12 May 2026 12:09:20 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection to a WPA2 Wi-Fi router fails
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Sven Dembianny <sven.dembianny@bshg.com>
Cc: connman@lists.linux.dev, wbx@openadk.org
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
Content-Language: fr
From: =?UTF-8?Q?Fran=C3=A7ois_Galea?= <fgalea@free.fr>
In-Reply-To: <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/05/2026 à 11:32, Michael Nazzareno Trimarchi a écrit :
> 
> I think that change only asks the agent who established the connection
> to try the various method. Is the patch in attach work?
> * sven *: Does it cover your use case too?
> 
> Michael
> 

Thank you for your quick reply.

I applied the patch to the connman git master branch and I can confirm 
it works. Thanks!

François

