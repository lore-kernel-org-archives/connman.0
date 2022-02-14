Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831C27C
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 10:39:35 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id qk11so16075088ejb.2
        for <connman@lists.linux.dev>; Mon, 14 Feb 2022 02:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=aP2AeX9Re8aZS+jJUZ/KYV7Fbx+hd3QH08ai2xNeLl0=;
        b=Iabcqdj1tSCMkssYpuJwwRqbC4AtCkSZ8HaOxU0zLBWQuCpoon11LPIiTPdTRBvZ05
         7N9QI8iin+jdbb1JifNU+0jlUB7oYZjERSX9/EkCrRElqPqy4fXW+eGCZQVIo3UMryXl
         Hd0Nyg25MF2SumdKtNXPqYqR7QFAkMr80ilgYEqh2a/FFspycrUlJYgvFoTH+e14O04F
         oNilhviro+LHgbkGP2umovhZJlCBz2FpPgd7aGf9TILzwdoQmeM9vcYUfhm/bLAPSCUW
         3SzZdJ4rnU1h9JpzegaklX+5GpnZCZ6pQoK4/Di8ltz/zyjNs6OfZIJ4ijUsMSMIqScl
         ttGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aP2AeX9Re8aZS+jJUZ/KYV7Fbx+hd3QH08ai2xNeLl0=;
        b=6H7TVGk+578CPvBdzdSa00GnUb5ePsJDpwJ6McGmXi8ldyw0d33+gEPboSR3NP5VeR
         xBOSJRj/NYPwLl00HEKFu26mNTHgzCo+4Pnqea2RMHEuEml3aL3XOubn4RH6Mz2PoiRD
         JwxqBP7o8U87FkLmwE974i36eS9nrX7rmopR/huSjnsB3ioUwf3w3tBrmAvIw+dCoXEb
         SncKsi1c6ppSMR3jS+0kKllQ9NiWaKrw/es/6KdNm83LfNjNha/UaazzRUi4cRCeMaGD
         KLlRX7Fn7ywEqM1EBSilhpFkjSsNVa89qAMXarBiKrXCJtjtJ6B5gByy7OJWC3tIoEIO
         z4Qg==
X-Gm-Message-State: AOAM533GD4bVUWyv/NZsJuMYqTuElS2C2e4qsYGgYwDaEx6VO9dU/YR8
	U89I/IdFgVkThB/5FYwn7ffPpoBON5mB2GXuQKQ=
X-Google-Smtp-Source: ABdhPJyM7lVmLfRiH820DQn+NHWfjFUImDvVaKnLa8oP0JiyvYOsy6MwthChZZJdbV8gvbx3QZbr6t51foRrM0Cwelw=
X-Received: by 2002:a17:907:6e28:: with SMTP id sd40mr11101326ejc.746.1644835173765;
 Mon, 14 Feb 2022 02:39:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Mon, 14 Feb 2022 11:39:23 +0100
Message-ID: <CA+iibzD638TEqqCJ+c2_KvRaeXST745nwq+N1a8MvZtvxUzQ-A@mail.gmail.com>
Subject: connman issues with enlightenment since last upgrade to version 1.41
To: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev, Emmanuel.VAUTRIN@cpexterne.org
Content-Type: text/plain; charset="UTF-8"

I use a systemd linux distribution with enlightenment, connman as
communication manager and iwd as wifi controller. Since the last
upgrade at 1.41 I have observed
two things:

First, the connman icons (wifi or ethernet) are not blue anymore and
remain grey. When I look at the parameters, the wifi or ethernet
interface is ready and not online . I notice that in the journal
records that there is no more unknown route 82.165.8.211 as described
in the archlinux wiki (unknown route on connection).

The connection itself is still functional. I can access the internet.

Second, My laptop is connected via a wifi connection and I use virtual
machines (virt-manager). When I start one of the VM, on the host an
ethernet connection is opened and connected, a vnet0 interface
associated with a virbr0 interface. As the host interface is connected
and in a ready state, I suppose that connman tries to connect to the
vnet0 interface. The side effect of this is no dns resolution in the
virtual machine and sometimes even on the host until I disconnect the
ethernet connection vnet0 on the host with econnman.

Reloading the connman version 1.40 makes the problem disappear but it
falls down with the 100% cpu usage (corrected by the last commit in
the 1.41 version).

Finally I have reloaded the version 1.41 and have created a
/etc/connman/main.conf file with
[General]
EnableOnlineCheck=true

Now everything works, The icons are blue, the interfaces online, and
the dns problem has disappeared. It seems that EnableOnlineCheck is
turned false by default despite the fact that in the git in the
src/make.c EnableOnlineCheck is set to true.

I don't want to worry you anymore with that.

Best Regards
Dania
