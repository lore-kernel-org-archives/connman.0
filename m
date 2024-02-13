Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840811712
	for <connman@lists.linux.dev>; Tue, 13 Feb 2024 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850834; cv=none; b=SfKG3b9OC6BiLfHdWg09vsOv/97feSmAEXi51mpwjwMKKpbE8VdOyPpl981C/Bg2xa2eqy057+zbdGEDDiW9uquxsGZGO2M0Sv1/A8ylkOxzPVe6PLlq/U/TeySVjZOkaQCKy7+mj3qNc3N3rGV7mzlUNVf/HF9JErDvZ8C7ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850834; c=relaxed/simple;
	bh=rMia8YlQ7V0DkLWInuW2T9/0jlBSh9UNZJxlryGqCwg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Pz5/XPoEJN0UL5Mgr5MkW04kRrEzbHAelwtwNojTp5QKvlrU/oERzbQAUbP4WZ/nYQXAX6DBcG/To9pmdnRio1xkFlHxGBnOuWRqYUfhtxufUnCPsS6Tsu5emzfZ49Hr52axkStkvjVyqiMYmzsUZXkAeLs3HEvM7abOO9A93MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEp4GHZp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEp4GHZp"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so863141a12.0
        for <connman@lists.linux.dev>; Tue, 13 Feb 2024 11:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707850820; x=1708455620; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rMia8YlQ7V0DkLWInuW2T9/0jlBSh9UNZJxlryGqCwg=;
        b=bEp4GHZp/c5lhAbotK1PW62WTuO6vNQP0c+XFO8tfW3oZ5bxc06oDUsI2HkC7sUIfq
         62uXyJQ5qhun9b9HnPfnkjV1E2OGFM46pnF658rX7U2ytuwhns9REfwhAAHmOY+K4OHI
         HxN95Prj3+eoXsDVjbiCWGO5jky2yXfwZU3XbnAItKRXyj0q9iqZHGD+5SSJY4F0aAmz
         rcdMTMDu8eiCAGtgeL3C2tbWIx7kxWFwTed4pw5izr8S2bS6TgwfzTrTT3K0lCsvYBUs
         SAPUYRGxSnb6udNqehhuTzhaEpcEP1tu3PyKoDkCUI/DQsaujPgNmOcSxcK5kHgLNdmh
         Ed6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850820; x=1708455620;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMia8YlQ7V0DkLWInuW2T9/0jlBSh9UNZJxlryGqCwg=;
        b=tS/B1ivEtF8VY3sy+Ohjk5BMuxDuLWpFvyH4x1sN4zFUj/FT5pZQ4iGeiEXWXvtLn4
         Jdcev17zT54UjgWp2V36GIloiVKxnfCVYhVcSjyTa3wN/2PDJr9jHASsyH/zkEYdJbHy
         WD23WJZvaoSEvoYa5MA0d/TO1hXc7j2Z7KpJTfn1BBoDm5jD7N5F2DD0REAmaiGYvyL4
         XUyKtrAwT1qi7BQTzyD6SmErxvo9WLfjVbI1ckQkAI5dRRD5RnYonXRK+30Nkecxcwsu
         4LAoC5BKoNpUo4YcQJu52BFK1ZtkY6ySW7EfHav990UZNWw08Yg5gH+panMkWxGrSJhG
         iK2A==
X-Gm-Message-State: AOJu0Yz69fUMjXipka+/uZkI9qP3AdRPEKXYvlyFI12RWx4lQsm/r9q2
	aRGqpIkrnut1ISaYSnPWuKTpQOTdGp5G8D+NvzXOQoLqucE3strkvHcy0irV2zIP4lrIiiYanuh
	ZGjiY2PPWUr6n1tfobtGuiJZOeNhBdNZrDaI=
X-Google-Smtp-Source: AGHT+IFnxSQcKiPNTlPbALH8UNDLGmfMYey1+AatSM5VVJuoHua4aHaP2oan5mlcyyYGi048qRVJ3CHn+CIyXFfV8N0=
X-Received: by 2002:a17:90a:8a85:b0:298:b86d:cca8 with SMTP id
 x5-20020a17090a8a8500b00298b86dcca8mr371481pjn.36.1707850819983; Tue, 13 Feb
 2024 11:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 13 Feb 2024 13:00:08 -0600
Message-ID: <CAG17S_Pca6+L5HbBTK-Vq0jwA+=_GCFFwKyFfQ7GS2UreXd6Zg@mail.gmail.com>
Subject: Request for runtime configurable features: resolved, ipv6 disable
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

There are currently ways to implement both of these, but a runtime
configurable way in the connman startup for both would be nice.
A) The way to get connman to work with systemd-resolved is to
recompile with a flag:
--with-dns-backend=systemd-resolved
A setting in /etc/connman/main.conf to select either resolvconf or
systemd-resolved would be awesome.
B) Same with turning off ipv6. As it is, we can specify something in a
*.config or in the settings file in the 'service' folder:
IPv6.method=off
or by issuing:
connmanctl *service* ipv6=off
Once again, if the user is having ipv6 problems, being able to turn it
off for all interfaces in the main.conf would be nice.

Now that ipv6 is active by default in the kernel and in many other
packages, new problems appear: We have noticed that avahi will
advertise spurious un-routable ipv6 addresses and that Mozilla seems
to also have troubles when ipv4 and ipv6 are 'on' but only an ipv4
address is available.

Thanks!

Keith
