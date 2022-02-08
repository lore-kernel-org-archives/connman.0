Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761C2F26
	for <connman@lists.linux.dev>; Tue,  8 Feb 2022 17:17:28 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id fy20so5348849ejc.0
        for <connman@lists.linux.dev>; Tue, 08 Feb 2022 09:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=CFxh7EBeEXC0evFw/LDHhDStf1JCGI4z7tr1fOgiC3E=;
        b=cwopgft6itBSpK3NwOgPf8OB7a86Q488Z7jA8KPQb569+LHp13Dqbib3IGNDzbW1Ji
         YmqZJFvpvjaklljRJm1OZWEwFSY6BnQWUAvnPx7jYNhHxuAqix+DPuDQZ8Qt2BiUyzHY
         J2PuRUvz5p8ZSckBv8seQQewsE9xBQkOLvsIkhM7xyTH8R7MdRLCMNNueG8tOHds+4/8
         J1GPnwVjaJW2MMIxbX+/sp7O1dgINf5XVqK0vM2f5kT7FtqamklGeO0Qp5oenHiprHtL
         FfWuGBwfee+brt+K5v/+q0EMFaQqLt8B/TKpyzDsgxqpOM2/ccmrr16XFvZAYZW+Uzju
         oUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CFxh7EBeEXC0evFw/LDHhDStf1JCGI4z7tr1fOgiC3E=;
        b=c1x/65MtexBAQeWDMDNXFlmKu6QpJ+KF9amd9lPRnVufIOhrmF5v/RmcPhCNI4+cRX
         /djkzSk0H9Xok4dyaZBC8OBeYFHfN5PG21iQ79vXyHOIjI5d1+ND9SjCnKuim/uREHV3
         MlUTDroFHU4UPjPpAJWKP4hndusP+x7IpntSdRyvwHaBkusIynafuvfVUql3sHKgzhUC
         6GjvCDuRI+EcknfILk+IaP0jkpoC2IQtVOKcbECa4oVJ0trpy60REKNR9S5NRUPNTMhV
         ZKcKz5pfhIAcqmUODPqeUawg9gIruTUr7k67HTc5bT/5zkkYhWUpHU32o4NEitnGKrqI
         oQhA==
X-Gm-Message-State: AOAM533zexk7nCMaugWtjIub5R5WQFqN7s2ITeNsOtv9qYvR8BlCxYAT
	gDcA9eo/gZ6Sg+PVkzZ13cUsWI33ue3H+1Cry9w69ugzMl3piA==
X-Google-Smtp-Source: ABdhPJz6E7bK1LR/cs4ZA3i5x2qokCEBCMz9XPp8/OOaJWhvIrjQ7aa+kam3uwyXxH9lzgxn3GGJ3x6fllasYvuAaUo=
X-Received: by 2002:a17:907:a409:: with SMTP id sg9mr4493079ejc.219.1644340646390;
 Tue, 08 Feb 2022 09:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Tue, 8 Feb 2022 18:17:15 +0100
Message-ID: <CA+iibzDhfvFgjaUdKvXw8_WKcYwkzr5n0n0NFqOeEpU8ujqYpw@mail.gmail.com>
Subject: connman issues with enlightenment since last upgrade to version 1.41
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi gentlemen

I use a systemd linux distribution with enlightenment, conman as
communication manager and iwd as wifi controler. Since the last
upgrade at 1.14 I have observed
two things:

First, the connman icons (wifi or ethernet) are not blue anymore and
remain grey. When I look at the parameters wifi or ethernet are READY
and not ONLINE . I notice that in the journal records that there is no
more unknown route 82.165.8.211 as described in the archlinux wiki
(unknown route on connection).

The connection itself is still functional. I can access internet.

Second, My laptop is connected via a wifi connection and I use virtual
machines (virt-manager). When I start one of the VM, on the host an
ethernet connection is opened and connected despite there is no
ethernet cable connected.The side effect of this is that there is no
dns resolution in the virtual machine until I disconnect the ethernet
connection on the host with econnman. I suppose that It has something
to do with the fact that the host connections are READY and not ONLINE
.

Best Regards
Dania
