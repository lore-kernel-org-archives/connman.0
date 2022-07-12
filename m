Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34994681
	for <connman@lists.linux.dev>; Tue, 12 Jul 2022 17:59:56 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id l23so15699419ejr.5
        for <connman@lists.linux.dev>; Tue, 12 Jul 2022 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightyear.one; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XCkj1AmChGAeVZ2jTW0O6iOAMD/wxnSj3YM7/7GOqy0=;
        b=TFhNop29GIzPAPxMFkWsls5fS8tcq6dsEpNAGjy2/cEAns0loUOjusbiSi9F64dVzR
         9/E4CumIZxa5j31atWHEPvvBk0v+h1gvLSSHOUEGSlprAPtI/WjpbDc2GN7p4jYjUVRY
         arwyqMyDSuWxOAJwlw4zXLWpAxrARJsPvQmTESOb7wTdvcLpuK5vu8ak6eEYTSF2jvXN
         5C6Tv+n1VkYw1Y2E9JhrW4HJkpwdG2WgJJfHkJrPMXE4tD9lO/Jik1G46O34KyYyDghi
         Alkgd3ac4YHQh2deqC+veFJltlX6wTu/tkHtwgePQNUn+ahLNHXaj193h6xkm+VfoAZW
         6SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XCkj1AmChGAeVZ2jTW0O6iOAMD/wxnSj3YM7/7GOqy0=;
        b=2jnvYoxrR4MUXvpbW6GD52jWcZgXPH3iMWU+cE9l9J3lB9YcwqzS6Yezz44ysjoBgc
         jti/OaaTD9obcMrGUO8eyTUuhmO+z//n40FsC9dBZnifKHnuiODKXzOdgSjl6OfVjOTQ
         7BKCoWVnK7EcJUUVo5IxxLjmFpDrdyqI1PStXVq837vfwCKFGz79YZTEouDg6T5POivy
         h8hMGIF6biLbI9lk0ZTmLUvvp7JhnrSDNz0HWLuxkBELBDCCp+vnkUhtzvjTL/cMbtkb
         CTXUOOJaVI0YWBp6UiBF7vVvY+6NXwL6zWegs+fRBKk1Q8MKR0azhPQ3jyvmExEmuIbB
         8FGA==
X-Gm-Message-State: AJIora8D5wO2qaGTjgJy4lMabuAEpUuDecGnY6CMp/cHDEZZl4DZ75xo
	R7ZjL0pcHK/iXFN9rLwQIKGZcK/F6sDnkFpVyA8GL+4knCPLZJvLwpUvZ+SLGBUPg9AGZPG+A+R
	B/t3rqf0Jb/+RzMifwg/dsQuJo9VzqSfg
X-Google-Smtp-Source: AGRyM1sxzhrZHF6hCsBHfNQLGsNRlhudJQNSzoiV2E7QHOoknXwQ7FJwbGshGPtDvoqap5ZKHgbfXPs4dStrdJOijXs=
X-Received: by 2002:a17:907:60c7:b0:72b:5651:e1f8 with SMTP id
 hv7-20020a17090760c700b0072b5651e1f8mr11229043ejc.375.1657648794624; Tue, 12
 Jul 2022 10:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKO9uzo6wftURnuxZBf8Fo+F1D8TYSKTOtC9JLvQQXSiUxG=KQ@mail.gmail.com>
In-Reply-To: <CAKO9uzo6wftURnuxZBf8Fo+F1D8TYSKTOtC9JLvQQXSiUxG=KQ@mail.gmail.com>
From: Maik Vermeulen <maik.vermeulen@lightyear.one>
Date: Tue, 12 Jul 2022 19:59:19 +0200
Message-ID: <CAKO9uzr7nwsjuBA_4w7waQ7oeZg0QBJ2e_ex+m0PYBPUcrLtGA@mail.gmail.com>
Subject: not reconnecting despite available network
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Currently we see that after deregistration, we are not reconnecting
anymore. Everything seems to think the modem is already searching for
a network, but if we execute AT+CGATT=3D1 on another port we instantly
get a connection:
Jul 12 08:56:03 agent336 daemon.err connmand[3037]: Failed to change
property: /quectelqmi_0/context2 org.ofono.ConnectionContext.Active:
org.ofono.Error.InProgress Operation already in progress
Jul 12 08:56:03 agent336 daemon.debug connmand[3037]:
../connman-1.35/plugins/ofono.c:context_set_active_reply()
/quectelqmi_0/context2
Jul 12 08:56:03 agent336 daemon.debug connmand[3037]:
../connman-1.35/plugins/ofono.c:network_context_unref() 0x16f5a910 ref
1
Jul 12 08:56:03 agent336 daemon.debug connmand[3037]:
../connman-1.35/src/service.c:service_send_changed() nnel ip address
(null)
Jul 12 08:56:03 agent336 daemon.debug connmand[3037]:
../connman-1.35/src/service.c:append_removed() removed
/net/connman/service/cellular_204080811961813_context1cast (null)
Jul 12 08:56:03 agent336 daemon.debug connmand[3037]:
../connman-1.35/src/service.c:append_removed() removed
/net/connman/service/cellular_204080811961813_context2

!!! AT+CGATT=3D1

Jul 12 09:30:51 agent336 daemon.debug connmand[3037]:
../connman-1.35/plugins/ofono.c:netreg_update_name() /quectelqmi_0
Name KPNg 0x16f5b950

Our setup:
EC25-E, qmi_wwan driver
connman 1.35
ofono 1.22
libqmi 1.20

Does someone know what could be the problem, and how to solve it?
We hope it's not necessary to update those packages.

Kind regards,

Maik Vermeulen
Embedded Software Engineer=E2=80=82=E2=80=94=E2=80=82Lightyear

--=20
=20
<https://lightyear.one/careers?utm_source=3Dsignature&utm_campaign=3Dspotli=
ghtroles&utm_medium=3Demail#vacancies>

--=20


Automotive Campus 70 =E2=80=945708 JZ Helmond, the Netherlands
www.lightyear.one=20
<https://lightyear.one/>
 <https://www.linkedin.com/company/lightyear.one/>

This email may contain information which is privileged and/or=20
confidential. If you received this e-mail in error, please notify us=20
immediately by e-mail and delete the email without copying or disclosing=20
its contents to any other person. Lightyear is a trade name of Atlas=20
Technologies B.V. and is registered at the Dutch Chamber of Commerce under=
=20
number 67264298.=C2=A0
