Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06443FC3
	for <connman@lists.linux.dev>; Sat, 11 Sep 2021 08:40:12 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id rj12-20020a17090b3e8c00b001991428ded8so2504091pjb.1
        for <connman@lists.linux.dev>; Sat, 11 Sep 2021 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SDpCmmCHVAS8pza1eWqTsfT1UjfgCzkL+T3o6JM7z8A=;
        b=mXEFYPEUHR0CIC2WVrumgAX6JfTmtmQwN5W86joIBsSgqHBUEOU4Y8vIlFNgfDHubF
         upl0qg+AZ0YyptUN9KIC4ZEU8PtbVK0lQDhEaMh9E2hBgwZl91uQpf6t9OBB3WE9WPQU
         dZzWVjWkk+KhpBZ5NBG8L4bQtS4gs+CtfhGwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SDpCmmCHVAS8pza1eWqTsfT1UjfgCzkL+T3o6JM7z8A=;
        b=7f2OHfBsbZmMUZh8ppW5tZN/wljCCAmkaTRlUCldUIM0CZFrP4Rfk/WeQEC+WzXvOV
         EscGTWPEO6J4a44P0EimXV37ZBK+bpILWCQVwpOadlcDb9qxeWybfoEEkqnJLBRRSwma
         W9SBVWIHvjv4amScDvWRAmrgcA05wvtFFias7Zz2dRRfEOVWySEURXMcRij+mhFcatD2
         ENW1MPOqQzUQjzo2oA2Aj1Za9X6LaVFxnfQRPEn3AzZxYSBAfneMJlQUnWdgnL4+MkcT
         IDTNxl5RylL/fWwG0DTO0TP7sM2e4RvW94kADPH40QD8NWlhMZpv4tJJbHFp5tDo8ras
         pTbw==
X-Gm-Message-State: AOAM531nAqa4SH8LTkvXRQ+V4djUtlI+MgWjAbmGpSR0T1cEDdCQKa3u
	Qrl8ISZJ95giUARLmDSGsJQxw9mlA3I/4fo7OmTNrwln9hQ=
X-Google-Smtp-Source: ABdhPJw6DLu+Q/XfC7GkjWjTFv0mHScIM7dE6HD9bN18bO1hULYRdeG1fAsUwf6/zVGCrOJFoNKLOfe5DufnvtBUkRw=
X-Received: by 2002:a17:90a:7342:: with SMTP id j2mr1927992pjs.59.1631349611605;
 Sat, 11 Sep 2021 01:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOf5uwkzZU-vofxOZyNBDu=5emmkoewjPtAAZPhhapumKdh_gQ@mail.gmail.com>
In-Reply-To: <CAOf5uwkzZU-vofxOZyNBDu=5emmkoewjPtAAZPhhapumKdh_gQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 11 Sep 2021 10:40:00 +0200
Message-ID: <CAOf5uwkQLTfdZBGvXwBUMEA4Lx00BuzL-uEJRDzrLWp4HFQXYg@mail.gmail.com>
Subject: SIgnalPoll dbus function
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all

I would like to know if is there a more simple way to get the bitrate
of the link

 iw dev  wlp2s0 link
Connected to d8:8a:dc:58:99:57 (on wlp2s0)
    SSID: HUAWEI_B818_9952
    freq: 5180
    RX: 1592950584 bytes (727134 packets)
    TX: 121351631 bytes (625159 packets)
    signal: -56 dBm
    rx bitrate: 585.1 MBit/s VHT-MCS 6 80MHz short GI VHT-NSS 2
    tx bitrate: 650.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 2

    bss flags:    short-preamble short-slot-time
    dtim period:    1
    beacon int:    100

Some equivalents come with SignalPoll of dbus interface of
wpa_supplicant. I have implemented already a way to put in the
dictionary the frequency where we are connected because is already
stored in the /var directory. Can this be added with a proper patch?

Michael
