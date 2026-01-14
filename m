Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2391352C2B
	for <connman@lists.linux.dev>; Wed, 14 Jan 2026 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369588; cv=none; b=r3zQcUZI650EKIsNuuKmyUXeSD9mn2ditxPQxfiZl6KRYSMc7Y6jED4TaJQ63JmDFBLiI1Y6zL58qJk4MjS9JgoMdh01c/dNnXjW7QOKy+dhsOxXapUOmLRCOMazBUDYKVo3IYJOmcCYLZtZhALt640gjbnFEZNt5Hv0lvgBm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369588; c=relaxed/simple;
	bh=SY4a2N5IV0v7kX2a4PIeL3v/Lw5ChPj49KFKehImCqc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ETWLRxfvzwNRt6PKBP88wxZdGaN6mbQo5o8F6QYxvpRkFCVQyyxw6fdwDlEpiDFpEzvg8APTP+4hBzo3VhCIsW8BOEIEWMb/sLb5BAcPssA5e/pOxqx6ppwRPiRluDry4hOFccyKCOzVnYEahGpzUStUPp4K3x9iGWEj2CUqCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=hSezpmUe; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="hSezpmUe"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id ED2F316007C;
	Wed, 14 Jan 2026 00:41:11 -0500 (EST)
Received: from smtpclient.apple (c-73-189-96-183.hsd1.ca.comcast.net [73.189.96.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7D1AC12636A;
	Wed, 14 Jan 2026 00:41:11 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] Fix the crash issue when restarting the wpa_supplicant or
 wifi driver while BackgroundScanning is enable
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <PRAPR10MB5421CA78CC13074E030BE07190A8A@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
Date: Tue, 13 Jan 2026 21:41:00 -0800
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>,
 "Dembianny Sven (BSH GDE-EDSD7)" <Sven.Dembianny@bshg.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA1DB512-D21F-4FAE-A91C-B46233D70728@nuovations.com>
References: <PRAPR10MB5421CC811D1DDDF69E01283690AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <PRAPR10MB5421DDB53D5BE922CBECB47B90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <PRAPR10MB5421B3F7A9A117FD038BA5BC90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <CAOf5uwnOFnQZa3zV06RWBum1z6PC1SUoyFicShC-rL2PMyc0uA@mail.gmail.com>
 <CAOf5uwmeODc99O0LMs=kLXBuxK7RR6MarHLrg5WZX+o5199CqA@mail.gmail.com>
 <PRAPR10MB5421E3DC52B8B0479761FC4E90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <CAOf5uwnotAp1o+oxsuK6Z9xhjxjn4NQvqPy+McWPebFLWG_bMQ@mail.gmail.com>
 <PRAPR10MB5421CA78CC13074E030BE07190A8A@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
To: "Chen Yaming (BSH GDE-EDSCD)" <Yaming.Chen@bshg.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=iuL34KZjyGgLu7hEVlDgBUhLPx/604UD0j+YUK49U8U=; b=hSezpmUeeXAvnD3QNClkkDTWYtZcLA+e2FkO/v3RjX/fhDUn4nUXILhdVbAzNjjncbniCAPKI+pe7DkOROjCPfWkr2ZtLBJLmvTe9XHKHM4nb9lbyuzy9nY3qwTpglCjsjIzHek0OWjAZPaXtp5SbtkFSMcBK9OVCDl47OvB7WoW//pOOnLm5iFm7tn/QF1kEwjM2zyV+er6voqy9HJQ4mubWmKwYY2z4/W72eyQs26vLX2IFk1cGbX6O030Rqg6UukPbjlH4LX8mW3W9giNBivTPFI1qRsqpFjDuAeK9KZwxGkdcMmHzfuZ/8DBklcx1AK/W+4+UkLyVV3ruwja/g==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Chen:

I have been working towards integrating support for connman into Matter =
<https://github.com/project-chip/connectedhomeip>.

In the process of doing so, I have found myself doing many cycles of =
=E2=80=98connmanctl disable wifi; sleep 1; connmanctl enable wifi=E2=80=99=
 while Ethernet is enabled and connected while logged in over a ssh =
session.

In about 50% of those cases, command crashes.

With the latest instance of your patch in place against =
wpa_supplicant-2.11:

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 12389fa6..191c4fa0 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -1999,13 +1999,25 @@ static int wifi_scan(struct connman_device =
*device,
 		}
 	}
=20
+	/*
+	 * If BackgroundScanning is enable, passive auto scanning =
timeout work need to
+	 * be removed when a new active scanning is triggered.Because =
wifi->autoscan
+	 * and auto scanning timeout work will be receated for new =
active scanning, but
+	 * old passive auto scanning timeout work is still running, if =
wifi firmware or
+	 * wpa_supplicant is restarted at some time in the future, old =
wifi and autoscan
+	 * objects pointers will be freed, so wifi and wifi->autoscan =
objects pointers will
+	 * be dangling pointers when the timeout handler function of old =
passive scanning
+	 * work will obtain wifi and wifi->autoscan objects, it will =
trigger a crash of connman.
+	 */
+	if (connman_setting_get_bool("BackgroundScanning") ||
+			wifi->scanning_type !=3D WIFI_SCANNING_PASSIVE) =
{
+		connman_device_ref(device);
+		reset_autoscan(device);
+	}
+
 	/* Distinguish between devices performing passive and active =
scanning */
 	wifi_update_scanner_type(wifi, WIFI_SCANNING_ACTIVE);
=20
-	connman_device_ref(device);
-
-	reset_autoscan(device);
-
 	ret =3D g_supplicant_interface_scan(wifi->interface, =
scan_params,
 						scan_callback, device);
 	if (ret =3D=3D 0) {

the following two tests pass:

    for i in `seq 1 100`; do
        echo "Running test ${i}=E2=80=A6"
        connmanctl disable wifi
        sleep 5
        connmanctl enable wifi
        sleep 2
        connmanctl scan wifi
        sleep 1; ps ax | grep connmand
    done

    for i in `seq 1 100`; do
        echo "Running test ${i}=E2=80=A6"
        connmanctl disable wifi
        sleep 1
        connmanctl enable wifi
        sleep 1
        ps ax | grep connmand
    done

So, I would say that this patch is quite effective and worth of =
upstreaming. Can you resubmit it against top-of-tree using =
git-send-email?

Best,

Grant Erickson

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

On Dec 18, 2025, at 1:48=E2=80=AFAM, Chen Yaming (BSH GDE-EDSCD) =
<Yaming.Chen@bshg.com> wrote:
> Hello Michael:
>            Thank you for your reminder. I did overlook the importance =
of device ->refcount before, now I have modified the code again and =
generated a new patch. Please check the attachment.
>           In this modification, I moved both connman_device_ref and =
reset_autoscan ahead of wifi_update_scanner_type to ensure that the old =
auto scan task was removed before the new auto scan task was =
initialized. However, when background scanning was not enabled and the =
new active scanning task was about to replace the old passive scanning =
task, I skipped connman_device_ref and reset_autoscan functions because =
I noticed that setup_autoscan would not create autoscan objects and =
tasks for passive scanning without background scanning enabled, if =
connman_device_ref and reset_autoscan are executed, it will cause the =
device ->refcount to increase inefficiently. What is your opinion?
>           I have done test in several scenarios for this modification, =
such as staying idle and restarting wpa_supplicant when wifi was =
disconnected, connected and factory reset states , to ensure that no =
crashes occurred and to monitor the device ->refcount value in real-time =
to prevent leakage or ineffective increase.
>             Best regards!!
>=20
>=20
> Yaming Chen
> Senior Engineer GDE-EDSCD
>=20
> Yaming.Chen@bshg.com; www.bsh-group.cn
