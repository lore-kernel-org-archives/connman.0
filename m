Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1307B
	for <connman@lists.linux.dev>; Fri, 29 Apr 2022 19:07:05 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id u9so7298197plf.6
        for <connman@lists.linux.dev>; Fri, 29 Apr 2022 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ssnFkjc519pkRNffBnmwHakK6PMA5qEThEtjTDUcRkE=;
        b=qWlTOFddfxMDZ8T4cLRKGoXTaLhVAqTHj3+V1nqS22jZT3P0ZX3NmTPicpeueQR0Lw
         jMB+LqBRRayeWFODGIvqGBH2ShwiA1MtoDhGzolHJ1EW+nmwURz86/Jl3zSBeVvZmRX0
         RGfsk6Y/U/mbZ0X9HLktAdHbnwm9PCwoYiuFJvUaihBsPMfsyjAKYCaNy67G/UKtjkUz
         pvMj0Yk245fPQdgjWk1WPSb8jwybtqftoY5YAX9LU0j5p2fGQ/+bkoGq1+l7jcuD8uo4
         qlkKJfxxKsmKM5uckpCqHnUqsmyjadrlqFMvvoVjE1C1nygyPwt6una7SItSWbV+8S/c
         W40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ssnFkjc519pkRNffBnmwHakK6PMA5qEThEtjTDUcRkE=;
        b=kzu6XuSf2zK1q+AnTsQfv9gS0WNuH6WRhuPvBVg7KJ0wBgaxVYoBwooH7dDvoc+D0q
         aVLBbNgC4k6szO6bGExleSvfQUwRCxob2Veo9OZqI+sHDhUqBLdRzILnFcGIXokeAyY8
         KnqXgKQ6smaNEFIEcnyKrOteUm9B+KGkCiQk0gCgL4Yj/xSSEDhVHIAIghTrtkMEn1ca
         ni6MlY+mfxwHxt4tu0yqfB1C116ahX83zt3ZUUBVJJkeGdAb5fXBMKwAvk9wx6u8JKdC
         ILFTYp6guBhwzqJRtaEaNd1sEULDDEO3Oa/GgDoTZ4+TVhy2SnGFWpLZEIctXqU94oce
         3gIg==
X-Gm-Message-State: AOAM533e65N7W59M2EJpdooBaK8EwkPp7/LKWVUByz24Bx+AVca7zXqT
	vwYm0K6nx3gYbH+OmFt2BdDICR+tytIU/ON5nfM7UOfo
X-Google-Smtp-Source: ABdhPJx89BCRQDISUVht9A9Zmr9LEhlPOWQRS6DMk5bzYruSE474awW/rEZkHP98TSP65P0Kvkid7OV0TpiOM5SkET8=
X-Received: by 2002:a17:903:230e:b0:15e:81f9:dc43 with SMTP id
 d14-20020a170903230e00b0015e81f9dc43mr837398plh.58.1651259225021; Fri, 29 Apr
 2022 12:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Matthew Austin <matgaust@gmail.com>
Date: Fri, 29 Apr 2022 14:06:54 -0500
Message-ID: <CADEpph=wc+bN3kMDCYtV5b=mjaB81-V2CW2hfzZJJJ1shXXAEg@mail.gmail.com>
Subject: Issue with connman.service
To: connman@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000008a492605ddcfbf6e"

--0000000000008a492605ddcfbf6e
Content-Type: multipart/alternative; boundary="0000000000008a492505ddcfbf6c"

--0000000000008a492505ddcfbf6c
Content-Type: text/plain; charset="UTF-8"

Hi, I'm using dbus to try and connect to wifi access point. I've made a
provisioning file in /var/lib/connman as suggested by the documentation.
However, when I make the call to the endpoint Connect for the service that
I'm trying to connect to, I just get Operation Timeout or I get that the
signature doesn't exist. This happens when using my c program to do this as
well as doing this through d-feet. I'm not sure but it's like it ignores
the provisioning file that I have. Attached is the file that I've created
as an example. Any help would be appreciated.

Thanks,
Matt

--0000000000008a492505ddcfbf6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, I&#39;m using dbus to try and connect to wifi acc=
ess point. I&#39;ve made a provisioning file in /var/lib/connman as suggest=
ed by the documentation. However, when I make the call to the endpoint Conn=
ect for the service that I&#39;m trying to connect to, I just get Operation=
 Timeout or I get that the signature doesn&#39;t exist. This happens when u=
sing my c program to do this as well as doing this through d-feet. I&#39;m =
not sure but it&#39;s like it ignores the provisioning file that I have. At=
tached is the file that I&#39;ve created as an example. Any help would be a=
ppreciated.</div><div><br></div><div>Thanks,</div><div>Matt</div><div><br><=
/div></div>

--0000000000008a492505ddcfbf6c--
--0000000000008a492605ddcfbf6e
Content-Type: application/octet-stream; name="main.config"
Content-Disposition: attachment; filename="main.config"
Content-Transfer-Encoding: base64
Content-ID: <f_l2kt2vrt0>
X-Attachment-Id: f_l2kt2vrt0

W2dsb2JhbF0KTmFtZT1Sb2JvdE5ldHdvcmtDb25maWcKRGVzY3JpcHRpb249Q29uZmlnIGZpbGUg
Zm9yIHdpZmkgbmV0d29yawoKW3NlcnZpY2Vfd2lmaV9hNDM0ZDlkYTQxY2FfNDY0MjQ5NWY0Nzc1
NjU3Mzc0MmQzMl9tYW5hZ2VkX3Bza10KVHlwZT13aWZpCk5hbWU9RkJJX0d1ZXN0LTIKU1NJRD00
NjQyNDk1RjQ3NzU2NTczNzQyRDMyClBhc3NwaHJhc2U9c25vd2RlbjNECkZhdm9yaXRlPXRydWUK
QXV0b0Nvbm5lY3Q9dHJ1ZQpOYW1lU2VydmVycz0xMC4xMC4xMC4xCklQdjQ9ZGhjcApJUHY2PWF1
dG8KTUFDPTU5OjdhOmUzOjhkOjM5OjJmDQo=
--0000000000008a492605ddcfbf6e--
