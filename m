Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F912C81
	for <connman@lists.linux.dev>; Sat, 27 Nov 2021 05:51:35 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id w23so22672074uao.5
        for <connman@lists.linux.dev>; Fri, 26 Nov 2021 21:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A+UUrMyDLtA+XjLXsJSwBQlAxznyKLH+X2j/VhK39Ag=;
        b=lHUd0OfiGCisXIZKuX+tRNpQb7bpImrx1eb2VZnySJlsUgd8uW6jSZrF9zAUGMpoFq
         shh7CZ3SKDA5SNvCTrrktuDBdX1Lvk9YB1fI3ydXeYuwb8BRmupeJfHhiBq7d+GLCyLB
         b5YGJW11R2XVnehp6IUq6jCxuauxEgBdrZufcE4QjEg1KerzO7LLu7GAUKmIQe9/Mkot
         nvY6wdE+/A6mE9JF4aMAoeVQUZ30KHdQtF7j84nSddErwqntFGuizqjhcQ5cGbnOFHwz
         4kNG27Y/QslmyGu21sbxsYUcptyeuypKbNyi1SVp59Ck/hE5wDWItZ3Dqe13EDEx7E7q
         72Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A+UUrMyDLtA+XjLXsJSwBQlAxznyKLH+X2j/VhK39Ag=;
        b=zeKlUfUzUawD/+Ec+pceXywhBDhpljIeiO4Wgy8/mxt7LFGPY22nAHHA+dfsKovjV2
         DsLrC31qjF9+1t3CmfVCMH5jK6OxuhPdCCZtX4SABAima5nX4e8Ejyz0UADYhKEv7fcx
         gFlFFyB68h4ttytk+hMfYSldTl0QWcL8bh/nJM81lF/5OKsUsqNeJEohdK6Ce0PTUBgq
         R5FCJzOExwpHP0lVmce5jq273bCDi9fRIyZAOHVuJZdssZrwDhl7KQneEehuOEnVfr9x
         kDTlM3PnxlRe2e3Modei0wUIwaE+8Y+Wwrc6BqvjIiku/yLFhfuS9Ix+uYrDzScSc28L
         NS6A==
X-Gm-Message-State: AOAM530em2NjXvhAcS32tCXkH9CmmI2SIQ3A0pAKDlJDDzwTJOkmf0JH
	8A2JmKcNvskTgQy29n65C4Vh086dUbUk/UN8Foo8KwqptCI0nA==
X-Google-Smtp-Source: ABdhPJxCDQMDE1PzYhOV5NV9iDFpcjT4eN/Xl41+CpScDlFvbNqtabouvw3xcPVLzwIjQJOTKiWy9p9MzBuWk0geBUE=
X-Received: by 2002:a05:6102:a46:: with SMTP id i6mr21286778vss.19.1637992294356;
 Fri, 26 Nov 2021 21:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <16BAEC7B11896AEA.23256@lists.yoctoproject.org>
 <CAA=hcWSA8-8TCJDD8_Zib11Vaizok-xZvQMqSevjKJLrQ+GuhA@mail.gmail.com>
 <16BB4412EB9EABB0.15594@lists.yoctoproject.org> <CANx9H-BczVumN8LwcH6+4SmobRJz=Hxmand2soVyfuoYZVmMQw@mail.gmail.com>
In-Reply-To: <CANx9H-BczVumN8LwcH6+4SmobRJz=Hxmand2soVyfuoYZVmMQw@mail.gmail.com>
From: Jupiter <jupiter.hce@gmail.com>
Date: Sat, 27 Nov 2021 16:50:58 +1100
Message-ID: <CAA=hcWTwe9WM2CoaMyrxWX3zHRRa3QyzgMQd5AC5QPGE61o3rA@mail.gmail.com>
Subject: Re: [yocto] [OE-core] How to create connman_1.40.bbappend to enable
 and to build connman with iwd?
To: Tim Orling <ticotimo@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, Armin Kuster <akuster808@gmail.com>, 
	Daniel Wagner <wagi@monom.org>, comman <connman@lists.linux.dev>, 
	oe-core <openembedded-core@lists.openembedded.org>, 
	yocto <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Tim for the link, I have built the iwd.

According to Daniel's advice to configure with "--disable-wifi,
--enable-iwd", I added PACKAGECONFIG[wifi] =3D "--disable-wifi,
--enable-iwd", to override PACKAGECONFIG[wifi] in oe-core
connman_1.40.bb. The intention is to remove wpa-supplicant and to add
iwd to connman_1.40.bbappend, it built the image without error, I
believe that the syntax is OK, but the wpa-supplicant was still built
and packaged. Any idea from OE/Yocto insiders why PACKAGECONFIG[wifi]
in bbappend is not effective?

Daniel, how can I verify in the Linux console if the connmand is
running with iwd or with wpa_supplicant? I have disabled
wpa_supplicant.service, and I'll remove wpa_supplicant completely when
I find a way to do it.

Thank you.

Kind regards,

- jh
On 11/27/21, Tim Orling <ticotimo@gmail.com> wrote:
> On Fri, Nov 26, 2021 at 5:48 PM Tim Orling via lists.yoctoproject.org
> <ticotimo=3Dgmail.com@lists.yoctoproject.org> wrote:
>
>>
>>
>> On Thu, Nov 25, 2021 at 10:26 PM JH <jupiter.hce@gmail.com> wrote:
>>
>>> Hi,
>>>
>>> Given the high profile of iwd and advocating connman with iwd, I
>>> believe someone have already built Yocto connman and iwd,
>>> surprisingly, I could not even find an iwd recipe in
>>> https://github.com/openembedded/openembedded/tree/master/recipes, nor
>>> can I find connman document and instructions to replace wpa_supplicant
>>> by iwd, what could I be missing here?
>>>
>>
>> Please look at the layer index for recipes:
>> https://layers.openembedded.org/layerindex/branch/master/layers/
>>
>> I don=E2=80=99t have any advice for building it however.
>>
>
> I forgot to include the recipe link:
> https://layers.openembedded.org/layerindex/recipe/89268/
>
>
>>
>>> Appreciate your kind advice.
>>>
>>> Thank you.
>>>
>>> Kind regards,
>>>
>>> - jh
>>>
>>>
>>> On 11/26/21, JH via lists.yoctoproject.org
>>> <jupiter.hce=3Dgmail.com@lists.yoctoproject.org> wrote:
>>> > Hi,
>>> >
>>> > Please correct me, but it seems to me the connman is moving to a
>>> > direction to ditch out wpa_supplicant and to use iwd, but the Honiste=
r
>>> > still configure connman with wpa_supplicant by default, appreciate
>>> > your advice:
>>> >
>>> > - Is connman with iwd stable enough?
>>> >
>>> > - How can I create a connman_1.40.bbappend  to replace wpa_supplicant
>>> > by iwd configure?
>>> >
>>> > - Where are the documents for configuring and building connman with
>>> > iwd? Where is the operational guidance to run connman with iwd? Can I
>>> > use the same connman dbus APIs or are there any dbus API changes to
>>> > run connman with iwd?
>>> >
>>> > My apology for FAQs.
>>> >
>>> > Thank you very much.
>>> >
>>> > Kind regards,
>>> >
>>> > - JH
>>> >
>>>
>>>
>>> --
>>> "A man can fail many times, but he isn't a failure until he begins to
>>> blame somebody else."
>>> -- John Burroughs
>>>
>>>
>>>
>>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#55430):
>> https://lists.yoctoproject.org/g/yocto/message/55430
>> Mute This Topic: https://lists.yoctoproject.org/mt/87331141/924729
>> Group Owner: yocto+owner@lists.yoctoproject.org
>> Unsubscribe: https://lists.yoctoproject.org/g/yocto/unsub [
>> ticotimo@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs
