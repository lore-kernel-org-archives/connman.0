Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53872266591
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547562; cv=none; b=EMArxPl1HVrixgcxvHH1Jtc6mQNc3G6iU2sJS8/Cnk62TmngSQaHU+vMiTNdBZNhcKTfRZq0ZuN475+XD2z65n/HgXb7zCfk+CAX3R+4NRxgsg+DaMT3dE0AZxe7Dy/Z/QRK+1nbBOTxj5SFtW/y4iX/p2+0pXtoesEOROtAe5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547562; c=relaxed/simple;
	bh=L3TSYtT17+uBPJNBf2SPJnYSWDVAN67qTySsl+0AsKM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IDCxwLuhUi/NwmzZK3+9UfNf3jDzk/ku1Xqj9auu9POLq2muNseS2w3V0CdT5tKPdrWDkqqnkC0oWVZrIX6c9nQ+msoONJ8tvhCW8O+4l0rhrI/4iOg1v6GK59thB4Thdd/J9W/x2gMOF90ndScR2ZmeyDSHUd8ZBlzAaZ4yw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G80islj1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G80islj1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e83d65e5so28426965ad.1
        for <connman@lists.linux.dev>; Fri, 14 Feb 2025 07:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739547560; x=1740152360; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L3TSYtT17+uBPJNBf2SPJnYSWDVAN67qTySsl+0AsKM=;
        b=G80islj1eWO37joAgpjKgHkD0yvYFC3G7ir7UVN5sty54mdDQJGM1JPokRnfj/xxOD
         FxBgmZzOpweDxOcDkzXhRbGb2Tep+yo4JbX0xalzGoxjRJEE0+E/j7gDL6UVzR0XnicF
         0ER9dWp6WBNdShY+rZrUVffvMRXZcjzjMjqJ2N1XIw7rL5wdH3zQn1cs5ul2eVPzGQYX
         EZG+M4cmQ/yMBM87l+yleILQ8y4rWbATPGV+YQ8GTXumkS01dtYWMHxEE3lViy0mhwi4
         qsp0TqAsEPd4KKIH09dHwxE8FVwrYTXeDNUw0bFuVt6rBwOihrtbNt+lxm7FbkG9eLsI
         PX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547560; x=1740152360;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L3TSYtT17+uBPJNBf2SPJnYSWDVAN67qTySsl+0AsKM=;
        b=AlYDR5ZXWXbUpm+UOa2LiZX01DqTqGx3VN6fk42RplWZjmj7eNoP3eVUlkVBBrSnpU
         oBzVRUpzyekRp9yF0wvqJYJbYH4capeFfsA5mMZRCUusUrXvX1fWG3KhvnkXh6pjo5Dd
         4v86pA49JaeLwS4BqRPhacvmle2iXxEMFZ07lXfSjAPK+UFav0jwno+ecqt7RtFvajYg
         Tm2w2TxgG2G1Dw6gKFOcXd0lijlCHRMVXyZDhFbEUpWumRxgmiMTOlhb2q1LswNc0p9Z
         g1Z1Hc74GsXSVB9CVDNf5n85qEZDC49h1uVH102nMPQjatOxHBoIV0syTtZRi8p6ZR/R
         hgwg==
X-Gm-Message-State: AOJu0Yzd8vYiBINbOukwosXSHvLBCjYMhbE4T4nmI3BlK9f64zk+E/XR
	8po6Rg/o5iAtG7I2qFyeS2QPwDr/ifB0x76eFHsWYn0WKUab7t612APWdkstoFA+dQpyZxpRbq0
	u7avAHfJ/kTYhEZiGdmUaESjAuVo1mQ==
X-Gm-Gg: ASbGncuhzom42acwoXmzNMimcLH6Knb18+OhL9C2AVAYWyd0JHEt2oOwwpyoSxNtcAe
	BOmX0qoI2MvYXob7ohcfJ7Y9XubSvj+62/n8OOFU28K+PfMCTNUaWux03qMFwbyYBtfnvSkIBUw
	A=
X-Google-Smtp-Source: AGHT+IHjfNFaqYOXh9oigVZUEMitPMJWwdQGWTLdcRHKxVzQOmBspdrY4CnpQPFYjrlHdj4B3CpOjPIo5HQDYKAvur4=
X-Received: by 2002:a05:6a21:6d85:b0:1ee:66f6:87ea with SMTP id
 adf61e73a8af0-1ee66f68ab4mr19068211637.36.1739547560473; Fri, 14 Feb 2025
 07:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 14 Feb 2025 09:39:08 -0600
X-Gm-Features: AWEUYZmCcPq4s_yAlFkyMCYawjz2TDUJeCWNEKpD9PbFOHIacXhVZSTzv4M_LQg
Message-ID: <CAG17S_Mx9RKX=aZf9206tMkoc6GgGJs77nN70X9r_JS13eommw@mail.gmail.com>
Subject: Configs interfere with SSID deletion in connmanctl
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Is it intended behavior that when a *.config is present in
/var/lib/connman that connmanctl will refuse to delete the config?

I have a config for my local SSID. What we do is upon boot: a script
looks for wifi info in a txt file in /boot/wifi. If one is there, we
create a *.config and put it in /var/lib/connman and when connman
starts, it will connect to that SSID. All good. Works as expected. If
I go to connmanctl and try to remove the config
connmanctl> config wifi_blah_blah --remove
Error wifi_blah_blah: Not supported

Is there a requirement that the *.config must be named exactly as the
folder in /var/lib/connman for that SSID and then it will work? As it
is, we give it a name which is the "second blah".config (the hex
string conversion of the SSID name). Is the intention that we are
supposed to delete the *.config after our first connection to the SSID
and then let connman manage it? We do notice that when we delete the
*.config that connman automatically disconnects then deletes the
folder structure under /var/lib/conman.

Keith
