Received: from mail.oscloud.info (oscloud.info [89.58.28.149])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347D23AB9C
	for <connman@lists.linux.dev>; Wed, 24 Sep 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721198; cv=none; b=ZGOQv1z5SeoXHyrkG+BNhjpEQHgdBcJzTxw8UbqcNGoJ17MuyHcBh5hjL6bPnX3Xs6miKR7eK2Bf7Z2MTf/12Vlnv4bcwbGhxmuNTu5FzMwH/RJyscCASjdyFaPk70PxEh0YYd0d1DhGtngbUey2NWLEMsR8nktIvAO1ZDXYaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721198; c=relaxed/simple;
	bh=WiliIxtPk90ooS2CvDofaBqdmciZJ6/04ZQY4LpZycs=;
	h=From:To:Subject:Date:MIME-Version:Message-ID:Content-Type; b=kp7aK4U/wuIexlsJ0XPpICey6Y8P1uYYryw2fjQlTXXT0cuLJovDgCY9EY0EEAafYk6W8kFhXZBYV4tXXUhm3erkZFw2RYfds4af5e3jMrGSxxZB0cJGslI9/iwHKI3HqKgJLpOoVZHlRAlwCOtReFYBC1vr4p0lhQhCbvfZALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oscloud.info; spf=pass smtp.mailfrom=oscloud.info; dkim=pass (2048-bit key) header.d=oscloud.info header.i=@oscloud.info header.b=WI8vTWtn; arc=none smtp.client-ip=89.58.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oscloud.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oscloud.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oscloud.info header.i=@oscloud.info header.b="WI8vTWtn"
From: Oskar Roesler <o.roesler@oscloud.info>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oscloud.info;
	s=2023; t=1758721193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WiliIxtPk90ooS2CvDofaBqdmciZJ6/04ZQY4LpZycs=;
	b=WI8vTWtn1AfSANecb29ATTZsjw3qPHArBli94WKIgGov7RMQINtXoAys4UXmSiyc4iTNnw
	VIoGBH69m8p6vb0BAN/WK02dPIDSVEbQa8qMjhTk2wRZOSm126uk9CRkau3miGrNhVMmPk
	wKnezRKMmWo70BD8/wl/pFLO7U4U4xCyxuY9JWLmyh+2178j/holFt3wg3ghR6mmcOckAL
	+hREnjA5PE224g6YvCLHbkSNp9Q/S+75Gq4guvzeR9XIkGPvN8+YyP5h4PXqCZJAgniTA8
	4IfFMwVR0Q+rSrL7weyhs+pLSEJrdC5KDTng6i/CPfaWPXeiSUPZ82DYHqLE5g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=oskar@oscloud.info smtp.mailfrom=o.roesler@oscloud.info
To: <connman@lists.linux.dev>
Subject: Where should a Loglevel setting be =?iso-8859-1?Q?implemented=3F?=
Date: Wed, 24 Sep 2025 15:39:51 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <edae8ff8-293a-45f9-b6cd-7798de838ea7@oscloud.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,


currently, the logging of connmand is very verbose. Connman uses the=20
vsyslog() function internally, but there isn't any play where setlogmask()=20=

is executed, so even the info level is always printed. I want to make the=20
logging level configurable. Problem is that currently logging is=20
initialized before the configuration is happening (which eg is necessary to=20=

log config errors). This prevents the straighforward way of having a=20
LogLevel config option & setting the logmask during loggin initialization. =20=

I have 2 options in mind to fix this:

1. Use an optional flag to set the loglevel. Some flag handling is already=20=

done before the call to any init function, the value of the flag could be=20
handled similar to the debug flag.

2. Add another init function for configuring the loglevel after=20
__connman_config_init(). The loglevel could be specified as a key invthe=20
setting, but connman would keep being verbose on startup. 2 init functions=20=

for logging may be less straightforward to read.


Which approach is preferred by upstream? Do you have any other idea how to=20=

do this better?

Best regards,

Oskar Roesler
