Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645D2CA7
	for <connman@lists.linux.dev>; Mon, 24 Jan 2022 21:54:33 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso340127pjv.1
        for <connman@lists.linux.dev>; Mon, 24 Jan 2022 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hVl+u14sLPQrZovNHOub2b0QgX3cGrjKkOhtirK/wOU=;
        b=AfRVRbrJp/yoq4TpVNmGdgjy88B93ygHPRiOPpJsARx5+AGPr2TEUaC6VESLPcJ5e+
         bYZMAgfA+aguBhzdzwe4Ahqb6mRwH1eCQdJpGpoA3K+2+qqHqzk/AMviyjqz9igJZ4Td
         oDP73K4Yg1+0nn1O4JlNtOcJ+d0ScpD7xjJ13phX6sI5MnZjh/vfeSe0bg4JlfJgLqdl
         7fjkSmmgd0hxn3CqDk/oXZByhBhSX/OtY782C1aiyWjDQM48b0Fslk85RGMgINBjwjKJ
         m3vwKiOA1s+it/eWfzQTr7DYS0imXvaSULACBl6vE8yFqr1YqQKdpEiYZQmplDjazdZQ
         qsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hVl+u14sLPQrZovNHOub2b0QgX3cGrjKkOhtirK/wOU=;
        b=21QaTQ2Yl+Xyod6d2SkPfiQ+YJ7MxwTfSC+NjIyidy/vDJVD+jWIlQ9aBPk8Pxxttu
         kV340HZJlkYnSlwRZ9p4FqMAuXCYxuBAUkru2yt0WZO+sSAFKzPAhqHd6b6vLpSylbTl
         LnuW0jhqaF95zdlFKXljtl2N1HWqR+kRvWO7SwWCEYGFcAD/ht3yW+ylmWlOZWMSdIB9
         EZ6DJktpRZuIjpwpiu1jOM1gFcIlhRf0hJ7asGdOLev6T4USUW8f6yT0x9wVUB4JnK2Q
         XSb5Ue76Xx/tIf6ShlvbnFI/mKSJppUvfQUtN5tbimBx93G7jSDWYGEMnDgwMqaO9ngM
         5e/A==
X-Gm-Message-State: AOAM532f6KXJZipqBXSz5f/QLrf+dafxKnH5lkWlseb76eNSHbT8b2io
	hpGaD46RQpoEPPneVzTf8Tw=
X-Google-Smtp-Source: ABdhPJy1jKwOYn0LfsTRzcBELtIebVmqcp1oQ4hN3psp0Gz2tChXM1X2DIJmC9NFUKhoRSGcg4pUlw==
X-Received: by 2002:a17:902:7786:b0:14a:e8f4:a9d4 with SMTP id o6-20020a170902778600b0014ae8f4a9d4mr15961255pll.86.1643061273165;
        Mon, 24 Jan 2022 13:54:33 -0800 (PST)
Received: from [192.168.254.18] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p17sm3912862pfh.86.2022.01.24.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 13:54:32 -0800 (PST)
Message-ID: <cff392fd1d28547d00b24d8f39e43e7741bd7ce4.camel@gmail.com>
Subject: Re: [PATCH] iwd: Mark only reachable networks as available
From: James Prestwood <prestwoj@gmail.com>
To: Daniel Wagner <wagi@monom.org>, "VAUTRIN Emmanuel (Canal Plus
	Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>, iwd@lists.01.org
Date: Mon, 24 Jan 2022 13:54:32 -0800
In-Reply-To: <20220123131447.yxpmf5y3ku6cefu4@beryllium.lan>
References: <20220118125207.1204244-1-Emmanuel.VAUTRIN@cpexterne.org>
	 <MRZP264MB154437A17FE29544A015748A93589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
	 <20220121075447.nazzfzcc5h2lcnv3@beryllium.lan>
	 <MRZP264MB1544A373628E5F36B3800AA8935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
	 <20220123131447.yxpmf5y3ku6cefu4@beryllium.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sun, 2022-01-23 at 14:14 +0100, Daniel Wagner wrote:
> On Fri, Jan 21, 2022 at 09:43:04AM +0000, VAUTRIN Emmanuel (Canal
> Plus Prestataire) wrote:
> > > Patch applied. I was not aware that iwd shows networks with no
> > > signal
> > > strength. Thanks!
> > 
> > Great news, thank you Daniel!
> > Indeed, it is really rare, but I have noticed that during some full
> > test
> > campaigns, what I have never noticed (during years) with wpa-
> > supplicant.
> 
> Alright, let's add the iwd mailing list. Maybe it's a bug, no idea.

I only see one way this could happen, with a select few drivers.
Looks like the kernel has two possible attributes for the signal
stength based on what the driver sets 'signal_type' to. IWD only
handles SIGNAL_DBM, but SIGNAL_UNSPEC is also possible.
 
What hardware did you see this on? Based on what I'm seeing in the
kernel it is probably one of zd1211rw, at76c50x-usb, adm8211, or
rtl8180?

I'm gonna guess this never got handled because the nl80211 docs say
this attribute is "unspecified units"...

Thanks,
James


> _______________________________________________
> iwd mailing list -- iwd@lists.01.org
> To unsubscribe send an email to iwd-leave@lists.01.org


