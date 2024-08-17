Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085B14375A
	for <connman@lists.linux.dev>; Sat, 17 Aug 2024 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723937370; cv=none; b=fkki87rI3d4lcSMlfFSY5Es59sxjknwvbhnCWzaIZ9/KU8RL/vjlVJmzr2kPNGU2AKrVzU2/BkNUuYrW/M/J3mJhLcwlOYetJdOZMD5MKz+cHflKMK6TAUBuxMEd35w2vO2aqbCSlIkr1lU8SdZq0fjLG2aRuGYFVfEWW29ZA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723937370; c=relaxed/simple;
	bh=L2yHGeVXMlChYeSlzW4UG40dJUrerzSy+LxNfS7hWq8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tgJbLJF9knfEsE4qFXssHSBB0rdq0PTEUDuIhv6SgAbokh52YNCXOag1s60kLY3yk0Hea9otbHwYYjlL1JMWp/1S21Cs7vTmpmS+kUuoQEiBCOjxMOcKHiTIvzVp8Tb7Ffbn6tFHqIm0FZIMgw7sNROaqp1ZDItwE5SRkpsOMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd6N5+Pp; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd6N5+Pp"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093f3a1af9so1971830a34.1
        for <connman@lists.linux.dev>; Sat, 17 Aug 2024 16:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723937367; x=1724542167; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XZGXmdio1d0lwT/ZbDSpribC6YQIhq9Enm53P2rz2M=;
        b=jd6N5+PpUYJ4FQMiC8bgKUPHuY9UgHWQMDLr0wF1Q1EVvI3k8WQK2kuS8jVywfkXFE
         NngbR1t1Dl9SstPE588m26rEj0wz5slkSpshnovYYDPQ35Lo+EkrfIyAjSV3smyolWKG
         XWvkRK3Nh0JbjLN3aSJhbWnZHKDAqWCn+P/V0DqtTFdGwqB4CmLSq/0BuYILI9rcWe/m
         xTZY9YwaBCAaJDV70PzfeuymPxM0xVU38sNh2aZZECCotl5fbEbZWo8pd29WwyK7jF1K
         dr3OLlMiHMkN7NysTPWd+QTCh34W06qyYkL/JJ/omwGmuNwMYCsAr4qRqkA3DUEyu8NB
         Cj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723937367; x=1724542167;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XZGXmdio1d0lwT/ZbDSpribC6YQIhq9Enm53P2rz2M=;
        b=m3NdN+dVMv9bFaEnYJvsA8e8QwKzwC5yB6TloA2dYVmXVGvxO0X5N6z47qOvR2fcE8
         XVe4eigKdfkEN/l5cVb7Ns2wccd18vspUfWfacGQ7yICNlK6ye5M0zIl+bNeorSLysky
         wOwh20s8F0eGkNGTpM3lkoiu94iEPeyBdOe3xo0+gBk7KCzBR+VwTSnNZ+qHn+08nxq7
         Lp/NaaugbKX0v0EBygkACtsOjHAOkBfemhakTnuXjwKik3kzmedTz/95CqJnZD4068ru
         wGY+nS8EMo91CsDN0Es3ZDaD0oyJ4oSN1cH1tZiNGFjpZ6SoQMPMnER/ug6EogCv2716
         lmtA==
X-Gm-Message-State: AOJu0YzYMkytbTtB19nUC9VevCwzs1Bp6InpYrvBu7pwBM/wPCazoSkA
	ykOwX+Jr4O6CfiARvOKxSPL8ljhlODcWnm63tuzguTcsSO5STAeFOTHKkyzFWESSwd8v3FizaPn
	nxyfHZM0AnzIUYnnWI3iV4QAny2geuKcW
X-Google-Smtp-Source: AGHT+IGtNwAfl03yhuCGGkEakuPtfldoPxIiAG0j6OtqhvaFV+vqO3qo1K9M2VExQYr7+Bd3y3i1eFY8W5Dj6Z/l7nM=
X-Received: by 2002:a05:6830:43a6:b0:70c:934c:b1e3 with SMTP id
 46e09a7af769-70cac83bfffmr8799551a34.1.1723937367133; Sat, 17 Aug 2024
 16:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 17 Aug 2024 18:29:16 -0500
Message-ID: <CAG17S_O7LdFxW4OUAoN+zOJ43MpmSg5V5O-jxkUg4aMmN1eXBw@mail.gmail.com>
Subject: wpa3/sae authentication does not work with brcmfmac+connman
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I run connman on RPis. We use connman to manage the ethernet and wifi
connections.

Recently, the brcmfmac firmware was updated to the most current from cypress.
[    2.185046] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    2.383977] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
01-b677b91b

With this update, running wpa_supplicant and nmcli, I am able to
connect to a wpa3/sae ssid successfully. With connmanctl I am not able
to connect at all.

Please advise what I need to send as far as a log to show what is going on.
Form connmanctl, this is what I saw:

connmanctl> connect wifi_d83addd2ae3c_6465736b534145_managed_psk
Agent RequestInput wifi_d83addd2ae3c_6465736b534145_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? xxxxxxxx
Agent ReportError wifi_d83addd2ae3c_6465736b534145_managed_psk
  connect-failed
Agent request cancelled by ConnMan
Error /net/connman/service/wifi_d83addd2ae3c_6465736b534145_managed_psk:
Input/output error

From the machine running hopstapd, nothing shows that it will even
start the authentication. I tried with wpa_cli and was unable to
negotiate the authentication, either. It was only with nmcli that I
was able to successfully connect.

The version of connman:
root@pi5(rw):~# connmand -v
1.41
I also tried with the most up to date git and get the same thing in
connmanctl, but this is what I get in the journal:

Aug 17 18:22:50 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
0xd02e fail, reason -52
Aug 17 18:22:53 pi5 wpa_supplicant[4413]: wlan0: Trying to associate
with SSID 'deskSAE'
Aug 17 18:22:53 pi5 wpa_supplicant[4413]: wlan0: PMKSA-CACHE-ADDED
d8:3a:dd:60:a3:0c 0
Aug 17 18:22:53 pi5 kernel: ieee80211 phy0:
brcmf_cfg80211_external_auth: auth_status iovar failed: ret=-52
Aug 17 18:23:03 pi5 wpa_supplicant[4413]: wlan0: Authentication with
d8:3a:dd:60:a3:0c timed out.
Aug 17 18:23:03 pi5 wpa_supplicant[4413]: wlan0:
CTRL-EVENT-DISCONNECTED bssid=d8:3a:dd:60:a3:0c reason=3
locally_generated=1
Aug 17 18:23:03 pi5 wpa_supplicant[4413]: BSSID d8:3a:dd:60:a3:0c
ignore list count incremented to 2, ignoring for 10 seconds
Aug 17 18:23:03 pi5 wpa_supplicant[4413]: wlan0:
CTRL-EVENT-DSCP-POLICY clear_all
Aug 17 18:23:03 pi5 connmand[651]: Interface wlan0 [ wifi ] error
"connect-failed"
Aug 17 18:23:03 pi5 connmand[651]: Interface wlan0 [ wifi ] state is failure
Aug 17 18:23:03 pi5 wpa_supplicant[4413]: wlan0:
CTRL-EVENT-REGDOM-CHANGE init=CORE type=WORLD
Aug 17 18:23:03 pi5 wpa_supplicant[4413]: wlan0:
CTRL-EVENT-REGDOM-CHANGE init=USER type=COUNTRY alpha2=US
Aug 17 18:23:03 pi5 wpa_supplicant[4413]: wlan0: PMKSA-CACHE-REMOVED
d8:3a:dd:60:a3:0c 0

Keith
