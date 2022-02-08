Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4112F25
	for <connman@lists.linux.dev>; Tue,  8 Feb 2022 10:55:55 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id j14so27658319ejy.6
        for <connman@lists.linux.dev>; Tue, 08 Feb 2022 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=izphzUx0UJ00IHbxOiRAsSCP0YQoqT/Jt0jP8hJ4Jek=;
        b=had/FIPl+O/uZEM94D33bdAWLzOIixuJqt5B8AdzGBgwsHYztdUTOMj3OciSrS7i3C
         vRIahLKJ55yCK6T9Vs7k2v1z/syXA9O+6DypQpEvnEs2C0x3tjxax8ZBmqiG+y1ZhRBr
         sXdXLc7TzT5PuAYGCetoAC4eH9O2vPJ516Tbgc0lb1manpHoVfTSmpUx0iy+63auaRe9
         +0WaJrsYYUtrKEc9FX0sPxEYamFbU4ldYgsKE9g82iEAWly2P20UyiMJhpQdhpEv5Enk
         z3NyqmZBWY5eHxf5kgi+b41xTHYR1gagxPfieKYzbpj180OxN91g7YII07e/rz6iHFW3
         a3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=izphzUx0UJ00IHbxOiRAsSCP0YQoqT/Jt0jP8hJ4Jek=;
        b=ziAwpKgH4Twxsm6vj79hLHqO8Kj0pR9mrZ9cBOKgMO7OLZlzUAVtSD+fd2gPFniBkx
         OEE3HHiOHnvjwiSpf2Pc74tQ/bOSk2nvupiJJy9cMjwXXXjftprzMNtyh9cMf56F85Pu
         PSKbubQM0CO79uOJi9mls7NOvnyaalO+UjLauO7iYTL2N1+29B6eX74bfvyMS9u7hgRf
         4AJ/kIiu1grA74C+/7pRaq3B5maXYyPJlxzMuwSQZvVZ1paZ4uhKaiKCHsQFoCPHMkO7
         q52eWZO9bPTUsMNUZ93EiGebWfEjjCdjSp0QPEx++NmbmuXugZxTRJlQSmKnsyKlYmlu
         QDyA==
X-Gm-Message-State: AOAM531FjLg4NBHL9gfbFukEPvqgI1umJy+0H9gTyx/3VnVApDxFFTzW
	uzMHER+W0VS7W7HFbVFdNCI1RiBPMZqVh/bwycymHnBYrQI=
X-Google-Smtp-Source: ABdhPJw17tBsvVrPJ35o9g4o7SloghJdrMbNkTJSngYT4GKk8zzm4Ps+nIX1ne25CadUk8v6H5SuAAhTood13RwHEd0=
X-Received: by 2002:a17:907:d9e:: with SMTP id go30mr1290994ejc.125.1644317753624;
 Tue, 08 Feb 2022 02:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Tue, 8 Feb 2022 11:55:42 +0100
Message-ID: <CA+iibzD4x+4r-Jn6XsF+r=f91r=PFTM2VCm2db__XCWamJfWUQ@mail.gmail.com>
Subject: connman issues with enlightenment since last update to version 1.41.1
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

This problem is not related to enlightenment, I just want to know if
somebody has got this issue.

I used a systemd linux distribution with enlightenment and conman as
communication manager. Since the last upgrade at 1.14.1 I have
observed two things:

First, the connman icons (wifi or ethernet) are not blue anymore and
remain grey. When I look at the parameters wifi or ethernet are READY
and not ONLINE . I notice that in the journal records that there is no
more unknown route 82.165.8.211 as in the archlinux wiki.

The connection itself is still functional.

Second, My laptop is connected via a wifi connection and I use virtual
machines (virt-manager). When I start one of the VM, on the host an
ethernet connection is opened and connected despite there is no
ethernet cable connected. The side effect of that, there is no dns
resolution in the virtual machine until I disconnect the ethernet
connection on the host with econnman. I suppose that It has something
to do with the fact that the host connections are READY and not ONLINE
. I have sent a note to the connman mail box and iI wait for an
answer.

Best Regards
Dania
