Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CE48CC7
	for <connman@lists.linux.dev>; Wed, 10 Jan 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezbAJ/1V"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28c467446f0so3569671a91.0
        for <connman@lists.linux.dev>; Wed, 10 Jan 2024 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704893969; x=1705498769; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Hp9E/AyifwUDp+wFa5atF/r+qqLzBuSfBxsJKR7Ybc=;
        b=ezbAJ/1VLlo9qIU5rlDb9Zyrninm51R/QsfBQhQIq82TNzCi7hNYeuVsGnVDgRM1uH
         HqMEORJXiM1kVMGjgFjMBOhpLYSS6OPDCGebi3M4q8yjONrzCielw4S+arTrMSz6iCKm
         ilI56TH0898U/5LrT40AWtvDHGH+ja4dr+ue0sJawyeviLKtV7HxEtz29O27BilgBs6w
         qCnajxQaxCf5O1CurHhneuHcG7rVXdMUDAtRqdqw3wcwgEhBI2DYAFoHb3wfOrjO03OE
         +logAbxJXwEUzl+TFDkRz7RWfoQrIxj9MXtwtOaaK6NpwNOosyy10jGk4jSdW880pEdf
         6V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704893969; x=1705498769;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Hp9E/AyifwUDp+wFa5atF/r+qqLzBuSfBxsJKR7Ybc=;
        b=tVDRgG/qLwODLthJuvplC3wAWi1t+bq4DM40pzEjvCtMkY6tOtRc3S9VlitcBF9S2X
         aJ9I+Ju8GN0i+sPxv9al7HzaQniPgqqp4vXFqFyDNggsghmKagNmbdY3oEnIPu57+8OD
         fzzyJn2qtE9r2KX8gYthPsrhKI1pgbHX7AKWLRA7TcAZEzmqe6g/npWG8p9DH2+Hck/K
         PYhH43MkuWnD1N/Wg/IxINyWzZyQ2sfswj47BtTDfSxHOhtRdh57ibgEvfMvqkpg2Oli
         ab461IGdKoPESRfP3n8cRByl8VVXJHjeysfgUBxwJDpotLp0iBo6oAp0KMwbNNCEzMTr
         Wzvw==
X-Gm-Message-State: AOJu0YwFSqKq0s00oFR4T5wMBtrZUqTzTX9dLw0JFgOW/IAqcENXQpfM
	/aekaJs/FtZCnryhg7gWDZ4Q8t+7AR5IN5XwV9bKHbg2Xgo=
X-Google-Smtp-Source: AGHT+IGg7ICuxYLmMhvyFOWNMbdDDBRMtITJFHpmadV9iPD2VrelenUUxT3zyR//A1ucqHmXox1fzCtFfs8ama80Z8o=
X-Received: by 2002:a17:90a:6b0d:b0:28c:ee69:c1c6 with SMTP id
 v13-20020a17090a6b0d00b0028cee69c1c6mr101606pjj.41.1704893969514; Wed, 10 Jan
 2024 05:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 10 Jan 2024 07:39:18 -0600
Message-ID: <CAG17S_M2JoeMXnTVRU=Pa=QYjkS69jJ1zK_sYr_8CP2tfS1vtg@mail.gmail.com>
Subject: resolvectl versus openresolv with connman
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am trying to set up connman to work with resolvectl/systemd-resolved
Is there a way to do this without re-building with a flag?

According to the Arch Wiki, connman would need to be rebuilt with this flag:
--with-dns-backend=systemd-resolved
to work with resolved.

Could this be added as a runtime config in /etc/connman/main.conf?

Keith
