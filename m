Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC970
	for <connman@lists.linux.dev>; Wed, 19 May 2021 12:15:52 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id w7so1977385lji.6
        for <connman@lists.linux.dev>; Wed, 19 May 2021 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=478/0K2kwIZIGFM7TNK6b7/DFlc90gmaHSbEZb6YTSw=;
        b=oGryENStZnwx14mhszd5t3K8YcQrFRVqI4WtycooXSviioc3cd3A9bIQ9RrqITpB3s
         jIy+uYZOOMmjdESSCAbNVMaurrazxJHTfEnPXyNlfSJyqd/0UZXmfzheBvlKaSiYfMDq
         fadzPAOvymuZQlg8obYzdPvSrYK+gk6Gi9VANfq6tzUh8gy0FzcARLv0ah05XTbgkiV4
         TA2ii6tSg2hES2P5en/6kxtdBE0JA1/vGVAbDgaysc5rLalQbcE7ttTiCH9Gyyy3Gc7A
         8A5LbuuTq6X3DYiWM4ykfGkm2C8zAZowy+HPFe4uTW8JjykBhWh0kUDNhhYRapBSlp0g
         it0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=478/0K2kwIZIGFM7TNK6b7/DFlc90gmaHSbEZb6YTSw=;
        b=B6RYTljsHN2A8uDHd4kjak08lj/yd/0k35rOyP7qCMhYP7M++EXBC4nOQhbEhA4RM2
         v8FnVF2lWvwDsKRElYUoGzbNytJKAl+Nzu5nyli57L+1wxyEeAeXzJkoil/25PzMCfEB
         v5LrWx8mvsSwO6eQbg1rKZJUiY9vP6HCJoYgHqJtkc2zoxVMD4nGxFW5G9Fgwqt4zvWe
         Ec2oqWYohSkixrhXehlRwfvOAuvKv/+V/o+yc+hcvbLpXbCc2c6DLrleyEnOUTyfm0ls
         0xEsqSYPVN7K6su2/XYSje/m5g+r1/DTTatpDhjMknE6XcviIOwUFFGyPhZoy0JMT0Ax
         bBYQ==
X-Gm-Message-State: AOAM532F+3ltk8WHMpdCIfXIMckMyB/tIJD+HqX1ssmSQxwr8DBLMBAz
	Neiinpn5C5VwZeVsHXHn++/p4/S4mq18Ki6YyZ2LyxNMkecv1Q==
X-Google-Smtp-Source: ABdhPJzZntLSTfNngph01Fznjv5H9N1a16RL67OJpX5+I0pDJ2QLr60C7wMEkefNfRrkcbTze1y9yWor+Rv0z/5K/uI=
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr7551398ljo.456.1621426550503;
 Wed, 19 May 2021 05:15:50 -0700 (PDT)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Wed, 19 May 2021 17:45:39 +0530
Message-ID: <CAH=dH98mErqeQf9YaZok-w5_x0=MSo38fMd3qqS=a+dNs=ueOw@mail.gmail.com>
Subject: Test Mail
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Test Mail

-- 
Regards
Shyam Kumar [ RHCA ]
Code Aurora Forum Admin Team
The Linux Foundation Collaborative Projects
