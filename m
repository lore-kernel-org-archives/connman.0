Received: from sonic307-53.consmr.mail.ir2.yahoo.com (sonic307-53.consmr.mail.ir2.yahoo.com [87.248.110.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664612F39D6
	for <connman@lists.linux.dev>; Fri, 22 Aug 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855863; cv=none; b=tiSN5vSJmW2HaP7k2iVkJuNVjjeO7GKR1UDw+ETaw3WGVcH0RA99pHYv3PIVyNU761AVhJ09Jv+BA/hY8IwiLog++pOTfUchk6Gd0vpQ5OQhLEz7D81HpHHnZ8UxWZH3pw376SRrGH+hQqkbPhFLbRIvSllzbPt9Go1Ipbip5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855863; c=relaxed/simple;
	bh=JGr3vjA9iOm+Wu0HACu3WRyYvyYj0zjfYEBuQtmSyRo=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=N3WbnG0MvBIgR0d2+nOJc6aD4Rvn6BREsS9uE7W/uLBPKo8uUI3FPmrzh8tOyygwK1+T3PCP6t4rw3GKKSLdJocOSTOv9XvYerosp6gBQse8Q3cnRpWd4KTltEm7umiE+xnqiMovhW4JdAHiFiPCmtcKjoSvCW4u97YHs+BEXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=QQyoJ2I3; arc=none smtp.client-ip=87.248.110.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="QQyoJ2I3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1755855852; bh=JGr3vjA9iOm+Wu0HACu3WRyYvyYj0zjfYEBuQtmSyRo=; h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=QQyoJ2I32iPz106pAMuU5svGHGFUlcJn8Z8C7VjeBULsA9m184px0X4KlgxakKyAAP7OOR7Mv6n4j61RSsIKXsJ0iYQPaoZEaxK+gL360AaNvvAkvbbxW19Xrjd7uDUA4NKBqfP/IiBKMl51mKL0ZF0N89MnePLV+nmlFuRfoel8qXbL4GCShUq7j4Hdfh2DhXi5uRK+9qynYUlh8C5ndneRSKGlvxQtwLFNF6RRrF8GsEgxrQRUVDJ6+xSlnW49fyO4L45Pei3nixq3x2NO9y3VzSz0shw6wh+C1L99Qx7MH0LWzdJFf+c7tQGBWWnEZwROAEFp5khK5NbNFdKWpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755855852; bh=i+O4AYtkV+LI8jZ+aIllpLCUre1JV7ZJLgplm5HdQ1Y=; h=X-Sonic-MF:X-Sonic-MF:Date:From:To:Subject:From:Subject; b=qvPcBh7Y29hmxkVPdzHg2jou5MydD1aQTMTwl5L9pp3Wgt0owVfEvoRlcWafnjGQuaBhC+4VcpBV72e0HjT91PkDGB2DTe5vy3+yZJJz6MwwzJkUi3Acq0d1Z+ZCEQk0h7gL4TOr4bS/7SUCNCGc5RRuqIWbEN/P2fmOL4AAcJqTAzSF5AoaboSr8CQKIGrGgcAHS9lWs/DXNiA/NM4fTP3YUjehinyaMs8E+c2qIKa79zNfgdog7pbGhSqfwaGWNYq37SfYg+ZZWZ3WJA2UQUZ3E6s9LB5XYluei43mQq4Dm1nhoTmBJbUMif7il01pXRk0LY0lMuibPTMFC3Z3Jw==
X-YMail-OSG: AMymbU8VM1kbthnX3QeOF7RM8VEpAxU.OuRYunBVJVhQruoyzd35FYeKOrJZoFr
 NhL1OXdY7q.RG9xt2oB1YmvnzYkhiqZNV64ZJBiuFo85dkv.KHLmfWTjxgyyzC04fVpmvWgTevGk
 EhJop.yHwFk9hGA4kbGj7MtZ8qyTcnBDRaw21TCU90e2W5UgXUlvSsGTUiHr4ROYMb.Rzso.7CC7
 1iUG7jga2EUjZpXAs_oWr6GtiLebAHhbsoItY_D6RzkO4jJVjZ3B5KSB1YokOTi2y_UZU9h5Uo6t
 59H1sQaVw7xB_k1dIA1WhBNBDjMaE2aE9tK1c.R3zx7tK3lbWb49NO5Wl1wsUG1uOJHz.JcIBWvd
 kLe2IrtVR0mM2d7szz5b0vM4pSC_OhReEiBhv74pRRuEPnyzi04YeUny9nwWnxLRhNBo0.uHhxKn
 1WK0n8I3w9XgM1erKpj7miSfM6skbnCFNyipL.p0EFH5IfHauXynhO4EnGAbtQr7tyYtDzWUdSG9
 lAWB4TfUbwxkpuDtnI2RaBlRl8b9gc4dnESbeE2ygSMotXuN6OidXCfjJzZ.xUOqe17JoOeX0NYs
 ge3f2oo1VF1gDVDvfGV1bInBkBO_ebiZQqNlzi6hk.4nFpQs42U7FE7eKBWJecBAdx7IusNthRJQ
 5QJgcv3aLvQgMsnJSX4MQ61rob5CgHh2KIX6kKr72lGhgtInnGHrbQLNxFGNHK1Rx8p4anNUB7Y6
 yzCktkhK151dtbmRjSOCV0mmjxqgC3UEwbPqOj5FrW8VFEkyDdGWlomV3gK4n428kuPzMMYZnB8I
 wMq3jRXnyMcRJd.B6GSPp9VF_PWZw05FmNuRFvpYFiFgSOy2XIpLGeSQjTP_92xmh.NbcVF5NXAN
 nMupNWvHGjbxN_6lO6liQeLGx3u34V7tmh_.Oz.V7yq3JFMkpT.WM0k43TdWTChAEkPdFrT3N4JN
 lmB1nPzgllHYIMY2TBSLw3u3Xp5aKTHyXAN0aMnGlNBketsxNpqqi.JmE_G1qIlfSC0yB3rwrVwX
 V0g85qIZsIPocLIcLqIkFTM8bgBpkjtxK2A6kLREKtmsz3JC_pDLqA4Rc8bPZ3MvWoQ1AgC7gUD.
 N5Zv5O_aIPBc4L0QG6NLvjRBk9ECIjCtE0qhV_JnybwZU_Nvav5a9bl0vGZVLkQB9tH6wkEPDrTF
 pk5BDv7RMnYnBnG1VeH_MJsuXeRdkr1.8PpOreonC4Z_b6nBdD43Td6iRnHAhRoa57aPum47LCx5
 GLZ3c6azOjegR0rhv9U7T0Aqdr0N49J9KHyI6X.1EnM3ciFF0VqxBQjo14T8eeSo9mY0oEnQmj3x
 O.FLOR98qbQy4CxmczXHLnBi8xDK_UqEVZlZ8uQxinnf9tYTHD8qIodlhI.sQcDQjoslx3OotHck
 _IhqoKBueCXpvQRMrwEvt7JFJaeJLik2PNbADs_S7lNNpl8UZT65IXwR1qDvXLrhumHz40n6573K
 Aw6hE228YBQSqI5Bo0fcWJP1fpI8sk40RVbaJk4CrPvRNyucANnLrmmT1CrN0f_AbFoXww3Tu6W_
 DtXTaWdi4qYpzPW2Gj2f7T84mp527Qxob2LnMgqA6GFcPjT2_aO4RUBZLStVcSR5ttDeteJiutwC
 OBIe1hNJhPMRlI0vP6CaQ16KN2tR4JclXVY.ywLioBASJQdj5fNcSFpjDfPAc7cJ5I.qFz2Q9_k0
 UHZsaqQ.4s8EYhw36rXt8p.W5rfi1DIicblCUxj.YynZ_mMTTObk3gHRoWAfTRZpkLG.blRYpVOI
 abvRVJaIusuTxAhdi.bvgocBavfMwSr5L6RYS8H1PfTY2MC_NiCVnaUr27YNviZbJvvW8shp3UNn
 PYvkFl3tDyeOG48n09zX.gahR95fmf1KLMDnh_DHuA9pl0BU69meywR7NBFSWf2J3c3wsQWqssSg
 Iltq5AFZjHqVhkuAaAymOJEsfodd23FZmh9yWTt.wZP69Ypq6wkJwJJDRidvnNUvlenbjXlG56FM
 J5KzOl25El_1DW97JfyY4MmDdWXXM7_GIP76zaR2FSrpeZ.xgcJSUIKxNeIr8Nq_zxGQYJr9XE1Z
 W7nPRv_mqzVnfMhIVoupP3zWECRh9UT9rtBsZbHnCWpJ4NXKnTUPKEBlFW7_RdaTBZ86vjyJobim
 0RNwEuh4.FeIEnUcUCQgEKRY2UnWMnP1t6ZxOcoa4MESQwTOKz5HXgiUMdFYe48pyW_X1ZyTHO34
 T7JCdhABLEjNds1.zJNtnGjHAVS9rsC.clfJOjyUA4sDaKxalK9IDSU43VV_EAvpxeIbrI8LKGyz
 48i.wJ5x0Yp9yNlNkzT5mZmZESSPLJgU1DDt_DJTbbsZAIN4gPA--
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: f8b24553-1540-4a47-824f-7e351ecd322f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Fri, 22 Aug 2025 09:44:12 +0000
Received: by hermes--production-ir2-858bd4ff7b-g5qbj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bf5ac9ca54f4f58e87f25d299b1ec2d3;
          Fri, 22 Aug 2025 09:44:10 +0000 (UTC)
X-YMail-OSG: Q3CVx5IVM1n1sY4ZLaxQBynoms7vpBR3A7MNzZotcQMajkJ0lodI0oSAVRCZyBH
 QzQheQc33RicOZIx9wq3IuJ8yOb7UGJtEBx7hyFAnCcI1BxhocMCmOsse0Zzexs5sWOVeAaP_iDK
 S4_O7SCJY694gvH0O9g94bJbaojjAbFgUWkw9lm2XMAJhRWfsy1lBtRNqOWoEFajqizZY1SiyLjD
 FXnA0TrMWUq3ax9kyaIjjxdBz1OtKMQrtIEeCzq01g3a_UNy888rOS.D_he4pf7VXonC63MtjxcR
 WHCvQRVzjhxJLJr54bi3_jzzi3nEoyM1HDbvmziwQrkYd6NWSoE64EkUYM9x8yoJDGLp5oUSz14A
 b4gy99tAsWYGNvlvZRafomocx3W08qLp5EOn076HSUJhYXDOFRzZckcjrigwZaZtXSbXGPT7D4ax
 XrC_6wgKVtJew17OciuhTVdg2rGpvY_NDM823dlz0ZQIKlM26GJDLoPf878wei4U3MF_ssMNw3h5
 xS5E2qeKnyDfIJyZxtJuyE.QxRaKsrV4nsCaEkJntpVInx.g_8aebJrcJUUuFjHgZ9Oje09OamRT
 0S3acOZTBxOSEGlhK.ehjfdSPs.1.sKqVgIemnrO37Guf_R_tRN3f9PlXC7FR91dTN3ppxqdU2O.
 WknAK.nmVM7Ne2tyw4.dPBA0cHnQ3Hf7ohPfMdjRLPx9p6gMS5sJ3vIIb3qbay311.EZMl_Y2URC
 .pON63L7vStAB3SLvCRs9lLIVs.PfJbs4JmYXzf7cHioocZfU.vfO9jaV_AR1..ELNGcM93Ir2D4
 lnpw_kOMkr5oc..M74xuiUs9.F7PdPqNYWH6cf5Sd1ba6Un_8V3O.a5ZcHWRxUYpsV_bINyYEUHs
 AzD_G8hBMZQUc9V6G3xmIzNOOEaI32YlRoYNACKmuBlcezaRoQULzrUuLM1LIeUyI.vqPVQVc9f4
 A_FIxR2iKs0sElcHYIHdPfvp59L5K4IWRPJ28OXJ_bJRxQ64jIbV5.1uF9Ejutcm3qtaedNSoUeY
 0BpTYhF_fzIbvQhY7yvU1NMgW08t1JAQFAeAC0lOZt4VncsavIxyumaXg8uZZPKr70wKC0ySA5cq
 c_ksnzM2YqCyc3DPMcEzRLr7y4FHH8TOnyjI6xXBm8FiSObQBAyn5xr.ghOthUKY6.1g5XZpcjtv
 QG1Sf0JHxNxCrhDDV8KHL8BlDacdODTZYG1ztV3ObCcVoLw7dR5LQ8GQDZqXqD2ZV7lKwdp0DWZp
 6DJE.Ib3gId5_CT.g7sZqkOb0PAtCcLSICVU1EJI9CeSjUZvxR9ozCopdISQ9XirvskHEGm_qtJa
 XN7LCt0g_xL6yUMfYqFuj5bU_NYqrpw78tP7HtGY7HhdHg1yGAb_MK95IMCaGkn1W.nuoAM7m6AX
 rVfxzIuIJ_pv_VkVbUhzYlLYJaX1GgjHVkXqQqycjOzCVv2._AtgoenY0DI_gxVm4rUZiE5OuPXt
 2trO1hUbKBxtHjvdAQHYsN3kE99wBbN7qMwJqevuSRaCGSoMF2ROI2ts6nXWgnxLwUdQRZH3mIzE
 b64LoMADZGQROHF03e7Lx8Y18QMvQZtDdY4XQOCFj_wv1WrvYw26Ugl8cub5WNr7AEPPjyaDmnlz
 vKxkY8ziM9qxHw1m4YE3VumbnN97D2IXdLvR9PzmlGY9CZEMQrn8rsfilOj.JkPLrbcv8XNG.VgZ
 8.Z3T2NR8WQ9q1fCIZf5HFOtLIr5HmFjfk74Vky9KYSgluXTgTnk67QzjKfGV3d9hUyaSF4CEDfP
 UgXBjBsLv0RUZ..mi2QKTLC1PzHWVEba5k2dJuJnCrGYmnptR5iAkWGeqPPkc7aFW3QV61XgiWsP
 JDolqRRO_DztldRfionmxyl0CCNohQKyTlAGhlNOBHgrhy80Trb5tM.qBIgdSe5x091nOtyA3LDL
 .EI1qezJmfM6jjdNKpw.SKU_9wfACfjZNdEB7nsedMj1T1OZEbAuCY0TM9cpaf4ibs.OUqgbhgwP
 zq3UjcDHFASQ5By5QCQ4o6Z24swBRY9XX5n6r3S3huvuM50c41PejfiRgEqNwgfzxl5OVtU4_K.p
 LRM.qIQ74fFrvFFeZgDGP3TBB5jmV3JY11DeYv0pdvmHmSD0.13f2m4N_Oohn7UhK9opaTFRMvQE
 QNL5uddPrLn0Veou0cUENazSYm5XDOtYyXjZvueR8OUMuAFJBRsaJ2w7EisJ.IwQh52CuEB6hQ.1
 yZICo2Em8wuG7SZnA.LrFjHEOYJMcZWBUbNocxPFfyGQR2QWlO07cfOuiRiZl..DXzQAKcyq9X.g
 3BpT_Jw9YtA7hGJgr1zo8DVk-
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: c60df0a5-9c84-4924-95c5-db48ee004844
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Fri, 22 Aug 2025 09:44:10 +0000
Date: Fri, 22 Aug 2025 09:44:10 +0000 (UTC)
From: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
Reply-To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>, 
	"Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Message-ID: <1575346913.202340.1755855850144@mail.yahoo.com>
In-Reply-To: <AM5PR10MB168209153ED996ACF90BEA4BF43DA@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com> <1082538859.4574595.1754637525886@mail.yahoo.com> <211116062.4586180.1754639815460@mail.yahoo.com> <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM> <511456109.2450472.1755696051598@mail.yahoo.com> <HE1PR10MB1690B9444B6197D17AB086A9F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM> <1972372971.2755960.1755757618469@mail.yahoo.com> <AM5PR10MB1682BF72395A55D04F486CA8F432A@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM> <1430299077.3058830.1755784100023@mail.yahoo.com> <AM5PR10MB168209153ED996ACF90BEA4BF43DA@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: AW: AW: AW: AW: v1.45, broken wifi connect
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.24362 YMailNovation

Thank you again,

I disabled now the feature NL80211_FEATURE_SAE in the w2-aml driver.
Now it also work with CONFIG_SAE enabled. It looks like the SAE handling in=
 the driver is faulty.

Thx,
Portisch






Am Freitag, 22. August 2025 um 08:11:13 MESZ hat Dembianny Sven (BSH GDE-ED=
SD7) <sven.dembianny@bshg.com> Folgendes geschrieben:=20





Hi,

I suspect a driver issue, you can check wpa_supplicant & kernel logs.

Spec says to be Wi-Fi certified and 802.11ax capable, WPA3 should be suppor=
ted.

Is latest driver integrated?

Best regards, Sven

> -----Urspr=C3=BCngliche Nachricht-----
> Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> Gesendet: Donnerstag, 21. August 2025 15:48
> An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7) <sven.dembian=
ny@bshg.com>
> Betreff: Re: AW: AW: AW: v1.45, broken wifi connect
>
> Hi,
>
> I just started to test Ugoos X5M Pro with Amlogic W2 chip.
> With this chip it is again not possible to connect to Wifi.
> There does no info exist about this chip, only this source:
> https://github.com/CoreELEC/w2-
> aml&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C10696a11780345b42e8508dd=
e0b966bd%7C0
> ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638913809067032337%7CUnknown%7C=
TWFpbGZs
> b3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT=
WFpbCIsIldUIjoyfQ
> %3D%3D%7C0%7C%7C%7C&sdata=3DX7vKJYz41CPLpsAKFzkNvMXTS4OPDE7O36ZWa8hUqwA%3=
D&reserve
> d=3D0
>
> Only by adding the revert of the connman commit and disable CONFIG_SAE it=
 is working again.
> I also tried without the revert and using wpa_supplicant defconfig it doe=
s not work.
>
> Any idea how to find the reason?
>
> With reverted commit and disabled CONFIG_SAE I get connected with this in=
formation:
> /net/connman/service/wifi_f0960256bbc4_43492d30303330313536_managed_psk
> Type =3D wifi
> Security =3D [ psk ]
> State =3D ready
> Strength =3D 99
> Favorite =3D True
> Immutable =3D False
> AutoConnect =3D True
> Name =3D CI-0030156
> Ethernet =3D [ Method=3Dauto, Interface=3Dwlan0, Address=3DF0:96:02:56:BB=
:C4, MTU=3D1500 ]
> IPv4 =3D [ Method=3Ddhcp, Address=3D192.168.2.221, Netmask=3D255.255.255.=
0, Gateway=3D192.168.2.1 ]
> IPv4.Configuration =3D [ Method=3Ddhcp ]
> IPv6 =3D [ ]
> IPv6.Configuration =3D [ Method=3Doff ]
> Nameservers =3D [ 8.8.8.8, 8.8.4.4 ]
> Nameservers.Configuration =3D [ ]
> Timeservers =3D [ 0.pool.ntp.org, 1.pool.ntp.org, 2.pool.ntp.org, 3.pool.=
ntp.org ] Timeservers.Configuration
> =3D [ ] Domains =3D [ lan ] Domains.Configuration =3D [ ] Proxy =3D [ ] P=
roxy.Configuration =3D [ ] mDNS =3D False
> mDNS.Configuration =3D False Provider =3D [ ]
>
> With reverted commit and enabled CONFIG_SAE, no connection:
> /net/connman/service/wifi_f0960256bbc4_43492d30303330313536_managed_psk
> Type =3D wifi
> Security =3D [ psk ]
> State =3D failure
> Error =3D invalid-key
> Strength =3D 91
> Favorite =3D True
> Immutable =3D False
> AutoConnect =3D True
> Name =3D CI-0030156
> Ethernet =3D [ Method=3Dauto, Interface=3Dwlan0, Address=3DF0:96:02:56:BB=
:C4, MTU=3D1500 ]
> IPv4 =3D [ ]
> IPv4.Configuration =3D [ Method=3Ddhcp ]
> IPv6 =3D [ ]
> IPv6.Configuration =3D [ Method=3Doff ]
> Nameservers =3D [ ]
> Nameservers.Configuration =3D [ ]
> Timeservers =3D [ ]
> Timeservers.Configuration =3D [ ]
> Domains =3D [ ]
> Domains.Configuration =3D [ ]
> Proxy =3D [ ]
> Proxy.Configuration =3D [ ]
> mDNS =3D False
> mDNS.Configuration =3D False
> Provider =3D [ ]
>
> Thank you for your help!
> Portisch
>
>
> Am Donnerstag, 21. August 2025 um 10:01:59 MESZ hat Dembianny Sven (BSH G=
DE-EDSD7)
> <sven.dembianny@bshg.com> Folgendes geschrieben:
>
>
>
>
>
> That's good news.
>
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> > Gesendet: Donnerstag, 21. August 2025 08:27
> > An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7)
> > <sven.dembianny@bshg.com>
> > Betreff: Re: AW: AW: v1.45, broken wifi connect
> >
> > Thx,
> >
> > indeed, this do solve the issue:
> > https://gith/
> > ub.com%2FCoreELEC%2FCore&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C1=
0
> > 696a11780345b42e8508dde0b966bd%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%
> > 7C0%7C638913809067076253%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRyd
> > WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
> > D%7C0%7C%7C%7C&sdata=3DSIEjXqBiozA35HFokZksZLl0SaCZPCLmevSyso6Fd4A%3D&r=
e
> > served=3D0
> > ELEC%2Fcommit%2Fa8f96d2c4a97bd2afdd49c5aac6d14cd6efb8494&data=3D05%7C02=
%
> > 7Csven.dembianny
> > %40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d6
> > 48ee58410f4%7C
> > 0%7C0%7C638913544287997489%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnR
> > ydWUsIlYiOiI
> > wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
> > C%7C&sdata=3DGAlOx
> > 3ugq0WWVUMwUXE%2F1AqZelOQvRd8FndGqYwiMfM%3D&reserved=3D0
> > Maybe connman should be include a switch if this option is enabled or n=
ot?
> No idea, CONFIG_SAE is activated per default by hostap, if mainline defco=
nfig is used, or a self-maintained
> one is updated with wpa_supplicant updates there should be no issue:
>
> https://w1.fi/cgit/hostap/tree%25
> 2Fwpa_supplicant%2Fdefconfig%23n258&data=3D05%7C02%7Csven.dembianny%40bsh=
g.com%7C10696a1
> 1780345b42e8508dde0b966bd%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63=
8913809067
> 107569%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMC=
IsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DsZugNQsu5nyx=
7nWvbHO6UDwk
> nzmsyDRwXEy2Rry8jIY%3D&reserved=3D0
>
> Best regards, Sven
> >
> > I tried also to replace wpa_supplicant by iwd like LibreELEC was doing =
in past.
> > But the results are like the Wifi networks are not visible at all anymo=
re.
> > If visible connection is not possible.
> >
> > So we will stay with wpa_supplicant.
> >
> > Thanks for your help!
> > Ticket can then be closed now I think.
> >
> > Portisch
> >
> >
> >
> >
> >
> >
> > Am Mittwoch, 20. August 2025 um 15:44:38 MESZ hat Dembianny Sven (BSH
> > GDE-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:
> >
> >
> >
> >
> >
> > Hi Portisch,
> >
> > maybe adding WPA3 support for wpa_supplicant can help us.
> > Can you give it a try and add
> >
> > CONFIG_SAE=3Dy
> >
> > in
> >
> > https://gith/
> > ub.com%2FCoreELEC%2FCore&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C1=
0
> > 696a11780345b42e8508dde0b966bd%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%
> > 7C0%7C638913809067140991%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRyd
> > WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
> > D%7C0%7C%7C%7C&sdata=3D6Z6FIbqmAglo9y0b05gAIbTqX0%2BYO1CQnjnRqfDZIRk%3D=
&
> > reserved=3D0
> > ELEC%2Fblob%2Fcoreelec-
> > 22%2Fpackages%2Fnetwork%2Fwpa_supplicant%2Fconfig%2Fmakefile.config&da
> > ta=3D05%7C02%7Csven.d
> > embianny%40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84
> > e4bbb6d648ee58
> > 410f4%7C0%7C0%7C638913544288023231%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1
> > hcGkiOnRyd
> > WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
> > D%7C0%7C%7C%7C&sd
> > ata=3DHSQurgEaI8o%2Fvx5D5IoEQylng796X1TcA181TV9qf3A%3D&reserved=3D0
> >
> > Best regards, Sven
> >
> > > -----Urspr=C3=BCngliche Nachricht-----
> > > Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> > > Gesendet: Mittwoch, 20. August 2025 15:21
> > > An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7)
> > > <sven.dembianny@bshg.com>
> > > Betreff: Re: AW: v1.45, broken wifi connect
> > >
> > > Hi,
> > >
> > > server is OpenWRT with: SSID: CI-0030156, Encryption: mixed
> > > WPA2/WPA3 PSK, SAE (CCMP) Client Khadas VIM3: AP6398S
> > >
> > > Same behavior with X96 M300, RTL8822CS, vid: 0x024C, pid: 0xC822
> > >
> > > With commit included:
> > > --------------------------------------
> > > VIM3:~ # connmanctl
> > > connmanctl> services
> > > *AO Wired ethernet_0200001e1f01_cable *A CI-0030156
> > > wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> connect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Error
> > > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_
> > > ps
> > > k: Not registered
> > > connmanctl> state
> > > State =3D online
> > > OfflineMode =3D False
> > > SessionMode =3D False
> > > connmanctl> disconnect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Error
> > > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_
> > > ps
> > > k: Not connected
> > > --------------------------------------
> > >
> > > With commit reverted:
> > > --------------------------------------
> > > VIM3:~ # connmanctl
> > > connmanctl> services
> > > *AO Wired ethernet_0200001e1f01_cable *AR CI-0030156
> > > wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> connect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Error
> > > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_
> > > ps
> > > k: Already connected
> > > connmanctl> disconnect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Disconnected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> connect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Connected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> state
> > > State =3D online
> > > OfflineMode =3D False
> > > SessionMode =3D False
> > > --------------------------------------
> > >
> > > Wifi is working again.
> > > We got multiple reports from users haveing same issue:
> > > https://disc/
> > > ourse.coreelec.org%2Ft%2Famlo&data=3D05%7C02%7Csven.dembianny%40bshg.=
c
> > > om
> > > %7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d648ee58410
> > > f4
> > > %7C0%7C0%7C638913544288040178%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG
> > > ki
> > > OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > > fQ
> > > %3D%3D%7C0%7C%7C%7C&sdata=3Dm%2BtmZYRdI8bMJxhT2%2FU3j5XvwmBZfjqsnZ%2B=
f
> > > OK
> > > gIeb0%3D&reserved=3D0
> > > gic-no-
> > > discussion%2F46663%2F2296&data=3D05%7C02%7Csven.dembianny%40bshg.com%=
7
> > > C3
> > > cce9ee05e2049040
> > > 15108dddfec6794%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C6389129
> > > 28
> > > 619230523%7CUn
> > > known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> > > Oi
> > > JXaW4zMiIsIkFOIjoi
> > > TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DEjK%2FrOlN1nhCNVmlmxzbp=
e
> > > Yw
> > > cyRt6tqLJt9VS0y
> > > uJpc%3D&reserved=3D0
> > > Then we reverted this commit and all is good again.
> > >
> > > Thank you very much!
> > > Portisch
> > >
> > >
> > >
> > >
> > > Am Mittwoch, 20. August 2025 um 13:33:40 MESZ hat Dembianny Sven
> > > (BSH
> > > GDE-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:
> > >
> > >
> > >
> > >
> > >
> > > Hi Portisch,
> > > >
> > > > Hi,
> > > >
> > > > current connman is broken and can not connect to encrypted networks=
.
> > > >
> > > do you have more info about your setup?
> > >
> > > We can't reproduce the issue with 43455 chip.
> > > Which chip do you use, is it WPA3 capable?
> > >
> > > What AKM is configured on your AP?
> > > Which wpa_supplicant version?
> > > Is SAE activated for wpa_supplicant?
> > > >
> > > > Revert of this commit do solve the issue.
> > > >
> > > > Error log:
> > > > connmanctl> connect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Error
> > > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d303033303
> > > > connmanctl> 13
> > > > connmanctl> 53
> > > > connmanctl> 6_
> > > > connmanctl> managed_psk: Input/output error disconnect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Error
> > > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d303033303
> > > > connmanctl> 13

> > > > connmanctl> 53
>
> > > > connmanctl> 6_
> > > > connmanctl> managed_psk: Not connected
> > > >
> > > >
> > > > With 1.44 there is no such error:
> > > > connmanctl> disconnect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Disconnected
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> connmanctl> connect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Connected
> >
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > >
> > > >
> > > > Thanks,
> > > > Portisch
> > > > Team CoreELEC
> > >
> > > >
> > > Best regards, Sven

