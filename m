Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35E70
	for <connman@lists.linux.dev>; Tue, 22 Jun 2021 18:10:18 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id k8so31224712lja.4
        for <connman@lists.linux.dev>; Tue, 22 Jun 2021 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZjLYwIOYpGyHiYsySBcQ2+1UdD+tmfRnkTBSxdQUCOo=;
        b=jx37PbVycaNwCgDOvk/DUpf1ViAa13U1mYBQFeqAK/nS3MFAr5H0fT+PvSg1WFJj5m
         HLqBEcjsgeYvYbEMDWlSSJj6eH4eDVyXJxNNTIEVLs037fgH29zEglQSgnxsMBGFFZXQ
         2VDl7AR7W6nF+GZWBQIGCI9VlfRVdh2n2f2fwFjZmfjZRdyLitalFhxDqlyU+6Qa9jcS
         KjVvpZ53rNBzGJ1lG3B6d3MH1nQ0k49vDGtTSsjKWtdrhSFFrfV6w8deMOQQf3pM96nX
         ZBrOqMXltXmOiBQRBYzrMLPEcSr16Xj3fPL9jgvAfdD7aj94pbkPbXoHjoaKE/kuDhGg
         oJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZjLYwIOYpGyHiYsySBcQ2+1UdD+tmfRnkTBSxdQUCOo=;
        b=kPM5p0k3AonsuTnrEK+E0EkW+zExDhCzzUJYnJVamA39fw/q4A7E0I79Zy7p+1IhNo
         AIiQeViMuUj+tlr2G4ZLyFJHgE9q44QwzmoPo5aRgR0NW/xvrUdG3ZQxyDji1IRTO+Ol
         CKotjy20yV3uxbN7Br046noLdU+nYnFEzTBJsJM18N/xdnAprSkqtD42ryMNLT1Pn9AI
         HpuhIkuSAjsbHPL+Leiholr7m3lNbtD60Ukz651oidKNZjRsLIZWWr7867nwzO9inoCE
         5Nd3JJ9rLlzSFIpffgUoQ3llXdEmjsJVhapUtJtnlvSt+2LVQee5WiqTi8kfipQX79W6
         Wx+g==
X-Gm-Message-State: AOAM531HXC7h5NpMCIKoXGZDuoZ3wZ8jUeX4nX9RYTETEc80fPB3RdVj
	ApwVbLwIIXdVBD5R8J4WheCXXIw9D4cs0hUwQdxmnQcx6BA=
X-Google-Smtp-Source: ABdhPJzEIUE5/qksRicvDBExEasvYwHaogW1xWrtUlvoXuWQnuUZ2mmlq9flmaL8LDI3c6NB5tgdHjEdiLKFY3+Z6xU=
X-Received: by 2002:a2e:9cd:: with SMTP id 196mr4231478ljj.457.1624385416662;
 Tue, 22 Jun 2021 11:10:16 -0700 (PDT)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Andrei Datcu <datcuandrei@gmail.com>
Date: Tue, 22 Jun 2021 21:10:05 +0300
Message-ID: <CAAmFs7=AcOmoNWVaGEoi_9FPgh3NBS1LiceWOVQgL0xS=hnKYw@mail.gmail.com>
Subject: Clearing service error from invalid-key will not invoke the agent anymore
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Using version 1.40, I'm trying to connect to a basic psk wifi hotspot.
If I input a wrong key to the agent request, the service will
correctly get Error == "invalid-key" (and State == "idle"). Invoking
Service::ClearProperty("Error") will put the service in a weird state:
every subsequent Service::Connect() call will fail without ever
requesting any agent input. To leave this state, one has to call
`Service::Remove()`.
Is this expected or is this a bug?

Thanks,
Andrei
