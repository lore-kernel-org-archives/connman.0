Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD915696D
	for <connman@lists.linux.dev>; Wed, 24 Apr 2024 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938769; cv=none; b=hnrMbQcEB0JJDQdmzWS7g/+8TY0MHjAC5q7DB9Z0HM34JwLJSOzZeXmE2Q/YNlhWr1BiOOuFkn1DMQgcHzfFvvrrQt31YMi9ifmKHOpLs4/IK8KdAUpW4LsuCZtA8NWOdkhyPEl6YBkr/i8d5k8ZloSgjAfF7hZbskldSQuT+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938769; c=relaxed/simple;
	bh=DyP8oWeLpVZoPcrWjtQkXyO9jLqoXMRp1z4IGycZjhM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oEGNHzKqw5jwCJvs+8EtkL53P06YD1w4h3f2YzoexT9th1p3WQi5cx41WnC1Id/6qNqOKXU2SRp2ypsY5pjsIE/b9BuynJS/uGhmfuYfkk46YbsfM9wDHAR8tsxNmj+wpmgPQvJvwFQWXNp2YvRro4E8LzWqa+BsICuDlzzMPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW4lizH2; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW4lizH2"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4daa1be011dso1627425e0c.0
        for <connman@lists.linux.dev>; Tue, 23 Apr 2024 23:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713938767; x=1714543567; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kj8rvAl+mKNH/3xBh1Q8yfghj/HggCVzLGA1YM6fA9k=;
        b=VW4lizH2UnDYwzFLntCHGmiGQJClmdMWZnv+ZrkLvXIhsfINa3JTacvn0kmw8vromQ
         1gRj+AuQG/vJHeNqHN95G3W+C+wa0kIFIXfE2y5pC6j+cXtp0mP5qO/Jx6YkQ6SJqakh
         MJ98SuSg+36Bv/5Ruywq1Zf1yyz4DfqhldO3cw0GY/wcDlSXdtWpWe+YTfrH7pfUKE5Y
         5ztFK5V5AB8AIbOHSmEtj3SJEwelNTmAwM1xJMVYDoKxo2Ti3vnTUL3k1jYPrgV8UptW
         DNyJEFq56a20VhYFKryx9wfOi755R0inVKCCHJnUWcXLvLTv0LjTzzIXHXZCzwCFWuDp
         zvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713938767; x=1714543567;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kj8rvAl+mKNH/3xBh1Q8yfghj/HggCVzLGA1YM6fA9k=;
        b=I+SJgmlqYkj/DQrjChii4CF1/7s/9OWZwXmng2aH4cTezktK4FR82ttrTo6EHkuGNa
         VkZAs+Lh2RyetsM+zMsjcTyrYrZ/l5XaBodlJI9Xt8nu8HP1Xuk8XHvan+Pq+PteN3Dt
         cuCGe5pkI14wTkkGCRntZEFRQZ3CEbO0LYRbb1I0J4+rAHs9Yqx6PpcxFn2ZvqJr5xco
         V3SOOCu7/cxfPFOPXvh6ZkS/5mA+NXC+zHIVgAQdReqpKvUw1mHxoE8vOGVq9/GCdHkS
         75PR1qRMAukIs62bacT5B579QinbOPkb5yjX2s/EjduV6JfEiwbPp7GKdpeurujHuF7/
         Z+hg==
X-Gm-Message-State: AOJu0Yxs1Dwk8zQq1qXrT8ydNwaHRwqFKlvksOC/nVYB3TwVTr0y7oiI
	Vso43wOZWTrKSMVgWieKEs9oBHNHWwQPBDwfZaVKkciIYnPWkWfSghpBlNQ6wjh6gWMKv5ULeZu
	GlBOQWFGjb5RF+7yTbp90EMfAfmNGe7XI
X-Google-Smtp-Source: AGHT+IHt84nr2PypdVeIODrX5nvEaH65q15zCZR0IRoYyz394nTr4c8HPVdKduOWlMFXj4N+nbpI+K7rBdm4dAlwSDU=
X-Received: by 2002:a05:6122:c9a:b0:4d4:872:c68a with SMTP id
 ba26-20020a0561220c9a00b004d40872c68amr1495574vkb.1.1713938766827; Tue, 23
 Apr 2024 23:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Wed, 24 Apr 2024 08:05:56 +0200
Message-ID: <CA+iibzA2M1fDosrij=nUWCAuL4mS+FsO-jt1xxH_qsadBe7ZTA@mail.gmail.com>
Subject: connman-vpn does'nt work with wireguard
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

I have installed wireguards-tools on my system and I am able to
connect to a VPN server friend with the command wg-quick up 'name of
the interface' . The configuration file in /etc/wiregard has a host
with a FQDN as blabla.com  . It also works if I replace the host by an
IP address (IPv4 or IPv6).

I have adapted the configuration file in /var/lib/connman-plugin like vpn.config

[provider_wireguard]
Type = WireGuard
Name = vpn
Host = balabla.com
WireGuard.Address = 10.0.6.5 /24
WireGuard.PrivateKey = xxxx
WireGuard.PublicKey = zzzz
WireGuard.AllowedIPs = 10.0.6.0/24
WireGuard.EndpointPort = 51822
WireGuard.PersistentKeepalive = 25

My display environment is enlightenment. I see the connection "vpn" in
the connection window. When I click on it , wg show vpn displays the
connection to the server, a ip a command shows an interface wg0  but
it drops after some seconds. I can ping the server 10.0.6.1 until it
drops.

If I replace the FQDN by an IP address in this file , for an IPv4
address it makes the wifi connection shutdown and returns. My laptop
is connected by wifi to my livebox. If I put an IPv6 address it does
nothing, no interface wg0 is created.

connmanctl shows the vpn service with the command services and the vpn
connection is present in vpnconnection

My first question is why connman does not accept an IP address IPv4 or
IPv6 . I have compiled wiregard-tools with WITH_BASHCOMPLETION=yes
and WITH_WGQUICK=yes

After why the connection drops

Best regards

Daniel
