Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118411DDC1E
	for <connman@lists.linux.dev>; Wed,  7 May 2025 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594425; cv=none; b=BDqpNvUKCvQHX3Bt/2BpLxs5l+XcT9+eI6evF0KMJ60owa/OlLUfVMykxQ9tLsH7dGXPE1fcG1k957pLIC+5TxX9QMAe8hI0LbDTO0TU3p4T/TvnmOkmc5qmFASkFmXqskALGj21bHrwOpn77aJg0iAYXzQeNYWbc8YItP5vuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594425; c=relaxed/simple;
	bh=O+IdEbU2sowUqCsNr4ImUXJ2W8kYuHr+zGMbMkP+jJE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PibrhIiA3JBLJXWSYOD5HcFtVkwlQCTLEU7368QMWcjfo5nV8MyNaTk0JtTjV3TwBC624jFECBMeiIFss5N++wSg4XEpo/ZjRVTSYDQf2IdWtYUGPJvWtGvvdP3+yxNaTdNbFtXO3weRIMipgWxSYzDSHZ/7vbavEsHaRGQKs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=mds@gmx.at header.b=Nq2Q5Rmc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=mds@gmx.at header.b="Nq2Q5Rmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1746594421; x=1747199221; i=mds@gmx.at;
	bh=O+IdEbU2sowUqCsNr4ImUXJ2W8kYuHr+zGMbMkP+jJE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Reply-To:To:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nq2Q5RmcFxAwuyuZZBQqlWBgt7PK/5+5CHM6qui3PtaV6Xd95eIf6nj5Tl9slFY3
	 PV5MmfzzoV6LKUReqdrowOzRHovEdK9c8OFdFb39skk31Vn77wCOM+tE55LK8GeY4
	 Wn+25tHqK0kPb6xHLGyA1RdYc84lYIU3b94H5b9S1gd48BqTi9dYRxT/Nd35e69P3
	 yaZ2yREbiWfyloyCv3NCxPkJr2BOEGhqZUhIyZW/BM6JfTpsLyGS01uZXMgQKct+k
	 FEoWAviTlUj2+NV14TVaWk9CyQVS5GPXQOIST4DZCYjK2Aesa525AvSHE/t10USl2
	 aidCiDFTR0VU8eWxeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.223] ([185.16.53.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1ujw4Y3tz4-00jkdw for
 <connman@lists.linux.dev>; Wed, 07 May 2025 07:07:01 +0200
Message-ID: <3b289afd-128b-4527-8abe-2488d18358bf@gmx.at>
Date: Wed, 7 May 2025 07:07:00 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: mds@gmx.at
Content-Language: de-AT
To: connman@lists.linux.dev
From: mds@gmx.at
Subject: Please revive the GUI "cmst - Qt GUI for ConnMan."
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:63zbEwT7CmUYeiuSSci/ZMqXo0rNNt0iq3z1/x7hcASrGwEXihr
 gsAQiR2nBRhQJSoGMegCPcBPmo/MzQ2G35gSOyp5jm/7pIqkc61Q5W1cknnbkhfTApZ3DNK
 gxGVc6l9OUaXH+09CeHgCfLYNj5bqUThmocFXDMJwQDvJcsYtVFj6UimdOQZv9C0alio2lw
 6jz5jbJ4FslcB9BTuBdWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T9Vza8X/G/c=;brDwGkU5KZydNLbGG3+vbqGF1WR
 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
 siIh8Sbsc3ZEg=

Hello,

I've always liked ConnMan, it has all the features I need and it's not blo=
ated.
Until recently there was also the actively maintained GUI =E2=80=9Ccmst - =
Qt GUI for ConnMan=E2=80=9D (https://github.com/andrew-bibb/cmst), which d=
id everything I needed and was also not bloated.

Unfortunately the original maintainer suffered a stroke of fate and since =
then =E2=80=9Ccmst=E2=80=9D is no longer really actively maintained.

Since ConnMan lacks a simple GUI, my appeal to the ConnMan community is to=
 continue developing "cmst" as part of ConnMan.


Regards,
Robert
