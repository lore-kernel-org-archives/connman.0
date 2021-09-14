Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03543FD0
	for <connman@lists.linux.dev>; Tue, 14 Sep 2021 06:58:52 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id i23so10907684vsj.4
        for <connman@lists.linux.dev>; Mon, 13 Sep 2021 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gzwNlQnhgntPXRKMT/P18uv5JdbzPmC+3cc5sbERe4g=;
        b=QgmsVqedmKgK1C+41ny5wY0n+hGVxSfuIYD9QIwyhDKpI5t6bSoGeY8DCM1dMvt1tW
         ydLP2jC3+eAoT3u3RPHAzYWeFOWSV7Bm2ohpeykMKSNO93iDBO0K8vOQu1VCq4rj9fW1
         UoGbEV9MvHthWcoaPvMqxeEMqTnC4N0gcMosTKlciwkZr27biC4Vrd34/1klmvQw2Q6d
         I12KXOUuwgj8ZUvUgfDuUZtu74jnzNj0QvOYokzg/WBn1Juja2PHDf/fYy2yryKAXyQU
         ObAU14hYLJrVz8etjNBxK4WHhoPm9pvfn6ksiHBHKIwjaH5R5BT/Gd4LFe2hHmNmIwPB
         k0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gzwNlQnhgntPXRKMT/P18uv5JdbzPmC+3cc5sbERe4g=;
        b=d3wSDftkqkR+456KbJrpdhFZsiUEx8pYagg9YuQk6VnomQ4yPZ4IVJstg/OmmOLtoY
         eeivXnMPzdTRlO12HzA7QgnwcdVf3BdqRC5F+0RHWpDX58Trpa9keIWpV+8+a/oMbeWy
         lDSJqIIY+xuKFEWgzsVDSWwYBFuJnX1pg7JfOJRZeSCxfHArFUkCOwqrsscFDM+6EIEv
         yxEjrMhgmgfCyV/L6PaSF8Ys7Pva2oB4VVEyvPnOj1M1+y+SxU2D4L/gMgtSRYUZ2xKB
         e/7ywz5A340zB7l1JSbqfjGKxroM42sdoTZwLQLa/LpR37TcLxIsHc2L3ZNRQO4sZj7K
         oSvw==
X-Gm-Message-State: AOAM530ZedKlXEv+K8A8uDWaz5dE4ys9v4QKCrLWlfS1olKIfdv9iWrD
	s52B3dNfObxy9cEPwl/fkjc2gz5Bo5/BK6Xcabim4/ci
X-Google-Smtp-Source: ABdhPJxnh+/C6jDkkffJ5s1lJhC/S4nmYcd5Vc6cUhlxWJgEPy8LjCeJIWWQ/CipHzvnMjDy+0qUGj/V/EquZcfFvKA=
X-Received: by 2002:a67:f653:: with SMTP id u19mr7425534vso.51.1631602731500;
 Mon, 13 Sep 2021 23:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Date: Tue, 14 Sep 2021 16:58:15 +1000
Message-ID: <CAA=hcWQTDvN-vh+UgXx8jpV--NPBrXWWsd1O6Sg=FVufPapDWw@mail.gmail.com>
Subject: Connman stability degraded upgrading new versions
To: connman <connman@lists.linux.dev>
Cc: Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

When I used connman v1.35, it was very stable, it could switch to 4G
LTE automatically and reliably when the WiFi was not available.

After upgrading to version 1.37, that network automatic switch is
gone, I have to restart connman to make it work.

After trying to upgrade to version 1.39 in the Hardknott branch, I
cannot not even get WiFi and 4G LTE work, the WiFi network was
assigned with a fake IP address 10.x.x.x, it could not get the 4G LTE
interface. I have to abandon the upgrading. I was told that connman
1.39 did not work well with Hardknott libraries, I have no idea who is
managing the connman release on OE Yocto build.

What has been changed in connman new versions? I must miss something,
I was told that connman uses WPA supplicant for WiFi, I have used WPA
supplicant v2.6 for the connman v1.37, could it be WPA_supplicant
problem, or Yocto build problem or connman problem? My apology, I
don't have good debug skills to debug it, but if you could instruct me
debug technique I'll provide more testing and debug information.

Thank you.

Kind regards,

- jupiter
