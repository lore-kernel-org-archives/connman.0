Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558D10E0
	for <connman@lists.linux.dev>; Tue, 21 Jun 2022 15:00:49 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id mf9so7778129ejb.0
        for <connman@lists.linux.dev>; Tue, 21 Jun 2022 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=j9OYrY7Lxy5pQjuWR4CtU8g71u7jAZfqipnKyAGoLoQ=;
        b=LDUK8GP5ZfVIvnD61D4uDKwcP+HsuDIHReiHCjBVwNeZJ8yow9O/OxBM5yxlH4Nkzj
         JvNW9X22qaD137cZmuY9f4l7ftmpXlZFaDv7PDAHQPT+Ycr8MtI88dvMRD5deNecxamz
         WBpFt0snjS1opGG9Ifmqi7OSqumHF5olCQcwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=j9OYrY7Lxy5pQjuWR4CtU8g71u7jAZfqipnKyAGoLoQ=;
        b=44arvabtDsXFNRJVTZyKhN3wOs0vDo9mDbpOzJt/mg/QxwWm/abMSn84TqgMrfYdwb
         uUeb9YcFwoXAz9dyM7YdSwZXTg0QoNZAD5YU46tWmDRV8aX0b9clgD6ToSKw8rLFR2/U
         Wb/oROayU7x30tRxfhr0//7eCMPwEocUOklBnkT6UvOgtdYBhe2I988ETCnXjDM3aofI
         dp+5rNXHZ6ERS+rEoqXx2TlWFyd+CVrJU6n1K13kzUI/EiJ2fuBC3OJRxG/O3mN4N9V4
         BgJzBVv4Na3KnIacRXzddPxlXMYODQ5RAk0fx2wqSeBZhvK3zD5PBQT2AIpGDAwyvzWz
         dVug==
X-Gm-Message-State: AJIora+mixiGg+nzacHaSUmRmHuqY8tKG9DwnySEXq08SHdFY9/4AyVA
	nokB26ZmtXbQIdrcRChBych/3ymt2y8zJK/C
X-Google-Smtp-Source: AGRyM1uboBkbsXhUt8uNtaWhPaeJTllS0auB0kC4286dNpXIJsEQYvRfhKP3Jw+Cdcg3tIbIBBvBAQ==
X-Received: by 2002:a17:907:161e:b0:722:dcf0:2a0 with SMTP id hb30-20020a170907161e00b00722dcf002a0mr5043332ejc.694.1655823647729;
        Tue, 21 Jun 2022 08:00:47 -0700 (PDT)
Received: from smrz (dynamic-2a00-1028-8382-0206-0000-0000-0000-05fa.ipv6.o2.cz. [2a00:1028:8382:206::5fa])
        by smtp.gmail.com with ESMTPSA id cf9-20020a170906b2c900b00711d5bc20d5sm7765806ejb.221.2022.06.21.08.00.46
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:00:47 -0700 (PDT)
Date: Tue, 21 Jun 2022 17:00:46 +0200
From: Roman =?utf-8?B?U21yxb4=?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Subject: Removing credentials for unavailable services
Message-ID: <YrHdHggQSI2xH5fB@smrz.lan>
Mail-Followup-To: connman@lists.linux.dev
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we have a setup where we need a way to remove WiFi credentials stored by
connman. This is possible using the net.connman.Service.Remove method,
but that's available only for currently visible services and I don't see
other way to do this that would work for any stored service.

To solve this, my colleague created a couple of patches adding new
methods to net.connman.Manager interface to list and remove known
(stored) services. Does this approach make sense to you for submission
here, or would you suggest something different?

Regards,
Roman
