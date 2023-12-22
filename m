Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED801D53B
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW15/JuF"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso1046533a12.3
        for <connman@lists.linux.dev>; Fri, 22 Dec 2023 05:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703252979; x=1703857779; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BRnboN6uaVXz3cH3ChHYLZiWLsWj+o5rEqFcor8qFBk=;
        b=LW15/JuFjVNbboMTIACo4gzi8ZaNMPFZI03se/AubpjQiGtJjZ8FhU9YFDL3MOoPmH
         int/6EJEmHzIO5C7lDrjZAHJX7sFaoZGYh2z4/5kGbNpg1xzHcTAYe626tT6SAJ0w+Lf
         j6/7PLL6UkhzOnZHdq5d4F3ARxhQl+MRbvss+cLXry3k/7g9t/dE859iflgsS6KGkodH
         0zoHXZUKVfQc2sMbU8FcnhY2tFtfl4Dfs+W9x7o7piwWPGuReo38v6D9UooVDxfIN7HR
         Y1S+UuwxdiPoPzXgp2YYWuWvcCnpmsDUIDTHGbSFP4Npmd8ect/b3fOqc95YagGsZtDX
         WuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703252979; x=1703857779;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRnboN6uaVXz3cH3ChHYLZiWLsWj+o5rEqFcor8qFBk=;
        b=jb/T9su5Eeqk/CV052HmvpI5NfskcYJRR8RDTbAKga6X+SJrZlBpy7AxtToRG9iemr
         gYVui3tQ3qixDa8MHx+1LJp5U0MkAH5XYSrIVtdiJ8vUmthR0n1UFIyYFJKAwDrMK+Pa
         yNqlGB7v6TrtB5HMy80jJAyCbuHcTQ+LcRncBxMNUzX64DMtoXDjeZoZEZRYUIgD22Em
         12gYRbmQyXXmyX4x1gFbWy+XT1nAivgMYpnuvyqxLB1SUgVwNPcIx7BvTkrq6P8sFuBW
         StdoNXVY4kACZgKmTul3HDlSz8793TwPe2Td3oY98jP7QxaoJbPFvAYr14KMqmExtXZ4
         JY+A==
X-Gm-Message-State: AOJu0YzU0CRyeBreKxBsQpKZETWxKRrUp9ARPxGTHf/BLWOlh630MBik
	bNsiMLygO+51X+pFyPfNi8bW29ba4EfPULJSqUSrvwO47dc=
X-Google-Smtp-Source: AGHT+IF+U6XHzyCDX0ljKX6pTpS0zBCvGB0UVUd7KAjXTGRMJqAx76HY16yZAz9WxmssPcNp22QkRyERubPUOlqprMk=
X-Received: by 2002:a05:6a20:6d13:b0:18c:5c04:a548 with SMTP id
 fv19-20020a056a206d1300b0018c5c04a548mr899187pzb.28.1703252979309; Fri, 22
 Dec 2023 05:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 22 Dec 2023 07:49:28 -0600
Message-ID: <CAG17S_PAwPF6BaL6SqLcZi7HxgGjho2oUOT1vHqbiqyA8LfJtg@mail.gmail.com>
Subject: cannot build release 1.42 on RPiOS
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

In the past,I have successfully built connman versions 1.38-41 from
source on numerous RPi based systems runnign arch and rpios. I tried
to build the latest, 1.42, and cannot get past this error:

scripts/libppp-plugin.c:37:10: fatal error: libppp-compat.h: No such
file or directory
   37 | #include "libppp-compat.h"
      |          ^~~~~~~~~~~~~~~~~
compilation terminated.

A search for a debian package with this file reveals nothing. What am
I missing here?

I have used this 'config' for a while w/o issue (I borrowed it from Arch Linux):

  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
      --runstatedir='/run' \
      --enable-iwd \
      --enable-l2tp \
      --enable-openconnect \
      --enable-openvpn \
      --enable-pie \
      --enable-polkit \
      --enable-pptp \
      --enable-selinux \
      --enable-threads \
      --with-openconnect=/usr/sbin/openconnect \
      --with-openvpn=/usr/sbin/openvpn \
      --with-systemdunitdir=/lib/systemd/system \
      --with-tmpfilesdir=/usr/lib/tmpfiles.d

Any help appreciated.

Keith
