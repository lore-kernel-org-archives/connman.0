Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4021378
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk1TLp+o"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so5082436a91.3
        for <connman@lists.linux.dev>; Tue, 07 Nov 2023 18:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699410783; x=1700015583; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxmNh6sjP4obhuNTtHjWbcBuVwdRyAHOqO4IaP5HoNQ=;
        b=bk1TLp+oV3Ah3izxxv1JvPZSKn2T92C59CTO9wqPEfwC11csQuALmCzJWrg4/QfI5f
         2TdDOEbq+/cX1N3xOYs+6PyXxokBz2Sct9P2cMqysZ2xAfkQeQqmkmBwsXwAq7j+Z8pF
         4tG4Wj9lf//dYfN69uZngwlNgdUHB4ygIYSoEkhr1tjDM9WD+Av8u4iZ8C7iKWRK44F9
         JbAGSjcJYwk6zkUy2qkadBQTsnwiSQFDFtgqxV+mihuKkQEt28ta3IGE2HlQuQiCV42h
         /1GkU4A4y5IGC+a9sMS7anExVejEgprGxA/T3WQDDEVcbgxFM69L2asyXHEn0KQwlN+Y
         FC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699410783; x=1700015583;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxmNh6sjP4obhuNTtHjWbcBuVwdRyAHOqO4IaP5HoNQ=;
        b=gS0Bjye+ztic385IGFTY8E9qHeQPdF8QJYfBjMTUfHP18uw04Z5hEPKkf9REfXVDsp
         a7pPDxKYiNWPMQeNx+ynAirSphdMaXh0ZZTybme3RrxHZDoclkWoDoMLSnH3YsK2Tx45
         wWJU11zaqHXwsvaG68PxNYDZfSyYQOwi1INguUS18X9aprQQowptzsae4qmmFBMbP9nu
         quC5MYQLcm8cLFvd9buN3XpELRijsSp4Jr86HzOTowme/3hKF3YWXk55PFAw0ohiUHRH
         URdzDrUNfIJkjya0ZAZOQEJJqJLaslA9JOz1J9BSLROOVzXplBUlDP4nG8fjzaGoiq5Z
         wFPg==
X-Gm-Message-State: AOJu0YzwxVtdWo7irnR79fzzqC6BAP+EaBhBhaESz1gZv1+2H4HNeVp1
	Ttr7WSX0WkdgHI4OdSZ2pRg6puwPaFFhe8cxx+Hn6LlXjwM=
X-Google-Smtp-Source: AGHT+IFoCVzcdwaMmuvi0NeZvvbV60PFwOoBBE2X+Z3JzqZmi7QHfHWiWSOgmcp2MDierax6GtqnttCHTbbQEEQlsww=
X-Received: by 2002:a17:90b:3887:b0:280:1dca:f6a3 with SMTP id
 mu7-20020a17090b388700b002801dcaf6a3mr522732pjb.43.1699410783038; Tue, 07 Nov
 2023 18:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 7 Nov 2023 21:32:51 -0500
Message-ID: <CAG17S_MvGT+fP8-L2zSazgenKS1kkm0hYHLGJnrFAan2xpMQqQ@mail.gmail.com>
Subject: Feature Request scan SSIDs when iwd is in ap mode
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

We would like connman to be able to scan for SSIDs when iwd is set up
via iwctl as an AP.

I last asked for this back in 2022 and a patch was developed by a
lister which did not quite work. We are still interested in this
functionality. Is there someone here that would be interested in
developing it? As I understand it, the patch is to the connman IWD
plugin to have connman issue a scan command to iwd to be able to get a
live listing of SSIDs.

What we do now: We have connman and iwd managing our network
interfaces. If there is no ethernet connected, (with connman and iwd
running) we launch hostapd on a known IP address with a SSID name and
key. We then connect to our headless device on that known IP. Once
this is up, we are served a web page on that address where we can
select an SSID and set a password. We then reboot and the headless
device connects to the SSID. When it reboots, connman connects to the
selected SSID.

What we would like to be able to do: Get rid of hostapd and Set iwd
into AP mode and then have connman be able to issue and receive a
'scan' command to have a live scan of available SSIDs. This feature is
intended for initial provisioning.
What happens now if we try this: connman has a store of the SSIDs from
when it scanned them before iwd was put into AP mode so signal
strength and availability are not 'current'. If we rescan, these SSIDs
vanish as connman does not communicate to iwd to be able to get a live
scan. When we issue the scan command we get this:
~# connmanctl scan wifi
Error /net/connman/technology/wifi: Did not receive a reply. Possible
causes include: the remote application did not send a reply, the
message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.

The command line inputs to iwd that we would like connman to send are:
~# iwctl ap wlan0 scan
~# iwctl ap wlan0 get-networks
Somehow it is sending these to get a listing when iwctl is in station  mode:
~# iwctl station wlan0 scan
~# iwctl station wlan0 get-networks

From our perspective it would be awesome if it worked as it currently
does when iwd is in station mode:
~# connmanctl scan wifi
~# connmanctl services
