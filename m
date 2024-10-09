Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E691E230D
	for <connman@lists.linux.dev>; Wed,  9 Oct 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491021; cv=none; b=gRTLMPPMZHLg+WckWZAuoM/nUCPft32UHi8mHxMthXlUH8EFn3EbZLMj4ECMyJtCe7DC7X4CCAxjuquDcrB3G50DAIDJRG4MkIyxkBlKLchLVYvTYg6VvL7nGBaozLqNTDuYpkARTE5eaB41CayLV6RJiTp1NMZP62pm4kY500o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491021; c=relaxed/simple;
	bh=G5UlorDz02n0Imn+KS/q6UO0aAIp6HzstBsGMqjJHwQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=g1uWJk9wAc83mXPE9pDSlHEtg5xQErJxj5Cx0O9hZgoqNkYUEMPTL7BBXr3LwJ0+sSlPoDygOJB3uw8htEfFkwq5CiCfHmmOLC/hGyoYxa3qTbqv3yNKEpfXvZOWE0nU0ccXbB0Fdg68+/qR9L0ewwDxoxGyBCc4jj20ZSMpniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MubKAg5f; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MubKAg5f"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fb56d2fb2so370421241.3
        for <connman@lists.linux.dev>; Wed, 09 Oct 2024 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728491018; x=1729095818; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5UlorDz02n0Imn+KS/q6UO0aAIp6HzstBsGMqjJHwQ=;
        b=MubKAg5f3h8+fNweDa8Mm1C9G3Mc1uS1TZ5FcbwDth7M0jUXcOf1QmXLBDeWufLyZF
         mrgBEetH8e9dDu4Z+CBWDNMY3dOMYip5p1JedyD7B+mj1VhLn1NguYNjUVDRcQrr8Zpy
         lmFgIfStr5k4k1ZIuclVoNoJ49WdQQy+O7gUVRvUxSsXA3uYcrQ8KqKvU/2ZFjQXMlil
         qZS7p3UpmjmYmI9Z3q1Cyg1pEor2jkl3vHaYR9o27sMGatJHuh2aqMH7t23hI0vPm/Na
         Y1CTNJqIb8FlhZda6oafyYLybZJCv6CUKW408AqwI68TCADToZhOQYrG/JXbfvn8cK0Z
         m1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491018; x=1729095818;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5UlorDz02n0Imn+KS/q6UO0aAIp6HzstBsGMqjJHwQ=;
        b=oT6TbWjNDKzVgAePXI0TxYBT8Goj3aPXCXxuqrtaTZ6lKLtfcp6hrZ+YJtU8zfV88Q
         cLHCdkiT/kIpam6vWw6fS9ide9YQl/k7hZkISHm4+8KBls44BEQOKkCHuvkTdcoFz4GX
         INfZhQuliK9MyyuvBCBFvQGIYtNrzQhxyhgjdyyLS5OmQTHV/SFmlCVkA/SqyLom3g2a
         Xld8Ri9AyzRPkeyy4XPLRwX/8i14I/MtlFzIV0+SxIpNYcbSdQzZUCiUUVrJqnUTTItK
         Jqr41dngWVCGLaOTJo1sLkuvreiNkvccn4lrepnmNb4eq4KgD/VXtBvgjhtq/+rr0uao
         S0/A==
X-Gm-Message-State: AOJu0YwB//jWDKw/8YAe8VsHNAlcLMA8PMPwyTgkwTSOGhXnxtQfoEeE
	Chv37Ov39ayhCtl0uGZYQPbzl239WlUIzfq4pMUH02o+3HQRJIe9Fm9s60MVZUcMcXGe8c7KtTw
	SXB3KtHxTpZu6DlaOH2kJ1NYkjixv3w==
X-Google-Smtp-Source: AGHT+IEyd8fyel8UVOebv3AUca4vPkaQgJmOI63lpkZn76oHepaHfu1CJRQorKNYJfB9x8h2JZciHTovuoMZSPA93Mw=
X-Received: by 2002:a05:6122:2089:b0:50a:8cb6:e9ca with SMTP id
 71dfb90a1353d-50cf09ab7eamr2289142e0c.2.1728491018343; Wed, 09 Oct 2024
 09:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Wed, 9 Oct 2024 18:23:27 +0200
Message-ID: <CA+iibzBem7wuPcMgaD8MivS7SdrbUBi=iHYoBz41bXATZwTSiA@mail.gmail.com>
Subject: connman which frontend can be used with gnome
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

Gnome has network-manager as a connection manager with
network-manager-applet. I have installed connman as a replacement. It
works but it is not recognized in the gnome parameters. What Is the
frontend to use, I have found CMST and gnome-connman-extension.
gnome-connman-extension is very old and I am not sure it will works
with gnome 44 or 46

There is also connman-ui and connman-gtk which are old too.

Best regards

Daniel
