Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345502C99
	for <connman@lists.linux.dev>; Sat, 11 Dec 2021 16:58:30 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id b13so8301338plg.2
        for <connman@lists.linux.dev>; Sat, 11 Dec 2021 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1QJ5afi4HDwXwsDtTAkeJGROEsEjSYsiKqDlAIGxB/o=;
        b=HpfhYlfGw8gRNY8eM0s2NL0NJYAMKj7QGog6rhB0JFSPfimsId8qUV0IAUO8nH7vuW
         VkUHtSU7ZCQCe3y9vD6jVaDhsNtyPGbtXJ7QaUyMeMl2mdccOWor25DJ5QpMS74KiVxm
         o30YnQGEG61g20p5w9rZ8HCjfMzBegi0MjIn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1QJ5afi4HDwXwsDtTAkeJGROEsEjSYsiKqDlAIGxB/o=;
        b=CN0aAt73AFwGBNwM6180hsBny3xYxiT/6it3AJI0KnoFzsky2+JxxMfsSOfRDj1/Ud
         lBi2ZIbKvXW0p818B4RQjM1o06m8t+B8mvsDyvoaB4me56te+XAPzV2z6JZ6Wj80WjlA
         MmpHwi/fECqseR6tHkmMKnU/X4wblzgTNV5YSDUgaedUpn7uJRA2to9eMr/K/B7tBekl
         kroznDky2EWqVRt8lmvMLLaeheMuoeqYIFSxvZejO+2RhU7L/UGb7m9Tw88YpK3ZnBOx
         IQSqrUXKjaeBy2NcjqhFlud+VrpfHKgTDUCSzYl87nVS1Oi9lk+3WM1XswxZMXoB1rCO
         8OmQ==
X-Gm-Message-State: AOAM5317Jt6z3aJ5E1cXrpRLJDfqZNBB/bQNXmZOEWauBeTN3xC0uEdp
	33pDrVBoBv4i1iaBH9gK+YrfUrr+tB5/pNg7SGCyDjYFvQ0=
X-Google-Smtp-Source: ABdhPJyaTdukndS1g0D7j3J6F9uEyI+spxjUgFc2dtLU1K0TKzhjQPCCMbc3ICBYwAD9+6PL5rEt8dms7rnQklWdmvs=
X-Received: by 2002:a17:90b:3ec1:: with SMTP id rm1mr32115220pjb.171.1639241909618;
 Sat, 11 Dec 2021 08:58:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211211135028.11355-1-michael@amarulasolutions.com>
In-Reply-To: <20211211135028.11355-1-michael@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 11 Dec 2021 17:58:18 +0100
Message-ID: <CAOf5uwkatFgqV+YT+s5_rKg_xRYzq6QE7xBQv_N_Ud=Rd8ydoA@mail.gmail.com>
Subject: Re: [PATCH] Add ObjectManager interface to connman
To: connman@lists.linux.dev, Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"

Hi

Sorry Daniel for the signed-off. I will try to adjust my policy here

On Sat, Dec 11, 2021 at 2:50 PM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> ObjectManager let us to understand if the connman interface
> is up before use it. InterfacesAdded and InterfacesRemoved
> signals will then be emitted.
>
> int main()
> {
>     auto connection = sdbus::createSystemBusConnection();
>
>     auto managerProxy = std::make_unique<ManagerProxy>(*connection, "net.connman", "/");
>     try {
>         managerProxy->handleExistingObjects();
>     }
>     catch (const sdbus::Error& e) {
>         if (e.getName() == "org.freedesktop.DBus.Error.ServiceUnknown") {
>             std::cout << "Waiting for server to start ..." << std::endl;
>         }
>     }
>
>     connection->enterEventLoop();
>     return 0;
> }
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  src/dbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/dbus.c b/src/dbus.c
> index c454a581..74b3157b 100644
> --- a/src/dbus.c
> +++ b/src/dbus.c
> @@ -687,7 +687,7 @@ int __connman_dbus_init(DBusConnection *conn)
>
>         connection = conn;
>
> -       return 0;
> +       return g_dbus_attach_object_manager(conn);
>  }
>
>  void __connman_dbus_cleanup(void)
> --
> 2.25.1
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
