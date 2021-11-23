Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55772
	for <connman@lists.linux.dev>; Tue, 23 Nov 2021 10:09:04 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id x14so2020162uao.0
        for <connman@lists.linux.dev>; Tue, 23 Nov 2021 02:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7rhjRHVR2CfVD6f3H0hMJvqs08d9KiQbnb2XSMNGP/Q=;
        b=o3OEzaKxeYd4mc4M5sWVaYcFff8q4AOXw1tDKSNGrTgstu83R9LWK+N5gMPF/fIKEi
         BHAixH+H9pd9hhYTVaCNAW5M+7JU/wQ84/ormNLSMCJySReEEnft8gqE84B/6YQCB9rc
         x2SpYO5XKqEnVkQcYszFMeA+3aj35z/Ae2mRHXMfM7wEm9jOFk6ENvpQMhKluCvBl5X3
         cyivkZmP5NrPsBNRrvCLX0CsVUedPHywIkvAhpvvD4B4i5aznv+QSznvBkrH4sDtxdrE
         vDtHf3sYkSoBEj/2Tq6kqSxjnyC67aPAW1TEjq2XiE8pkLDKYl1C4KjOin5arpEwCfTz
         e91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7rhjRHVR2CfVD6f3H0hMJvqs08d9KiQbnb2XSMNGP/Q=;
        b=RlCe8/cn47lgYvYvFlldiZgVTBF3/VNbvOQjTji9fMGb1V7HS0i32sQWrVdAOP93pH
         2j7QIzBMCSqACTQNX4v9anGV5ZmGA8zV+V1id09csHv00wZQbHBhJKnyn7ajmu/lfEAE
         Ut68ouTVPsRRVRnGuZcONH/0fhSdDM/UpBwzi/lyxsPK3TzNGNBOu5xUgJlhJQkLTGmX
         k/1dWJaeZcfEhxyKiPIysCkfFCPtdZqiZS9A2zEGIkV0ieDPYGh/QVgBjfNt1rR2WPso
         5eYSqQvkqIm/mpKCSNTXu6OfDDWd5j+/Hnq0NDnKpNBlUN5FMhxC0fiEFghdGxSsDWYP
         oKhg==
X-Gm-Message-State: AOAM530ZHpiL9is/Azw3h/n6KJ7/noxWhQXGC0vHPq0v7NIO3jldv7ko
	NiCWF1Zhjff4Sy1BQK8/lGAuD9foIVS+k6lXiAnpPGPN88I=
X-Google-Smtp-Source: ABdhPJwEmwq48N7XOYS0QcW31lGMCFZ5dWTM+qvE3hnhRq4LDoTbZE/kpg3Y+rJy28r3M/wRZl/37+QkkppvwPt1nuw=
X-Received: by 2002:a67:33d1:: with SMTP id z200mr7136808vsz.1.1637662142951;
 Tue, 23 Nov 2021 02:09:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Date: Tue, 23 Nov 2021 21:08:27 +1100
Message-ID: <CAA=hcWTGxMNJgUacD=ATZJDXvkWBKhryPXmhHd_qvgOcGPjtRg@mail.gmail.com>
Subject: Upgrade to version 1.40 broken WiFi
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Cc: yocto <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I built connman version 1.37 and wpa_supplicant in zeus, it worked
well. I have just upgraded OE / Yoctor to Honister, I built the
connman version 1.40 and ran it with wpa_applicant, but it is now
completely broken, no WiFi IP address assigned. I heard that a new
version of connman is going to replace wpa_supplicant by iwd, is that
correct? If it is true, I am not going to debug it with wpa_applicant,
I am not familiar with iwd, the Yocto does not have iwd option, are
there documents to build Honister connman with iwd?

Thank you.

Kind regards,

- JH
