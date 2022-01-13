Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF53168
	for <connman@lists.linux.dev>; Thu, 13 Jan 2022 15:44:10 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id m13so11062444pji.3
        for <connman@lists.linux.dev>; Thu, 13 Jan 2022 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=8iv1cc6+N7NxegRlml9FVcojs1uYZb3Hb8JJL5GTPKQ=;
        b=TLVoC5/lJg9ZciBdWYfeu4pfrktC2KMK48IqSOm2r4h82ZF+I2of+Oh5AqzIzQFm/q
         l5PusmBXyodfz+SssdHmJ+Pn8w/qRgzlvBUUPQgLeKj7CLkJIOqlrDQ3oB+obz6CsrnD
         wx4z6LrN+qyrQgGgHbofxiQ/QBCgDdS0EFbHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8iv1cc6+N7NxegRlml9FVcojs1uYZb3Hb8JJL5GTPKQ=;
        b=uX3OGCaPnXv+X4R8uittaqTPnasUj2cB/WKyrFnsB25qHDnUbtag4kwO1hO9sqbH3k
         QaaIrisSSFOz0aCKQxt3FElKfjceWyfkmZ+JbK4peJh0AYeKo0lc7+3xvPKc/E+zJ8ls
         +M3Ze/sJn8tlcWryHpEQD5EaR6mYrOZ/x5D/1x7TPC1SMw2Nq3YZEj3ewcRdTpJEzE4l
         hE1Y8WAa/aTQ2m2XwsE6tOVxSxR2c49Y3ZfhfVcGY7BlRR+Jisd+0YpOZR2JgIGW5QEP
         Cwipj4WR7olomREi0XPsohBimLL3m/QHI2zp7iURuWIbCVQhEpHUt4/MocD38v0IxQ11
         b3ww==
X-Gm-Message-State: AOAM531Unqf2Ly84XHar9fAi7Wg+VNdDmXjer4O/cO9CHT2J60DQp1T/
	dPW9eB6jYPNwzXa8ibY3jrBT+Veme28SRsCasgd1iZNE2uEoKQ==
X-Google-Smtp-Source: ABdhPJxzoOKG8Q3hsDqRgdJ+AAoTDpJNNJWQ1e9X8YdMWCPwuP1aZGdzTB5PCa4Pec+iRwNLeHor4mCnK3vaoTap/j8=
X-Received: by 2002:a17:902:c651:b0:148:b0af:6f80 with SMTP id
 s17-20020a170902c65100b00148b0af6f80mr4967726pls.130.1642088650005; Thu, 13
 Jan 2022 07:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 13 Jan 2022 16:43:59 +0100
Message-ID: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
Subject: Network with same ssid question
To: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

I'm not sure about this use case. If we have multiple networks with
the same ssid, should connman show all of them?

Michael
