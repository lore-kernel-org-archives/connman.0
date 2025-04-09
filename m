Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E5270EA6
	for <connman@lists.linux.dev>; Wed,  9 Apr 2025 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218394; cv=none; b=hFcVaekniqXyMEJQQf0kPoFg+Cz9HYcI9vGWA6jNZHPpJuBEspUTcy0ynvsLyzoypshHjaxYm4/oxEYT8QhPyz5CzUT/LaiBm8vK0zVLqGhhV0qTmrFBCv+3tNZ1jwTbzYvCNVVJKCcq5MQExKoj5uzPdL8k5mZDwTUE303Yegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218394; c=relaxed/simple;
	bh=IrujUS9mNWmL3WfqIxQ4fgMydxEwbkXIDiXIBv4g30M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=suerUbrCeQQxpKyZNCIVkxUbg7C4LM++IgFZ/d7kWc+J9lWYMn3OwBDrN6Xy9XnJOyVgLEqzjEp4735rEtYecJ1zeyQsIwY0ZZ5wK5IxtPbSd0JnO+/szCpowyTo4rBbyqj09ijWdEc57qPl0BCEZ+3C//z9mpGdoAbwgIqVCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKLbK4vA; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKLbK4vA"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so5900636241.3
        for <connman@lists.linux.dev>; Wed, 09 Apr 2025 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744218391; x=1744823191; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bRR1r9OW98j4LvR12tjb3MXdAVEdF6Nco5MFxilpASI=;
        b=MKLbK4vAeJogSQoJv7Dwt3XafUvaxWyc2TDw2nfZ9NNSCbiZIC1mpSN+TLxJ+j7sd/
         NEFhRl6KdmZu4eFk8tSfCxbbFlWuJQpW2V6NOkSAxij7NgLETLta/JQkC8GyTjnFPjvc
         UyNkysGY17t7dHqSB44HeBSoni/vMv2c/GvhGnF7feud74nRShqCaTnuNnD90wsFVQ2h
         PbEJMaUW5xdsPvIzGXE+J1sDKvb/tSyc0KxHW0IZzi3RbOSNkABGKkq6W7INB1mCWfKh
         bAURcdd/97+zSQsKdt930vTmdNYk4eko35jvbuJI2dIA+NnSSfIh0zEaoG1Idk0Bn4g9
         KdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744218391; x=1744823191;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRR1r9OW98j4LvR12tjb3MXdAVEdF6Nco5MFxilpASI=;
        b=d/QQsxQH9vGW0/ugEBVl/wnj7nrfMlJVVh3aIXcpB2GHwYs61fFQUzVkYea8WPqud5
         4trCw40Zq3Wo93MUT9GCX2ULM2B/uy98xu5smiIuPBLBRlMwVpu1fwTd6d7zWeK24095
         RbeOiAF2Fu2YPEJ89+29znp/DHEqoprfHZE28dHX8R8NDPgX1aVfFer3jqNvQFEW/6Xd
         SGLYEayCyRMSawUYxHorLiZgO7JNajl+/2Z3txxKygWINUaNQ/tOhLlLtFzgNesqFs5m
         IWFijrfFiAjsTlXswKDaoI1bVBH1Sx9ojHOekx8KGdep+3OUXXAmchuL0+nQZDDop1+Q
         2Evg==
X-Gm-Message-State: AOJu0Yzohzul8nbAoneZnd4Viob+Gujw6yKj2rMDIbOgLUz/xJVjHnV+
	f31ugCkC8PPL998yKcEEaM/mY3J2rrD+zzXGbzF/hCqGZ5BFEkvfqYz+ELIuuwgUDv0WGrYXn/i
	lNP+E7i+pgBvyjjC/lmqfy8k2AC4cuNNoJCE=
X-Gm-Gg: ASbGnct4BiGiX8q0Y13JZ1rqMG8pSU044zgmKbMi52RcRAJ+jkOwY3MQhgvuj0KRVyi
	WXuP5ozpsah+C6pzyi3fQMUt3rwRvHs7bnnsK0qyT7SPu1CoNQvEjRb1aj1vdJyStk6exHT8DN7
	9LNXb3J1uvJS8q/xTEcEbqk0e4ds7lc0R0GCQQBZgUmBy1nATxjnC09C/ZUurloPTt4Q==
X-Google-Smtp-Source: AGHT+IFputH1seM32hskLQ1hGVLB2hslZCLfsyIJn27wEV7QMuVOvg2g2Yu7hcuWo8eheoTwgvmHZxmic9lG3/2Q0W4=
X-Received: by 2002:a05:6122:252a:b0:518:91b3:5e37 with SMTP id
 71dfb90a1353d-527a91af7abmr3223999e0c.5.1744218391137; Wed, 09 Apr 2025
 10:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Wed, 9 Apr 2025 19:06:20 +0200
X-Gm-Features: ATxdqUHoVEiPbV-CWsuxswi5yPldr4oQ-7W5ynVl1xficEl4erK6Z93q5sbFTT8
Message-ID: <CA+iibzDj5AJa4_cyqCk_VJ+G3KXxubXY0u4bzkgYa637CX=kpA@mail.gmail.com>
Subject: connman daemon stays redy and doesn't pass online
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi
Since this morning connman daemon stays redy and doesn't pass online.
I have the same problem from my livebox or a shared connexion with my
mobile.

In the log

avril 09 18:21:37 grat-os1 connmand[569]: Interface wlan0 [ wifi ]
IPv4 online check to failed: Input/output error
avril 09 18:21:38 grat-os1 connmand[569]: Interface wlan0 [ wifi ]
IPv6 online check to  failed: Input/output error
avril 09 18:23:48 grat-os1 connmand[569]: Interface wlan0 [ wifi ]
IPv4 online check to failed: Input/output error
avril 09 18:23:48 grat-os1 connmand[569]: Interface wlan0 [ wifi ]
IPv6 online check to ailed: Input/output error

root@grat-os1:~# connmanctl
connmanctl> state
  State = ready
  OfflineMode = False
  SessionMode = False

If I try to view the link Ipv4 and Ipv6 on a browser there is no error
but just an idle. Maybe there is a problem with the server. The ready
state cause no internet access in VM

Best regards

Daniel
