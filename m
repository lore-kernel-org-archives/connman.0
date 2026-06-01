Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326B1B6D1A
	for <connman@lists.linux.dev>; Mon,  1 Jun 2026 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279072; cv=pass; b=Zj+nw+Yj66+9VYqQf73uewXZpDqhQ/zS6KFDPM+y3okCVwUMTRtdd/QdzscgQPlo7bNsoqKNFkBtbO2YFaZfmYzlntGpPUpo8JzglmlDmYz+oULlO/RD7rmnqBWN3D9CzCyaenxSx39xv2ZO00au1SWR3oACSgmoQfBf6/4Mgks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279072; c=relaxed/simple;
	bh=YQn2b0gtI30G2la7TyMINHSG0EgnygFA13aGNdxUtbs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IC07UEzuYP16zXCJ4rYNn5BMkFi8O+Wa3Ij/63OYDW+E45fQcteRYPUNkBaA1wPu9IFjNfq4xvvjPpKhvhBm2/zMzMF92ImaT7ZZfASNwJTzf3fY+RaI6HXq3YM0Uv5yEhUH14Z+YeJRK8T6GPrWidsm68kZ7u3czd4RTSZlc6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ2y899t; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ2y899t"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec4639953dso119295366b.1
        for <connman@lists.linux.dev>; Sun, 31 May 2026 18:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780279069; cv=none;
        d=google.com; s=arc-20240605;
        b=dlBCDYKfOzuc8F0rIFPSZ036bN5yluF7hf3eS4w/RQ6h3HjuguDG/9F+lGFBk8+/Q5
         ePCWADOzfWPLdoOvCj7cftpmQuiyv8hQORg6Xej102d50bJWgCIJLtxbxzFLQlUPXaV7
         OufHmyalroXOj/Do8wF2oKmy5xa0YG2kbe/spqrxxyxkIbDChLAcbhmuSStAabIW2Ag3
         HvfH9/zqO2TXz8f3wh7REH9yho4MawqBkS8sNV1u4zaFlXP0Kt8bEpwBHNn3zleFmyvX
         qZCHiSi7djNebLRuSSHRJHRMEWdkrXRfuV6+ZMBHUxIODTQ7mo9xI64BKdgcP5ZHkfWu
         /6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Kfbc2AKrFLC0C8mPaMn4qu0c8ghKL4EwEz51BlVg74w=;
        fh=NK8pMim8PLvTSy+0iL3woAAiFYZD7WCyeu9GJICENbE=;
        b=jddh9EzQqjbHwdw3clZ/Vqtzl1Cw3yx4ryOdKHjhSWYmD/CU7L/gMRSeE6PdWphTVk
         CttwOXcgt5FsKfUtEpI7QVRVHHf80phSDJ4Gh2589PDrsCtoUSe/8FKddkW4qU6XGLrK
         /66XWOn9ZLV/PHX0MWhACC8Z8nK1Klqj5iQ1ohPUJOR9iB209d9O9hc/0rD9jQm8J6Dh
         14Puws1nV7mczgFDMqGQCKWFI/GV8B0JYLdQu2NHB9cXnsCQ0Qt7PAgr9Nfak4D5gRWd
         Ar3KfMLNcwGwpWDog8+RYva3LaZ66tlwgYgaBsqdMBFktU+apElmV4M8ZK5QO46jT/cL
         Vk7A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780279069; x=1780883869; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kfbc2AKrFLC0C8mPaMn4qu0c8ghKL4EwEz51BlVg74w=;
        b=NZ2y899tijNKJ6rpYMnqlJfZ44EtLjB+K95N0rDvxxtUymF7UevmztaBCIP87h2/Yh
         ktWRCrGORGme6nmqF+oxVc1y15vIHyxJxUagUDijoIfSKy9SRSEYzvJLNz9WjQ7xN+Rx
         zZuExwTLB6bl2I17K1EiNm23aZzDcP21Gyc4kcNlPC8a4fTMnPqBrHcprMLhCTXh5/lW
         GTqXzqOrc6KBCfkIU3wWVjH6LB0siQjhLgoR/AMnvVJ8r5aP1A2IZC/ffqWnt1EvtbHD
         3nxxHtBtIwd9tLBnTyVVPZsxCj2xXBIuD0o4bGiMCxp5bdmSSPDcfZZkRmheE+bJCAyC
         dEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780279069; x=1780883869;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfbc2AKrFLC0C8mPaMn4qu0c8ghKL4EwEz51BlVg74w=;
        b=sQXaA9LgFm5VOLv+MVbydM+7NEB3TLBsmeNgAJkbb7HeTuXVd9JD1PFvyAj2hkHEp2
         jzOj1E+Sew3jZ5MR3WZsTeFJ7SrQsLaOHRp5djjrvfR9LNyF0Nr4bSu+iJQtQ7kNuLjM
         nBnHYcbrIAaTsNVw1dlLlaHtOE2EE8g9eiZx6eAuvByR6v9OJtTZjuxVkXj0YyBKIOCg
         zN81vx0aGXWU50uiJIFfTVfc87tc6Ob149e1wPfdd0e5FyJejxsrNAcC0tasqpYrnPCd
         dCRGED6lR3Z3MBA8ZyKsELO7x3yrxowaq5B6H0i3n6v6adXOdPEIplYzS0KgoUzt2+2X
         qbig==
X-Gm-Message-State: AOJu0Yw3/lmAFEYCVIGwjJvEiO3lBJ0DroxBHGCsgB6mfo1h7BNT3wMp
	ZFju3X9PS0OSyQyUCB0rWY93XptQHynfXf1YBSqdhdPbo08yr0eX0B4rISSPIhe2gTVapKaRiTq
	wTCIRuxSPo7DmLHFSvUNar15Ufl3aKdqJJncm
X-Gm-Gg: Acq92OGyxYbkD2xjB2YgSocbwIpEyZxJn+5x8lK2M+IktpbX4tBBR3jaE83wNeEhh//
	e+nHAccU4qi9z6y4mTG2MyEpFxSq1jtUhRJrjTevswmiFlROplaxrcJGX5CLc1h6fFLGr+CVT40
	aw86xTYB9e1ORBkQ/KwZxGAw9g8dqcVyuIuN0dZ8wLLFshY0sznnrBfR65be+zzBrkiOZEk9Mx3
	5jrFuzMB17jTMJJDs7RRqA1RefPfuHVEMAJ8Wf9L4/XNDImeqT298O7nfPKUVzUi/9fgyVqmAa1
	sv4Dh9wufeVTlOVA85r6UhwOdM7ZEGtSQ8tIe78C0+WlmpxFRbiBx0JTtwckIfmMBrwZXthZhXR
	Bt3Oe95TFdqiy8w==
X-Received: by 2002:a17:907:c5c5:b0:bed:7f50:c724 with SMTP id
 a640c23a62f3a-bed7f50d03bmr79446066b.37.1780279069334; Sun, 31 May 2026
 18:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: R4mbb <yong010301@gmail.com>
Date: Mon, 1 Jun 2026 10:57:35 +0900
X-Gm-Features: AVHnY4KmELMzk_EJW1SKu2u2B19k0PZrh2_C_ez-J3S1GJz83p3TAJrNQCukLjM
Message-ID: <CA+8xMBxLOfL7CutDYEeFDjZPJorTjcxFn7O4zsSVcGT90=4eig@mail.gmail.com>
Subject: [Security] ConnMan DNS proxy get_name() out-of-bounds read
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello ConnMan maintainers,

I would like to report an out-of-bounds read in ConnMan's built-in DNS proxy,
reachable when parsing an attacker-controlled upstream DNS response. I have not
publicly disclosed this issue before this report.


Summary
=======

get_name() in src/dnsproxy.c performs an ineffective bounds check while parsing
DNS names. The per-label bounds check compares the packet start pointer (`pkt`)
instead of the current read cursor (`p`) against the buffer end (`max`). As a
result, the check does not protect the following memcpy() from reading past the
end of the received DNS message buffer.

For a syntactically valid DNS label, this can read up to about 63 bytes past the
packet. Because the code uses `*p` directly and only treats `0xc0..0xff` as DNS
compression pointers, reserved label bytes in the `0x40..0xbf` range can be
interpreted as plain lengths as well. In that malformed-label case,
the attempted
copy length can be larger, up to roughly 191 bytes.

The issue is reachable through ConnMan's DNS response parsing path:

    parse_response() -> parse_rr() -> get_name()

when ConnMan's built-in DNS proxy processes a malicious or MITM-controlled
upstream DNS response.


Affected version / commit
=========================

Confirmed on ConnMan git HEAD:

    9e46e4a021cd8566b942d1a72b41b14a0a58f506

from the canonical git.kernel.org repository.

The `pkt + label_len > max` source-side check appears to have been present
for a long time, and this issue is still present at HEAD. It is closely related
to previously fixed ConnMan DNS-proxy bugs, but it does not appear to be covered
by them.

In particular, CVE-2017-12865 affected this same get_name() helper and hardened
its output-side bounds checking for the `name` buffer, but the
source-side cursor
check before this memcpy() remained unchanged. This report is the read-side
instance in get_name(): the parser validates the packet start pointer (`pkt`),
not the current source cursor (`p`), before copying from `p + 1`.

This issue also appears distinct from CVE-2022-23097, which involved a similar
`ptr + 1 + len` over-read pattern in a different DNS-proxy path, and from
CVE-2021-26675 / CVE-2021-33833 (uncompress()), CVE-2022-23096 / CVE-2022-23098
(TCP framing), and CVE-2025-32366 / CVE-2025-32743.


Prerequisites
=============

- ConnMan is running with its built-in DNS proxy enabled.
- The attacker can control a DNS response, for example by operating a malicious
  upstream resolver or by acting as an on-path/MITM attacker on the ConnMan ->
  upstream DNS path.
- No authentication is required.


Root cause
==========

src/dnsproxy.c, get_name(), label branch:

    unsigned label_len = *p;

    if (pkt + label_len > max)            /* BUG: pkt = packet start, not p */
            return -ENOBUFS;
    ...
    name[(*name_len)++] = label_len;
    memcpy(name + *name_len, p + 1, label_len + 1);   /* OOB read source */
    *name_len += label_len;
    ...
    p += label_len + 1;
    ...
    if (p >= max)                         /* checked only AFTER the memcpy */
            return -ENOBUFS;

`pkt` is the constant packet start. Therefore `pkt + label_len > max` does not
validate whether the current cursor `p` has enough remaining bytes for
`label_len + 1` bytes to be copied from `p + 1`.

For a normal DNS label, `label_len` is at most 63, so the existing check is
ineffective for ordinary packet sizes. In addition, the code uses `*p` directly
without masking and only handles the `0xc0..0xff` compression-pointer range
specially. Reserved label bytes in the `0x40..0xbf` range are not
rejected before
the copy, so malformed label bytes can produce a larger attempted copy length.

The cursor `p` is only checked after the memcpy(). If `p` is near `max`, the
memcpy() reads past the DNS message buffer before the later `if (p >=
max)` check
can reject the name.

One reachable construction is to use a compression pointer in an answer RR name
that points near the final bytes of the packet. The compression offset check
allows offsets below the packet length. A label-length byte near the end of the
message then causes get_name() to copy from beyond `max`.

Relevant reachable sites:

- get_name() used for the RR owner name in parse_rr()
- get_name() used for names inside RDATA, such as CNAME/NS/PTR targets

Buffer type differs by transport path:

- UDP path: stack receive buffer
- TCP path: heap receive buffer, which makes the allocation-boundary OOB read
  straightforward to detect with AddressSanitizer


Reproduction
============

I reproduced this in two ways with AddressSanitizer:

1. A standalone harness using the exact get_name() function copied from HEAD,
   driven with a crafted packet buffer ending in a maximum-length label byte.

2. An end-to-end parser harness using the verbatim parse_response(), parse_rr(),
   and get_name() bodies from HEAD, driving:

       parse_response() -> parse_rr() -> get_name()

   with a crafted DNS response whose answer name uses a compression pointer to
   the final bytes of the packet. This is still a standalone harness rather than
   a live connmand integration test, but it exercises the relevant parser chain.

Observed ASan result:

    AddressSanitizer: heap-buffer-overflow
    READ of size 64
        #1 get_name  src/dnsproxy.c (the memcpy)
        #2 parse_rr
        #3 parse_response

I can provide the standalone PoC and the end-to-end reproduction harness on
request.


Impact
======

This is an out-of-bounds read (CWE-125) past the DNS message buffer,
triggered by
an attacker-controlled DNS response.

The realistic impact appears limited to potential denial of service:

- ASan builds reliably detect the OOB read.
- In non-instrumented builds, a crash depends on whether the over-read
crosses an
  inaccessible memory region.
- If the over-read does not fault, the malformed RR is rejected
immediately after
  the copy when the cursor check runs.

I do not believe this leads to information disclosure or RCE on its own. After
the over-reading memcpy(), `p += label_len + 1` makes the cursor reach or exceed
`max`; the next `if (p >= max) return -ENOBUFS;` aborts get_name(), and the
enclosing RR is discarded. The out-of-bounds bytes are therefore not expected to
be cached, reflected, or otherwise used.

Suggested CVSS v3.1:

    AV:N/AC:H/PR:N/UI:N/S:U/C:N/I:N/A:L = 3.7 Low

If scored specifically for a malicious configured/upstream resolver
with reliable
response delivery, AC:L may be arguable, giving:

    AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:L = 5.3 Medium


Suggested fix
=============

Validate the current cursor before copying the label data:

    -   if (pkt + label_len > max)
    +   if (label_len + 1 > max - p)
            return -ENOBUFS;

It would also be safer to reject reserved DNS label encodings in this branch
instead of treating every non-compression byte as a plain label length.

In addition, consider adding a `ptr < buf + buflen` guard at the top of the
answer loop before calling parse_rr().


Disclosure
==========

I have not published the PoC or report elsewhere. Please let me know whether you
would like the standalone PoC, the end-to-end ASan harness, or a proposed patch.

Thank you.
