Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A81D5AA0;
	Mon,  6 Jan 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183632; cv=none; b=kmEniCvc9CPEGtg0Ir5Wkxyw7Ve6UM2Lpah3mBSqfPdIIGMZGJoe/eq3XEkfaSBAQGuuqJ9QNHcr0YY08/eucT8e04Ym8+CTfwSm/iW3duBCQ53mzd49Q6cNQb0giS83OvrDwJzFqOkDZTTbBiN3Hvt27DXWtX5ZO+Z3oksaPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183632; c=relaxed/simple;
	bh=4X6zyYxK1QCiG9SsBLkpMIskQ4/0BPLxlhV1jv2pTrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptg2gYax1k7xmIRgMYmQ1WKyEMKwozUBAXsQILbqg10Onco4dBXxOIfVupWB/HhHsswKqwwr0IK0ZClLT9/rSwYqQ8Gb9y07VothAACSCjVN+R09uzdtp3JUHuk27TzmH4e8lyjiQQAnstfb51yDlILDZ8E4VLyjFkSxOaYg0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUnuWz6p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUnuWz6p"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21675fd60feso11630885ad.2;
        Mon, 06 Jan 2025 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736183630; x=1736788430; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E4VBveUTiXAQY0x0OPSL/+vTNEOjG/u16OolfG/dLM=;
        b=EUnuWz6pjS7vvamW/9Q8pMF/9ybB+RcwsY7UtscUStub3JHnwt085vk6Enym5axi6G
         Yp9YNltffECh+5QNI98MoXVEihZYGwwu1/89P4R7fE8t7JxIon9DoMsDSUEXxiWYB9rg
         6ZY/uLSdVuk2AdS83YT6YDygnXniXpvbDbjV4Kfnfyl/C2nyvc7lGtax8yclQGfiWuN+
         g2Bs8H8DANDfY5fz1ESq4OrHUfJ7I4IPkPvLegnKRYZ1Z+5lUkc9ZJNYJvx/pHC9rYAA
         KlYO9KNIkKsOi1dAw75VqrkqxwfTryzBH9JO7sIL5ChEfKzE1SIWtXEs/RKvGzHZm/De
         ISwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183630; x=1736788430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E4VBveUTiXAQY0x0OPSL/+vTNEOjG/u16OolfG/dLM=;
        b=jRPb6MeAdV37n454IPyzS/8Xm5PHCatfVZhgpqgSIna9SA+CnFhbQ0j1c0Tj2P47LT
         2TSfsHJEzzA2BWgyfT8Nq6BmmJ9DU4LdF4Qov2IQpzs9OZik7D08VLki0c+qg2d0ZdQF
         dMr/6M5vo248FIjPlJpj68qCGz2NMQ5D56BuIf6KSUaBM7Fbm8ZQ18SZQUjUyyLlvsDd
         C1S+GTqJkrr8QsRMQ7XYUFyf0zlFlVzA5W9CJ7/bYdKz55c+on2RhchRdqCUUShHoYEQ
         uS1oeVhC4rjSgoG7wV4tC5iD5iU6LfqaPrVWih9I7eyTmPFVQdaNmDYXLvt/e+In147c
         1TLA==
X-Forwarded-Encrypted: i=1; AJvYcCUdupgatycQGftCYdOi/zhvuZk9xL1PQQTHWAaoWyJVCqFx7vXg3eK4WM5GCJpkgbCmtriz59CF+8o=@lists.linux.dev, AJvYcCVwlayCW9O7KpTMk52cuTEirjr9ifLgp07ZoGFoEw0TjzAfn8pQWwIeTx9nLX/L+xH74PMLMRPjJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxklaZ15bdRA/wt8EKf8Q3cnoX/F9na02hK8sF4+RGy1wP8Q+yY
	HQwfs/IslroQ5qiONV2cJoT7wG3kiDrQatXonjipkyKko+1ZqTCg4ppQVdUrwgIEO+shLwRr3fc
	ES8YwFdaFkyMX4QcuhAlufA5NoySPxn1N
X-Gm-Gg: ASbGncsGjp0rAxGdafBa9yRZF6INkuCr308bJyVIQGqDUzCcT7KY1Uc3rD7kKcaGxhW
	iOUKulAYQITnIoAEVmxjWfsv/A037aPVJHkOuXAYx
X-Google-Smtp-Source: AGHT+IGFEmKlsE7w4ki0FRERAZd7MgyKM/i6eTRH2L7lzZ9eaCyLEYA1hsVHBLYEJEXYfzPLxFzRrjHg8V+00MjhZ6c=
X-Received: by 2002:a17:90b:2543:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2f452e372edmr79317340a91.21.1736183630396; Mon, 06 Jan 2025
 09:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com> <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com> <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com> <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
In-Reply-To: <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 6 Jan 2025 11:13:39 -0600
Message-ID: <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: Denis Kenzior <denkenz@gmail.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, James Prestwood <prestwoj@gmail.com>, 
	connman@lists.linux.dev, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:26=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> wr=
ote:
>
> Hi Keith,
>
> On 1/5/25 6:41 PM, KeithG wrote:
> > I am looking at the iwmon logs for a successful wpa_supplicant
> > connection versus one from IWD. Both connect and both pass data and
> > both grab a DHCP address. I do note one difference in the connection,
> > though.
> >
> > Request : Connect
> > through the responses RTNL
> > wpa_supplicant knows it is dynamic
>
> wpa_supplicant doesn't manage network interfaces.  I assume you're using =
ConnMan
> for this? If so, ConnMan sets the IFF_DYNAMIC flag.  See
> https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/inet.=
c#n372
>
> >
> > Whereas the iwd log does not:
>
> iwd doesn't use IFF_DYNAMIC in its DHCP implementation at the moment.
>
> According to 'man netdevice':
>
>                IFF_DYNAMIC       The addresses are lost when the interfac=
e
>                                  goes down.
>
> I doubt this is the cause of your DHCP / connection problems.
>
> Regards,
> -Denis

Denis,

I am using connman to manage the connections. The connman config is
the same. The one iwmon snippet was with iwd masked and stopped but
wpa_supplicant installed and the connect performed in connmanctl. The
other is with wpa_supplicant removed and purged and iwd started,
running then restarted connman then initiated a connect form
connmanctl.

I pored over these logs yesterday and saw a few differences, but this
was one that stood out. I can look closer again tonight and see if I
notice anything else that I can summarize.

Keith
