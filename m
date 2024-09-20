Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF6625
	for <connman@lists.linux.dev>; Fri, 20 Sep 2024 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726795236; cv=none; b=IfSJTE/XUxXGaGxd4ciRdTcpYg/bMCwPabZpdKBP+qY0rxMmPkOcoAVc820e5CO63/OebTwYfSfSz90+xzw8FC8RO/zw1di+h78HH5Kp5yInPjwe8NyhmuwETDlXOONkZ9t5SFMQHwgg2svhgM+3Gjmm3RivUBpd/14717Fe50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726795236; c=relaxed/simple;
	bh=msLk+RXJtedTa+hjZo5xbZmpmou0BJHsXfRnrhWXgKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=T3BYFO1IoMPRG8T/OU4OALSbDgAb/NsY6fZkBCMK1Jp1bcY4BN2DRL9pU4I0D1N482knYPVWgGRxWgCLvT4od/Wzp8iX1jkFpLYLUlwz61zPx4n3XLKPjVGBkTROIA3OeX/wyIeFYEhWoWowOwAo3fA6qxs+uf/5iXvd982/Z1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9nozi0e; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9nozi0e"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53658e2d828so172348e87.2
        for <connman@lists.linux.dev>; Thu, 19 Sep 2024 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726795232; x=1727400032; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msLk+RXJtedTa+hjZo5xbZmpmou0BJHsXfRnrhWXgKM=;
        b=M9nozi0ewVyPQUtSisD1LcVyRJpyahlxcVpTFek49QBCkmTeGGQKPHjK3sxtdsvs2V
         Htx1pEmsphCIYXIOUn2MI+2X0YHUul+1G0jIoUlcnVDtD071Dz4CRNQfVixGTn7COEI/
         YH2z/Nsk3fVRc0RsxCW3zQM03Snr6n0cY+JVbLW1tQ4lxqS4xGqj8tmkJs+7kLLhej6s
         qHKHNJ0+N6PTFGI5RxWtA4DHEMrCHpV8okkov79YClFg8yG5ItuHlSw2uTtiNIBJbahB
         m35OBC2QxJeaQSUN/PM6QqVer7PPvlcyGEdk06/7u+/cd/cT2hZpsGcupbvFPmI+tWmF
         ewMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726795232; x=1727400032;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msLk+RXJtedTa+hjZo5xbZmpmou0BJHsXfRnrhWXgKM=;
        b=BrxR8MCCXcaDVjHh4OzCvGISly08ESFv2SI6hM9p/6gLc4G9hUWzfFavUr/q4Nb+4c
         6aSLAmD9wb084xT90urrgZKvwqjjw5YHYHz+KFlPNAZJRG8BCLiw8JrPGPyblx6yCvLD
         VgeCP1GSue6cTvxsCmDKAvhkkXoj2yTPGeg05aympxyLYqv5CBF92xyHMqucKMOLLOzK
         R87JvpDSSkIq2nKMe9jvbdLXQhduZHgVHUgO3sB11+gOEczQdaTgVsllCguGAXRejxSt
         vHXIcxf+NqvVz1ZL1JtVe8vmyqKMxQwLls09kQzQok+SGUPczq1b9+JxE5CWtVZPXSdV
         m8pg==
X-Gm-Message-State: AOJu0Yx3p0u2nkEGNinHxEyHDvPn47WAO7j0SDkjIsy3qO4upK7kyN6k
	vgfufsOx4vqAHJxdC9z3AFOIjyVtg1SJc6fEkSH1ZWejKlvQ2uGTAGiXb6RWb81xBH2Nf2DV0j0
	n62GedTYCb5a91wor4RgFGvu3bEYQyQ==
X-Google-Smtp-Source: AGHT+IERIPB4WIivVjYC8jkVVTBAXD7L1bAdUTe4OWOlfpuDu7Mk5bdwVxLO14/DeYuQ7hwy9dT1Tt487SO00iQzbNQ=
X-Received: by 2002:a05:6512:3b89:b0:535:4d89:5b52 with SMTP id
 2adb3069b0e04-536ac2cdf02mr153728e87.1.1726795231930; Thu, 19 Sep 2024
 18:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEG4cZW0gCz2W1YQzQLgoDBkCghR+tJAfhFf5P3k0Orvo-SpgA@mail.gmail.com>
In-Reply-To: <CAEG4cZW0gCz2W1YQzQLgoDBkCghR+tJAfhFf5P3k0Orvo-SpgA@mail.gmail.com>
From: "Susmita/Rajib" <bkpsusmitaa@gmail.com>
Date: Fri, 20 Sep 2024 06:50:20 +0530
Message-ID: <CAEG4cZWh8+WeyhiUWveDv30fNENFMm4Wcn6U7-m7fDyuD=KNQw@mail.gmail.com>
Subject: Request links to help-files and directions to configure and access
 ISP's cellular mobile network with smartphone's Bluetooth Tethering
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear Connman and Connman UI Development Team, the creator, Mr. Marcel
Holtmann and the team debian maintainers,

Good morning.

I have recently installed Debian 12.6.0 LXQt, having connman and its
UI as the default tool for internet configuration and access.

Familiar with network-manager and nm-applet, I installed and
successfully accessed the internet through bluetooth tethering. But
now I want to accomplish the same with connman UI without
network-manager.

I have read the man pages and briefly read the webpage:
https://git.kernel.org/pub/scm/network/connman/connman.git/about/ to
find that "Tethering support (USB, Bluetooth and WiFi AP mode)"
functionality and feature.

I have a few first queries:
Should both the connman and the dnsmasq accessing the DNS port 53
create a clash in case of Bluetooth internet tethering?

Should the DNS port for TCP,UDP for dnsmasq and connman be changed to
overcome the clash? BlueMan has the option to use dnsmasq (along with
dhcpd and udhcpd) and network-manager in NAP for Bluetooth tethering
(PAN and DUN support).

May I please be provided the links mentioned in the subject line and
be obliged. Your guidance would be highly appreciated.

Best wishes,
RKB
______________________________
A few innovations
IN191986B
https://vixra.org/author/rajib_kumar_bandopadhyay, such as:
https://vixra.org/abs/2309.0130, abs/2301.0140, abs/2301.0147,
abs/2302.0079, abs/2302.0074, abs/2302.0075, /abs/2302.0023, etc.
