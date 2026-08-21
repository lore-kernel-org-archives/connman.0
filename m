Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3247DD7A
	for <connman@lists.linux.dev>; Fri, 21 Aug 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328591; cv=none; b=X/t8dv75mhKMhizeR8odgXFZ8DMAZjErWGx3Zo57YWCoQgcSrHSvDNxE3ughqS5AxKTTIGzyzSLRU0cWkZpzrvQ6dhyj9HB10wXzLkpSMxsgJNRmGXUVYGBH1n2O1Sya2jj4dADR3cTzDUzKrXNTvdg/fl8ITv4xJFE8oyyfLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328591; c=relaxed/simple;
	bh=P1i80Q5xryd35mni8Evft2eVNQckAznF64BIkNOUsmM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JRCJC/XrOoF4pQUxH/+WY1D4YIlyHQYZUDUDHrsMjxLXci37N25va0W7IUp9ACrohN24jrY7psnT7hNGpxV1gcqJs53P7HffvQbccn0UOvPsvZTogJ0mxikt31/uBfR4p/9rtlUNdf0CZDouhKkENi47Ok+zFufCrSnVFZ7YM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=EzjEWTI2; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="EzjEWTI2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ERaRCrGluYhgX72LJysj7wxi6dTisWPP0Wu9KVb18BM=; b=EzjEWTI28M1/0cRRvDtPgsFuXy
	ZAjqqqXiHUaIWIeT6+1+U2eKQOg0nS8TgCUX7QWH5FXedhw6xoe6bpYQYDqH9zNsD2p2x0nq40cn5
	gLHgzJwJcNYkb8Omqf+gN5owYnSMOgKEWvZKNSk2LQ1Rl0Zyx/GXNaI2OsWkzR3fkMWiHY8d/kmjF
	6HCyveNWkOif966M7GXh0vVQDy8h6OOhh/KWp/9uS5+Sx1QsjRCZhkueCSej7EaXrxYDWE5ENEf0c
	uJ/0FPh8slafdA4hMDLDgCB8ZsNSRvw90SYzR6aePyXq5v8tKV+nSERQ4yio9tDQw9Wl6TCXkCZ7E
	t9MwZjjw==;
Received: from [2a10:a5c0:37:6501:3a8:42b5:e757:c455] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wxRoD-00AHD0-2h
	for connman@lists.linux.dev;
	Fri, 21 Aug 2026 19:09:37 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] Implement D-Bus API for toggling debug on/off at run-time
Date: Fri, 21 Aug 2026 19:09:09 +0300
Message-ID: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260821160921.386690-1-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

This patch set contains a new D-Bus API, net.connman.DebugLog, for toggling
debug on/off during run-time. The API itself is implemented as a plugin an can
be enabled by building ConnMan with --enable-debuglog. The aim is to help in
debugging corner case scenarios where restarting ConnMan is not desired but
more logging could aid in getting the detailed information about how the flow
inside ConnMan progresses before hitting the issue or an error.

In order to make the interface work, log.c as well as plugin.c needed some
modifications. On log.c the methods for updating the flags for the desc is
added that can be accessed via plugin.c to do this separately for builtin and
dynamically loaded plugins. With similar approach, a listing of available files
is added to log.c that is used via plugins.c for the plugin desc's. The listing
method adds the filenames and a pointer to desc into a hash table for
convenience.

The API itself is very simple, it has Enable(), Disable() and List() methods.
First two take the exact filename or GLib g_pattern_match_simple() semantics
for mathcing a pattern. The third, List() simply returns the filename and the
current status of logging on the file as a boolean. This is documented in more
detail in doc/logcontrol-api.txt.

Approach similar to this has been in use in Sailfish OS ConnMan fork for over a
decade (https://github.com/sailfishos/connman) and has evolved into a direction
where an external server is used via a plugin that requires more dependencies
https://github.com/sailfishos/connman/blob/master/connman/plugins/sailfish_debuglog.c
and is not feasible to upstream. Thus, this version is an adaptation and an
improvement from the old logcontrol.c plugin. Most of the functionality within
the plugin was moved to log.c and, thus, improved to meet the changed features
of ConnMan. This has been tested to work on latest Debian 13. 

These changes are also available at my connman_ng repository located at:
https://github.com/LaakkonenJussi/connman_ng/pull/6 - I will keep adding these
NLnet project works on top of next branch, and sync from upstream when there
are changes pulled in.

The work for making these patches available for ConnMan upstream has been
funded by NLnet foundation grant NGI0 Commons Fund:
https://nlnet.nl/commonsfund.

The NLnet project website is available at:
https://nlnet.nl/project/ConnMan/.


Jussi Laakkonen (3):
  log: Add update, list and enabled check funcs, allow to disable debug
  plugin: Add log update and list functionality accessible from plugins
  logcontrol: Implement net.connman.DebugLog interface as a plugin

 Makefile.plugins       |   5 ++
 configure.ac           |   5 ++
 doc/logcontrol-api.txt |  38 +++++++++
 include/log.h          |   9 ++
 include/plugin.h       |   5 ++
 plugins/logcontrol.c   | 181 +++++++++++++++++++++++++++++++++++++++++
 src/connman.h          |   8 ++
 src/log.c              | 122 +++++++++++++++++++++++++--
 src/plugin.c           |  34 ++++++++
 9 files changed, 400 insertions(+), 7 deletions(-)
 create mode 100644 doc/logcontrol-api.txt
 create mode 100644 plugins/logcontrol.c

-- 
2.47.3

