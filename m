Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AD2C83
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 21:55:29 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso4381662pjb.0
        for <connman@lists.linux.dev>; Wed, 06 Oct 2021 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slvlJWd1TKxbLWTBU+rb52shivbxTCHTtt4o+L9jbec=;
        b=AggOjfW6hpIuGL2cYDQ1l115fRFkY3cWOEYeP4OI8LAILylyuEyR5JfdyItu1Zkn6v
         e/memXAXSmXkmhbnZOIXqG04/0yNZpHW4Fl+zsRldUEdyp6AzEO4aScBHQRHUS3IeDmT
         mb+8hdUdbMMQlgGKOpv/k3KTiagp0A6Y35cbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slvlJWd1TKxbLWTBU+rb52shivbxTCHTtt4o+L9jbec=;
        b=swzHd2zZpIFIjxJQRwCFpiqfnOJAIkbAbrgB+JC8Y4GD+uqbYFhrwJ7mYce4A7LyoL
         g1RKyJQtxFzX7d29ODiUkLAB1eRa4xcfY3QSvK9ZUBn9uEKx8WfSb1GrkB0UJMrJ7izB
         92hdCiPbB+J9c7ie1fQaMZ3QwGHx4tLiVel6/4zCC72/j8HHwHfeh/4HZWOc7kzC7kfn
         38g1fYAgkoJ6lsqaRV7SYqZU7mErWdPgcQNfM6bDpIs11MMHY9ifLKT5P7oveZoPUC7C
         6Q34kt2SlLc+9zJyGvqhmK76kOlUF384HTzZH/HX2LWNrHy8U7Xp93TgxLnENiNU5Vr2
         xzIQ==
X-Gm-Message-State: AOAM531Fvzn6WoAU9VZybRqeo0XaAPPrvLWCqszYP2TW+RklQT+EfC7S
	QRKB2VWDM9ufjzsUm8G6Vf5cdIgzTjsvuaC8bMefRJPkF69MKA==
X-Google-Smtp-Source: ABdhPJy3H3HnBp0LYtolKpPy9dUSQkz31BDiZx+dKv2wuv/Nw9QnLJgB2DcPDyQzlOrdaqD5sDNxd5wsJ5HTWHUFvHE=
X-Received: by 2002:a17:902:d344:b0:13e:b684:5e79 with SMTP id
 l4-20020a170902d34400b0013eb6845e79mr300385plk.72.1633557328940; Wed, 06 Oct
 2021 14:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211004210016.1579481-1-michael@amarulasolutions.com> <20211006124043.l7nlcqciqk5wc6ef@carbon.fritz.box>
In-Reply-To: <20211006124043.l7nlcqciqk5wc6ef@carbon.fritz.box>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 6 Oct 2021 23:55:17 +0200
Message-ID: <CAOf5uwkPSxGygWi1EM+7BbqVJ_t_fK00exdcAyHO5nAFCOYJwA@mail.gmail.com>
Subject: Re: [RFC PATCH] tether: Add a way to define a tethering frequency
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

On Wed, Oct 6, 2021 at 2:40 PM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Michael,
>
> On Mon, Oct 04, 2021 at 11:00:16PM +0200, Michael Trimarchi wrote:
> > Add an optional parameter to set the frequency of access point. Need to
> > be splitted in multiple patches. This is used as initial idea.
>
> Nice, this is what I had in mind.
>
> > TODO:
> > - split
>
> Yes please.

The best thing here is to add libnl in connman. This allows us to read
some wifi properties, like
the available frequencies. This can be added in device.c or where you
think is the best.

We can create even a temp function that just check if the frequency is
valid in the range of 5Ghz
or 2.4Ghz

Michael


>
> > - add freq constraints
> > - move to unsigned int
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
