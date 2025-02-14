Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBB1519A9
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516074; cv=none; b=fWAdl0YKYD/DtvJPBNkuO5vbZ3u06wp6BC7BZuLhM/Z9nmhIPLGFxAB+wGHw+3xloLDPpNR/l7FcTIMKweKzMC9ZxZ/VM8T4Kyb9cGBuGafMYxjYYt1SV3QVizx+t0PBomwlGTwwaGqadDUnfrNaj0eG6NcLlBSZOOo7VxPQFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516074; c=relaxed/simple;
	bh=CWmVgILzWM57NoUIDEUXtSYOrklJnniQVwwdpmbhmS8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FkFo1TGtqgl4IW9587r59aYw18tW2P+vXmXfoaKdY+4mDiU4wTVyurIMD/7DLwBZ5bJ/0RkDWJwHe+Tufq7EPiwvqEHHmGjoZeGfgqHO9sfDgqcJubyYa30ls9QmfUyrhM0M3Js2moNTps/9PircPM4RUB0XtPRZmRCgzrx35nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhp/eEIf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhp/eEIf"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so1930548f8f.0
        for <connman@lists.linux.dev>; Thu, 13 Feb 2025 22:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739516070; x=1740120870; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9ryri6xztb9sjJylHmXH8aIU3jM1d4IJygal2rXJV0=;
        b=Hhp/eEIfAcpPD6XoyHut+eLzwT0d35rML8EOP5SnRuRM66wurA775Im4WGbV+dodRQ
         tlG+sUw9QIUvorjZGwLK9DYmxUc3txJBAaUcxfm/PIyn5LhyiKYR472TeRl5uwcI7Wl/
         MNOdiAVWZGyTeCdMCoh9h6X3Fk9s3ToJZ5vajMZE9FUc+mX9MIubbssPwgobo3iHbJ9N
         lfak7ndZWAm8H/p9FdmTQKkAOXHq7udOIfdkYALqjJNRI1APjX7ZHXn+nxUGWQq89eSi
         DAOpJfAJoVmAt6L9tRtz2u5fS/v45QHOgDEWkBQ3ylb3K1zVGwqP0Pa8SlwXKyd4WNBE
         ujow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739516070; x=1740120870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9ryri6xztb9sjJylHmXH8aIU3jM1d4IJygal2rXJV0=;
        b=XxONLvBbP+Wj0mXukq8Tnq4NM5lBP56fYAiAzClbAzSMnmGBakAueQoiAla0GAAOzq
         RSxdT0UA77odMSvzQAiCDYoffVTESo5lrNR8tijxtYAuuePBxSzNKLwfiKK207BYn33G
         OsAHZMKcKgI7sNKDzjQ9mCmf+GUTGr0cBmc9mvBdLGY1CSfeKZOLPao9cz2FuMZfgII1
         UV4lb/m1R4Aeu37Z4tNt0hf9RlpBd8s+uJadyU8Uoz3Urtm82MEfUxpG9jIDSiCnAgqw
         M4Dv9YP158P2eEIFQLuCrGsfw3rZI/hUaqtnsaXKApjcBmT5rcfpfiBxUz7vr/zRcTB0
         eDjw==
X-Forwarded-Encrypted: i=1; AJvYcCVEfGAM7nq/1C0MOIxQE+7KNKgmMP/DQG0s9PFON6QcnkLElotS7iCdppSW1oqJS8yZHwLQcLWM@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq8qEAjIxW8IOKIq7uTpI7gmmoal2vSaHsUwIP3kPQ1FEjLRGV
	MEgMm0GYZRdPw8leD4mivXem9+fqtNh4vTsoJlzz7M0jMTMAz2zPfoblVA36hzs=
X-Gm-Gg: ASbGnct/87b4VeyrA8sPob2ZbAQJZz7n/HTfdqyMXZTzLxjdi4ZMIrEfETbgLPyM6P+
	7fJ5WgcJU7e0Dz5VBGw9TdOiQiJzHEhaz/TlpoXyaXeivEqKtINleshK+EtTocMD2ioI3lWkHAj
	YQ+p8x1AN8bw4RpjCDyLYxezKKFaCBttPwDZwI3nGUsmVq8gFWAmp3gyd5l+/32OxOgG7jqO5Rh
	z9ktaFKTJ/7Qi4uC1vAtsvZnofzs/gzlYceVd2qRWQDLM7+zmucEg2HZHixi+s7eNbRl/uEZYKL
	tT2zebICosUhOqIqW9kd
X-Google-Smtp-Source: AGHT+IEB6UU62okve+KJe1Q7vD4MiKMmzXaPjgKw6L0kFUH7Yn0S+T7ovzEfExveOskrUdSJrBqIPA==
X-Received: by 2002:adf:e44b:0:b0:38e:48a6:280b with SMTP id ffacd0b85a97d-38f24518186mr6693536f8f.34.1739516070091;
        Thu, 13 Feb 2025 22:54:30 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8dd6sm3830650f8f.62.2025.02.13.22.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:54:29 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Denis Kenzior <denkenz@gmail.com>,
	connman@lists.linux.dev
Subject: [PATCH] Revert "Don't add route for invalid dst and gateway address combinations"
Date: Fri, 14 Feb 2025 06:54:26 +0000
Message-Id: <20250214065426.2697329-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 9eb1772d31b6 ("Don't add route for invalid dst and gateway address
combinations”) causes a problem regression in WireGuard support through
the connman-vpn agent. I asssume because the wg0 interface matches the
definition of "unspecified destination address coupled with unspecified
gateway” added.

Routing table with commit 9eb1772d31b6 and WireGuard (wg0) active:

RPi5:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         172.16.50.1     0.0.0.0         UG    0      0        0 eth0
1.1.1.1         *               255.255.255.255 UH    0      0        0 wg0
8.8.8.8         *               255.255.255.255 UH    0      0        0 wg0
10.127.0.0      *               255.255.255.0   U     0      0        0 wg0
65.109.130.17   172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
167.299.200.14  172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
172.16.50.0     *               255.255.255.0   U     0      0        0 eth0
172.16.50.1     *               255.255.255.255 UH    0      0        0 eth0

As wg0 does not have the default route “all-traffic" is not routed down
the tunnel as defined in "WireGuard.AllowedIPs = 0.0.0.0/0" config.

Routing table with commit 9eb1772d31b6 reverted:

RPi5:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         *               0.0.0.0         U     0      0        0 wg0
1.1.1.1         *               255.255.255.255 UH    0      0        0 wg0
8.8.8.8         *               255.255.255.255 UH    0      0        0 wg0
10.127.0.0      *               255.255.255.0   U     0      0        0 wg0
65.109.130.17   172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
167.299.200.14  172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
172.16.50.0     *               255.255.255.0   U     0      0        0 eth0
172.16.50.1     *               255.255.255.255 UH    0      0        0 eth0

WireGuard now correctly reoutes “all-traffic” through the tunnel again.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
This regression was pointed out in [0] shortly after it was merged
but it's now 18-months later and distros are still carrying revert
patches to make ConnMan + WireGuard usable. I'd prefer to see a
fix for the problem, but there's been no sign of anyone taking up
that challenge and I lack the skills to do it myself. Let's force
the issue by reverting the regression.

[0] https://lore.kernel.org/all/73D64378-2195-4669-8B60-39F808190977@nuovations.com/T/

 src/inet.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/src/inet.c b/src/inet.c
index 542e5a85..54c283ff 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -1697,16 +1697,6 @@ int connman_inet_add_network_route(int index, const char *host,
 	addr.sin_addr.s_addr = inet_addr(host);
 	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
 
-	/*
-	 * Don't add a routes for link-local or unspecified
-	 * destination address coupled with unspecified gateway.
-	 */
-	if ((!host || is_addr_ll(AF_INET, (struct sockaddr *)&addr) || __connman_inet_is_any_addr(host, AF_INET))
-			&& (!gateway || __connman_inet_is_any_addr(gateway, AF_INET))) {
-		close(sk);
-		return -EINVAL;
-	}
-
 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family = AF_INET;
 	if (gateway)
@@ -2128,7 +2118,6 @@ int connman_inet_add_ipv6_network_route(int index, const char *host,
 					const char *gateway,
 					unsigned char prefix_len)
 {
-	struct sockaddr_in6 addr;
 	struct in6_rtmsg rt;
 	int sk, err = 0;
 
@@ -2137,19 +2126,6 @@ int connman_inet_add_ipv6_network_route(int index, const char *host,
 	if (!host)
 		return -EINVAL;
 
-	if (inet_pton(AF_INET6, host, &addr.sin6_addr) != 1) {
-		err = -errno;
-		goto out;
-	}
-
-	/*
-	 * Don't add a route for link-local or unspecified
-	 * destination address coupled with unspecified gateway.
-	 */
-	if ((!host || is_addr_ll(AF_INET6, (struct sockaddr *)&addr) || __connman_inet_is_any_addr(host, AF_INET6))
-			&& (!gateway || __connman_inet_is_any_addr(gateway, AF_INET6)))
-		return -EINVAL;
-
 	memset(&rt, 0, sizeof(rt));
 
 	rt.rtmsg_dst_len = prefix_len;
-- 
2.34.1

