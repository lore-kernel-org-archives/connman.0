Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D47E
	for <connman@lists.linux.dev>; Sat,  5 Mar 2022 03:48:31 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id n7so104632oif.5
        for <connman@lists.linux.dev>; Fri, 04 Mar 2022 19:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XG/OlsyTy97M8oqiptTYmza91DIszX/PSRDT7DiTow=;
        b=X5MdwLtgUzt9mZfACWFX6NjjuOt5Cqq95zwuIuac/FfABhAY8tY3tLFSMMyFPmsCO6
         V5Eo10nmw3Jbr3bH/ynwJG67vro/SIIDVwj03kJV/27IH+EKoVaQVvCO4GTFmAD7A5MZ
         BaNlDE8BxeTdXLMt50aMeCCQbIc59Q7mKFUpDJTvX8Z//J4jbjywL52NRszsvELZqOL0
         elqqZLM2QatMvmhlEMaJdzPsnfjkRjEmRmmwD3NtCuT3EoBqKLSOiTuGsi3Iq+V6lNlB
         QMotsh3+Yd+koxFrR4jRNvU6n1vXnXuBJcKwZXn8ywOmlgYQUn7HVmbuvtJSupmhBa+r
         uH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XG/OlsyTy97M8oqiptTYmza91DIszX/PSRDT7DiTow=;
        b=EQaiDPrxVZRXwK8ATq1TWbaE5SmzLv3ZgFFArSs/wWBAC9CbJF5NCx46GdgEnaYAwt
         UXBfusrqVIZKO9HLk3XdFe5RfNLRx/NL9nQObWU1DX87qxutv+LVZ01AgoJ+zzDaZKiz
         UP7iOQE80Cn68R+OCSbNDSEbfYsSHaFOktImbMHrGbx/Pr6/95gKNjLM1Sy+/eQ+xSne
         if7imd/041nfwKOGcUDyKj3iapXJ0GfoJ+8ocdj6Aueyp3iHllWV4zMg/8jN6NMeLxrV
         pPEe1JO3jyPscC3aZHBU/HhcAkSh4iZTpjOiLcPfodoFQDUK5/GTFoC++nn5Vsm1u00r
         bTKw==
X-Gm-Message-State: AOAM532eECwmiuT7gJM9HEzzVyAA4uHLC+06D44LJ7bpRbxoXQYs1Oxe
	br5vlHPswsGY8whGqe9CqDkFQwmf/3t8rtQ9KkdLwYSHxWk=
X-Google-Smtp-Source: ABdhPJybyVwucLhSivBXQOrMUY2XW7cIHxf16+63NRkHzDUaZRnM3PFRpyZPNBaSJMheBPI5BYRF6frz2XDIY3qXBnM=
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id
 j13-20020a056808118d00b002d4be7e6748mr967605oil.123.1646452111120; Fri, 04
 Mar 2022 19:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
 <20220304091104.g5lbeu55z4oubyej@beryllium.lan> <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
 <CAG17S_N34PXuAdcpMRKhNXo4Cmz89f8JaJa__GFEXrxO+FgsgQ@mail.gmail.com> <20220304154136.wmifwaqdergdqkjo@carbon.lan>
In-Reply-To: <20220304154136.wmifwaqdergdqkjo@carbon.lan>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 4 Mar 2022 21:48:20 -0600
Message-ID: <CAG17S_MqkGhwBxJsQDC0BhhOB2f3vQbjxo+mrdKGN-9FG6d41w@mail.gmail.com>
Subject: Re: request for feature
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Daniel,

Is there something else that needs to be set? iwctl will 'scan while
in ap' connmanctl does not, yet.
# iwctl ap wlan0 scan
# iwctl ap wlan0 get-networks
                                    Networks
--------------------------------------------------------------------------------
            Property            Value
--------------------------------------------------------------------------------
            Name                spg2
            SignalStrength      -4000
            Type                psk

            Name                Edventures
            SignalStrength      -5400
            Type                psk

            Name                spg3
            SignalStrength      -5500
            Type                psk
...
# connmanctl technologies
/net/connman/technology/ethernet
  Name = Wired
  Type = ethernet
  Powered = True
  Connected = False
  Tethering = False
  TetheringFreq = 2412
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = False
  Tethering = False
  TetheringFreq = 2412
/net/connman/technology/bluetooth
  Name = Bluetooth
  Type = bluetooth
  Powered = True
  Connected = False
  Tethering = False
  TetheringFreq = 0
# connmanctl scan wifi
Error /net/connman/technology/wifi: Not supported
# connmanctl services

Keith

On Fri, Mar 4, 2022 at 9:41 AM Daniel Wagner <wagi@monom.org> wrote:
>
> On Fri, Mar 04, 2022 at 09:22:29AM -0600, KeithG wrote:
> > Made those 2 edits, built a package and will test it tonight.
>
> I'll try to give it a go as well.
