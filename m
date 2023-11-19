Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE3B648
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="PgcKd7pT"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67CBEE1C5D;
	Sun, 19 Nov 2023 17:56:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1700412980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yOXy58u84asB87vbE4IXcgzFM0YDpsV7rlpV72nttW4=;
	b=PgcKd7pTdwhe7xWhX0syIqqQNg8dN+5WzxV5m40snzv72QvOsGEcOEksvjxCx5/HstNVmp
	cR6PUOqiA15dJ5oSO9QTvDER6cpD8o16z2jYOJOmXo8S3RAs/V95iSX0xL2QRKBksPyto6
	BBMStnvJh15JBWPp4mnjUbw/dZUckhlXPuWUbIWcj+M6aOJ27R/G1kSNP+TnHYJ77h6C/A
	XNol1jGBnzvrFhOs/iOC3wA65SxaMUr1OBLBe8xUSXQIxcu2otazCWvLg2S7rvhtqo8H8m
	mXSCSt7XXKYswoBPgGo56Em/SRwDYuEOEmw0Rwf29OFF/KYLR0tA0WpLnknXPA==
Date: Sun, 19 Nov 2023 17:56:18 +0100
From: Daniel Wagner <wagi@monom.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: connman@lists.linux.dev
Subject: Re: libppp-compat.h missing in tar file
Message-ID: <bacp2536omiilw272akl5xjqaqvodo7aro66tti7gvri36jbb2@brfjeq53sjr4>
References: <b0e1c8ab-4157-4153-bc7c-529a54fbcd65@monom.org>
 <0A339003-F2B6-4BA5-A80D-2211979BEB64@holtmann.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0A339003-F2B6-4BA5-A80D-2211979BEB64@holtmann.org>
X-Last-TLS-Session-Version: TLSv1.3

Hi Marcel,

On Sun, Nov 19, 2023 at 03:08:29PM +0100, Marcel Holtmann wrote:
> Hi Daniel,
> 
> > I noticed that the scripts/libppp-compath.h header file is missing in
> > the tar file. The file is added to EXTRA_DIST variable but this seems
> > not to be right. Where should it be listed?
> 
> in general EXTRA_DIST is correct.

Good at least this is correct.

> Why a C header is in scripts/ however is total different question.

This header file came in via

 a48864a2e5d2 ("vpn: Adding support for latest pppd 2.5.0 release")

I thought it looked reasonable at this point.

> Can you give some more details here.

Sure, I was updating the rpm package for Tumbleweed. The spec file uses

   http://www.kernel.org/pub/linux/network/connman/connman-%{version}.tar.xz

as source and builds all plugins. And this tar file, the header file is missing.

  https://build.opensuse.org/package/view_file/openSUSE:Factory/connman/connman.spec

> I didn’t even realize we included a PPP header since pppd was
> something we never preferred and even oFono brings in its own PPP
> implementation.

It's used for l2tp. Does oFono also implement this part?

Thanks,
Daniel
