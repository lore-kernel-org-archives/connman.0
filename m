Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1643D8A
	for <connman@lists.linux.dev>; Sat, 27 Aug 2022 12:41:17 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so5319431fac.12
        for <connman@lists.linux.dev>; Sat, 27 Aug 2022 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=wqsha25TbB4g3csIRszjG8fuNfT7zTJt33jZL44Zxg4=;
        b=Itz2zonFvzjE8BbP1pgHOEbRDSR550xcQSqLMAuj30glAaelYnPkS/Qi0DTp8vsg52
         Zn8/YTkin8D3B85Oe7IMjQw76/pyJKmpeoj3n2euVYzWhFuzaYdVd4r2unxcxNeJu8R3
         2o9V0PwEQ7F+WJS0fm+RCURUj6e2fQQ6R5MBgNxPzMbUEPR0Z8umV5gwOMw/tW4zQ4ul
         TeNujfP0OGsQOvU6Jr/BbmWNkijOkXhxzNgyrXJ9GtuJc0/4ErZK3Chx1eCuNHDOfixp
         2l+Vd1wo4T4oWv47uLi6q9aU8usY2EVEzxgbnMo/LB9Ct7y90grIyfWAPMkfPcEO5Oxv
         C6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=wqsha25TbB4g3csIRszjG8fuNfT7zTJt33jZL44Zxg4=;
        b=dIdzTdFViCOYXNEBeIqdRINQURliqyELyH4dEgFHjVO1I+YsVAk0AdUB2x27AvSfWH
         ukkJjdRz/O6i6nqrLvLoom1q8p9afCR4uaDz6aQtQvLky5heL3O64rlRQVWgAgjE1vfg
         Xv2QEr48/8l7pz+Lph46Qs00HOjpWROxePGjSPnsJCNrX+NpGXaGvOlwQsCIqhcoXIM6
         KuCEUWCr8I+Qp2e212s8TTC9kwV5jBEBD4bovm0FxfGf927ncy1cxnsgEeKzpwmytz5x
         /Z/NrH7TmYkX/pt/UlMKpgPmlZqyyyE0V4KJrdNKenIUmQtKbgDF3Ve4NYVw1fddPa3b
         8VvA==
X-Gm-Message-State: ACgBeo3icZ9dT5UgOPQWH2ivbb7xkqsGkSr+U3HfVluuSRjaKw5QPtAN
	u6HPRNVYGsb6sw90+RPkjndCOMpPGV72s3SvNcNsY0Pe6Q3w8Q==
X-Google-Smtp-Source: AA6agR7NPQk/Ao1VVQ08pe+7nAq9anO7TfDiQWRNy26jancYmBNTx6egXJ6TlICKgAeA90BezMA3mAnyY8pxCtFRqP0=
X-Received: by 2002:a05:6870:239d:b0:11c:3434:863a with SMTP id
 e29-20020a056870239d00b0011c3434863amr4073135oap.296.1661604076444; Sat, 27
 Aug 2022 05:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzBCG+F5P4q4T4wTwONcCzR5doDpzz=t-SgvFR0eqzKeKw@mail.gmail.com>
In-Reply-To: <CA+iibzBCG+F5P4q4T4wTwONcCzR5doDpzz=t-SgvFR0eqzKeKw@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Sat, 27 Aug 2022 14:41:05 +0200
Message-ID: <CA+iibzBU-cYMgLHD98nB-jBhnH-gG0V6n8Z1SkSkmJFrudCHBA@mail.gmail.com>
Subject: Re: Link always ready and don't pass online
To: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I have tested by using the file source
https://www.kernel.org/pub/linux/network/connman/connman-1.41.tar.xz.
The link has passed online . So I compiled by cloning the git untilI
it failed on a faulty commit.
The link doesn't pass online and stays ready when commit
416bfaff988882c553c672e5bfc2d4f648d29e8a (wispr update context portal
references) is installed.

Best regards

Dania

Le jeu. 4 ao=C3=BBt 2022 =C3=A0 23:00, daniel antoine <univac55@gmail.com> =
a =C3=A9crit :
>
> Hi gentlemen
>
> I have a similar problem as the issue described in the commit
> d48584aa8bed06f9b728579ea64deb8d30b03b86. The connection never passes
> online. I have tried different ways wifi ethernet and a shared
> connection with a mobile without success. The systemctl status connman
> always returns:
>
> ao=C3=BBt 04 09:23:16 yaolinux2 connmand[2138]: Failed to find
> URL:http://ipv6.connman.net/online/status.html
> ao=C3=BBt 04 12:22:32 yaolinux2 connmand[2240]: Failed to find
> URL:http://ipv4.connman.net/online/status.html
>
> When the link is not online , I have no access to internet in a VM
> (virt-manager)
>
> I have the main.conf file provide in /etc/connman without option validate=
d
>
> I send you a log of the start of connman done with the command
>  connmand -n -d 2>&1 | tee cm-log.txt
>
> It looks like it never reach the default URL for the check online.
>
> Best regards
>
> Dania
