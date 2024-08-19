Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFA1779B1
	for <connman@lists.linux.dev>; Mon, 19 Aug 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085442; cv=none; b=ERWnKhBerV9S3lI4AH27MPwwlKFCWmSh1H7FSCN8IcVeEetcr8P+5d76HcXm2P26drBeAY5O8WsqIIn1JUNzmGvKAnNHADfp4erT0u73/4AP/YszJqIAD5isor8/p+q7bbZCphDbO/zQdG3KmwNrH8HkQ2SmQmzKh/qLSaaPZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085442; c=relaxed/simple;
	bh=o1IZlfHXm/g3vTyJil6vdG6pCXuAlIr3F7ISbFnu1Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq8pbC29ajL+yuDF5EPJS736AnIfbSzbW9hQaUkBKR1YsCtS2VjNuy0eJsgM3aMmQDPIOksiaWXYPeWt/kba0nnc8fncfzjzISjr+uZJ6uYtMR25K4rgbm7M3N7BbM7mo4c63XaFDYdBEAmIG7fqi/0nWHe56jeOe6l8AtU/9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpeM4bxs; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpeM4bxs"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d439583573so816005a91.3
        for <connman@lists.linux.dev>; Mon, 19 Aug 2024 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724085440; x=1724690240; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcgA8TO0mDCQyDF8a0mmEvQviRrdQCThhofPh+IVQlo=;
        b=JpeM4bxsnes3G8PYfkzbNFwO//z5V2vrEe3eHbbkPr30apIrmeEsL/wsW+KK9IHbVR
         aRN7EhuzkCPoNh54NgfOOd0EnXDUnhdocw9dgWXGYpSE6A9P+KQI4KAinCUxygEUkX3U
         0qk87qZMW0SMTY69jxprNRx7fDGcpHvcJimMiVWNE5PNPgWRinXHhfpZqqef5PCsIgBE
         LL5jDYYf5bMyULmmTvm92wPEnmqFxb0hX5CvaT9Bl83gRR25c+V7RAsaZ8c5NVDSu/8a
         UL6cH7Zi6xUVT63kajfC/sUPn5OcrOXOpwvG9uoCf77d69y0OODavtn8oScJImBQ4Qai
         EjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085440; x=1724690240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcgA8TO0mDCQyDF8a0mmEvQviRrdQCThhofPh+IVQlo=;
        b=N9g3CPN9S23AJvY7Vlp/HJ+pbk3wW+9ZUeF+vJZK8c5E1ko0EkPUwTClE9qqicLeXH
         BswJ3ck8/k0QahGrW1NW0xhqQpqCwzEDnVzoDQPSsmCdZ1dbLUK+qIPHWUNL1KuB/hRz
         Df5dZb69P6DZ6fMSuzIu2rn0sP8eQR7X05oc1WWT3+4NiiSEBVJRyipbFdlfzrNncMcn
         fAWUMCDvefzk8lAXRj4u9bcrXHU7m42gfsN7UwLUubsAED/ve6k6TgEeCFednWAK+Unz
         LVzAu1XYuXR7lGgvKQI+N7CRXXk0igGgkHB5gkEgM+y8lYphHOiXQvO2RzU9WhBetT+v
         Otng==
X-Gm-Message-State: AOJu0Yw4A6VMyi0IyKUdmtl3VLsstOc82As3FrSUV3EBQElOm3sOS33C
	6EQmThluqJXuMMhmA3pMJ/nPAVP56BCtrBVDzZKnm3MTGiU4jUlJXwooduO9bIQhtJnMd0COw1L
	Ox0HqWDtg+I0pOgpPV90IneQQSgc7/MsF
X-Google-Smtp-Source: AGHT+IHYaRYNH3m9V+aStetC4Lg1eWZzZiGdetaggYwIPIcNocwDE47aKRQuLpYUhT0JE0qk3RgSU8h1+mrXjExMJeE=
X-Received: by 2002:a17:90b:814:b0:2c9:5c7c:815d with SMTP id
 98e67ed59e1d1-2d3dfc8918dmr10551717a91.22.1724085439742; Mon, 19 Aug 2024
 09:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_O7LdFxW4OUAoN+zOJ43MpmSg5V5O-jxkUg4aMmN1eXBw@mail.gmail.com>
 <a0bbbf39-82fc-4f41-a60b-7631716e536f@gmail.com>
In-Reply-To: <a0bbbf39-82fc-4f41-a60b-7631716e536f@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 19 Aug 2024 11:37:09 -0500
Message-ID: <CAG17S_Owj6pWj9D-VVWpb3bg5k26Tm-VAhNjWu+c=s4DN5q35g@mail.gmail.com>
Subject: Re: wpa3/sae authentication does not work with brcmfmac+connman
To: Denis Kenzior <denkenz@gmail.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:46=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> Hi Keith,
>
> >
> > With this update, running wpa_supplicant and nmcli, I am able to
> > connect to a wpa3/sae ssid successfully. With connmanctl I am not able
> > to connect at all.
>
> That's because the firmware is broken, as I've pointed out before.
>
> > Aug 17 18:22:53 pi5 kernel: ieee80211 phy0:
> > brcmf_cfg80211_external_auth: auth_status iovar failed: ret=3D-52
>
> There's that errno -52 (Invalid Exchange).  Basically the CMD_CONNECT to =
SAE
> fails, and ConnMan (correctly) reports the error.
>
> Regards,
> -Denis

I get it that brcmfmac is broken, but the latest
Broadcom/Cypress/Infineon firmware that was pushed to the kernel on
our RPis appears to be broken differently than previous versions.
NetworkManager, nmcli, works with this newest firmware and is able to
connect to a wpa3/sae SSID when I use it with wpa_supplicant. Is
NetworkManager modified to handle this broken firmware in a
non-standard way?

I was able to negotiate a connection with: "nmcli --ask dev wifi
connect SAEssid"

Keith
