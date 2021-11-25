Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802282C81
	for <connman@lists.linux.dev>; Thu, 25 Nov 2021 23:03:47 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id i6so15142272uae.6
        for <connman@lists.linux.dev>; Thu, 25 Nov 2021 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JijBsQ9wD61X4Q+LD5hq1lToF3omjCtGlvnNxNKZHbc=;
        b=ZNreQ/Cwkb7M2yJl+mkdBHk8oPiQzbzDLXywnn+BZ1wRtcKhrQxSEDkv+XN/+jxkL4
         eemYn2HAHUT1qFSMaj/DLDAQNM85EMA8/Bo4J/JCQPPD+V4xhouBmsRIeb+LBOf4lmEO
         EoEq2EX8Ns+sq6E2um529CbvzhT93HI23GWuxErnrLAvkrPcLWWxQG5tMwfjUKRz3QBG
         JI14S3QimgQkXsA9BnT0ejGm7B2WlL5s+pXMmZI7rlzP9vUuVKFw9yzVlX17f+fYg5sX
         NRz+tvYJkLt5FAxm7scUjtKcw7DAh5c3tOAqYUqwLyW17zDoYOrPKHzeqIG1JOOVMy9F
         P3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JijBsQ9wD61X4Q+LD5hq1lToF3omjCtGlvnNxNKZHbc=;
        b=6uyeALJ/at4PhyWtgps6w7FWRX/c1Xe79zfqpvsdRVlXG1i89Px/qBUDS0e0qhCHDa
         N2UpoOGSMDXo1E8hLeK4KSh/Cp4e/X3sIXdmBqbq4JykmTJHUWiIp1hsHAUvq1zxT5mi
         +amFFGVo4vA7w6Y95+haEXQb1Ofccy4DjdxrcpTpnBK0Q3JNl+ITS6vuEIiTeQQ1ZTcs
         aN8JIfVu4V2iLnz27zP8rVOnO9Uo3CKqrgYnO9J9QxNn0BsxpOd7BmGJzMK/3bVQXUYI
         E0M8RHe++zgTdJVTegh92kiS3c+qQkOYMIvV+G0ivg5WL793MBhlM7BBHDjHbNjhmvon
         sIBQ==
X-Gm-Message-State: AOAM531zkovkvSluSIhp0j1KGNAO+17WF0dPICD0dsaK6Dda41/UlXhT
	LID7ORj1gzHvXouw3iGPEQvPYJYu9FMAfJ8xJkk=
X-Google-Smtp-Source: ABdhPJxwkT4BSYjgcd401tr0WN7sXikZDFif9ZVy0mI9IF6oVQlIr58SS1JjogiGP3yxak795V3oRSHWD8CVeUqGmw4=
X-Received: by 2002:ab0:6ecf:: with SMTP id c15mr32464290uav.113.1637881426472;
 Thu, 25 Nov 2021 15:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Date: Fri, 26 Nov 2021 10:03:10 +1100
Message-ID: <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
Subject: How to create connman_1.40.bbappend to enable and to build connman
 with iwd?
To: yocto <yocto@lists.yoctoproject.org>
Cc: comman <connman@lists.linux.dev>, Daniel Wagner <wagi@monom.org>, 
	Armin Kuster <akuster808@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Please correct me, but it seems to me the connman is moving to a
direction to ditch out wpa_supplicant and to use iwd, but the Honister
still configure connman with wpa_supplicant by default, appreciate
your advice:

- Is connman with iwd stable enough?

- How can I create a connman_1.40.bbappend  to replace wpa_supplicant
by iwd configure?

- Where are the documents for configuring and building connman with
iwd? Where is the operational guidance to run connman with iwd? Can I
use the same connman dbus APIs or are there any dbus API changes to
run connman with iwd?

My apology for FAQs.

Thank you very much.

Kind regards,

- JH
