Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4C72
	for <connman@lists.linux.dev>; Thu, 12 Aug 2021 12:53:18 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id q16so5851840ioj.0
        for <connman@lists.linux.dev>; Thu, 12 Aug 2021 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pmAnOJL1NEtVBZNrTM52oPNyBXpSVPGyUGML4nfduf0=;
        b=QHtnSAAIHXSzdLLS+qKHYFDWiWYb5Kyq2DSbLaiJZIBEf/DjDFtYGwLgkj+9lz+gfY
         jQ3eUSgY5KXwIwCubt8bMmspjvFkB7dctRdQNia98i69wLTIqvNVY/rhVDcB8PBmXAfD
         JxURQcqgcTjxzAUEUfngOU+XHUbfcpnlciC4uPgCptv1hA+RdzXx5WxpQMoeVPtGjrrp
         75n8Kpkm4571ThbX3y63fmeKsC2QU3nYiVRsfPn4Tg6mKMoaqEPKk/VOENmR3arunQ+5
         pd8/FzkEVU4OFplRRqDNdcMs7eT/oEDRDh1EeQt2aKcFqADDPFAMLc1dbR7mekRpcf4p
         s15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pmAnOJL1NEtVBZNrTM52oPNyBXpSVPGyUGML4nfduf0=;
        b=M4vaLh2hi9ni5CAVDUlsplfUJRAry1a5sMt5bcmRoaas7byY9Mny2TBrVIHO+o49am
         8VjI/026AsmrUT6Hhmh/m6BFk6ZALzbId6C7YdSGdZp3QRulRpoq0ghwNhv2psB8gGxB
         qthu+Y8wS387/9w8kjTwXCuNlzO7NccU3GqdHswAI2ni1Bo+RwTBunALDylWVZPhEUGD
         uILjHBM9l/juyECBw8LP+AocnYWEwkt1FtJ5kIkdnRGRdRFOV3dOR48kOu426qDhisdv
         1BICgTjw8IyROkhpv2sfSUASccHzIEfof5kaazlGc639KXDXHoVxg3xAM26TKVnVqLui
         BBlg==
X-Gm-Message-State: AOAM530Gv6rOk6+3AbKWDU+GgV3uB32xkCUvCIeokyCJ/uEXhrej4nKY
	nQ6gVQFybxHjmMQravyWu0w+flKaGl4oSvmEZCcfinZqhvpZ+Wvm
X-Google-Smtp-Source: ABdhPJxzIEYElZCG5hDF+WlPirYfbM4bXhvZVw2IISn22/80zu6FyDmTKZVknYB5Dudv5SH775RcqxFhKICVXhSgccM=
X-Received: by 2002:a6b:b586:: with SMTP id e128mr2968929iof.37.1628772797789;
 Thu, 12 Aug 2021 05:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Michal Zatloukal <myxal.mxl@gmail.com>
Date: Thu, 12 Aug 2021 14:52:42 +0200
Message-ID: <CAKKZj2B6uwmwpAtAFgW7Av1Qasb6Yg1h2q-pHW17svwdQJE_Rg@mail.gmail.com>
Subject: IPv6 Online check broken/down?
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello.
(Please Cc me into replies, I'm not subscribed)

I recently got IPv6 connectivity at home and soon noticed that connman
on LibreELEC is continuously (every 3 minutes) trying to reach
http://ipv6.connman.net/online/status.html - an "online connectivity
check", as described by the documentation. The IPv6 host from that URL
(currently 2001:8d8:8b4:c861:5826:fa5f:6690::, hosted by IONOS)
appears to be completely dead (no response to ping, or TCP_SYN on port
80). Curiously, the hostname also resolves to an IPv4 address (also
hosted by IONOS), where the HTTP server responds with "502 Bad
gateway" (and ping responds as usual).

Regards,
MZ
