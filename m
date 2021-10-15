Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705A2C82
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 07:09:44 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id i76so5466059pfe.13
        for <connman@lists.linux.dev>; Fri, 15 Oct 2021 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrMoh9+GZd0op9X2mxdgVg32mNWhm8ASmQwEZVgcUq4=;
        b=onjlBlR1+drW/N7AcvSytiCPd6lZg0yhNuEBPKB+24LyhJuGRgs6S32sSeOr0z4CFq
         v8I66thuYkSzdCZaMJEipqN3nyA0nGK2zGbhV522/ibEsyn5X8nxzpp8P07C4B0W/qxK
         xGRL0COjAAfE0zSBCd4s1Z/VwuX5Dl6j/fGkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrMoh9+GZd0op9X2mxdgVg32mNWhm8ASmQwEZVgcUq4=;
        b=QC3YKkLobTKjupZzq5hIwuQ2k12z49vtp5bQu/hrXO3UYD9PrZq8vqcdEnpSmMF6v6
         cOYKV5KhwiDD9MVwsFFOjrtu6QVqgVqKDpDvR3FsrGd//NzgD2SRMmvyoHc97TEdXMqt
         ES9ZQJWU6XLAPJCtxyiSvPFQpcS98PfJK4R+spMUpKppfMWabNFFjE+yOvFchQ3YtqZF
         Tw0vn1xyPDaXhfmoRfplpTjkvo/qB/7pPJM5bAHMPEtWhqVWgtRIxZXx9oQ9WwnYIGdN
         /y2y6fvrgjXYJKqhZb/dFqJWCeFVGrEJqPw9JhyPB6S9h7H9HMURcE/vf6JjGpK4ECBN
         fpQA==
X-Gm-Message-State: AOAM531sMbgNnZyoc8YV159Nz/fDMM3c5AmKlXKtLlozlfrGqovtWH6i
	30nh7qDzA6WBeAU5PO29oAg6Z01FvSMa6xX8PR0OlWiD0WZ32w==
X-Google-Smtp-Source: ABdhPJxs2HE0Xh00WPZCQQo7nEdBo4GUmiOJ64PHT5wfIKFkvCeV/RealYMhaok8fMohS62d1qz4UXxjaDuUxs+ib2Q=
X-Received: by 2002:a05:6a00:1634:b0:44b:7184:5ec4 with SMTP id
 e20-20020a056a00163400b0044b71845ec4mr10094201pfc.40.1634281783523; Fri, 15
 Oct 2021 00:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <20211007213021.58712-2-michael@amarulasolutions.com> <20211015065250.nt2bprsnsrpdfeoq@beryllium.lan>
 <CAOf5uwkB6FYrpzs0djVB8EYe3-rG8C0o+JfzoV7+3B_YtU1OrA@mail.gmail.com> <20211015070401.of3ybrtbt2p2vm2o@beryllium.lan>
In-Reply-To: <20211015070401.of3ybrtbt2p2vm2o@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 15 Oct 2021 09:09:32 +0200
Message-ID: <CAOf5uwkQWf8e4Tj-FaW4Us7iHzGa+uz=roFpp+NQyHsXMBoozA@mail.gmail.com>
Subject: Re: [PATCH 2/4] tethering: Add possibility to configure the access
 point frequency
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

On Fri, Oct 15, 2021 at 9:04 AM Daniel Wagner <wagi@monom.org> wrote:
>
> On Fri, Oct 15, 2021 at 09:01:15AM +0200, Michael Nazzareno Trimarchi wrote:
> > I have done git remote update. Nothing new there ;)
>
> Try again. I wrote the email before I did the 'git push' :)

Can we move the tethering in iwd when the plugin is activated?

I have done some test and we can support AP+STA using iwd.

Michael

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
