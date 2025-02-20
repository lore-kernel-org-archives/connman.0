Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2031E9B07
	for <connman@lists.linux.dev>; Thu, 20 Feb 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089441; cv=none; b=gqAIgGWTybPZ7VfgjBOEShvodohgp3/3DNcbBcRp/ba3XvKoQFNvWRNthX7e4v9tI+h9cCBDaeiNVuWqAysQIj+A/r2dN/yVVWaVwv17ysF+PfEeZ7XocrdJVKd4aUnSpVzAFWbwSzXsiaucAVMXzhVamKx4AFfP3TRV5ITU49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089441; c=relaxed/simple;
	bh=bWz+X8I6lGY8TUNfKoHNhIKdgaDVuRQvufxvtgwCEE4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PURmTkBihQoYvyxuh4gAZplbBTyAwbTMXVogcUg1sDSq4nCZ61uwZfztS2cI657goAo+c+BXXzhLem1xtL4kzTH2E2AXdEBjk4EOIjl2tiVX2XRAHzb9Kq5CXqC+uOy6nVFGB++Q99Up+UyPMajHqQN3R27mG4Wk/RZspzXs/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Ll8k+/x9; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Ll8k+/x9"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 673CD164AAC;
	Thu, 20 Feb 2025 17:10:32 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id DB689124FBC;
	Thu, 20 Feb 2025 17:10:31 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: Configs interfere with SSID deletion in connmanctl
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <CAG17S_Mx9RKX=aZf9206tMkoc6GgGJs77nN70X9r_JS13eommw@mail.gmail.com>
Date: Thu, 20 Feb 2025 14:10:21 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E65D058F-7765-48D3-A73A-D98A5A5661C4@nuovations.com>
References: <CAG17S_Mx9RKX=aZf9206tMkoc6GgGJs77nN70X9r_JS13eommw@mail.gmail.com>
To: KeithG <ys3al35l@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=bWz+X8I6lGY8TUNfKoHNhIKdgaDVuRQvufxvtgwCEE4=; b=Ll8k+/x9c2DP6v7vDqN+opq/VIuqcCjsaYDrwA/9NRzNqJy0Djjo0IBq0lgLlxqA1f+8PfmYEtc/ez+sOPhEOzpj7DhiIgTJQHtjGQ+gLsWJ37PZv8w0OVm5wXtIcCs8KQ73HXTAZhYiIOy554khjS4Fqqli86d0L9oCMYsuVJESTvk0pNAE4mbsmGBsZMhj72wBLr9FZQXVES8YGKs1F8J+AX1Z+q4Xrn0Xv2HgmIaO4HCvD5elI1srLx4EkqX3EVH8WawDvd+tzOaCQUA9se9D67UArOcQb7fq7oEkUO/czdFrcdXOvwrhJNxsp9F0PU2viG3g6bnbfDTTqGTQuQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 14, 2025, at 7:39=E2=80=AFAM, KeithG <ys3al35l@gmail.com> wrote:
>=20
>=20
> Is it intended behavior that when a *.config is present in
> /var/lib/connman that connmanctl will refuse to delete the config?
>=20
> I have a config for my local SSID. What we do is upon boot: a script
> looks for wifi info in a txt file in /boot/wifi. If one is there, we
> create a *.config and put it in /var/lib/connman and when connman
> starts, it will connect to that SSID. All good. Works as expected. If
> I go to connmanctl and try to remove the config
> connmanctl> config wifi_blah_blah --remove
> Error wifi_blah_blah: Not supported
>=20
> Is there a requirement that the *.config must be named exactly as the
> folder in /var/lib/connman for that SSID and then it will work? As it
> is, we give it a name which is the "second blah".config (the hex
> string conversion of the SSID name). Is the intention that we are
> supposed to delete the *.config after our first connection to the SSID
> and then let connman manage it? We do notice that when we delete the
> *.config that connman automatically disconnects then deletes the
> folder structure under /var/lib/conman.

Keith,

It is important to think of *.config and =
/var/lib/connman/<technology>_<ident> as distinct and separate things =
that are, likewise, administered distinctly and separately.

I like to think of *.config as =E2=80=9Cprovisions=E2=80=9D. That is, a =
configuration provisioned by a user or system administrator for a =
network the system anticipates encountering at some time in the future. =
If the network is never encountered, then it lies dormant, in wait. When =
the network is encountered, it serves for automatically fulfilling =
information needed to connect to and create the associated network =
service that would otherwise be interactively gathered from a user or =
system administrator. Since the =E2=80=9Cprovision" is created by a user =
or system administrator, bookending that, it can only be removed by a =
user or system administrator. In effect, it lives under but outside of =
the connman automatic administrative domain.

/var/lib/connman/<technology>_<ident> are connman=E2=80=99s own, =
internal dynamic, mutable settings that both live under and inside the =
connman automatic administrative domain. If there is no *.config, then =
settings will be created for services automatically (Ethernet or =
Cellular) or with some user intervention / input (Wi-Fi). The format and =
administration of these settings is opaque outside of connman, =
accessible only by the D-Bus interface. When a service is removed (or =
mutated) using the connman D-Bus API (which includes connmanctl), these =
are the settings that are removed (or mutated). Any underlying *.config =
provision is untouched. While related, as we learned above, provisions =
are understood by connman but are not administered by it.

I hope that helps!

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

