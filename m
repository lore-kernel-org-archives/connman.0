Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010413699B
	for <connman@lists.linux.dev>; Sun,  4 Aug 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787187; cv=none; b=KwyCVG2rFwMSN96hfGnBm9l4zfxntm14FlGnoMTyTWGs8MdruLHhxaP5xw/CC06di3w2ZSJhDIStU/0PqrFhBQCAdjc0VLCpe6zp1E0LQgdGTSLadTcTXQvNanH4iM2Qhga2jhbmR5Abi9Eqd3dGTRe5dav/bTJXuIAs3LK+X4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787187; c=relaxed/simple;
	bh=vjtqdaZSh6pWa4cp61APSdmAYxQnx+cZCwMawQzvEX4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=phgUw3OH2SYIh9SuBO03AK9BeRSiXwpp8lx4yI8V6HeoKJjgINoH4D3Jv51OnubzLhZGCa/PtiP3Hyft69Sxt4bedWgifYV/XOiOnAoCb8O3/WqdRZNb3wdY1TYoSE9Vqf+Ff6r2aOM4BZ88MQQLpqVyWFt+GHdj+hnzJRvscNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tuo6TAG4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuo6TAG4"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so6014778a12.1
        for <connman@lists.linux.dev>; Sun, 04 Aug 2024 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722787185; x=1723391985; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjtqdaZSh6pWa4cp61APSdmAYxQnx+cZCwMawQzvEX4=;
        b=Tuo6TAG4rp3VayY639RdITgI7N9HeqUOn4yXnyJZbapY7Gf4cYj4R4RaoFjqUKGAwC
         HAm6BgKnqqmnAOY9mUWBRv98x6jqPBxoa8IJK8Vv9t6PAz58aPImRuEaBnbHq6sF/SZW
         uT4O8Oqc2pw8rQVI0dx2/akLBKTkr8BrmTqC8VkZgkvkz4RQCC2bDkU7Odqp7kb5xwVP
         trWDGS/BNei1ixhMo4eIg7NzjYZ0gsrCGNVWdYjFEghVkjB8LvzyECAPT6UvFrXtnUNo
         OF7rQG+Tm+7e0P8S90o8Z/jfmTC3sOL2G9Y9YNKXWHfmi01TOQ4VLwfIb/S8oFx5aJbp
         Ux5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722787185; x=1723391985;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjtqdaZSh6pWa4cp61APSdmAYxQnx+cZCwMawQzvEX4=;
        b=pnxkr9roPh+49Q5lFcjI/F6kq8l2ngNiovBcQo40SA8esB9BVLB+g0Nn3sXZVQScAc
         hpLNAYYC+qBU+NX/000/067ZPRndoquTYC7fWdNjNoAUzxRRhLS31NvnVJ6BJ1GUbNIL
         tPk1ArQmWSJhu94yQv8h598arUSgHeEUQ9UQlW40BsezNnO576+nUlAENymtt0nJqyyn
         4A/mgHcKqWrQKVJB7XvYd83U0zrtERAq9zCf5XTl/nHeBuyqDuDfwJxrIJkKuKHTLYhl
         kcJ9++MeILia70WPSoot5KkYT8OMl+HAgzkAvUCHJQxTuEQGuwTXXzOyc3nM+4prtj/s
         SEpg==
X-Gm-Message-State: AOJu0Yw+E1bdHHKdR4h2NxQ/ux9pUXBxSAW49aEpB2uuXGZ8rMtOPdVz
	g2+kQeC1ugBbovM08rxKmgWeo+80yAxlVxwIeXBiUD9Zs0/xf4VyzS7y4tgSTH7dxXA/eptcFoc
	F5yIOxbd8FYN76FT64CgI2eR2kzwPPIpI
X-Google-Smtp-Source: AGHT+IEQKHt5YnHnW8PTiM9jkGrFFyHP0GraCCvotMZwJ+owf2r9iimpw4HeN4WeYZfqY3IwHjCpHe/At/nhQ/2e824=
X-Received: by 2002:a05:6a20:12c7:b0:1c4:772d:fcec with SMTP id
 adf61e73a8af0-1c699528650mr10765065637.4.1722787184765; Sun, 04 Aug 2024
 08:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 4 Aug 2024 10:59:33 -0500
Message-ID: <CAG17S_ORF=akVn1hUTefQGciw9sdMw7Jt0uFzCkAoZP-HyOxmA@mail.gmail.com>
Subject: can we add runtime configurable DNS resolve selection?
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Connman is built by default with resolvconf for DNS support. It can be
built to support systemd-resolved but must be done as a compile option
with a flag:
--with-dns-backend=systemd-resolved
systemd-resolved is pretty robust and more broadly used today, in
2024, and having a run time setting in /etc/connman/main.conf to
select either resolvconf or systemd-resolved would be awesome.

Keith
