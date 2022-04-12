Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AD1876
	for <connman@lists.linux.dev>; Tue, 12 Apr 2022 07:23:30 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id t25so30623820lfg.7
        for <connman@lists.linux.dev>; Tue, 12 Apr 2022 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=L3UE8rI4y97dE3IeVMLVGiKswTQjEcBHfPDhrvsM5Wg=;
        b=qgJVw5GhVi+LBEc0XhP5omVV/vWnXRF1SKjcO3nwTC6X+QphPQ5a9/uMwWhnxZk2BO
         pUXy2XVaVtzTF1poewtYMOZbJ2aaFbAS6aKi97aEj6jM31PxYTmdyzg753QAsuhiRMz1
         x1ePqbXLqam2oGY4GhCaRI32efJGzFEaSfZX/dV0vh1F6FSWcNPyFYMOm2f2coquywgn
         NDsaWRLJbFYFwBbW8uvZe9VlFwCGsBEzalCWswpzJF3n7GwwnXmtFSUbGPIK1rbxVtXa
         6+c8sQuXSQeo8HkI/1FqHPg4UN1teftdqhriuvgAnub6ekUVWJOEvYB+2eR6JZRk23y+
         cl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L3UE8rI4y97dE3IeVMLVGiKswTQjEcBHfPDhrvsM5Wg=;
        b=hQdCN1PrnPxeQVmOYyQEOD7z3UwnzB1Le63BWiRCYKwm03sMX5Dneh+ERlQP7bfSgP
         x3/SbS0DM0uesN3ju++EgXiRjJAVfGinlInpUm7YZomZ24t5laNgLbUuIXniZcni4OtM
         hWJNuO2DTitXKEB99TnPs4Gdgov2C2F92c+hP4LWlYWPfTOzOvhQH3bwNyAmsbvFl3Cm
         uhGlGF0RoIXioW7tFDzUwCermxp4jrZ3PwjE2tH2GGNdiAPsFxV7ZKHFbDOgQ9JS+mrd
         LELenFOQFIqCU9tj8CBe+HGfx94iOHJDPiyZ0keA9G+bkNb9v0CFpzZyhs7gvOOYYyIA
         vDtw==
X-Gm-Message-State: AOAM533VFtr50/OcvznttiWS+3L8zFRWW33YQUbABGT3O7JNak/zEzAQ
	2vQtDmIY/lUYhk7bcHyuuB+j3iPWz5Dp7Wg2EHWbyYTKdqs8+Q==
X-Google-Smtp-Source: ABdhPJxFhfCwuXtKnhqkKYgcLG0nWxYP4Joa1iFwYamZDeuTH6WC66yTFL+gVJuXy4WBEMFJ8anfP2ylx03MQC5Cd28=
X-Received: by 2002:a05:6512:1106:b0:46b:a65e:cd35 with SMTP id
 l6-20020a056512110600b0046ba65ecd35mr6328053lfg.329.1649748208471; Tue, 12
 Apr 2022 00:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Vishwanath Chandapur <vishwavtu@gmail.com>
Date: Tue, 12 Apr 2022 12:53:17 +0530
Message-ID: <CALQBcOdNjp5WvTXGVLBynASHc0K0fDArggDo=imX31dXJkHjSA@mail.gmail.com>
Subject: Request for feature
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Group,

In the current design of connman, if a client fails to discover a DHCP
server, it will assign IPV4LL ip address.
In some systems it is not desirable.

Hence it will be good to have a runtime config like "fallback-ipv4ll".

Please let me know your feedback so I can create a patch for this?

With Regards
Vishwa
