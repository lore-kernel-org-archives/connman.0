Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09018F42
	for <connman@lists.linux.dev>; Wed, 16 Nov 2022 16:22:24 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2855123pjd.4
        for <connman@lists.linux.dev>; Wed, 16 Nov 2022 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1EkFIshg1oFYDr5EPRuz+m3CC7jN05wID4QNE+O0EU=;
        b=JhDo2Ffo9meTaaPQOq/LaU0B2cp64B7hT5RWCzWfx3IQMN5dyLL5hWOQV5O2xKlC53
         mKsYqnG/EcfkcH1/6D61rR414v8DtI03A4XGlyzwvkSe8x0CMxfteqS+EX3VC8iQf0KV
         mfCZenQERU2Bk2pOMS+aFUZmtyD8stHx5NDk6CC7yauqyBEN6UBUS3F6A5W2mzVxIWX9
         VOinXhRwdjeEtGP6hK9a8i2Lg5E+g5+X4/F0M97MN95dnmEj5glst3rcWRgNClQM7njq
         /rqeyxJRkL9eIB9Q1vtWVJBw3TdHWsVK84cDJtGt9khKMaDyOmJ0bmKx0Yyhbg8iaHKX
         boxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1EkFIshg1oFYDr5EPRuz+m3CC7jN05wID4QNE+O0EU=;
        b=BJ4fRdwLOKQwgXwkFvi7YnKqCJ6t5OMB+T2HqKh6X5Bkff4qjJxbam6pfNUjp57iUW
         Hnzr6xms4BM/kTYkvZ9Aqe+g5nzCMN06iDkzbINJtRijouyJ4vE0N2T0MmA2LhfLwhOE
         gEqu5ww/oD2vVv14g1NcticiZMRonR5U/hugWZhX81js/gnGFG7Zet+L8Ngu3O9MRcs7
         ePhyig24/WlQh4zlU/dVoY5YoPESMjxjlOTXrV7N6r1pQziTzx6emd7n6jDEh0/SF5q9
         gc6iRweDR9h4QWPm5Iv72hr+gQ7nIgJWWWd7J0f2+s7x7VHG18LunGh0arqsUPgz+Rkx
         xuBg==
X-Gm-Message-State: ANoB5pk92fERLfCLL9n0XuKFLyFd3Qsy1iAllW+vIYgUEMLEgeCwBJTk
	SHhNJw/yXD8tYkZrkIfwrE6NxPzqXseali7iTWU2qv9osog=
X-Google-Smtp-Source: AA0mqf4Qx9KJlWQfBll+bAcHtt/RdgxD2E2z/3ofFv0cB9YunSaDkJclPkMjzVI4mC8Mbqssif1zAT3pvO1SSSj9m7s=
X-Received: by 2002:a17:902:ef93:b0:186:b32c:4cdc with SMTP id
 iz19-20020a170902ef9300b00186b32c4cdcmr9623379plb.166.1668615743932; Wed, 16
 Nov 2022 08:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Date: Wed, 16 Nov 2022 17:22:13 +0100
Message-ID: <CABX3Wh7_0yVSd537F-exr20LKyNypfMg2HrdHWhe_8A2dKAr2w@mail.gmail.com>
Subject: service: 'ready' Status ProprtyChanged not sent
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a gateway running a very recent version of connman (1.41
hash:19789ae039b). I'm monitoring connman over D-Bus on Technology and
Service PropertyChanged events. I noticed that when I boot the gateway
with ethernet disconnected, and then plug-in the eth jack afterwards
once the gateway is in userspace, we only get the Technology changed
event ('Connected") but no ServiceChanged event for the "State"
property. "Nameservers" and "IPv4" properties do get sent. I was
wondering if this is expected behavior (which I think it isn't), or
maybe a regression?

Kind regards,
Geoffrey Van Landeghem
