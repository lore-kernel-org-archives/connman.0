Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222B1D9352
	for <connman@lists.linux.dev>; Wed,  4 Sep 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452862; cv=none; b=GjVKlEeCWKJPwDdj9A3uGE56HMIPcwdNa5p9WPGP/dqFxSAg7SIX4dSg9wiB2wg8GK1EfIHVv6UwWGP6ZxyTI9XnraQHMh88Uu7qECYaAWupHX8wmFGVVxUchKE6bWvuty+3YBcWy07tnz4sU88lC0EDqjsLtGiEReV5BVo3Fr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452862; c=relaxed/simple;
	bh=qVingwpfeGuXO+gXz8qKcmO4iVhlsktIowHFWeeLKIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWAYLs96aK2qDIEhxlo8FBvmsoqutgvQDZ2Tf9iNHnFZzdbLnsCrfH5K3MkB1mZQEJU0f255D8SJlH4J6SfzmMUQXoLdn5WHNmaw0dP+Sm6O275fE9Tum1VXbGuFI7MAfkrwpeviHXLgDMUwqV3UWGhWjE2FxkFSxOM+qck8czA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xFn/3Yq/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CoTSCh9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xFn/3Yq/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CoTSCh9F"
Message-ID: <95298b05-4c02-4821-97de-9fd1696ec13c@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725452859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VyXPveFncbKvJWur3d21buDp5ibt7G7HqSUeYOalIRA=;
	b=xFn/3Yq/EXl46RR9xm3nrIz1n5WqtM8QgM5pGXB1Ce2ICpO1tN/TzBPYmQetX3jFu5+/bQ
	XogMrvV0Q41e+stddOwleXIQvXIvrZ6HiCeoiqI7JP4X6BqvJLgycqTUshchrsw3KSyJGJ
	xU2aUZPVSf8Ut04ovP2ltoeh/LAXxbSw+jv7ZGpWfesRB8CZHJBeyMmAV54OgAZB0/ZPKU
	OozlyLTIaE1KEqoC/SrK4CZO+srH22qN7x3i2wXtI8IqFF7SUtLDXFHUOYQ68yd4tK5PS2
	Me6gG3yufZ8eL3JDFgiOLlakn11AvX0WDHjiuApH5QwSJRWNBMtbma5XZ7+13g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725452859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VyXPveFncbKvJWur3d21buDp5ibt7G7HqSUeYOalIRA=;
	b=CoTSCh9FNa3QBuSA29ItYTMKSbobvfdwt3AEKeQ5WsxqWq2cmnDZVBOtUW+kXFWD4bpeg/
	nq8CVk0khVYVbCDA==
Date: Wed, 4 Sep 2024 14:27:38 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] gweb/gresolv.c: make use of res_ninit optional and
 subject to __RES
To: Marcel Holtmann <marcel@holtmann.org>
Cc: connman@lists.linux.dev, Khem Raj <raj.khem@gmail.com>
References: <20240311110918.1399173-1-alex@linutronix.de>
 <C110D6BC-3B9E-4973-A1CD-5075AC52903E@holtmann.org>
Content-Language: en-US
From: Alexander Kanavin <alex@linutronix.de>
Autocrypt: addr=alex@linutronix.de; keydata=
 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
In-Reply-To: <C110D6BC-3B9E-4973-A1CD-5075AC52903E@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/24 10:30, Marcel Holtmann wrote:
> we have a bit of coding style issues here. And this should really be a helper function.

Hello Marcel,

I sent a v2 where things are moved to their own function and spaces -> 
tabs. Let me know if something else is needed.

Alex

-- 
Alexander Kanavin
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 39; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen |
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700
806 | Geschäftsführer (Managing Directors): Heinz Egger, Thomas Gleixner
Tiffany Silva, Sean Fennelly, Jeffrey Schneiderman

