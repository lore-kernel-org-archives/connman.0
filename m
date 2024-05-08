Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B921A2C05
	for <connman@lists.linux.dev>; Wed,  8 May 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183599; cv=none; b=BtJJkkuolcO1tEv8v0kN/hxt3fVIGX/C/30qn1wLM3TQE/e1y7LuiPu+JB8OUTh+9Lx2FxuZ05o1bG6TGhu+XYynqS8tLJHoyuRNB7A8dPCyCwI84iVY3lb8EARhi7x8rMaBa8EVOzU9pOTzObKf86Tj7j2lVuGWWufgUXyI4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183599; c=relaxed/simple;
	bh=8xWkEkqXC1pv/+QeO9G8+EJ3SblU4zsuQ/ELwOoyEAs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kqym3dCb4RA/tEX0zvZjsTmDljwNh/6YQLIIFc4bw25diyPraB/AoPYfJkhGhjiilrv84/j8bP4jjUov2xM5mLFGKwPgPGYnnG4xDD2HVrynZB6IMqlIZzw6A2YdVJvCcfp049c6X21HEr+k2zwTngmMx6MRvz/dlIknOyJQHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc49c.dip0.t-ipconnect.de [79.239.196.156])
	by mail.holtmann.org (Postfix) with ESMTPSA id 44621CECEE;
	Wed,  8 May 2024 17:48:09 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] Prevent a short allocation by checking upper_length
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <lvq5tor4tudvh4xtxy47p3cescldr3v5c3fijgrqwkdfrktq5g@ycqxblnjgbaj>
Date: Wed, 8 May 2024 17:47:58 +0200
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
References: <lvq5tor4tudvh4xtxy47p3cescldr3v5c3fijgrqwkdfrktq5g@ycqxblnjgbaj>
To: Colin Wee <cwee@tesla.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Colin,

> I'd like to submit a patch fixing potential memory corruption in
> connman. I've attached it for review, please let me know what you =
think.

we prefer inline patches for easier review. Best works a combination
git format-patch and then git-send-email.

Can you also please have a human behind the author name and email
address since we don=E2=80=99t accept patches from mailing list or =
aliases.

Regards

Marcel


