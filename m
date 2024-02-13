Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979955764
	for <connman@lists.linux.dev>; Tue, 13 Feb 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830306; cv=none; b=gl8o5qTjDgpRFnyMtb0XiJof/PT+cDx+aYIZr225IfyXP0pQPJitWqVuvMBWcpXTLCGqSfyLrwm6rXCCThdliny2CSXSP6YO035RLilxBROUGgFDZdhgogvmHiC1cDNPhjqKApLhO9Q/tcn/ZmcEV33hvE+SCM4yZAD0eIxBkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830306; c=relaxed/simple;
	bh=aT9uakTDE+5AOxheOWAyeXd6zMcpRaWqgOBtd9cgSZM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=V5qXMU0n+tSMH8GwSBqXvPBwFnm/Vg9I5PcuvntONlr76Q9azpU8vTuKfk3IopMix21olb4csJEddl1dutFBADvHiiKWXYj9LNm3e259rTZSfcwTdjFIz1e2aZ/ct9/9jYpbBBI6ULV1sS8mPtdMyC+wxJQmmSCobMsmgX1znNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b=sKMMfnGc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b="sKMMfnGc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707830302; x=1708435102; i=rtie@gmx.de;
	bh=aT9uakTDE+5AOxheOWAyeXd6zMcpRaWqgOBtd9cgSZM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=sKMMfnGcjZ3QNJeYfh1NdJoKmmK9GdN49VSW4QdBX0BJApf+P8/LR7kY6JFv1Xhq
	 mkm/fx5NElw5UQZUpIGiCbcdGo9EzU15APEq2Q6IN50sEyWcNRln6YAM0rB6x6sSQ
	 0SxFgO/C4a4nPweyYo/z/rPON5TJIoFOsWYE4HdhHudOEbfefl79sw+JTjQIRb0vY
	 QblkxNHzpU1zKKs1uCHoh5qCGAKT4Qyf9+T+7V+zR3C0ne52Tv13uY2RHZp08xnye
	 phY2C/D0B5s3TnzIVvP3A4YhuTlR90T0F0jCbzPElYR1mK8ctbfBrlxXxoolxaMGI
	 fdeBG6y0/R8GY+3kHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJhU-1rAgLS39u8-00jMZT for
 <connman@lists.linux.dev>; Tue, 13 Feb 2024 14:18:22 +0100
Message-ID: <3aea58eb-e3ea-4abd-b6ab-b03e0bfd7f19@gmx.de>
Date: Tue, 13 Feb 2024 14:18:22 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] technology: Fix memory leak.
Content-Language: de-DE, en-US
From: Robert Tiemann <rtie@gmx.de>
To: connman@lists.linux.dev
References: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
In-Reply-To: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KuCmhLvjyqHm9BuzWN+YuaUsZgWTC/erEALBMyomUZNmJ3uS0q7
 59bAcbDFBBbbjH7G1+KdFrdFOMN14Zev/1XjVTei4280Hy1PeBuCOntZBSrKXDZz6pPAqOj
 Wi7wyFDZd2Vo5JRnHOhxpwozN0u/CChmSLMag/xvr8PwlW7TmY6S62VsN206wgRFeLbZl8h
 zt/+ZHObYTarxFk4ZbNVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AIzmkerwTNI=;7IJv3R3xzjohLe/ztDE44qska12
 faEKQtx9B30976nFrattizhbhX7S93WO5ZbGVJWDTHzz8sArwlarTTGWLPZtVBZ0Hc4fHgu3h
 vB2aw8YFlOA1SEk/hSyh4s/UqtRjCO87IyDQ/kbZVHl9dc3S6AmN4ykveGM/Svdb6/bS+tI+6
 nMIiIeetdJzb3bvdBmlqpiXBl6e8ELlNcbtFb4/cAjReWX7SFjSSyCCVIApDRGY/ebdVTKmM2
 4m+Bo0Cu053unltNUDsaOS4l0xDi2WOUQA0ht3tcsAmRwc50MbMS4hq1e0fl3eOyQwu5iAxBR
 0PDqMXXCUDO6R/lCQ+ZEKVR+ACh2JP7oWDqM6Jq0aHmn68ycteSeG3MMPJ7j9Uvn9ntMd8EED
 0WGAQpxa514YiFcsp6+jbPY616594zNT/0vfhlqO5NSZlkSPF+VRV1vIb1TOmF5o8H0wM1hge
 BxI1z2tlXd2lUiJ0VE48VUu6/SNs02Z67YmwYk9lvO46cYZgXSlI5Xq8JBNCoflocX3mvd24j
 q/42KzvksGgfTkdPNMd4+cfHZkI4c3ePnIsKpI2afMRK4kAicodscE8ctk+vRd/ibIO70eZpY
 YbwUscGq7buz84Nu2Z3GvWHRYvoIqU1zwW+VCs+XMCHIIExCMv2mZACcpMtGwdF7rqHh2viWB
 p8r4EljY8a107dFNZK+bvKjJpuzKtRHendH9lI5m0l2bIin0zaX5pJ7/cv2TMyGWbdnQYmIL+
 1phq8DG62ApQsK3T9pfQ0I703nxPf1+UQuFVAn+dgJRcHnXlx8aeX3la8vToUgyuMlGmCrzs3
 jtQXQSY8c3GFk7R4T82C/u5E3yPFJyeZ0MWiaKvZ0tMBQ=


=2D--
 src/technology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/technology.c b/src/technology.c
index 65fb9854..270d83d0 100644
=2D-- a/src/technology.c
+++ b/src/technology.c
@@ -479,8 +479,10 @@ static void technology_load(struct connman_technology=
 *technology)

 	enc =3D g_key_file_get_string(keyfile,
 				identifier, "Tethering.Passphrase", NULL);
-	if (enc)
+	if (enc) {
 		technology->tethering_passphrase =3D g_strcompress(enc);
+		g_free(enc);
+	}

 	technology->tethering_freq =3D g_key_file_get_integer(keyfile,
 				identifier, "Tethering.Freq", NULL);
=2D-
2.34.1
