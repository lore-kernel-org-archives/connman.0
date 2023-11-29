Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BE32C87
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGlMyHiz"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2856254bd74so5091567a91.2
        for <connman@lists.linux.dev>; Wed, 29 Nov 2023 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701269146; x=1701873946; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KwYoGNiy38p3giAvM/b/jzEBpNxyPQhq580sBpemIuc=;
        b=HGlMyHizuBNYNjeE+Ezy1Px1mrq67G8O8MsJClOiNE+lhHNkefpZQD9QRm/pD9Tv8w
         yuWXEBFstF9yu4+EYI2CV28u0vfQsiWTtzsvR8Tby1mPrzpjHAzjALm2viDKnT7mwoLi
         uotxjkuDUDp9O056gbYU/Nu7lMeW+dIRLBE9Q23rn8TlKQCGcaLjrNI6/IrAwrMsUBxr
         /x6gFDwkeyaxnW+C9RrcLVpGcNzi8qNnv1tBkRK8J+z4Llojdi/OiFCvhpKEjKRrrvCo
         UWFJISQ18XyMX8aBDkHB2uqJKn+oFaquuhlx60ezeYyhDC4m6W5xe62DVkZ9byxoojH6
         W3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269146; x=1701873946;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwYoGNiy38p3giAvM/b/jzEBpNxyPQhq580sBpemIuc=;
        b=bQLlhC3SDGdylos4bPNyVhxCohvl+HvHxSjlUS6JmrlfmgbHkbr43WP/Gz/yB4PuNs
         I/af7hDL/Y2wkQ0ytqoRBXsu+79ABnJ7ekHH1ImnHj4rHj7CEOMJw9qRhEM62AjTPLSW
         5YB6ThLKek7GmcmQ5mDl9Kx1GwJYBdXcr/1XE31YgKK1ZfBT6PI4NkFWqC8RVao8o9rr
         S2OQA4Bhzdig42o7iQwGvFTFKc3k2ji1hn7RGLqRyF0FIodOBnB37oOYI5HjHq4UE3PI
         eVEVsoVnAYcAC9UKOQBdRiJiXipbEX329u26KjV47pEo+oL+yKEq3jSVbjbn9XZYGGp5
         QHLg==
X-Gm-Message-State: AOJu0YwOGG1LJs3Yxj7RlcgqvP6c4daBLv5vxTGqk4gV0nhVls2VMcNM
	r1nW98t7l+R82Qssgotuddj1/N+4aGUqHbDBOVbkj1VQ
X-Google-Smtp-Source: AGHT+IEQa/uxYbLpQnWsifqfSVtGgXcSpL+Y27Q2pGa+Yr4fknvdyFu9wOJiTFm4FUgzZ+olhtuAf3q0tu41QZQrK+s=
X-Received: by 2002:a17:90a:191a:b0:285:6565:fd20 with SMTP id
 26-20020a17090a191a00b002856565fd20mr15685950pjg.22.1701269146496; Wed, 29
 Nov 2023 06:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 29 Nov 2023 08:45:35 -0600
Message-ID: <CAG17S_PomgZSoy+Z=rS-u4_TM=S33G7FMAHRqnTaf+42U0LkMw@mail.gmail.com>
Subject: Thanks!
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

A big thanks to Grant and Marcel for tackling all these issues. I was
concerned that connman may go away, but this renewed effort gives me
hope that it'll keep going for a bit longer.

Keith
