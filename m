Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5F37160
	for <connman@lists.linux.dev>; Fri,  1 Aug 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046296; cv=none; b=pfVUhvL8aEwCIzOzHwkceUK5iHQ0rr2+wS8ki5DSZZFewRerz5c5smCXYZkiI2NtO1wkWIzGx6nkkoeGawuAgYVXEE5Sl9RO57cSzhpbuBFmYlhuUMfdNaR7+7rBhnAWy7LvU37eId5xewHcwpwZ0PalfqjS4s+DGtBq0dbEkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046296; c=relaxed/simple;
	bh=2WNSwdKHOqPbp8dT5M566RqeVNfOQXbr3OhbqAg6NNo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=spRwKGI5Jse9H0u89pP1RMBDuUXgfEJfM9iwMtooxjFlWJSbkQUD7Y+4ERzl1svW5bXMU7gvx1XE8rcUQyMvLK+auv5fMBdn18P3amQKNWwzQGeltzbFbHRBbeCD6ZcAaKuOhvtD7SP2jFHuxOgVWQJmpjUVEjZkx+XluelUt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b=Cjfr2Dpq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b="Cjfr2Dpq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso11127635e9.2
        for <connman@lists.linux.dev>; Fri, 01 Aug 2025 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20230601.gappssmtp.com; s=20230601; t=1754046292; x=1754651092; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WNSwdKHOqPbp8dT5M566RqeVNfOQXbr3OhbqAg6NNo=;
        b=Cjfr2Dpqv41xxNT67oqUvrfg7Iq1HiiIEo1ASn4Jzoa4OA/Sf/7Gnh3jpI39E+0gmR
         U44gx1ia3E6Ig9PoGgxGgtcpbmd4Yv/uTtJVy3do3gI45OQLDHVB83NQNCrqa2tKe+mM
         QrVOoeUTYKBhVRzY/kcx8y1UdrxjGZmnbEyjBOEUGJHJTzeeMGr5RxAhowDUnxa2S+1k
         YFCzJIq1q6+ogMJ/toyAyWN2C8CX0MUha/poD6K1/ttfsSbbR5fCyXNv6l9c5y6lO6gU
         m8aLxepy7tVO7dT9Rna+mVT2ERKj3SVxHL2SXj928eB+JcqZ5IFR7yKvMxXU+Z2wbQlE
         QO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046292; x=1754651092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WNSwdKHOqPbp8dT5M566RqeVNfOQXbr3OhbqAg6NNo=;
        b=MYdCd2az9DLKeJFMj5Nwjc5ceWyOI9xhvm/7NBfGFVRH6lOY45P4R1bbW9QJARoj1H
         zJObJT98oj4RflCiv67nMomAJQ+NKM/MXpw/BZKSKDb21YX9eB0pKb1w7+BTXehQmjv/
         6o9G42JV8saIOUzKIfXk+RhSzFkcFtsgLxbjYiSB2hJeQgeCHWiRBEfcKf7jjZQ5w6kn
         WVwrKmGH3BRjFs/xqGMntYfVgY2z/vjfcu8WZB7D9dCGKTdPz8y85ETV5TRRTfe2Ep5O
         5Rj+UQIxvhQVgwOgoWcdgzqmrpqtCpPs9hOT9NTrsXEPk44C/bdMYexGBwCi373tpc2z
         arJA==
X-Gm-Message-State: AOJu0YwswEwv8FYJICcCn6k2kTAcVELO2k4sk++pIz+HoF3OZWxv8+0c
	1z//yvXvs31f2kV49AXLRugOEmg2pYyOxN33Jg1W9miRZzQPxns0ERr9FiDQS0lOk0hv0Z9gDCK
	LFHkX
X-Gm-Gg: ASbGncua9LsR0srFlY0nFsIkMENRmbnCYi4o/qs4fHM2motDoesvEta2PW86sjdELhX
	oooW3yUfgAl+kkURNHC2K3ayg3YF10/pQusYBdRitle/vWO68R7bIwGYk/5cUbY17g/I+P+BWZR
	hwJgHJkCmiN+X2xBto0DbU8swz7osTze3RcvqZ3cr7sIO15wIDulJGpPogoDysyIljatt/mJF4t
	oLI3vHdD2LHsPtmZeXqAPx5/XKRhxnMeFehbfIkq7Rja6mab0H+XXRj3Jk2kJK7cOR3Lqc/0UA0
	7tAyj03K+6WQKXV7wHw1Xvq2EJq3fAlSarqrcjk+duGhXxd4Y3Tfr1FfvJz0wO8XLv6HyxGBGLH
	L1T/ZJ7oNUnX6cO4LzxkW6FA01b0=
X-Google-Smtp-Source: AGHT+IH8eWT9dQRp769hTriUShteOiPrbB9otOwKftVPt3J2ZlrROcefRDwbPOycsftLM+i1o6iZlw==
X-Received: by 2002:a05:6000:2f84:b0:3b6:d95:a3a4 with SMTP id ffacd0b85a97d-3b794fbec3emr8100475f8f.4.1754046292004;
        Fri, 01 Aug 2025 04:04:52 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536acc9sm103116905e9.6.2025.08.01.04.04.51
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:04:51 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Subject: [PATCH] service: Fix comparison of services of same preferred type
Date: Fri,  1 Aug 2025 13:02:38 +0200
Message-ID: <20250801110412.203290-1-johannes@dividat.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I don't have enough familiarity with the project to judge whether parts
of ConnMan may have become reliant on this path-dependent sorting
behaviour. My patch is based purely on local understanding of the
comparison functions.

