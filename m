Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711F205E38
	for <connman@lists.linux.dev>; Fri, 12 Apr 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957128; cv=none; b=jMfcLkLcnGtf8Kbr3dTFooEc8WmZ3WtpD31Ro5MIWSXO8Sa65bVai9VrWKmZI8UWa52YfYPI8zS5EVpnVDkNenKiCqNe5/jY+HlhqXcbh4RrOkuaUNZWX1oZP7gOBQmxCk/3DKtS5Pq4x9M3yfB7KQ5gN3elQQ3P1eK5zCA9ypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957128; c=relaxed/simple;
	bh=FvrkK4kpw995XmHYW2obRO5lJ+l8n49TprBm2Wiru6M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VlgX/i/CibqqdPiq619iGxzw2eCjAeqQHFMCz2Yl3lNNRjq/2fNQVnfuNQKPLZNvAhwN3QaMAYAaF56ebHGpblElV8hwvpm1mYDVme7g+HGEikovizNrwoHcB+ia0rrAwkQRrUOYrTz+nDwC2rlpJR1QOfJZR5PYI5TEficmIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htvsYJBX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htvsYJBX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e782e955adso1301804b3a.3
        for <connman@lists.linux.dev>; Fri, 12 Apr 2024 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712957126; x=1713561926; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FvrkK4kpw995XmHYW2obRO5lJ+l8n49TprBm2Wiru6M=;
        b=htvsYJBXS3vR78mpEAA+lL4k8v/FWMzYPSIZeYElj2E60f6H9JZwCDedLBRyU4A5on
         1xxlCDH+AZSDBy7GgggQu7VnspcIluQFmdp7793ZZIvvG2Ysncwl5IURkg9eAjEgugHL
         tMahPGF9mPuBEn5yV+VuqsaUf91S5BppsZ9j9U+H3uwxpfX4Um6mqCjeZUjzUSFAiJpb
         qQqsgY1Qpc3XDJzyh+imswiw8IR800/Az7pSjKkx6kZ4ufFBKm9ItkpLKA/hGNIWvOaH
         w1BINAgmteV36WN7Wdxk8VwmPfGMZ/xtvynIvm8vVb4JaliXQ2aKrdEB79dc4Bp/Ufch
         DCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712957126; x=1713561926;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvrkK4kpw995XmHYW2obRO5lJ+l8n49TprBm2Wiru6M=;
        b=DbD2o4eEzOVaYJz7id+xXAt3FLFbNTNbPKwkqesxSPGvOqNlNhwVKzdNhjHejqJvTe
         LTIZYpBNOhayWlktleCkZWWv0Id6eIegJ7X3RlueApRdFnEYLUci0REWELWC/R45j1Ic
         qSK7IhiTA1gSbBMtVGAS1aiT5Ij0IN5OHF3u1bTr1xzshTbkVHkDX6ZxWNolHWuIu5f5
         TAXMKlyGId0obTfZrEPzw2ivcv/cEsRhbnbjnt+ZpNj75j+VuRsVLT00N3Kj4L9D+SV6
         OpE4HTaQszCmD5W+JbEEA2n65Evq5jk2EbguLuhqTVCXRJCmZekhNBvCcjJmuyl0nPON
         TJMA==
X-Gm-Message-State: AOJu0Yz2dr0CxROfrqxDmbqu6SQGI2TrWnhqsEvw29JisV3nugiyFRhr
	M/hdJQU7/m/26vqd8r4h+ceanRtxZfZMv9JWCyIMcAgZIeNbCdmarQYklgXwtlUEJBZo+erxBGC
	VicToH4kbKBMhJoLQLxzET6iss3XkjUbi
X-Google-Smtp-Source: AGHT+IG/wLAHV8lzWqMOY6K4Far2ydaHMybMScv40uHShEP0gNSRsqTyTnHMdl1CFUlMrB89jnWROz/+lb/O9uf31Cw=
X-Received: by 2002:a17:90a:5d83:b0:2a2:7a00:f101 with SMTP id
 t3-20020a17090a5d8300b002a27a00f101mr3315882pji.47.1712957126130; Fri, 12 Apr
 2024 14:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 12 Apr 2024 16:25:14 -0500
Message-ID: <CAG17S_MphDzOwu5xwqGfD7GeJd+ww9JZ1w77ia-cwyaAYpuqBw@mail.gmail.com>
Subject: Pi5 does not always connect eth0 at boot
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I have been using connman for a number of years on my Pis without
problems. The Pi5, though, I notice that it fairly regularly reboots
and does not get a valid IP address even though the cable is connected
and there seems to be no problem on the network. None of the other Pis
(3b+.Zero2W, 2b) fail to grab ab IP at boot. Is there some sort of
race condition that is causing it to not grab an address. If I restart
connman or force the interface down then up, it grabs an IP and all is
well. I have noticed this with the latest connman:
connman-git/now 1.42.r383.g49b16df3-1

Apr 12 12:20:02 pi5 connmand[54339]: Interface eth0 [ ethernet ] state is ready
Apr 12 12:20:02 pi5 connmand[54339]: Interface eth0 [ ethernet ] is the default
Apr 12 12:20:02 pi5 connmand[54339]: Interface eth0 [ ethernet ] IPv4
online check to http://ipv4.connman.net/online/status.html failed:
-22: Invalid argument
Apr 12 12:20:02 pi5 connmand[54339]: eth0 {add} address
169.254.184.199/16 label eth0 family 2
Apr 12 12:20:02 pi5 connmand[54339]: Interface eth0 [ ethernet ] IPv4
online check to http://ipv4.connman.net/online/status.html failed:
-22: Invalid argument

down then up:

Apr 12 12:23:00 pi5 connmand[54339]: eth0 {update} flags 102467
<UP,RUNNING,LOWER_UP>
Apr 12 12:23:00 pi5 connmand[54339]: eth0 {newlink} index 2 address
D8:3A:DD:D2:AE:3A mtu 1500
Apr 12 12:23:00 pi5 connmand[54339]: eth0 {newlink} index 2 operstate 6 <UP>
Apr 12 12:23:00 pi5 connmand[54339]: Interface eth0 [ ethernet ] state
is configuration
Apr 12 12:23:00 pi5 connmand[54339]: ipconfig state 3 ipconfig method 1
Apr 12 12:23:09 pi5 connmand[54339]: Interface eth0 [ ethernet ] state is ready
Apr 12 12:23:09 pi5 connmand[54339]: Interface eth0 [ ethernet ] is the default
Apr 12 12:23:09 pi5 connmand[54339]: Setting domainname to local
Apr 12 12:23:09 pi5 connmand[54339]: eth0 {add} address
192.168.1.128/24 label eth0 family 2
Apr 12 12:23:09 pi5 connmand[54339]: Interface eth0 [ ethernet ] IPv4
online check to http://ipv4.connman.net/online/status.html succeeded
Apr 12 12:23:09 pi5 connmand[54339]: Interface eth0 [ ethernet ] state is online

Is this a problem with connman or the Pi?

Keith
