Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770C1C5F2A
	for <connman@lists.linux.dev>; Tue, 14 Jan 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845075; cv=none; b=TFu/DDV1wORTYKPrldd5GlcFpk7LwI87vU+2k9Rxffm8zWiM7hcwBCVxi8flOY35sK/D9IgpzWujQHRTMHi+YlI7bIYsfi2t8QEWTb17Qeiuau2ly7aqOG+mxueHZphOEQAMqAks3k0KXg0RJLbR0ozXBKhH5PUyP5kV8DoWZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845075; c=relaxed/simple;
	bh=/pRT2QS6FzfABDKiUIr76vIgu3ofoLKv078ZECSJd3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfWtJEDEpL6HTrZHu+kL5VffcUPiXrexJc0YLOTxEf2fXA8H6dE1E4ADoj3V0bCt7QuSf4gzSIedjwTBhSQw8Evu4wy+8jX548f9Cj8OVTOAKDRV3UsQWXB+OhS+ElurO7EByzNhX1wu6QnvzqPGgvjH/YiXPEICxmLs4B4Y7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=Sk9NMiyb; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="Sk9NMiyb"
Received: from email.seznam.cz
	by smtpc-mxd-5f779ccdf-9p8nb
	(smtpc-mxd-5f779ccdf-9p8nb [2a02:598:128:8a00::1000:4c2])
	id 1837bdcde6edbbaf181f575a;
	Tue, 14 Jan 2025 09:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn20221014; t=1736845070;
	bh=EmPW7F2an7DXwYYLlnMmlD7+g10sp/cfywy/3lDoRkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=Sk9NMiyb9WGm+XoKPFPMDXNQYazO19aTIOLgrRsUAUstgqLPJTynD0eqBaF3cMCme
	 7D8VF9CYMYoePW8QyIt7CTPxZy0pVGI9XZo6ivjhFT7K0F5eRjmecHBfE5ysS0MzK5
	 b9jABmOpldzC/VT/sfkzmD8Etf8JNQ7FoRMFl5z52N5wmas291trzqN/oLrYNVeMqQ
	 fPbv56BHtJJk+14ifyv8VZXpUw5yaU6W+vI2aW5CFgx42ibI2OK2FADte3ixY3+72x
	 CPBQP8mhMIERCwrcoxDtYS4erKCEpXCfPStY4xIf5HYKmLAPO1LdrJ79/s5FcSnX+L
	 zrmABXPmpFRVg==
Received: from smrz ([93.90.163.238])
	by smtpd-relay-7666f97df9-qcjg2 (szn-email-smtpd/2.0.27) with ESMTPA
	id 61fc97de-ab62-4d0c-8b97-303643a07090;
	Tue, 14 Jan 2025 09:55:15 +0100
From: =?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: michael@amarulasolutions.com
Subject: Re: Manual configuration of tethering IP address
Date: Tue, 14 Jan 2025 09:49:17 +0100
Message-ID: <20250114085457.26934-1-roman@amarulasolutions.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAOf5uwnN7R-3znm80TzhAPF=GgokUuBg2Zy+C0sqCETRNJy_RQ@mail.gmail.com>
References: <CAOf5uwnN7R-3znm80TzhAPF=GgokUuBg2Zy+C0sqCETRNJy_RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi

On Wed, Jan 08, 2025 at 07:24:51PM +0100, Michael Nazzareno Trimarchi wrote:
> Hi Roman
> 
> It's easier to review if the patch comes inline with the email itself.
> People review it using
> their email client

Ok, sending slightly updated patch directly as formatted by git here.
Though my main question is still if the approach for the address
configuration here makes sense.

	Roman
