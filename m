Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3E2CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:24:08 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso2055412pjb.1
        for <connman@lists.linux.dev>; Sun, 19 Dec 2021 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6IoUZSw4a8SnOaX+8bCjwv3UxQjxAE9HQ5BEbH8avk=;
        b=j1Ny5H/TuKfa/LrGMJYOJ53DxbCfILPl+UGq12A8dxt6WpEC0fWsGKBieBaYMT8em7
         tMBvZ6tyoS1Y3RDIVm+5RWPlVLFDXkzcHbtgaxkoyjzEctsjQoPv03iwusvJedeQzF51
         Mqi5/ID9uemtGYbezqbRB37A2iQI+D8H3jsKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6IoUZSw4a8SnOaX+8bCjwv3UxQjxAE9HQ5BEbH8avk=;
        b=Sy7FLzffgURny8uz7RSFqmOjCVncTbiW9fJbouo+jaU72bWtlV0qCstD4SO89u4M8u
         Y25UVLC5P4OPG12hnbkudUWf6b6Hw3WPYRkCQJnXUGzbRwzdvYF65JImWLkuX9MZdf51
         OkGKayVvAW9IMjr2ghHK7BybYp5LqRSpuxwm49e3kFr+yjC3rt0K8NIb+RM0mJt/yp7I
         BDkvU82O74OKu5AdSM4fYiHHhuOtwgQOkD6v3QfSdB+sWU1L+ZwCr7ESKvGwW5fTh5GM
         /lPExUKNGynZxuRLuix55gxbjppWhWFa90xF62DhE1QdAhEoJJsfy3M6nUDOOSe0qbGt
         ME1w==
X-Gm-Message-State: AOAM530wIIwwlpz16IaDwo0SqRGno4L2HuFcsproFkti0KBiBPeWZL3T
	R8Y3jWU3UDkx9raQMcMCeX6Wan3jsC+JJjit890S4caB9eY=
X-Google-Smtp-Source: ABdhPJyuI6I6bDNCrLeWkxaGFkm9wJ89SocxSOPTtEFNWpRUoJwpsrhgVYIOWHqHamMLJ/hecaSu/MD2PqxvNIxTHcY=
X-Received: by 2002:a17:902:7291:b0:148:af12:91ac with SMTP id
 d17-20020a170902729100b00148af1291acmr13200076pll.134.1639934648332; Sun, 19
 Dec 2021 09:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Ya4LuuATLuB7waD6@ikki.ethgen.ch> <20211219172226.73tupsi7z24hkiiy@beryllium.lan>
In-Reply-To: <20211219172226.73tupsi7z24hkiiy@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 19 Dec 2021 18:23:55 +0100
Message-ID: <CAOf5uwnvYzk0ZX3Ca_FSQLM4sf4mp_UtBStoUcdoeH9L8DJvOQ@mail.gmail.com>
Subject: Re: Too many wlans
To: Daniel Wagner <wagi@monom.org>
Cc: Klaus Ethgen <klaus@ethgen.ch>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

On Sun, Dec 19, 2021 at 6:22 PM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi,
>
> On Mon, Dec 06, 2021 at 02:10:18PM +0100, Klaus Ethgen wrote:
> > Hello,
> >
> > I found a bug in connman when too many networks are stored into
> > /var/lib/connman.
> >
> > I shuttle between different locations and today, connman stopped showing
> > networks at all. After some debugging, I found the following Messages in
> > wpa_supplicant debug output:
> > ```
> > wlan0: Event SCAN_RESULTS (3) received
> > Scan results did not fit - trying larger buffer (8192 bytes)
> > Scan results did not fit - trying larger buffer (16384 bytes)
> > Scan results did not fit - trying larger buffer (32768 bytes)
> > Scan results did not fit - trying larger buffer (65535 bytes)
> > ioctl[SIOCGIWSCAN]: Argument list too long
> > wlan0: Failed to get scan results
> > wlan0: Failed to get scan results - try scanning again
> > ```
> >
> > The `Argument list too long` got my interest and I looked into
> > /var/lib/connman finding 104 directories in the form
> > wifi_XXXXXXXXXXXX_XXXXXXXX_managed_XXXXXXXXX.
>
> Do you have the exact log for this? ConnMan uses GLib APIs for iterating
> over files and directory. I would be very surprised if GLib is not able
> to deal with this small numbers of entries.
>
> > After deleting all directories and restarting connman, everything went
> > back to working state.
>
> I don't think 104 known networks are a real resource problem as long
> there is enough memory in the system. But even then, I don't think
> ConnMan needs more than a few kb per known network.
>
> > So, if that directories is an issue, could it be cleaned up?
>
> Yes you can cleanup the directories but it's recommended not to do this
> while ConnMan is running.
>
> I think by deleting all known networks and previously corrupted? entry
> got removed which prevented the proper working before.
>

I have respin the patches on network removal. I will send

Michael

> Daniel
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
