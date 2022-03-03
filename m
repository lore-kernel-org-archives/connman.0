Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641B036A
	for <connman@lists.linux.dev>; Thu,  3 Mar 2022 22:41:48 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so7504341ooi.0
        for <connman@lists.linux.dev>; Thu, 03 Mar 2022 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=VBHICdCCU2jgbDBFsIbCgiDoxuEwWhphH8p6WMRHRfA=;
        b=bCt73ydQAM2gjwsz/pQWHK35rI2qav6js4GeUJk/7wjl+E3bToitqdpMG4kUljn4LT
         AzP8H65pfEI6uaULFbRd5V76B+hl1gHlMURgGkBXBiFjDHweDmXRZLa3Nw1n6TvcXcs/
         KM0D41/b0ZSGD16icQxDy/i5nHB4yUvOre0ZzpmJsIXsH6e9+w2ZajN5Plboy/A+yc7f
         AFLt2h3Vfpb/XyNh+VLwYWRPQ8gqhMsXwk5a1XmkeTDcvjpgrfLk1ZwjWLEvlgtI4aZP
         3Fo0sOPlkpJBeLR/MbIoIdnmhRz/zeixhUKIVRSZZsmWjzqMSS2DAqnznF1hByUNuQpS
         dcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VBHICdCCU2jgbDBFsIbCgiDoxuEwWhphH8p6WMRHRfA=;
        b=3uFASPJy+bc0T2jopAfw9WyTN6FBi74HzCciWs09wym2PnLRxUAgHEQN9cRFHGiIxB
         U4MHF0J83fHfuG4vgDHXTDhKGIXTsYs1E+yd4YjkiJzHMLPeCDkPH6Jqt5VqhE40dpr4
         B6yamD/VZHzml2CUi+cxX9AER7Xa6JhDMT7YiII+OZCditNZLXtrjRuRBq9nxwWDwRCo
         5/eTeTNbaOM+g4nOmNH1wXnZ95ZykSoFeqGjmH6dZJnQVx6zmumYUl89lFUMr6/b0rOh
         Czd3Yo1JVfOp9JTT/AnAoj6g0U/9drkthld/RG1XBUH/inROhm57HnK+FdzVCR5NRTw9
         3OKg==
X-Gm-Message-State: AOAM532X+eeTfXrmvTAo9+hK2KrIuYOPGwcnPI7ibmJCy3XvP2XkKPiB
	A7TGHIeIuf2wSnfVldP7L/w7Rc0TH53fGIJXE3BRXYdneaQ=
X-Google-Smtp-Source: ABdhPJzmrsPGVQsWhvxVL9jr+mnZuuTrUCJ1ytnpIHDHomPni5SGgLd+vjyB6LNoQcULVwFv1fqbLPPVcaNg53Ua05Q=
X-Received: by 2002:a05:6870:5494:b0:d7:14df:d870 with SMTP id
 f20-20020a056870549400b000d714dfd870mr5774567oan.55.1646347307408; Thu, 03
 Mar 2022 14:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 3 Mar 2022 16:41:36 -0600
Message-ID: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
Subject: request for feature
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Group,

iwd has recently added a feature which can allow headless wireless
configuration:

client: add AP scanning support to iwctl

Would it be acceptable or possible to add the possibility to do a
'connmanctl scan' when iwd is configured as AP? Currently, connman
does not work with iwd in this mode. This addition would allow us to
ditch hostapd for the headless music player we are working on.
Currently we use connman with iwd for normal connections, but when we
are trying to do headless wireless configuration, we fire up
hostapd/dnsmasq. We would like to just use connman and iwd if
possible.

Keith
