Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE731868
	for <connman@lists.linux.dev>; Wed, 28 Dec 2022 15:25:15 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id 124so10940972pfy.0
        for <connman@lists.linux.dev>; Wed, 28 Dec 2022 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5CGFsoMSr/E5vQ8iSTJbM6KzfntJcFuyBHuRY6o2x7k=;
        b=RufWen4xNZpcX96bS0KXfkgUezT3xDv+XGNEDZL8yTA4oPdbEo67tXXh8pCOFb4qei
         M5QalzahwEdfG8hiJxQk2sNRcD+/vdd35odlBZsKRfUs3Mr/aefRwn45KiDx+qb/wFrG
         cMgzHjXe67VZSAKLbnQUOH7/7DPzia9m8xFoGZh4nqsgFYpGiXQlDE7fSCaxX0LHIH1z
         Z8XwznppuSaUkFBq1fOhHB6XErVYKIm5u0xr4YyjbEsfPNcL+ACyaehxHr0mXoPTdhmu
         JCiUJfBREFeubsU9MuRCfs/hZYQnfPkta1ewVTp6nQEfRT+TDnthJTxDGYBd9zNZBRFn
         7eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CGFsoMSr/E5vQ8iSTJbM6KzfntJcFuyBHuRY6o2x7k=;
        b=SclsR0jhotsLrdxzi3KlqpSB7330JM/+3fyenXSAqy4aM4ektXiycht01Ns4afh3h+
         jIEwNgiLDKlTBRQmh2PUE+wXfQzsUVlhR8DUHAp6aJS2PPjX1JalsC61XOSjRwIkHXel
         sjauuCV0sHvOZYlv2EIIulgKKG0krNjCfyzdvI/GcQwUp5OnQnzRoNiWGKos0iWRHH5M
         Yx9hMhwXhfLlvpYIltunhZWhn0kWNN2TlyNrQdyW4JdRimSKjtscxm3vBi8mW7sgVbNO
         cWwG8ou6xw+Bd1Sm2JmfDqJIDU/x3mXbJKaJpS2FbXyD6o8J08OZ/6Zq3J+lsjkHR7+J
         CWAg==
X-Gm-Message-State: AFqh2krgjcUykYmOhcOZ7IKsi0EH3fr+KPG+8UYk6AFDjXEyodMnZmdy
	wBxX1Stp1kQW2J2xZPxv9xcyKYLttPnL++GvmOIZw8qH2Eg=
X-Google-Smtp-Source: AMrXdXu2eNjoBtu+VtRsnLyzvHwwumTDVUUtR+3AR2rgtlOmdrC/8CP74pXkA/yKKwLHPIhjo8Adq5lXcdBOq0cI+bw=
X-Received: by 2002:a63:5c2:0:b0:46e:be03:d9b2 with SMTP id
 185-20020a6305c2000000b0046ebe03d9b2mr1621387pgf.406.1672241114437; Wed, 28
 Dec 2022 07:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 28 Dec 2022 09:25:03 -0600
Message-ID: <CAG17S_OZiy2AtuWW3g81_HLUTT3m1en71UXszHz8yFCQfKah1w@mail.gmail.com>
Subject: Connman Request for feature
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sent from gmail. Tried to remove formatting. Sorry if this is a duplicate.

Would it be possible to allow connman to scan for wifi networks when
iwd has been put in ap mode?
We have a headless audio appliance and are currently using connman to
manage all the ethernet connections either cabled or wifi.
When our appliance first boots, it looks for a connected ethernet and
if so it connects and sets itself up. If not, we start hostapd and
start advertising for a user to connect to the ssid. when they
connect, we will display all the available wifi ssids (scanned by
connman) for them to connect it to. If one is selected and the user
puts the correct password in, when it reboots, it connects to the ssid
and is now on the LAN. This is a pretty clean interaction and it works
and is similar to how other IoT devices work.

iwd has the ability to scan for available wifis when it is in ap mode.
Up till recently this did not work for the RPi wireless, but it does
now. I have verified it does work on my Pis.

Set iwd to ap mode and advertise SSID with password.
connect from laptop
then from iwctl, I can scan for other ssids available

Connman will not scan for ssids if iwd is in ap mode.
The difference is that connman will scan for SSIDs if iwd is being
used with connman (wpa_supplicant not installed), and hostapd is
running.
Could the 'scan wifi' command run to query iwd to see if it can scan
for SSIDs even if it is in ap mode?

Keith
