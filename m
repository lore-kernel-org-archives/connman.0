Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC7173
	for <connman@lists.linux.dev>; Fri, 14 Jan 2022 09:50:52 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id e19so12825714plc.10
        for <connman@lists.linux.dev>; Fri, 14 Jan 2022 01:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKHpK9Bt8HfMcATE+pmUvHuQ8WlzPYcKrIGTOvuYniM=;
        b=SW8klUkom7hfUIsRIE1uIlhTXxp5SdyPEPLa+wGS4pnliAjmMtb/PUfXCJrA61K7tQ
         52GYuY22npS9lj7gL2haE4p9oquqhYBr57l+omOlWuwEA/A+ZkB37JzwThMNheF2DkdG
         Io8nDCn1Fo2XdKePBh607r+KYj6cHJypI7dJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKHpK9Bt8HfMcATE+pmUvHuQ8WlzPYcKrIGTOvuYniM=;
        b=6VqMKbgkcLsNHVewQewmKQL7fTBdWBxrezNs8EL7YKzFy9NqYqAGxt2cMKmsItk8se
         vNr4BHZ2a1NjVkjn494/g8idhnSZhM5wZUwSqQIZlLx1M9nVGwUsI0z5TbPXw7ll5UMO
         55gZhEsthJzW8pYMSj6vcYbratQZCpd0zeJDoaY0f7fALgy9JkiGdzpzchrEd3l7/qus
         Y1o1H/Ps9KZflNnGIHnfDBGQKgLjWq/mjnGclVQuFYdEic5LIwH0N5yHirPvlD35gbsp
         bJ51UVyUXSg6ymSwz2t0T6Jb/Em4lTB99aQhpdKy/GUZ56jw5jiD+HLAa9Wq1YhM6KrZ
         1Csw==
X-Gm-Message-State: AOAM530aKph0fHCmsP8g+Z3N1V9JZ1JH/uxKu3woGKQNlDVf9vOOZVHv
	iG+lWtmPT8iVEZE+9+fQLjBwGj4S8AAjcmbVQmzMTowDRbKarA==
X-Google-Smtp-Source: ABdhPJz36PVfwdtC72OpXxc6MZrXQI46T8aOPkKzUIbwPNqGHTPIR6cK1Tr6cqZLcG/6pEs0n01QnBaJ1f4Ii9WEJZg=
X-Received: by 2002:a17:90a:630c:: with SMTP id e12mr9774796pjj.59.1642153852260;
 Fri, 14 Jan 2022 01:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
 <55549edc-f52b-0552-2134-d87c6dc71416@monom.org> <CAOf5uwkGg_XA2Wc00hKMYAxTVW8QAZfEUT0NcZJbmFR2QnJKBw@mail.gmail.com>
In-Reply-To: <CAOf5uwkGg_XA2Wc00hKMYAxTVW8QAZfEUT0NcZJbmFR2QnJKBw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 14 Jan 2022 10:50:40 +0100
Message-ID: <CAOf5uw=319J8Dewg8_j575kBsp0pEkh=bpTaS0jiBb5imemNfw@mail.gmail.com>
Subject: Re: Network with same ssid question
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

Sorry again. I give the use case

suppose you have 3 access point with different signal strength on a
network, the best will be connman select access point in the area

Michael

On Thu, Jan 13, 2022 at 5:08 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Thu, Jan 13, 2022 at 5:05 PM Daniel Wagner <wagi@monom.org> wrote:
> >
> > Hi Michael,
> >
> > On 13.01.22 16:43, Michael Nazzareno Trimarchi wrote:
> > > I'm not sure about this use case. If we have multiple networks with
> > > the same ssid, should connman show all of them?
> >
> > IIRC, ConnMan merges those together and only exposes it one Service.
>
> is_duplicated the one that merges them? I think that in scenario when
> multiple access point
> are present we should not do it. I have seen that even iwd does not
> show duplicated. Is that correct?
>
> Michael
> >
> > Daniel
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



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
