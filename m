Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6172EAE4
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnlhF6RF"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35f56f06142so13862105ab.1
        for <connman@lists.linux.dev>; Fri, 22 Dec 2023 14:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703282858; x=1703887658; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xJEzarW0ZR3vRcxKlQyS76cuSl6EKPRNixNKfcK+C+8=;
        b=nnlhF6RFUId8EIUgZZymWDWw60ol3tNC0iIpGQm5kex748g5NBzalH2K9PH5LJ9Ip8
         /vaE5GTQ7tdXi9YpXHL/35GMGqntRCLUf8P6dfY6MeMjrPWvx5IIqpc/8V5f2qbRcdMc
         729o639gujJA1bJIzL6ZWbctY9qPcUF3VxjTFV8W0ACS6yU70ooHW/jbvOICoijGgr1A
         MBSX0uJEDVjYKVtdxcqRGHW6Dm9XM8bTntJpfojzLBuk50FI8+cEaaMHOlvA037NkkhQ
         GF3zpBBFiigGaJSsXNCLLuPxV5z5QzPsEnZjXc+BRIxPKr+BbIEJlYqNc4amqSCtsvLL
         PGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703282858; x=1703887658;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJEzarW0ZR3vRcxKlQyS76cuSl6EKPRNixNKfcK+C+8=;
        b=mo/eo9XlyO98GxpyhE58S9/opcy3oQnySzhVbBCF2l3cHxpRlIsbquGJVmkzDknZAq
         3Wt7IScgNt5orxzxrCaAGQBa97UDAIyVxYnuG+ZenI8eTQFNlL//tyiT/6y9hZfsc0uI
         2xNWXnLNB/1Fwwg38jz2UaGEp2susm7U9qIKrQQnwLR2roqIkEPoUbNt4lEAiukGttPv
         QmWIWmfzLC33Whs41YKHTjT+1EHhMuAEceKnHYtoq/yD2nxJSPyOxUbzVHRR01ULgA0W
         8gGST6iv77qjIqClKx7NC/UFcQDOD9rQTEP5tKB5EsnWOoSqgv2tL5SLPApes2GND/UP
         zBtw==
X-Gm-Message-State: AOJu0YyThOn3idyTEWRDGkpV4rpE5TNyYB4F/aGSIPFn5vOrtkgPYN+J
	KElzOWWQLqoO92+RZoSxR7VFBvJ0oy/EZQIDJvdWbACR/EM=
X-Google-Smtp-Source: AGHT+IFa6GGhTMoxW/lzE4+vv6qRSpa8+2+ewKu8jjGF2DJQTDSkkMiBZ5wl3Oj+CKm04wKexklNZ8DuhSJhuFRgqmE=
X-Received: by 2002:a05:6e02:3184:b0:35f:d59c:984b with SMTP id
 cb4-20020a056e02318400b0035fd59c984bmr2525128ilb.65.1703282858376; Fri, 22
 Dec 2023 14:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 22 Dec 2023 16:07:27 -0600
Message-ID: <CAG17S_MPuJ9ehB-3Ki0MKhbyz4VRM=u_VQRzem4N4mq4mEsJVg@mail.gmail.com>
Subject: Request for help integrating iwd ap mode scan
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am back on the project. I feel it would be a great add to connman.
What it is: Feature to allow connman to scan for ssids while iwd is in ap mode
Background: I know connman can tether and we have done that, but this
has 2 issues. 1) it creates another interface called tether which is
confusing to some users as we are using conman in a headless audio
player 2) tether will not allow us to set a preferred IP address.

The iwd team added this functionality a while back where if iwd is in
ap mode, it can still scan for networks. iwd allows us to set the wlan
adapter into ap mode with a preferred IP and keeps the same adapter
listed (wlan0 in our case). I would love to see connman be able to do
this as well. With this functionality, we could use iwd/connman for
'wireless setup' of our audio player. We are currently using hostapd
and it is balky, disconnects and is slow.

Daniel Wagner created this patch to iwd.c back in January 2023 which I
incorporated and built into a current (git from head, source built)
connman package. The resulting binary works fine in station mode with
iwd, but it still will not allow 'connmanctl scan wifi' when iwd is in
ap mode though iwd can do it.

When iwd is in ap mode, if you issue a command 'iwctl ap wlan0 scan'
then 'iwctl ap wlan0 get-networks' it returns the available networks
similarly as it does in station mode.

if iwd is in ap mode and 'connmanctl scan wifi' is sent, connman takes
a long time and finally returns. The log of the iwd plugin when I did
this is:

https://pastebin.com/AHq2XkUs

The patch from Daniel Wagner is here:
---

Only compile tested :)

 plugins/iwd.c | 54 ++++++++++++++++++++++++++++++
++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 2fe49a23316b..491a0e41da89 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -633,15 +633,28 @@ static void cm_device_scan_cb(DBusMessage
*message, void *user_data)
        }
 }

-static int cm_device_scan(struct connman_device *device,
-                               struct connman_device_scan_params *params)
+static void cm_ap_scan_cb(DBusMessage *message, void *user_data)
+{
+       const char *path = user_data;
+       struct iwd_ap *iwdap;
+
+       iwdap = g_hash_table_lookup(access_points, path);
+       if (!iwdap)
+               return;
+
+       if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_ERROR) {
+               const char *dbus_error = dbus_message_get_error_name(message);
+
+               DBG("%s scan failed: %s", path, dbus_error);
+       }
+}
+
+static int cm_station_scan(struct connman_device *device,
+                               struct connman_device_scan_params *param)
 {
        struct iwd_device *iwdd = connman_device_get_data(device);
        struct iwd_station *iwds;

-       if (strcmp(iwdd->mode, "station"))
-               return -EINVAL;
-
        iwds = g_hash_table_lookup(stations, iwdd->path);
        if (!iwds)
                return -EIO;
@@ -653,6 +666,37 @@ static int cm_device_scan(struct connman_device *device,
        return -EINPROGRESS;
 }

+static int cm_ap_scan(struct connman_device *device,
+                               struct connman_device_scan_params *param)
+{
+       struct iwd_device *iwdd = connman_device_get_data(device);
+       struct iwd_ap *iwdap;
+
+       iwdap = g_hash_table_lookup(access_points, iwdd->path);
+       if (!iwdap)
+               return -EIO;
+
+       if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
+                       NULL, cm_ap_scan_cb, g_strdup(iwdap->path), g_free))
+               return -EIO;
+
+       return -EINPROGRESS;
+}
+
+static int cm_device_scan(struct connman_device *device,
+                               struct connman_device_scan_params *params)
+{
+       struct iwd_device *iwdd = connman_device_get_data(device);
+
+       if (!strcmp(iwdd->mode, "station"))
+               return cm_station_scan(device, params);
+
+       if (!strcmp(iwdd->mode, "ap"))
+               return cm_ap_scan(device, params);
+
+       return -EINVAL;
+}
+
 static struct connman_device_driver device_driver = {
        .name           = "iwd",
        .type           = CONNMAN_DEVICE_TYPE_WIFI,
--
2.39.0
