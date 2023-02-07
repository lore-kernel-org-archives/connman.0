Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7119B
	for <connman@lists.linux.dev>; Tue,  7 Feb 2023 22:39:44 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1636eae256cso21045788fac.0
        for <connman@lists.linux.dev>; Tue, 07 Feb 2023 14:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lBFl4Hs4R6g2jdsG3CboYPhaGVTCEHIAoUZqWyhv6VQ=;
        b=AM9lOa4Q/2q0RaVGHhJjBN0jgeXgnQcYjkSKA130ah7cgpWMerQGhGIOljPmIA5sGr
         c3Hedl0s2oV0QpTnHP9/bPtBNOkrlKvLQtAX3Xf6dzPmCfHDQkGvj8BrmZ2DNw2MyLC1
         uZ5U1cz+LXQGwfXcFBDdieOA0dEy9dw/ErTrpX9GbJmPCS4OcPW8ycbYNm9CJWPXsEjp
         BsJu7CSaBiMfxITc7zjYPyAUUnHDpugRNPo/CCtW7nc9CsLHmoFygJqiS9GE/X9Jq4qK
         0pMOF25+nPMUEK486J59a3JUPYjfGANEqHokbIhwRMVDcIzUr6BWrWLHcHnvSRPHvfTe
         rvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBFl4Hs4R6g2jdsG3CboYPhaGVTCEHIAoUZqWyhv6VQ=;
        b=uYleCFuhDvn4/RByEGcUsnpCJJDoVqJ7WpWFKYfosZKOWPWgbHsFM7nhE7IrWqcTLD
         E4muSPQ5KNuxHcAGOL4lc6LaAieA/W8ahgJxDRoMfQ0QFeESWmmzq2T85jFUqJ5SFwrf
         KfqMmZD23NbzPCp/mTudbWWu9PJYFWssQANHITQDZCunz4tjEavzTTK55Ol1KjgpXuBw
         c/jQdw81gI8NwaCv6iRWU3eEvtVqCFzSLjowezU+8oX0SPI6N4ZaGJFOnsJqVkpszQle
         +mOfz/KYp/GVHq9/TH11DEnwnbMm8Y2wVM1i995kpZWtWG0KuOvlIpT8hlbyVpJgKTao
         BWmw==
X-Gm-Message-State: AO0yUKU6XGfVD6v/HlYzKVZIlPO3xqufx1uXBC3HwBAOxkrERTCKhDxh
	U0GzTAOay3BSVZlG2OvD84fHFb3hjDMfQwF67FYVLZST9Yhddqc5lZM=
X-Google-Smtp-Source: AK7set9D8aKWnASCKp+bqW99SAeu2Y/wKNwrtLE79Hnhg5mntpWtLohezG+JsEKm1kQ4WsUowV0vlPNCqEbV60AuwNA=
X-Received: by 2002:a05:6870:f28b:b0:163:db4a:c428 with SMTP id
 u11-20020a056870f28b00b00163db4ac428mr77419oap.235.1675809583532; Tue, 07 Feb
 2023 14:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jade Lovelace <jade@jade.fyi>
Date: Tue, 7 Feb 2023 14:39:32 -0800
Message-ID: <CAFA9we8U1=_7gkiPuXUS2P1n5Bb1=7s5mNCsJf6-7G6vryZ0Rw@mail.gmail.com>
Subject: Passing the --nodevice option multiple times appears to replace the
 previous values
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I have been running into a frustrating issue where the connman
interface ignore lists are misbehaving for me. I was invoking connman
like so:

ExecStart=/nix/store/k479wdfq88g5qfhlkpr6maqfzj5q8jf6-connman-1.41/sbin/connmand
--config=/nix/store/z07f0rkb95d8zjba99pjcy6v7152y5qi-connman.conf
--nodaemon --wifi=iwd_agent --nodevice=en --nodevice=eth
--nodevice=tailscale0 --debug=plugins/iwd.c --nodevice=veth
--nodevice=hostonly

This had surprising implications in that it seemed like the nodevice
options were having no observable effect. I went spelunking in the
source code and found that there seems to be no combining logic for
the "nodevice" option if specified multiple times, although I may be
misunderstanding it. Is this intended behaviour?

Also, the man page doesn't seem to adequately describe the behaviour
of the nodevice option: it is unclear that it uses wildcard matching
with g_pattern_match_simple from the wording:

> -I interface[,...], --nodevice=interface[,...]
>   Never manage these network interfaces.

Regards,
Jade
