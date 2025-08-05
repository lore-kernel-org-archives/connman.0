Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793472566
	for <connman@lists.linux.dev>; Tue,  5 Aug 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390604; cv=none; b=gQIBQt7Y+BzFUYR6srfMjPxsZ0ym/02YFGmujH4uPzecxrN9OcqJzm0Kf+4melkJ1pMEi28PHrLW9+rsSf30XoFNPp63SNVyxcOKtHG0nivJrKZwXJEpskW2G1b2WP08wVeQ3s9l4qz6CITZ4rcUSrELTIlgikNad4fBtlIARY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390604; c=relaxed/simple;
	bh=t7p3oBy2q1MrBPTNUiqkXT6wLqATtuiVQauRVGi7XLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oi2mxLgET+Ys3Eh7LFP/XHc7Xpt6MmlOXLFsUV62WaQ9pG/tfZcZQTUZ4V0otESpLLdHBDKcPk2CFh86T19vBeqAJFzvq86oUh3/OdgIbgtx21LEJDYZRS4JDam5qrmxLI2syafVLRVy2r7z+Y/gyRUmlpVhMtoI8IckM7NpK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVa9Adpa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVa9Adpa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so3388364f8f.2
        for <connman@lists.linux.dev>; Tue, 05 Aug 2025 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754390600; x=1754995400; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NAdncM+84OcEaabj5Xt9m6ihrIqezXaTemKGM5xq6c=;
        b=TVa9AdpaG3HSJ9caqV91MO0rZU3zZaUB04v3AaTMzUaWZI45PeOubouAwjRnjYY3tD
         l/+72nDGdSTsC6Ls4UZaNmKj9j7KUQH+uEGYR4G7qs5eZ+G75UbM8Y5HjBcwNBVDRMuv
         GSgt439KDN+vQbPR3u14lslcMfy6YxqBQExCg2U5QtjzXpsOIAsxozFsz5Tks8r/Z7hF
         0ruMjU2CTEchtkRdprsFVqyQ10QnjB4C31y9g4JJHI/xr/Gl/Iv6hd2V63doXLW9ZWoS
         KQ6oX7kH7wnKGot9N4vLfv399/Uleg6MUaGspno1WYMMoayXKzOsViuIT0Rb+xBkqIOY
         WCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390600; x=1754995400;
        h=mime-version:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NAdncM+84OcEaabj5Xt9m6ihrIqezXaTemKGM5xq6c=;
        b=ffIZjWSvFO5Ksb029J2y9zS5tjRBJbpQz8xbVhzyhTmL6GHhY6pnbAQzWx4dD9lt8m
         ZC0F44yMhnQf6lR+a450kM49mSNmmO49J1eZHTSzCTPbk/cV3PerriNV4Smf/TMUeyPY
         qACTC2bmA4qMdaDMT3RncU0sAcEDyfwkP2mzDNWtL0kLqS5TelBf+Gk4OmSKzFOZW9Wt
         Z6Vg4YpEsass0Uj1SA8gkCCAMe+VhZrfL1PWpiCtXV+gAjN6AImzZkwHg9ZZQ6sz3j8y
         f7q87lj/N9FXBrsd6ZDUrY+ZOXq76eyfAtMpG79DjMOuBV6ADDL99fhsrwYo076JCRa3
         oWGw==
X-Gm-Message-State: AOJu0YwKaH0zgLvxZK5qSSNTwmmW+e2GhnhEsVz0QyEDMhbZqFyQUepJ
	tw7skNd3l4RDKASu7qAP0nhQCGAoSNkptZ/8YAASIKWnQMVkvBdvhbKs0wVB6A==
X-Gm-Gg: ASbGncvnZkXd1prmMJjb+NDHdiQll5Wg1qq2tiDajRvOHj0sgPLGx+afC9YOlu1vHKO
	pLggiNDZl8Cg4QOMMD3G9C7O7y0ymyCG+S/bQvWgHb01JsbUL+vhZ33ywWGP/jMmNhZb1ht0x73
	7elJ4Wf7aNgK+LnXR7jkDldZ9OeIAItOokOKZ2PxJlweN6KmsJdHcfEm7YR20W7Nzma1QsK2n1F
	rhNzB5TEoT+SUBjrNIVRUyApL4dARJYWZl8ggmxmJUW/qUsbJFA5vK0Frkmo9e+Q2QJTl/Hm8bA
	p5TjdhLWHHG1KKVOxv8tqXcJ/JzGwfhkRSW+d/WaVFTlzj0KH1ulzGZHWH65vkuoQZ4AQfOhxXj
	03vy94itQCx/F5aM8BuxfKn2Kd9/FQqnD8w==
X-Google-Smtp-Source: AGHT+IEK9CV/K+KKDGFe1AsD/mRMIR+hFiZYCrMz8btM8Gutm4X750CIv4Zsdv45DkSZvNIafIXX9Q==
X-Received: by 2002:a05:6000:22c4:b0:3b7:96c0:4172 with SMTP id ffacd0b85a97d-3b8d9469fc2mr10111143f8f.11.1754390600137;
        Tue, 05 Aug 2025 03:43:20 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([2a0a:ef40:c9c:2f01:d37:b7b5:3eeb:78c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47c516sm18763764f8f.62.2025.08.05.03.43.18
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:43:18 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: connman@lists.linux.dev
Subject: connman configuration for combined wlan0 + ap0 devices for tethering
Date: Tue, 05 Aug 2025 11:43:17 +0100
Message-ID: <27032848.1r3eYUQgxm@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2347599.vFx2qVVIhK";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2347599.vFx2qVVIhK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Adam Pigg <adam@piggz.co.uk>
To: connman@lists.linux.dev
Date: Tue, 05 Aug 2025 11:43:17 +0100
Message-ID: <27032848.1r3eYUQgxm@adam-laptop-hp>
MIME-Version: 1.0

Hi

In modern WMT mobile wlan devices, there are typically multiple netwrok 
interfaces for different purposes, example, wlan0, wlan1 and ap0.

wlan0/1 use for 2.5/5ghz access, and ap0 for sharing/tethering.

Is it possible to configure connman in this way, such that enabling tethering 
on the  wifi technology activates the ap0 device, and not the active wlan 
device?

Thanks

Adam
--nextPart2347599.vFx2qVVIhK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEr1aGel3+a3VM67n3d+rfHu07OYAFAmiR4EUACgkQd+rfHu07
OYC8oggAqufUXFsW2nspwAprKNbpWTSwe5eDOXAo3Au04eF3MpKsgXLCXAD47cye
3uMQorDIkgW285V4VqiGZ/+TR8ceatxcauQwcrm4vhM30dNdV7M7e8AunKIorE1H
VNk8Gmyl518q8aBr+mfHvziZbSzuysCnmo5+xCvo1V5k7INX5U7cWIF6XX4IWVjg
pxDvaoDRq53VF3MmhSKB5BolguRigpGL38wRiDCPeRtej72RmFJkyTyzHRvs4hC5
BR8wy7kv/Q84xS4YAVIltefoR5lm37uPN48XxG7+KGLH1NR/uzI1hS0c8qIkI423
oer/JZhRp0ryhsmZQlbNM3F3dTHOcg==
=uoTR
-----END PGP SIGNATURE-----

--nextPart2347599.vFx2qVVIhK--



