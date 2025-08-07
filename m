Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3311E1A3F
	for <connman@lists.linux.dev>; Thu,  7 Aug 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559044; cv=none; b=UlCLl10meMvFw/9qKQYrHo/Dc3i9UcJfy4XvRa1XI4vzHeX7x0C+bLgYmeRIF9cfJWyxJ1HTo+Dokuj2PuQQBlpkKa/uRUzwt3oLpMFx2SaVfC1cjNvg4uU9f46UH4y+bSWp/2mvhia4Hw7u0XecZE0/9CnB5vVrXMXDwx9PxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559044; c=relaxed/simple;
	bh=KFnl9hO46fUUtSX6sqimbk4rnFkq1ZFEZ88z9lPWlb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+VxzBbJZ3UUaJCOXyyP45vFYtVKetVQzvEx8JwhCwiEtXb3TH7QWeMpFeAXjjw/XWtQKIRFbB+/XO6GmZh+RqU4uYIgveYJFLqgyNtyXGRo60ok4e9uVKPtVGJNyvQaVbU2GjjHX7PvPG5+UlCXO4bDzO+lcRJQw2n1Q42eDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpq0uZBG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpq0uZBG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso4987365e9.1
        for <connman@lists.linux.dev>; Thu, 07 Aug 2025 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559040; x=1755163840; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=C9tTidHhUxPOa8dRv3K57F1pHv93R9dZYoL+icz+9eM=;
        b=cpq0uZBGUljO/RgBEZPZFKj8hitsVAEHe61CYH3DkGEe5v1FWcCsnARXcpopmAk/Th
         eJfFxJ9E6LXiDupyXU4/Ab/36BD9rzJdAMQK3bddCru9xnZSeiFS/CTFjtq4HPLGqVzS
         RPjNFC5BoEHYHzrfLhLhD8ouTHG/hhbThXv+reAqGs0asKKI/MeWIKitY/i/NH4+PCTz
         ezKuMjvohjX+qvqp6rxxuAnTHKxmY/K08uUXoVJuKIO/JRowov3V7QYXDx1wZsCoRQ5+
         HU+DX2OaIVPPeh0ppWnid6xE2TY0ta5nfsTwC42dp3JM1Oe8xXFI79rIU/3hXKVyTMX2
         KEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559040; x=1755163840;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9tTidHhUxPOa8dRv3K57F1pHv93R9dZYoL+icz+9eM=;
        b=gpNLMCmTXRYXoRzUnjFbDKAYPuU3r8lsoUZkB01Kw7InoFo/B0lQCEksdxsK2tmWD+
         yAiwdRjpgYjR7wlepWtL+Yw3AskDtjSfY9ULUVn1iAdetnE7gKHD9UkkzdnmQqWKAYlQ
         tx/nLwHMZy92bgDrYCAuxu+YfTbcgdYovHSrGhstvHCOLuw5dcAfMywqqXBg/11BQceB
         mQvGZn3AeKHHtQ2wcepIIsWYBJk/dkoBKxWSotl+C48VE1Ywy6gchxVmn29+94jfTmCw
         iMkHIqFK1kbLEbE9EG0tvwGZcQLMY+ONAg6sPQbuWXtUeS3ErhbKiScSXrZbcIh2I7L3
         uvWw==
X-Gm-Message-State: AOJu0YxsvUBZY/JNsSfGIhGzNl46NoTJ3+epNoHh55CAU4ESpNEq4/iq
	9HZWKcWwsF3LkDFrM8QbmUhyaH27WKDkcOethORNNNw1NUNrQfc6rkxohrAT8A==
X-Gm-Gg: ASbGnctsltpxawBBfOx0sBDEqLhJeZBF9a915Ju6Lm5FeqzRzFP4lAfKKrLjnjT6JeF
	Pb9tLSXNRfaMlVtgN1GaRxTEGUDWnE5tNa5/5S549YcZBt5Z3Sus+sNXHbnnPvuoYyZ3XxdBKik
	8BRKNBE1Fb9/xUjyrIPR2qcoOyfvN5QuH1lBRvUCLRUEp5FId4rdTd9xR6XpNypYmF0V3Ir0Z/m
	hUAXsrK2YzXm7kCDJiGdlvH6okFd5i8tekHfJ7MTRZ0t9zwRUsurbZIGrgKFlu/hq78npqS3D8J
	7xJ3/hIKHmcWZ6o2v+869X9mCEU7mszRKIV2GgC2HtZTREuk2b09ajwgHqp/jRxqr5d1lINmLv3
	d3o5MV8FW7SHPrMySb3FJyA6l0fRHCubv3w==
X-Google-Smtp-Source: AGHT+IGUp1SIt3dgdihgXjv0337xlVd8zL40ALh72GVni5iNuMM6Mr/Uc/Ko0MUykW6xhXTbskZwjA==
X-Received: by 2002:a05:600c:1c1c:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-459e748fe05mr41101455e9.20.1754559040017;
        Thu, 07 Aug 2025 02:30:40 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([2a0a:ef40:c9c:2f01:d37:b7b5:3eeb:78c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586eef8sm83087905e9.21.2025.08.07.02.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:30:38 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: connman@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject:
 Re: connman configuration for combined wlan0 + ap0 devices for tethering
Date: Thu, 07 Aug 2025 10:30:35 +0100
Message-ID: <9954986.eNJFYEL58v@adam-laptop-hp>
In-Reply-To: <a61b634f-412f-4e45-be20-935e1a5b73c7@gmail.com>
References:
 <27032848.1r3eYUQgxm@adam-laptop-hp>
 <a61b634f-412f-4e45-be20-935e1a5b73c7@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22251832.4csPzL39Zc";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart22251832.4csPzL39Zc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Adam Pigg <adam@piggz.co.uk>
To: connman@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Date: Thu, 07 Aug 2025 10:30:35 +0100
Message-ID: <9954986.eNJFYEL58v@adam-laptop-hp>
In-Reply-To: <a61b634f-412f-4e45-be20-935e1a5b73c7@gmail.com>
MIME-Version: 1.0

On Wednesday, 6 August 2025 15:29:37 British Summer Time Denis Kenzior wrote:
> Hi Adam,
> 
> On 8/5/25 5:43 AM, Adam Pigg wrote:
> > Hi
> > 
> > In modern WMT mobile wlan devices, there are typically multiple netwrok
> > interfaces for different purposes, example, wlan0, wlan1 and ap0.
> > 
> > wlan0/1 use for 2.5/5ghz access, and ap0 for sharing/tethering.
> > 
> > Is it possible to configure connman in this way, such that enabling
> > tethering on the  wifi technology activates the ap0 device, and not the
> > active wlan device?
> 
> I've never actually tried.  Hopefully it does?  Multiple devices of the same
> technology should definitely work just fine (e.g. multiple
> ethernet/cellular/wifi).
> 
Hi Dennis

In my experience, if the 'wifi technologyi is connected to my local network on 
wlan1, connmantctl shows:
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = True
  Tethering = False
  TetheringIdentifier = quintus
  TetheringPassphrase = sailfish


If i then enable tethering, I get
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = False
  Tethering = True
  TetheringIdentifier = quintus
  TetheringPassphrase = xxxxxxxxxx

This create a bridge device called 'tether'
[root@Quintus defaultuser]# ip link show type bridge
42: tether: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether a6:fc:a9:e6:27:cb brd ff:ff:ff:ff:ff:ff

But it has no bridge members
[root@Quintus defaultuser]# ls /sys/class/net/tether/brif/
[root@Quintus defaultuser]# 

ip link show i do have the ap0 device
41: ap0: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500 qdisc mq state 
DOWN mode DORMANT group default qlen 1000
    link/ether 1e:9f:4e:72:66:55 brd ff:ff:ff:ff:ff:ff

Im not too familiar with connman configuration,  but I cant see a way to 
instruct connman to use a specific device when enabling tether on a technology.  
Grateful for any suggestions


I will try to dig through the dbus API to see if there is anyway to do it with 
the dbus api, rather than config.

Regards

Adam
> Regards,
> -Denis


--nextPart22251832.4csPzL39Zc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEr1aGel3+a3VM67n3d+rfHu07OYAFAmiUcjsACgkQd+rfHu07
OYAV7AgAhx556NMr4GVexDpwwKjO1keGp3Q1AxMKajcQ+Zfc0RanGTtPu5j0sxen
fuW3qFtWu7FJp7rpnmQL1CWeTnQR+mAZ64YExP5PPzN+5DQr7lkKD9tyUOYZ6AE/
HGFKigcgNJf5HRi9JNwkehX/hPzcq3H7pTqdBpR36t2+eXqkeE1B9fwtSTMepcM5
bgm+DLZu4xtTKDJ0swgMi7T6ORWKoEVD3xpIBI1agHtQI8RydOlicD0nrT/19z90
jiU6UkEG2Iqs4VjMWzRM/CHZWC89YMaGQWulZrjvHU8X+Pvb37THc/Gaz04Bu2fM
FRXyfwkBQw2VfYe5gp2nNFRw6PAGXQ==
=S3mn
-----END PGP SIGNATURE-----

--nextPart22251832.4csPzL39Zc--



