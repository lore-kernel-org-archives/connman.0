Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33652C8B
	for <connman@lists.linux.dev>; Fri, 22 Oct 2021 15:33:40 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d9so3962618pfl.6
        for <connman@lists.linux.dev>; Fri, 22 Oct 2021 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddGH+g7X+liFJYs3pHJxxBLKagiCf4tbRM31YS6X8RE=;
        b=ifkmtbvGynw4N6JAu6EmVf6WGfINN0ngarvaFXVe3MpxebXOStP3KoUvJbbltpU2EC
         ugQdJv3ss5UgrOy2ULb2RtnF4QhE3o9LiELF03lIHDpRi6V1LIOBbAPaeyiJDs3aBxmR
         V6WGxgNY6LLzU06/onIN6M6fuRnIrwlniNUaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddGH+g7X+liFJYs3pHJxxBLKagiCf4tbRM31YS6X8RE=;
        b=0ucVysfRKVlRduodGQgm6RXKBsuhn3bB9zKhRH8E0bENjYoOBE6Cs2f5GW1FYe/Dbi
         mSyWsD0/950fSLlknz5K+ecED4mthT18rWXrj6OfUzFGJWkw8UKcuDegNvqGZ2DU+XBL
         ZUdPU8ZbSRi7az1FQxGT20qsk17OnrZuGijydt3lKW84MySuKSOD8mlJ3zj17gX3/Ww8
         n+Ke14T2ne8zVfSm69Jdf9KpLfBFPiYKj3Xx3hBtBqqJ4zUa0KF4xlGOe/Rdj6B9XYLf
         wnyDSe/DkegeAEaVhms0NR3639Rzc/rXERVB5ql4TQe+czdAHIGfT8xMVwiwMZJsaQwm
         FmoA==
X-Gm-Message-State: AOAM531BaKozBGz4wkntWMHlKrCrWSDp5QL79dxgYSSsvtUtz6RIbsMW
	qQ1SJFWodE74cPqYFSqOQ8mZrC/DAOunKf36C0el6A==
X-Google-Smtp-Source: ABdhPJxcGiYuyLL9tWwAUxzsAuGPbrBLbzkbGJ2+pQxT2+IVuZNuyiG0c+w+11JOh4+Y/X88F0W+Bszi4M05qU+xbQM=
X-Received: by 2002:aa7:93ca:0:b0:44c:da51:38ac with SMTP id
 y10-20020aa793ca000000b0044cda5138acmr673150pff.67.1634916819784; Fri, 22 Oct
 2021 08:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <65509ce0-a5d9-9161-7454-a93b8147c4ed@overkiz.com> <20211015065350.wpf6qqcdfsmvt3q2@beryllium.lan>
 <aac98118-9caa-25a9-e41d-eac205624cbb@overkiz.com>
In-Reply-To: <aac98118-9caa-25a9-e41d-eac205624cbb@overkiz.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 22 Oct 2021 17:33:28 +0200
Message-ID: <CAOf5uwmzOsNpSWrneXvHFgEFHWtCEqu4EQ3AXh0Rfa7-fnK2Fg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tethering: Reduce the number of parameters of tech_set_tethering
To: 20211015065350.wpf6qqcdfsmvt3q2@beryllium.lan
Cc: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Oct 22, 2021 at 5:20 PM Julien Barrault
<julien.barrault.external@overkiz.com> wrote:
>
> Hi Daniel,
>
> I am using the version 1.39 on which I applied the patch
>
> > Thanks for testing. Could you retest the current HEAD. I've done some
> > stylistic changes, they should not change the patches but who knows :)
>
> I've applied the 4 patches committed on master, but it does not work anymore
>
> There are probably few typos in the patch ("Tethering.Freq" instead of
> "TetheringFreq" in the second patch), but not only (correcting
> Tethering.Freq twice didn't solve the problem)
>
> Unfortunately I didn't have time yet to investigate further, I keep you
> posted if I find what went wrong

Sorry not have time to check them again. I will try to fix them later today

Michael
>
> Julien
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
