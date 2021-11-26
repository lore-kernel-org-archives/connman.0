Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B72C82
	for <connman@lists.linux.dev>; Fri, 26 Nov 2021 06:26:56 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id l24so16693847uak.2
        for <connman@lists.linux.dev>; Thu, 25 Nov 2021 22:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9D/UhP4+/1rJ285OI1X5QB6mO/60x3W6JPH4IH4ZuKA=;
        b=mUPKJ0mVffhv1LIzalC88XV9wtNtVEKrNl+2xSkl3ukvDdCS5TDfU57TULOXdMrtwO
         lyxJVBlQ47iB6e2/o0BgcbOjNmaOwmZRl7iLt3KCVOpL9sRgVQU6AjViJwEtPq1dWvV4
         XlknXM4Bjrq4QpF3lTGilheSOfgUjAt+Q0UDtB89xupemWWXDczJbemUTP9R70jTZaHi
         PZc2tDaNFVgPI37V1bQdl92IJOpykOQHMruAlfMIrzNP6Uybl1zq6AUhRGIql09ct3L5
         WTLaR+/ag+O//k4AoyM8U5yvdSnXXgaZW4VfLImWCqAN8hxD0Gz6tmn3eS7zYA3sMECv
         NdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9D/UhP4+/1rJ285OI1X5QB6mO/60x3W6JPH4IH4ZuKA=;
        b=yotUwtn5nFInBCrqhCs6F4P6b0GitnNNjH7zS2yNzvBT0oe4vhq1Uzd863V1B/6JI7
         duWy9Huvt0gz/xtkp+0B4c5EaSfQ05kVCHBJQbmM/QfJ8Z+02Dv+TD8gKPwTHxmFIhOr
         /ker5XR3X3oNHSSML0WdiZZ9XWSFfUaAzIKmH9YR+9273+Qj3kPEuRqq/BO669b+ltnK
         PK5QG8CiWtnfv31rcFgn96R1H2Sya8eLe330QLzpLS5zU9eU89QQy/qxz2CHmmqAyDIN
         ARco8VmfLjRVVaNIjLFPAmwCmYlb6ebq993CeGdSWxAMMMDRZS68swavilWU1xmOCzwr
         8/vA==
X-Gm-Message-State: AOAM531VPfgN/37/5fYBT9CGhp5SfxQq1UI+j9vanKfAmB3AYzkDRwbg
	PLmo0z6Lh7sGzXTJ0U/qsiCemWbkbVWyDUCh1eE=
X-Google-Smtp-Source: ABdhPJwmxDU7HlplXUoZihzSEi17OfWL1pQmth/I0bsK5mpOSiU6UwIQ/lFCPD/uew+ym2KMsoMmLFYWbI/Oj5pJq7E=
X-Received: by 2002:ab0:6ecf:: with SMTP id c15mr33289403uav.113.1637908015515;
 Thu, 25 Nov 2021 22:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <16BAEC7B11896AEA.23256@lists.yoctoproject.org>
In-Reply-To: <16BAEC7B11896AEA.23256@lists.yoctoproject.org>
From: Jupiter <jupiter.hce@gmail.com>
Date: Fri, 26 Nov 2021 17:26:19 +1100
Message-ID: <CAA=hcWSA8-8TCJDD8_Zib11Vaizok-xZvQMqSevjKJLrQ+GuhA@mail.gmail.com>
Subject: How to create connman_1.40.bbappend to enable and to build connman
 with iwd?
To: yocto <yocto@lists.yoctoproject.org>
Cc: oe-core <openembedded-core@lists.openembedded.org>, 
	comman <connman@lists.linux.dev>, Daniel Wagner <wagi@monom.org>, 
	Armin Kuster <akuster808@gmail.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Given the high profile of iwd and advocating connman with iwd, I
believe someone have already built Yocto connman and iwd,
surprisingly, I could not even find an iwd recipe in
https://github.com/openembedded/openembedded/tree/master/recipes, nor
can I find connman document and instructions to replace wpa_supplicant
by iwd, what could I be missing here?

Appreciate your kind advice.

Thank you.

Kind regards,

- jh


On 11/26/21, JH via lists.yoctoproject.org
<jupiter.hce=gmail.com@lists.yoctoproject.org> wrote:
> Hi,
>
> Please correct me, but it seems to me the connman is moving to a
> direction to ditch out wpa_supplicant and to use iwd, but the Honister
> still configure connman with wpa_supplicant by default, appreciate
> your advice:
>
> - Is connman with iwd stable enough?
>
> - How can I create a connman_1.40.bbappend  to replace wpa_supplicant
> by iwd configure?
>
> - Where are the documents for configuring and building connman with
> iwd? Where is the operational guidance to run connman with iwd? Can I
> use the same connman dbus APIs or are there any dbus API changes to
> run connman with iwd?
>
> My apology for FAQs.
>
> Thank you very much.
>
> Kind regards,
>
> - JH
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs
