Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D0256C
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 14:13:27 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso1519841wme.5
        for <connman@lists.linux.dev>; Wed, 23 Nov 2022 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZO/vySUTIoH87/HWrJJAeS5EeFM8VeaPqK2toWjp6o=;
        b=OC+dvM2TLdWEEpdWhV1gZz5tEpJVJuqi9NyhAfhy4xJqf2lvMDJ1fZX0kf0GH/MG6c
         5M8MAe57gihTmkt7x8okhaXrXzfFuPOnrAuDBT6Dhy0ypkCDx2rO3C/S2sIBeDrBCJMT
         D1ZyL4yByc2RmE3zANZESNArTMZz1jvjvHf411rVKsJ58W7p1c4cF0WtQPsCtUHkL9aB
         eOrgsduktEcw+vailspnFTD1GG2rCpIN+5ikVOksWYrKwPvkBtRiU4RlbwscOfL/tIiZ
         75E/lppu2V9SRVAHvBwXUgiAeGrOLAyqxUuMNMmNQhefFdVzEjsORv0MuVjPigtJwoEC
         jnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZO/vySUTIoH87/HWrJJAeS5EeFM8VeaPqK2toWjp6o=;
        b=ZnX0XlbzI0l3AAqzPC6XVpf5Dv4NYZNseCmV2xoYJ0ZoZreVWjbC7CNy6dNYaN3aQr
         D6k/ika22NJ0wPMi2/U7MdaKf/OcVrAo1BAR0Wo2ljYz9IaXzeUzJorW4UPpd3ZzYC18
         JNL7o+pZYmAgKNvcL1VDMdoXt43hhH4KhykI74J2X+xaX6/MBVd4lZG34jruUSwc0JB7
         /KDGbNfge8+0lwadEvjUpi8xPIbbZFx1xHE1xjkAjZXnOGyAJ/4+bY4S0z3c+keP5/LQ
         951Kb0dPB67cb2qRUKmP6H5VYsWF67VSDsG1IDKQ306rgJJDS1NbCaQ4yrJCSGxtV6fS
         ExZQ==
X-Gm-Message-State: ANoB5pmWKuImlzt1yNLyNmyKRoB7jvP+zfq2HVgLmcGATdT82NH1ok55
	Imfi4bfG/w4Fg4P2plzodwo=
X-Google-Smtp-Source: AA0mqf5IP/5rjN7MqXZpFL7EIw42nXmV4TviyDEGy1egqE638g6ZPecwggyx4HKF8JrQqoEuZJzT8A==
X-Received: by 2002:a05:600c:3109:b0:3cf:5731:53db with SMTP id g9-20020a05600c310900b003cf573153dbmr24315565wmo.85.1669212805311;
        Wed, 23 Nov 2022 06:13:25 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:d266:9a1f:8f14:dfe7? (ptr-gh3gmpbkotaupr9i21z.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:d266:9a1f:8f14:dfe7])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003cfa3a12660sm8153959wms.1.2022.11.23.06.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:13:24 -0800 (PST)
Message-ID: <facde9f7-3fc3-7c2f-b908-5e814a57bb29@gmail.com>
Date: Wed, 23 Nov 2022 15:13:23 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: geoffrey.vl@gmail.com
Cc: connman@lists.linux.dev
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Subject: service: 'ready' Status ProprtyChanged not sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Subject: service: 'ready' Status ProprtyChanged not sent


After further inspection I could trace back that following lines:

static void service_schedule_changed(void)
{
    if (services_notify->id != 0)
        return;

    services_notify->id = g_timeout_add(100, service_send_changed, NULL);
}

... have been in connman for over a decade. When services get added and removed it makes sense to just wait a bit until all of that is done in order to avoid race condition and such. Unless some one has a better idea I think it's best to leave that intact, still I think in that case it should be documented as a known issue. What do you think?

