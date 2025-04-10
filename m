Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317528EA5C
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319493; cv=none; b=DLDMsMjgvzmXWQ+ne65mvKTbmxvO4padTJg9LPx7oZf8d4ln+fGuQJeN3i8ZAQgdfl09CN5zPaWt3K8v0JZDqSyn2NLzNZqwZXS9dzgVH+wg2dA/apKFJN7/7xHxxZr238mu3eLN4HJrhXRMEH3JklLFu0oBy6c5fpmLBiK9R4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319493; c=relaxed/simple;
	bh=E96SEnlcr+RpxZsUjkOCzdflAgQSix4+imIX7V9NoHk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LOYagtsO2MDwJRMPOH1fHN0hhEyp/L7ZIWeAt4vnmCprMXgfEEa+CVgCYsHMAEkAhnmws/vPqA55GYk1WILkKvoZ+xHGsqlG6jZDdC0wYFvL5BkIgvanEtjy1HFGF/D0kb+gg7QZzf7yV3jFmcrmFPKkNVw38BSy9gla51HvWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kookmin.ac.kr; spf=pass smtp.mailfrom=kookmin.ac.kr; dkim=pass (1024-bit key) header.d=kookmin.ac.kr header.i=@kookmin.ac.kr header.b=OVVo3TjS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kookmin.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kookmin.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kookmin.ac.kr header.i=@kookmin.ac.kr header.b="OVVo3TjS"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so2227526a12.3
        for <connman@lists.linux.dev>; Thu, 10 Apr 2025 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1744319489; x=1744924289; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7plLaZgNJpB5iURw6LeVPv1zqF8pODUzLvyUKYuaDk=;
        b=OVVo3TjSgdDQ1aDMXyyc/i+akFzxKYenyB7lIg4RS+jcOtHdUlpLv/2IIDE64ppB2j
         kWpqabespSHDFoetXvuLIgQ86Ndv9Wc2mvMwXSHEr+XgArmVETRgNHUa3pG1ZnNCsqtl
         awKqNcPh8ECLb16n+q7oCMLFVD4RNFRBniTe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744319489; x=1744924289;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7plLaZgNJpB5iURw6LeVPv1zqF8pODUzLvyUKYuaDk=;
        b=GQzotcnvMl8sSKvDsTfPF2oLFAI1Rm+W7Df62fkfFifvBOpycF3Hh13MM43hpsXmFL
         6jT9zcV7+7yi0kXtJ/MrnXACRQfdd/yGmmdUtoiuvWgeze+yhUoVdvPMDj7kUuayinRZ
         E+bbPlQm07Vkl2YBMllg8r+KrNDo9K3k4XIbNoBN0jxwkzDt5GBaBj+s+AFPB64ri+ly
         PegQXD4qfNSUMrhaDNS70eRA94dtBMYyG8QlOawzAcLImWfmdY7awX1QTdJAIzuAfuHF
         lHZpv3KezwwmziJMHTGQTB9G1yOPiFjZgSOIZC8wjWjMTtC8QnFvpx9ya/hro7fsqqd3
         Sx7w==
X-Gm-Message-State: AOJu0YyG7hgFo32gSUAhf93Kq9VCsXlFUV8YszDg+IQthgYA2cPIzzya
	On2JvF7hi4z3Ei1d7B3NiJBBI3wLUgioYf+AKP5GWnqOdpdHbksCD0X8i2BRmswQPGASEJyp/1E
	odAc3nyiA7JQe2wtZgEdxqI/pnh1/OTO6zCrrB9N+Z0QYs3vAGNMfMLbHlGQHeV3ryLzQcU7An3
	JPQivm4wnOBJAIWSgt8jIK2fu8n3d+0kvRTTi73Bs=
X-Gm-Gg: ASbGnct3N531RoUsLRsBLCkl7dUwrzcwb5929DLJE+QaAP21ziXoT4h5o5QOWm8HNyV
	hyUWLBM+VjxV0KoVb3jLtfVXUJiqFfZIZjHeL1YhbYEFOQCZn6NeKCouPxvdSElXdxbDcOpqXe1
	eE9hnQPD9KoXoZbj5OsQDSMSE=
X-Google-Smtp-Source: AGHT+IGqLY18B21Gu7H01Pvn7zHK3qRupSDzHtRQKTQ3nejlBFlnnzCO24dV0EkUnQRq3gfryMeA57h/raot82fWzyo=
X-Received: by 2002:a05:6402:270f:b0:5e7:110a:c55 with SMTP id
 4fb4d7f45d1cf-5f36f77aad1mr51154a12.18.1744319488719; Thu, 10 Apr 2025
 14:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?4oCN7Iug7Jyk7KCcKO2Vmeu2gOyDnS3shoztlITtirjsm6jslrTsoITqs7Up?= <ioerts@kookmin.ac.kr>
Date: Fri, 11 Apr 2025 06:11:16 +0900
X-Gm-Features: ATxdqUFV8rh4Ybz-j6aPPtEK5M1y0so95hBFCcULv1rlmCHylV9GMbLEy9xh6Sk
Message-ID: <CADiHxDFvu+0uOKuMQrvuz69DwW9aH3ECYg326dfMy7pewj-6dQ@mail.gmail.com>
Subject: [PATCH] dnsproxy: Fix for CVE-2025-32366 in ConnMan dnsproxy.c
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

In ConnMan through 1.44, parse_rr in dnsproxy.c has a memcpy length
that depends on an RR RDLENGTH value (i.e., *rdlen=ntohs(rr->rdlen)
and memcpy(response+offset,*end,*rdlen)). Here, rdlen may be larger
than the amount of remaining packet data in the current state of
parsing. As a result, values of stack memory locations may be sent
over the network in a response.

This patch adds a check to ensure that (*end + *rdlen) does not exceed
the valid range. If the condition is violated, the function returns
-EINVAL.

Patch diff snippet:

@@ -997,6 +997,9 @@

  if ((offset + *rdlen) > *response_size)
  return -ENOBUFS;
+
+ if ((*end + *rdlen) > max)
+         return -EINVAL;

  memcpy(response + offset, *end, *rdlen);

Please review this patch and consider applying it to address the
CVE-2025-32366 vulnerability.

Best regards,
Yunje Shin
Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>

-- 

