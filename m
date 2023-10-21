Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3231119C
	for <connman@lists.linux.dev>; Sat, 21 Oct 2023 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APdKxjwf"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so1136194a12.0
        for <connman@lists.linux.dev>; Sat, 21 Oct 2023 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697907992; x=1698512792; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZNL2L6Q8JmLAT24RsDjOXRjGmoib1Z2Nb4K39TKIy4=;
        b=APdKxjwfmAy3yNV4vTKlIu/puni6Eu7sFMEiATB/tbHnlsJ8jwmaD051vtnSfxb2C7
         WWv9RQ4m2BEP7fZJDwN8tN9aIEgQw+XZiI//h5yP64hvinB9p2gVMdCuJTDqhDVNlXDk
         1qC98m2iosi5Ps5+TCv5wCHGZgwOe2uu6SbNDcOKXFSrOH7ivgWDH0zfGb17lMmtib7k
         VsYcncAZSKOvGkns19ffkNgJvQ2L+Nw9IVaubNlCjgaMib9hHT5xpEAMSHGXT8kFOj81
         U9aDHaGhbQ9m8YNHW1/AVphS+V4fvILZPHprHEhgBBrgkX3dOSZ0Lq/3NyUG6Q+23DhX
         b3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697907992; x=1698512792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZNL2L6Q8JmLAT24RsDjOXRjGmoib1Z2Nb4K39TKIy4=;
        b=lHq9ttIbE4QHLjwiSqW/Vgj/goZZo0ON5XIqGgspbmbMbrGCpFvEE6xrR0IixPmoxZ
         MfjETmn9rOxy/ljpnwTWupsgze9CMBAHOCmbi+1KhkGDLOkGV/RVgC1cWHxjJb9y9V7d
         w1SahhjADAHgM1TqQGrdunbUhojXHcNIhKqxLW5JW2wrKL2Y9H72iOzjYyGiPV8Rt0OQ
         gJ05Ryhx/GCR5bLX/5bGtSl5XA5JAmFVbiwukmG2AW0dqiK5ifHTTbGnhMdmTVsvODDF
         ZwjyEBbWCR86coXdfNf8Ca7fz3cCK/E9vAKGoC+rjw8SHlODQyOY+Q8cTlmV6OwvNrHg
         lriA==
X-Gm-Message-State: AOJu0YzPudIKoNbDb9FQuGtkx4B8KB6W63FfKWaLsYjuV0JNTjvPKgDt
	Pl7llGjTcflPyQQAK6mAZXbGEH5OmDQtYQleHsyRXDvBHCg=
X-Google-Smtp-Source: AGHT+IFqZRNDTaerxsLhlqzN4eAkXRJNTaQuf8xptMmWdVKC+RmYMJbhK3yKGfPL7BYPsw5Fi7X8Zwm/z1aXVYXTwps=
X-Received: by 2002:a05:6a21:78a5:b0:17b:9b0c:f215 with SMTP id
 bf37-20020a056a2178a500b0017b9b0cf215mr4202912pzc.37.1697907991785; Sat, 21
 Oct 2023 10:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <44B8A3FE-B61B-4295-8028-DF49DE56FDED@nuovations.com>
In-Reply-To: <44B8A3FE-B61B-4295-8028-DF49DE56FDED@nuovations.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 21 Oct 2023 12:06:20 -0500
Message-ID: <CAG17S_MHT=Uf=ZX3Ux9MFdS4dPv0nZcQk4Weh3LS16UVQc9cjw@mail.gmail.com>
Subject: Patches and the git repo
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Grant,

Do you know if these patches are being evaluated for addition to the
git repo? By whom?

https://git.kernel.org/pub/scm/network/connman/connman.git

Looking at the summary, the master was last updated back in 2023 Sep
16 and the last snapshot of 1.42 was from '3 Months ago'.

Would you be interested in / have time for finishing a feature request
for me? It is basically to enable wireless configuration via iwd
hotspot...

Keith
