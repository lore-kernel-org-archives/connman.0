Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3F1168
	for <connman@lists.linux.dev>; Thu, 13 Jan 2022 16:08:36 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so19318275pjf.3
        for <connman@lists.linux.dev>; Thu, 13 Jan 2022 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmyxvqsDt7nMm7ypFRrJXj0d7iuoix6I6uUap3OTnhU=;
        b=W2L1HhMUOT6fsu6wy3u2rg9QyZ4adhrwQxt+0wmmTt+Bve88x4RW4dxr/oTgBidP66
         Pt9UwXsxDwJ9A9HxVy1nUrLr1llxZPb4zVvWFO1eS/mPfOnq2rluIPXobM8MdveN0x7+
         lKhXmDTtOZ345njeR0hLyIwUVshOvF+0Pp6ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmyxvqsDt7nMm7ypFRrJXj0d7iuoix6I6uUap3OTnhU=;
        b=Nf5uEYW2lgHmbTa9RQu2G5m9s2E/B+RYjuXo+PI+kdT1hOu1bwWGWC/mLYGtCCC7BQ
         cCcB/IRgoai8MjDl0tS6pUUJjJqTLECQ5EP84KpUim0Bx6L96HPovS8eDfJ+cFFVMlXv
         9JcYbs2q0n4la5GFZ4TGspeUf1wpjQcyMKkuL+yeAHT6whpmV3gs3m6Mp1C9Ozaljf/u
         VeBwW1nm/X2mP18InNuZlv/LdPJlKqfZulEnSsDHXiPAoXXJIPFrEMwOkCj/fDxAdJaV
         V0GZlxmGfeUa0CHmjCcUY77vuWT5JERXwr6VkUW/1EkJwR566MqxWGZEh/4hEFBUAo3i
         oQRg==
X-Gm-Message-State: AOAM530ljSUXRY75AnZTM82DTabPW+z4qGxYvWVrX9XaNtF+pDXpprwh
	th10IKEHcNm4kfmeqRpR+h0yurbUzVPt0jWwIiknV2RhvbsMCw==
X-Google-Smtp-Source: ABdhPJy1Plq0t1xtjEZaNNPpcaYRb0I7+ogYdWDgPCGdRvr2cbWIp/kQc5cIXwiAX/B0JAw0LKyA7MrOhJEzskDxeeM=
X-Received: by 2002:a17:90b:788:: with SMTP id l8mr5857180pjz.171.1642090116328;
 Thu, 13 Jan 2022 08:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
 <55549edc-f52b-0552-2134-d87c6dc71416@monom.org>
In-Reply-To: <55549edc-f52b-0552-2134-d87c6dc71416@monom.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 13 Jan 2022 17:08:24 +0100
Message-ID: <CAOf5uwkGg_XA2Wc00hKMYAxTVW8QAZfEUT0NcZJbmFR2QnJKBw@mail.gmail.com>
Subject: Re: Network with same ssid question
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Jan 13, 2022 at 5:05 PM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Michael,
>
> On 13.01.22 16:43, Michael Nazzareno Trimarchi wrote:
> > I'm not sure about this use case. If we have multiple networks with
> > the same ssid, should connman show all of them?
>
> IIRC, ConnMan merges those together and only exposes it one Service.

is_duplicated the one that merges them? I think that in scenario when
multiple access point
are present we should not do it. I have seen that even iwd does not
show duplicated. Is that correct?

Michael
>
> Daniel



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
