Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95090296BD3
	for <connman@lists.linux.dev>; Sat, 21 Mar 2026 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094839; cv=none; b=TTkGl9KXbkmm9gjmkEp+TeRIgDsdAbqT1TIASX/6A7V0nqJGVKWyFDWJghBVOeGOmQ7DoBOZzN+f8g/SI9CZ54QpuOG3WKgPet514TKcUoL8ru25Tejmsx+JqM7imeTkQkiTUovbfygqy/Dk1RJ3Sln8cOr6AewlhyhoqLXOEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094839; c=relaxed/simple;
	bh=3ZaHvZQH2HOEIiWTVuI5UYyo+m8qzc52lG3WgGnJSTI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ki1a9xUkSyDk46+d+WT+fOkDsWj/659HTv6bBP3Ka33k+2hJzMqd++hnaj3z8PE8a29RQsYnmk9PHosmN4orvkqWz9jWkHW9gJLTyAF3FoaqOWKVmpKptLDxWBFc79oN8Nq2Y0HRp1DnL3igerZaF58kStxtlywEHlOggSgp0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=mds@gmx.at header.b=hvyuL0qx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=mds@gmx.at header.b="hvyuL0qx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1774094835; x=1774699635; i=mds@gmx.at;
	bh=3ZaHvZQH2HOEIiWTVuI5UYyo+m8qzc52lG3WgGnJSTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Reply-To:To:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hvyuL0qxjbPN/7Gv9w8rsJElnKRRf95Z9UaJjiCImbirJRy8VAlhIdAPIj0E1ehi
	 uYbpI0PxSBn6HTuUrP3eRBbqthAqpVtey1kPA3l0ZbhLx7pj5lu9RU//CQvmgAxQh
	 olAE7iqQ3G7uxPRH91bbpqE4hCz5IvnjLpKzcRRlMVnawpEJ8bWFi/Vi4y2T6skbM
	 A9gM5TiU1l+1abmj7oytfhb2zVn9Q7eWMvD8GxLefYYsY17cZ2oeSnTAWkE8Ux3YW
	 aYDgO0PDDb0ufozuQ+Auy8uEBY1brF8/avTP2Bpe4Bz+DOuURAHR2QxoPmFaHaiak
	 kxfVs5qGQnmwG4M+yQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1vpg19229E-005hku for
 <connman@lists.linux.dev>; Sat, 21 Mar 2026 13:07:15 +0100
Message-ID: <5b1c4d26-2c60-4a06-86bb-722a943181f1@gmx.at>
Date: Sat, 21 Mar 2026 13:07:15 +0100
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
Subject: ConnMan is missing a proper GUI, please take CMST under your wings
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iXdu8sbu+mZsrWp8srJ6T/lDLTcsZts+hkVZJo0GoPHoLtpOtWR
 /mF39a7v+VQNflnK+ym2YhkgvJUFf4aPjX72SPfNvVBcPghUOzJ+GircKO1JKWCRLlpqlaV
 KcP3RgI3Z37o5KfqSX9mg52aWDlLQl2xgARjfnywloqdZlthLcm2VmUSBbRSK9Ps2nvRGpt
 /0AKyBj0LWnEWvsNpJzQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wEFZ6vDGJ60=;YgUncRyZrwloZuSaDIEPXjvqkNk
 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

Hello,

ConnMan in combination with IWD is an excellent network manager.
However, I don't like configuring everything through the shell, and the other people I want to install ConnMan for can't simply do that.

For this, a simple GUI would be needed, which was previously available in the form of CMST (https://github.com/andrew-bibb/cmst).
CMST was quite simple and clear and offered all the functions that are normally needed.
Unfortunately, the original maintainer suffered a tragic event and was no longer able to continue development.
Meanwhile, the Wi-Fi handling doesn't work properly anymore.

I think it would be great if this GUI were continued within the ConnMan project; I believe it would also contribute to the spread of ConnMan.

Regards,
Robert
