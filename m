Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C1137E
	for <connman@lists.linux.dev>; Wed, 28 Dec 2022 13:52:18 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id p4so16295135pjk.2
        for <connman@lists.linux.dev>; Wed, 28 Dec 2022 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YY2fMHmQ66ekLZdpDPdau+jSUaSFsEOGNrdCBPudtQg=;
        b=OAjM3WMjy2ZWRU4W/vgbIzY8sD2zr5KqbU/vPqr+QCl8iyvgpQBJ/wya0lp7sP1cKW
         ouK6b4/CSxeI+mr5T5bhKYa9jdYtx4zZNZGAuZ4jgSUAJAGidwoAZWkbxXxGXYH8h9uI
         om07SsqAEz7MRRzenSzjmesUKnWV2YQZ6jgFefh2TcFjctE6g75r6xKpUvn6DqvPvTiX
         o3vNh5qpGBMUuBSydAH2lbCv95V15x/coXc+mLW/EMvrQBL5xsKAZ8GvdCRcek6fqrV0
         +R36w09qrouJbGPTui41vXPqswdre3quX8K/xtqsNgs1biTafIoKVtcCWqmcBSmtvBIM
         0mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YY2fMHmQ66ekLZdpDPdau+jSUaSFsEOGNrdCBPudtQg=;
        b=5wGNdj9V+SXImKLE3/eSRhbgAjyhnC1da7DedGB/EFA52ZvjvpqAaCMJ3N7FJkPGuk
         bLap0Bs3NJ4M6IkUiHfG0asy2M6CiH7FES85y8V/zJphBss3CaHlrM/LqvHX/Mtp0OyU
         l3X6XPxmEHa4uJAqVR/q22SXsDuQr2kPbeeKytaLljX92Eqa44scPUCq0h06RnqwiIA2
         uGUUQbvxpKA8eheQ7lgKVYfqaxRfyVfPVHCKMFR9C84OXzmjetBJ8zgDx+ICmmkyF5Ix
         HGbnTx6NnK1sLc4o8Ab7x7f/Lb2lTxST6ShHccWKRHZUVTjWALP6Cip9v7zV6vZuXKET
         AFxQ==
X-Gm-Message-State: AFqh2kp511vrBqzAUUKre8uhvOAOnseRX6S2e0c8cQZmz9xf0Ho9nx1V
	nTLbaYRiuRBZW0AOFVQ0006asx7dQjfbfZppDGog6hwX
X-Google-Smtp-Source: AMrXdXv8TW4eDAu4Mo0MuJ/e8KFybzeQG6cXn11wknEXeTuQpgfIc8ZIh9JadXwWCyMMEp4w6kOJhF1IrkeVVPMVdQw=
X-Received: by 2002:a17:90b:2787:b0:219:5b3b:760 with SMTP id
 pw7-20020a17090b278700b002195b3b0760mr1615198pjb.50.1672235537865; Wed, 28
 Dec 2022 05:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 28 Dec 2022 07:52:06 -0600
Message-ID: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
Subject: Connman Request for feature
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

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
