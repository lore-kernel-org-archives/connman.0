Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE81586CB
	for <connman@lists.linux.dev>; Wed, 13 Nov 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522084; cv=none; b=O4ojNvaUfAahivOVnaCBc3zu+86tDCsOpPVdQ3azTg9cR7hTpH0ho0SFiwZ5MDaNyh+ZzqPBVIRI2IXXJhB7UZQOdAFXzvW9qkIdP6hH/mWklkx/CO9m7r8sXFCre/IfQE/oVYet7rAKWmhveLCPQbbR35/M7sdRL9x0053iJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522084; c=relaxed/simple;
	bh=xoGUIF/J74xSMfRqoz1zmmewkguNJO+R1DfqKCNVN24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gbzv8FhiJbJ2K5fn8i00UoLm4q09Um9unh88PUsGlfAMIpdLtEPA3ZZd3xXJpTuHrNVs/ndZHYinX7/mILIguXHgIHff0esJeg885L8vE7+p5ii2lQeSI4FsNkCFmlSMZdxcJMU7pvxag+8AQrmIAunOsAP3/MAs4Onn4zfVSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=b3nmnylH; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="b3nmnylH"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aa3ced341so262323239f.0
        for <connman@lists.linux.dev>; Wed, 13 Nov 2024 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1731522081; x=1732126881; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PkOR3mKRlIQtFfKIj71wiQUihZ0K928G1uy9jdZvm4c=;
        b=b3nmnylHdPvA3bwGIIEtUZOU5Iqiiag2BPk41Tty+N/uObgsCJWXSBJKY3wssJMqjN
         aUmu85m0C1L6ogvPHVN7D+vq+7QmFuCBPLrg+B2vAAEblneHzSX0CK8FNTzpHwZqCYtm
         fx0jdwPwwStSwBL1lt/YSRsHUb8ufoLKlmpxGSs9USlfGj1wn/TNMjeI2tyWkUJgtFHz
         p00F2/v7VsfOay7uF/I9VEeqfV3cUiLUDDl3/aPaTRijJXB12HuahHz7mWVNHpEtSTFN
         B/nGUGiaQ5PKVrnee4KX6Y44KK6UEaMIHT3Uw1jRgErSm+1vbDiyMgOUbXEXCWKuYqhw
         qTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522081; x=1732126881;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkOR3mKRlIQtFfKIj71wiQUihZ0K928G1uy9jdZvm4c=;
        b=hwV8Lckl2n5yj0mWcG4Gju5alBW0ujIioKEaHUKe2oLUecyDJ+EQMZaluWyI+ALa5N
         Qu+uSeVdkfnHU24PMFeJBQcAKs35+WulmvHBGyOUKFLOJxzF94DWIDFEN1ppH6kCVyf1
         QP4VZqk8vNwwgHt3FCaoleVqWp6kxh3LUh3v6k5wV6BbuTj1JwbnqmVBVoKUCvvAFV9k
         DZ4u1z78h+44k8dLZDpxXdXkYlIV9UNLI9UdscD9ldkXEP+KeWO3Eq73Ok4USdrss8qR
         o3gSaWq64ut0dQw+do7ICDgFnBehuHrdyM3J9bslT6KXGSKFJb7kLXVGCDH2Mo5Q+Qxj
         khBA==
X-Gm-Message-State: AOJu0YyOEbZk6beEhgD/m/S775mCsLhexF3pAYw5MNlCiNmlLVfq7TlP
	tvpiJwGoAwBUe9PDZ5RD3zWkytwsM7AmGAPdSVvEJW6QeL1RQt0n4RM15O/HgoLo+BJKoGZ6E9h
	AjMrZgtYPOfswdFhPLyM27tiF1OlpeIJ92bSfJu3Hrjr/atFl5jORSFr+iiFxTFhZj1+Q53POZ3
	kbBUBX977rs7P6xB2ZxOtG1IcDWQyupYAuxpDPTeyA2I6znYu7UEg=
X-Google-Smtp-Source: AGHT+IH0HQfUuJ5c/NmPsZAbwjQpjw2+dG+Hw7I5gxC+nlYQpgJNKVqeqL+W0+casL2hZohG7ldD/Q==
X-Received: by 2002:a05:6602:6b81:b0:83b:470d:bcdf with SMTP id ca18e2360f4ac-83e4fb66961mr456656939f.13.1731522081403;
        Wed, 13 Nov 2024 10:21:21 -0800 (PST)
Received: from localhost.localdomain ([140.177.171.67])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de7874148fsm3076464173.44.2024.11.13.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:21:20 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: connman@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] inet: fix flags used when deleting routes
Date: Wed, 13 Nov 2024 18:20:00 +0000
Message-ID: <20241113182009.139820-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

When using PreferredTechnologies, default routes may be added and
deleted multiple times as interfaces of different priorities appear.
Unfortunately on kernel 6.11 connman is successfully adding routes, but
it is receiving "Operation not supported (95)" errors when it tries to
delete those same routes.

strace shows that connman is passing unexpected flags for RTM_DELROUTE:
  nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK|NLM_F_BULK|0x400

connman is actually passing RTM_NEWROUTE's NLM_F_EXCL (0x200) and
NLM_F_CREATE (0x400) which are interpreted as RTM_DELROUTE's NLM_F_BULK
(0x200) and "nothing", respectively.

The NLM_F_BULK flag was added to the kernel in commit
545528d788556c724eeb5400757f828ef27782a8 ("net: netlink: add NLM_F_BULK
delete request modifier") which is included in the 5.19 and 6.0
kernels. This flag was likely ignored in prior kernel versions which
was why route deletions succeeded in the past.

The fix is to ensure these flags are not set for RTM_DELROUTE.
---
 src/inet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/inet.c b/src/inet.c
index 5032cf25d396..542e5a851306 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -829,7 +829,7 @@ static int inet_modify_host_or_network_route(int cmd,
 	memset(&rth, 0, sizeof(rth));
 
 	rth.req.n.nlmsg_len   = NLMSG_LENGTH(sizeof(struct rtmsg));
-	rth.req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	rth.req.n.nlmsg_flags = NLM_F_REQUEST;
 	rth.req.n.nlmsg_type  = cmd;
 
 	rth.req.u.r.rt.rtm_family   = family;
@@ -841,6 +841,9 @@ static int inet_modify_host_or_network_route(int cmd,
 	rth.req.u.r.rt.rtm_type     = RTN_UNICAST;
 	rth.req.u.r.rt.rtm_dst_len  = prefixlen;
 
+	if (cmd == RTM_NEWROUTE)
+		rth.req.n.nlmsg_flags |= NLM_F_CREATE | NLM_F_EXCL;
+
 	__connman_inet_rtnl_addattr_l(&rth.req.n, sizeof(rth.req),
 				RTA_DST, host_or_network_buf, addr_len);
 
@@ -4717,7 +4720,7 @@ static int iproute_default_modify(int cmd, uint32_t table_id, uint32_t metric,
 	memset(&rth, 0, sizeof(rth));
 
 	rth.req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtmsg));
-	rth.req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	rth.req.n.nlmsg_flags = NLM_F_REQUEST;
 	rth.req.n.nlmsg_type = cmd;
 	rth.req.u.r.rt.rtm_family = family;
 	rth.req.u.r.rt.rtm_table = RT_TABLE_MAIN;
@@ -4726,6 +4729,9 @@ static int iproute_default_modify(int cmd, uint32_t table_id, uint32_t metric,
 	rth.req.u.r.rt.rtm_type = RTN_UNICAST;
 	rth.req.u.r.rt.rtm_dst_len = prefixlen;
 
+	if (cmd == RTM_NEWROUTE)
+		rth.req.n.nlmsg_flags |= NLM_F_CREATE | NLM_F_EXCL;
+
 	__connman_inet_rtnl_addattr_l(&rth.req.n, sizeof(rth.req),
 		prefixlen > 0 ? RTA_DST : RTA_GATEWAY, buf, len);
 
-- 
2.43.0


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
