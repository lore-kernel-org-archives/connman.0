Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5D5467E
	for <connman@lists.linux.dev>; Tue, 13 Feb 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829929; cv=none; b=WM1h8KJuyiI7N8qsDWj5uV+3amBYkNT9KiAZ34gLzg9j5Y7FfwEqL7COW3EREUCCg+7L7rgD/T6GW6U2lcfsXIobvv+/TlFz4Gzo4FqOUM+ZKp8L0e15JWgI3R/+tbZ8vXP+qrmruy/IlRUod0EskVFHXPCQPuFFcIbPYDAYKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829929; c=relaxed/simple;
	bh=V5VviAbT9DJVGhhS5kKswBNtje4isACMQQhOKEL95+4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MeloaRcRYjPDcYyYsOWIaPDwP7ZdBrpTzfPrZqPXSXzpcq1DyrIurc/BqWECiVvAVG1T/uekf8ITbTCglVrLKYXBQxdp0TgQ0sj5wvq3kPVdbSOhknmVtfXQGP9qzePwrbm+PahTQ0OgAyIS/8c2sJt5PkEJjC1z3bi1FsAA+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b=PRwft3em; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b="PRwft3em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707829925; x=1708434725; i=rtie@gmx.de;
	bh=V5VviAbT9DJVGhhS5kKswBNtje4isACMQQhOKEL95+4=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=PRwft3emSpHSaPyCWW5ltxpVltSh4NQ2uOqzinxI+yQ+Mkzb+9RgTrvlQVlJ1L8R
	 +sD9JPYWy9HkutrO8N9j9GDHugpqBcw6enAA2EoXUN4hufL+o2eXosz4JQcOHa+wr
	 P0THevf8E1nYpXjDFK1fD1P92ZNdQwrdZrfDiDEnPMJlYRM8vPcXy10Roi410Dy2k
	 GfZVQRqfQDjaNMzm4jyMlbzntkPDMvwW8JDYbE0mNWYk7xem8fOsZH5YRcqB8B6Aw
	 4oDJ3CMrJzVR3iQtSXPO2zPpr1R+OtVH/H5CgCekZ/GV49UNiBjbVvpXBcHTCiQqL
	 t4EAiTaasRU2JSZvWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1rie0L2Bnc-008vxR for
 <connman@lists.linux.dev>; Tue, 13 Feb 2024 14:12:05 +0100
Message-ID: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
Date: Tue, 13 Feb 2024 14:12:05 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: connman@lists.linux.dev
Content-Language: de-DE, en-US
From: Robert Tiemann <rtie@gmx.de>
Subject: [PATCH 0/4] Fixes for memory leaks and corruptions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXbMDB0ObFBdT6B834pSgRpHpRGlEKVKLzzOIo2CSlw0wXgi/1Q
 oY463y3RCtaBqiBcEURBVzwt34HXOeKE1RUVO5lJtsP7WGwTzmli/UpnpotvaTXN6jYaZ8J
 Su1rkLaN38dcs2TbmDoOCJZ2vTO8MShcINMDsSXDZGVLxeA9x+ntM/zgk4xkQ5J5z8vBSKB
 /gNkp4YRnSV3aGYjnS/ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wq0ZIWWHw8w=;K5+mMsTSeW8rUvNq4gfcbDSHrTp
 5utIP2ZPkMgfPukaISWIOPaeBTFSO0fEFaCtb761o6J74X6+VYcKGRTugRoPuKbEQOYA90Jk9
 UkA0hE+jgJLZvpKGEMgHw5yv2Y7AAvUxF7OKdLGGLar0ta4OX6QWkmYf1pK6IHH++GDm90mfX
 jLViLx3VhSPcLgwUkl5TuhP3CIUACNT2iX6wFzs+oS9NmrJvXEd4LjbB2S1K4tvxF1OwHxqwA
 C25ex/vqIysm0Zm/tiKgxldTDx91WJHS9X0+nYBaE/50SjvJxJWe+2YjxACk66AhX2/p4esED
 vLaAkYfGJ24dZC57kGukN+EN+wGT6M4LCrIaqxwTQC1NDLEaXA2PUAhgGmjkr8rnUNeuTwPNI
 uZz9ODaABG84+Yyk5Rw+jJrEIfDPM5DA/nUnYO3ptOke6sd9g4j68H/gvwuAhbculp5AIIFSo
 VBlYZMk1Ci6b0S3d+7MBwlVJhVRa8zZwc/W1OI/iFUkwmtvvWuCXHEI06PPJ8n+4CzB+2k/hh
 E+KuJGzZ+phO2TSIjiV8gtoNK0h6/P0bJSwH+UdxMPfDq2fpEeEwG7pN1cl06FmLBrguvIVRc
 /IlYDjuqZFySj0F82XQcEnEw/mUKSbaZg6+zypQAiaqCIJGi2xNp+SLZj5vSPkZF8TImWG0Fz
 0vPcjX3Pdc5HmUTdcYQooZvsw24WxIcYAsnshf2lnBu5U//uqFuxo80TZV+iN8L6bF9GP+YXY
 gYfKPu104lmsT8Go736eEMbViXz3lUmNCLxf8QnKsuPDMkwO5l56Vxlsq0rCK45fXlAnbqk9t
 OtlA4ORAXkDC3GUoh+2XOZACEMDg4C6Whhdfm5FXcevrw=

I've noticed that the settings file gets corrupted when disabling wifi
tethering. Wrong strings and/or binary junk are written to the file,
preventing Connman from starting up the next time it is run.

I have tracked down the breaking commit (481d08f108) and was able to
patch the problem. While at it, I found and patched two more memory
leaks.

Robert Tiemann (4):
  wifi: Fix use-after-free when tethering is disabled.
  wifi: Fix memory leak.
  wifi: Fix indentation.
  technology: Fix memory leak.

 plugins/wifi.c   | 66 +++++++++++++++++++++++-------------------------
 src/technology.c |  4 ++-
 2 files changed, 34 insertions(+), 36 deletions(-)

=2D-
2.34.1
