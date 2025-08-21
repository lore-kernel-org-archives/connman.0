Received: from sonic304-22.consmr.mail.ir2.yahoo.com (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAF24DD13
	for <connman@lists.linux.dev>; Thu, 21 Aug 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784115; cv=none; b=QBL/H89X1/Ms9LwXVW5snqdNGcOX0iaSfKCr/QGR7Ce1YPFnRkVWVv8BxYH0z4FiXptPZm/45QOm5a/PPhCh56KcOtswV5I242BDA6YmQLROOXq3bvjrMBhXlmmQf26XQndwXDY9rUjY2oEo/AAageXI+znDoW2UGCs7MRzol6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784115; c=relaxed/simple;
	bh=7JX9LAuN4zGyOKkplHM+JaXZZvEKzp8gZKKlPpIjLVY=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Y88J5iGltw2iMUexomYUUwCyrlK6C+DIQVp5TXNaz6wC/opT90zTjPUmj8/Ysg3LRtaA329kNWANxZqhY25hOSGkRpCWo6dgi+3hs88thpHAXe9bH5oe0hZYAwfgPhYHRAHQD/YFtSZfvZdrPEaK9yfbsSfW1BBcUNi6BM6BSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=Lm3Y06IN; arc=none smtp.client-ip=77.238.179.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="Lm3Y06IN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1755784105; bh=7JX9LAuN4zGyOKkplHM+JaXZZvEKzp8gZKKlPpIjLVY=; h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Lm3Y06INyI/4QnX3A9J7tILAoDuBzQbdylFPjeiQP08eoLhkOH9vAI2ObPI5wvLinUKvieis8wdm9quq+K5M8wUCN4u6YZisOlk+fEw0jyu7iVaP06CcT0cvvxy1DnDRKkGkrNnPV5fWBL92SEefWyVoNmFDRbUZIk+Ela94XNhc4hHOsAOq8YFV31N38+pOUAxPF06xIpJTZlEJ1Zl6b2+IS2pbragMDK8Gs0nkmExqDxy5sZemqGMpi1BBFHSJ7H0RDHRBRjaPOfpfjvtCRUKNvfTKsy6Of/qYJUVBGwXJRzSo6FtLvHQ0E0vjN2d+bKlOSxGoKchxlRbwt0Jmow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755784105; bh=g8CEEcCiZ7DDKFn/WPjmxg1OE5bPtY4O0/v8CPCuK9f=; h=X-Sonic-MF:X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ADVgHzVzvh2XIUwMHnmLETrFB/nlqsMWYMjxkb4HbTbaMVktsHTRgH6ksqVf3MW0JO8p8cC8oQzJ1CqazPQbwEHBIvs/n7p2QucokzpOGkCzU9lJ00E9m+45qeKxh0ak8+OUzQZSYetN+UAk6zQZhrqQM+V6vOJxK5tFJSs7oPqcH55BjpjtCsQNrp/tgTUUQgnaxcJ5zUYhJmESNPspv3yF80jB350sNicaMNptZGhtHYuTaxt7Ahf7aItcoFuqlwh5WxPXf69JdjYvz8YuzdjG9nXafxQu0m5J8afha/7VPqGHBFCm8WCl1yKXfR5msOVe+ViXdcemUrAy8+vW8Q==
X-YMail-OSG: F.2HFWgVM1neprSWiELsMBERXqIMdbaEnclxWVaRrudDjobKXlfcGuF8NMq1LNz
 UYr3vrBp1B250LfL8GTzOf38Y_To.nWNdbKA0MpCGfq9b4Hiuki_gzjC4cAYzALZc1XYqB8l6jc8
 .CtXucRqy2PPMxpmiuSBhJivRFuHvaGiXbgvq4VeX0Gi5_grsCq9KOE2xEwJG0aaQ4eatIcBnsJD
 W9w32yNe_yAbCc85FKS.0.MPzc2S8hQj_Td0Uh4WW00BBMu7hWWMG1X2PXX.WO0TGWTyZV6hzqry
 Iohgfjd4Yf_7P2iOPTdKfT1PpL0s8uKBbypIcddE114gktKsPUHhH3URXDkNh2_aRrEneCRJirem
 NRnd7D2aS9k8LItadEDSBhwzkhY3.8vx2wPCKXm_0Kl9RjOm8gcnHiBuwlx72EAR2z8lA8dPnL2N
 csbzKyrb7pmuE2CgBWe4D5ckLR.Di6LpdT9oWslHIlRXzTwFvG.Ac3lxaqPiSTrxkmbyJgF2IK1P
 Hs71ux54vXtlnDHF83iNJa37o5M8GKo783yMpt3WKoEDT.4.phNpg39XXS71_3MvPZucx7AWYnpu
 5nxvi6Gn_uZ0TarfaxqWRPacGd.XVDHDU5oRhqRM2sh8vvBBXTJpgso68Pu3BM3ZBkx.O2TBV_qf
 SlR9.IIUwLkLNositirUdBiixjbWFLpM9FGDZutrnazyIjp5tgXn7_aEUrQIrKY1lQeRkwwr0_ZD
 jgfWJ5fNwSd6Od6XpHqEjKfiGjwTSiB29IXhRRJVjcaQRT97vkQQen_uDMeS5SoT00OLKvn.nSJf
 5dNzLU7fJ_qGOKfNLOgylJQva.nNwMNA1m2t8mva959DuTC_UP7MFWbDQ8ULsspHFoHNToJT4DrS
 ZURNoQhRZOf7ugJ_pN5nP1QYdYWU2055ws8iB9S9AEO8gyiWkYGjq8fPnLoWJxmK4YHXL5_fCA_h
 r86b8d5Wv_P6ZNtqh4IQ9q_ZjV6b.QxKg9hWRuW6jJc7_Ar0dTd.Vn1J7PyZ3p8NDFN3sF5RRBMf
 CqAMpMu5ETbl3rjeYS4cdDe9_LasKsPRvpYRsYGTHiwG863_zVoaNeN4OijLiAharNCHkj6Mlqhm
 8CkjUrIOMGekWlkdpfaxD24j.F0Ik_JjottGjLMgez3xMcz1JsuuODS96w8mjNHBb53n5i5pT9gf
 9beczKxNRDsTYj9Ef_6qwmNl5tJJTiknwvp28SUToSfXmUmSTTTY.In211nKsgTDtmzQ5zmKuj_J
 0sHfF4Utu8H9pHcqjJ2eZzHx.6OacOui9jT7hqVwcf6nDYUGqvU9UI.9k2VJPgc6tb0PUKezgTsm
 14sWvOhBmo0Vbs24YfG62W8GkbWHU58d9d417AK8cmjq0uaQZuhmtggVY9MSxkuMxgp_.I.HoJ_x
 q_EF4fOKPoAKAuYk74P2Qq3i33RCH25BNffTkYSb9GzBWjKn1EhzY6HYRQxGgMGlsAVSDzjYHrfO
 OINVtf9.Mmql1LglYI_KZaZqenDVudtvFQ7aSifpXSKfTCObWuNWFoPHgx.CoOG8YjH2WfeboPxm
 xcFTVAjyXqgRB4IYdr4BVqexJYznvswrNtzpgqacuGZU3MwTsQ2wUcAlmq8zNNB0gdFt_1T1VIYO
 6tQhvihb5DVSuCMiEdtc9Dr3MNtQd1kVYdFb6LzSOqY1IOByA2n6_thvV5Ep9eXYIgR0_GBXMvV7
 pH7Xo_WF6hkLAG8wlbNUG1aaLVX.qTz195dmaFWXand_J88XCB1QL6pul0LW_rd3cQcq8p0Fg6ow
 ew1_M_l1ompmIKBc3DkCFqolVjN0GFvNF0_7v1lvbJq9cWExEhfFkG4vhWwJrQd7AapNhZxvPAdg
 4i0OvZ3uvNWiZ8gaBbPGexJ25CPCgC4HZkDKaJJTZMYbC8umBUp1CtR17DZy4IAr5O9l3niQs_l5
 p2i44NBuzzWx.ahc1WJLmy1_lADefQFKtJENpIeMmKfl8Do336uwUk4OmyhmNmAnpCuvzWZEwCwg
 XYPHeT8MLa8BDCsxRWOlvwxu0_83zTvFvdRkuwg21k_tbpJsxbtPmN2zUXWk_o3g7ZkK65xX5Mb8
 BllAUil5EfPa_9O119KamFjZj7UQR_Z2RDvz7hZ.RNM0lLbTB0_Mc_wnaBYygcbdo3BY7FokfJNh
 VjUPdMbDn3ZGVwBJrz5GDPPiyy_xXy1HWF.FG3Y_bN0i0odt7u2Q9cp0T.b0DcSsF.5XWWlEQQMV
 dIiLA5.PHjT2cP9O05438OVSCNOk3sjfkX4fLFBrRUYIq4P5YjHSA2aogI1nV3JCaqPoHBfOi4QG
 iS21Eecj0YNNvaPD9Mc8uZ4HTqVWcGYej64R4BYAWogoY5.BvXw--
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: cb5de22c-b791-44aa-ae36-069677aac627
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Thu, 21 Aug 2025 13:48:25 +0000
Received: by hermes--production-ir2-858bd4ff7b-v2qb6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 92440c8545a24a6e1eb196e6e20e9dc2;
          Thu, 21 Aug 2025 13:48:21 +0000 (UTC)
X-YMail-OSG: vnk6uoYVM1nsyHUtp4hHSMTPvjVphjXs7ZoTutQJlkKQN9.Shf26jlEqupK6vuQ
 4Ce5fuV8NI12lN4YYAgfilpDaxcdtysGYuCiAY0XML9RsY7Mxaoie9uW9qot3hXC372Bkm1tppES
 _o2b1HZpGGC9fai8yLtIy1aC.rJ4MtWb2wOzvw6jM5rqX9TCq0IZrfktLsizs2DeQoH7d0IA1e4f
 bwDkQ2YvJ99VOzlovpY6N4kWLjqlJ4x72cGu1QIRWRlbfWcNrM0k.n0zik0iNfUCSRnORp.kXQFO
 vOGJC6kMKEIniZROahWBDK0y.PKhMNAln25naQF3S1e_seR8ZMHg_StPSykGzW9mHTD323rd.KFb
 G8l3PwBMMnP4SXHufpGyOzYlmLt4RKnedmImDrjuXE1DBH9GDfIbMcyB07gQF8pK..k_WVuHEcVm
 SSRCuWeNXpE2xyUWGw0QmFQQhphaoo6eUUE4Y4ORs7o2ovU15v4bu3wXzDNtVxlfeiSLkbXtwHEW
 xwsYLydv1mfKBf2zby.w0HZ1SgK_IPQVOUsWawIJyZiZU.EkzjoMKBNpaRl8Qfx7dLIURyJhlVk2
 3UZVqG2EyCtDvhQjpdvVIYC.YWigWb.xOYR4TRFO6MOGN0q_2wm65pvDHsAs.Xwpi8ZOfhvJOWxA
 J7Lsoj6D3oFUgEjbO8rxCUghCHr.gk0bV634ZRuFzqx48ks3dCBvtGLrsr4v4SKGIkUFdAzdcREe
 iJDc2HxvwHKFQYOph5vMVoi3a9xBvlo3r5CTkGqshhyNhT7r4wRZHlz81OrShTSFDJTBVYyus0gW
 hHgFYbp_lbFvqMEenrtijBdYMuP3P3FL0nHW36me_eQoEaOGq1s.5s5dhmK_SgRdkRzqCJKjmb2v
 lRT5Qtudvfh0wHIGPol6fMTAsOt8c1Dt2kPpJ7AA8tg.WfTT9x2dJwUG34YT1Ci6Y3qGRhyOu5pQ
 ONdH.cMR42cylQN7hwWVvN88aw3ys7zAK0hVbb3NQtyxSNt0dvU0DGGXG.dBA6XWXZ9LML8pTcA3
 YyY6fxXw_H2.o4V__EjepHKrTFcxvIj7lqPWfgGERGOZWx0O6ZfrMUZ6QHVRoYkKPnxOEBcMIr.e
 UlXaNZ1_YrGdkLqkSBxVc68zyDJ7i_I1agICJALp37qb4p7FAhhhPl8W78UU6OvT2RP6bCAay4M3
 c3uxDFjOfRmDTkN0DnENwGrWHpUuB5x09ov5gCCsvLA3luVAuGZQsolnsudCPkNtr2wFvp.uUB1m
 kEFbmQay.30pIBFFLvQS2nIIJTTpEf4HHug.3m41F3wgZvyVV7NkmmnX85CuwthYj68qehPLHi4w
 vKz.578CwRg_fCakMRdembhUZU.rTUW2BBwP1qFCrrb9ydzgNmMPazOAVBqqosAmDQs5tDuIePhN
 I0xWLYsFN20RI1GllfgRO1Mj_n48KgHXtuk2jIMfaYLLt_Gl5ejz1CkZfj8ncYHKGGZ_keGUQDoa
 _u9miV17404lXEaaU1sYKJt.VP_iJdsN.23V75KCE0voWa14E1.Z7KNQZh50uRByXE4Be50S33sM
 bOLaTpl9GvBEpmn6yMM7UMr.ZmoA80dQc2tpSi977HGsDFK7ToEs7uSvbFG4Xi0W8HSof70y0bzu
 cVvtSRkY.QVb.pGhbetNdO4LHIWFw.fJ0G.ima6FKDiNaMdbR8JTpTeiqBQSf4AQ2PcseT7YWw3Z
 UlFLFNT3FReCipQlGB_23L0xz5ETGzMJE6i21d9Tn8UH11Tee2FsaaNUdJmboawfgSr_.bKHdU.y
 qYbFUldzcdRSHfz.fc213EpA.gHMWudBX1M38_MvjcCh6KI5sk9v8409NNutfk76QmCWP3HgrN09
 ssx3B4IEjcqec4lUIZyUdJWUm4KGIZAMlrFzQNwNlX89804wQJYjziuQuLYIiS3z6ODa7H.0nCuW
 9cWrK5TaYD_PK6pJVWuaroD7taaJRETI02IwiUA7SdFFLoVHHuvTQGiYV1AFRgATuOR7X9sZePNf
 VmIDgR.CIRQMVcZd0_QOrLkjTxjqAWdLY.3utChpCahoI8mgpBiuba_bmyuqdiI4G5l.kr6YZIQF
 sKrwzASdPfLWJSD16AtPQ_mpVmLVEiInpnTqdUkQIEf1_oO1eeKcbyOuYam7DglcVJzsINBfz5U8
 DTWufmb_1YqaXZIJnBQVzt80iH8spf6VO0YuYpfiYu4sMwKXM4gz9BBmBliOoPbW_9nXC6KVtYUf
 E6O5GGjeS5JXDFEv3MMfU_rzKbJfjlgfrS4wauxLvQvnOFvzcmt24evalRJNzLVFhTX00zE2.BLo
 unJe1ezEhNcXgqmrjIcIhR1Q-
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: ffc24d0e-8600-4190-ad50-277b085d4e48
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 21 Aug 2025 13:48:20 +0000
Date: Thu, 21 Aug 2025 13:48:20 +0000 (UTC)
From: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
Reply-To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>, 
	"Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Message-ID: <1430299077.3058830.1755784100023@mail.yahoo.com>
In-Reply-To: <AM5PR10MB1682BF72395A55D04F486CA8F432A@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com> <1082538859.4574595.1754637525886@mail.yahoo.com> <211116062.4586180.1754639815460@mail.yahoo.com> <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM> <511456109.2450472.1755696051598@mail.yahoo.com> <HE1PR10MB1690B9444B6197D17AB086A9F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM> <1972372971.2755960.1755757618469@mail.yahoo.com> <AM5PR10MB1682BF72395A55D04F486CA8F432A@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: AW: AW: AW: v1.45, broken wifi connect
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.24338 YMailNovation

Hi,

I just started to test Ugoos X5M Pro with Amlogic W2 chip.
With this chip it is again not possible to connect to Wifi.
There does no info exist about this chip, only this source:
https://github.com/CoreELEC/w2-aml

Only by adding the revert of the connman commit and disable CONFIG_SAE it i=
s working again.
I also tried without the revert and using wpa_supplicant defconfig it does =
not work.

Any idea how to find the reason?

With reverted commit and disabled CONFIG_SAE I get connected with this info=
rmation:
/net/connman/service/wifi_f0960256bbc4_43492d30303330313536_managed_psk
Type =3D wifi
Security =3D [ psk ]
State =3D ready
Strength =3D 99
Favorite =3D True
Immutable =3D False
AutoConnect =3D True
Name =3D CI-0030156
Ethernet =3D [ Method=3Dauto, Interface=3Dwlan0, Address=3DF0:96:02:56:BB:C=
4, MTU=3D1500 ]
IPv4 =3D [ Method=3Ddhcp, Address=3D192.168.2.221, Netmask=3D255.255.255.0,=
 Gateway=3D192.168.2.1 ]
IPv4.Configuration =3D [ Method=3Ddhcp ]
IPv6 =3D [ ]
IPv6.Configuration =3D [ Method=3Doff ]
Nameservers =3D [ 8.8.8.8, 8.8.4.4 ]
Nameservers.Configuration =3D [ ]
Timeservers =3D [ 0.pool.ntp.org, 1.pool.ntp.org, 2.pool.ntp.org, 3.pool.nt=
p.org ]
Timeservers.Configuration =3D [ ]
Domains =3D [ lan ]
Domains.Configuration =3D [ ]
Proxy =3D [ ]
Proxy.Configuration =3D [ ]
mDNS =3D False
mDNS.Configuration =3D False
Provider =3D [ ]

With reverted commit and enabled CONFIG_SAE, no connection:
 /net/connman/service/wifi_f0960256bbc4_43492d30303330313536_managed_psk
Type =3D wifi
Security =3D [ psk ]
State =3D failure
Error =3D invalid-key
Strength =3D 91
Favorite =3D True
Immutable =3D False
AutoConnect =3D True
Name =3D CI-0030156
Ethernet =3D [ Method=3Dauto, Interface=3Dwlan0, Address=3DF0:96:02:56:BB:C=
4, MTU=3D1500 ]
IPv4 =3D [ ]
IPv4.Configuration =3D [ Method=3Ddhcp ]
IPv6 =3D [ ]
IPv6.Configuration =3D [ Method=3Doff ]
Nameservers =3D [ ]
Nameservers.Configuration =3D [ ]
Timeservers =3D [ ]
Timeservers.Configuration =3D [ ]
Domains =3D [ ]
Domains.Configuration =3D [ ]
Proxy =3D [ ]
Proxy.Configuration =3D [ ]
mDNS =3D False
mDNS.Configuration =3D False
Provider =3D [ ]

Thank you for your help!
Portisch


Am Donnerstag, 21. August 2025 um 10:01:59 MESZ hat Dembianny Sven (BSH GDE=
-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:=20





That's good news.

> -----Urspr=C3=BCngliche Nachricht-----
> Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> Gesendet: Donnerstag, 21. August 2025 08:27
> An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7) <sven.dembian=
ny@bshg.com>
> Betreff: Re: AW: AW: v1.45, broken wifi connect
>
> Thx,
>
> indeed, this do solve the issue:
> https://github.com/CoreELEC/Core
> ELEC%2Fcommit%2Fa8f96d2c4a97bd2afdd49c5aac6d14cd6efb8494&data=3D05%7C02%7=
Csven.dembianny
> %40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d648e=
e58410f4%7C
> 0%7C0%7C638913544287997489%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW=
UsIlYiOiI
> wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3DGAlOx
> 3ugq0WWVUMwUXE%2F1AqZelOQvRd8FndGqYwiMfM%3D&reserved=3D0
> Maybe connman should be include a switch if this option is enabled or not=
?
No idea, CONFIG_SAE is activated per default by hostap, if mainline defconf=
ig is used, or a self-maintained
one is updated with wpa_supplicant updates there should be no issue:

https://w1.fi/cgit/hostap/tree/wpa_supplicant/defconfig#n258

Best regards, Sven
>
> I tried also to replace wpa_supplicant by iwd like LibreELEC was doing in=
 past.
> But the results are like the Wifi networks are not visible at all anymore=
.
> If visible connection is not possible.
>
> So we will stay with wpa_supplicant.
>
> Thanks for your help!
> Ticket can then be closed now I think.
>
> Portisch
>
>
>
>
>
>
> Am Mittwoch, 20. August 2025 um 15:44:38 MESZ hat Dembianny Sven (BSH GDE=
-EDSD7)
> <sven.dembianny@bshg.com> Folgendes geschrieben:
>
>
>
>
>
> Hi Portisch,
>
> maybe adding WPA3 support for wpa_supplicant can help us.
> Can you give it a try and add
>
> CONFIG_SAE=3Dy
>
> in
>
> https://github.com/CoreELEC/Core
> ELEC%2Fblob%2Fcoreelec-
> 22%2Fpackages%2Fnetwork%2Fwpa_supplicant%2Fconfig%2Fmakefile.config&data=
=3D05%7C02%7Csven.d
> embianny%40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4b=
bb6d648ee58
> 410f4%7C0%7C0%7C638913544288023231%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG=
kiOnRyd
> WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7=
C0%7C%7C%7C&sd
> ata=3DHSQurgEaI8o%2Fvx5D5IoEQylng796X1TcA181TV9qf3A%3D&reserved=3D0
>
> Best regards, Sven
>
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> > Gesendet: Mittwoch, 20. August 2025 15:21
> > An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7)
> > <sven.dembianny@bshg.com>
> > Betreff: Re: AW: v1.45, broken wifi connect
> >
> > Hi,
> >
> > server is OpenWRT with: SSID: CI-0030156, Encryption: mixed WPA2/WPA3
> > PSK, SAE (CCMP) Client Khadas VIM3: AP6398S
> >
> > Same behavior with X96 M300, RTL8822CS, vid: 0x024C, pid: 0xC822
> >
> > With commit included:
> > --------------------------------------
> > VIM3:~ # connmanctl
> > connmanctl> services
> > *AO Wired ethernet_0200001e1f01_cable
> > *A CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Error
> > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_ps
> > k: Not registered
> > connmanctl> state
> > State =3D online
> > OfflineMode =3D False
> > SessionMode =3D False
> > connmanctl> disconnect
> > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Error
> > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_ps
> > k: Not connected
> > --------------------------------------
> >
> > With commit reverted:
> > --------------------------------------
> > VIM3:~ # connmanctl
> > connmanctl> services
> > *AO Wired ethernet_0200001e1f01_cable
> > *AR CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Error
> > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_ps
> > k: Already connected
> > connmanctl> disconnect
> > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Disconnected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Connected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> state
> > State =3D online
> > OfflineMode =3D False
> > SessionMode =3D False
> > --------------------------------------
> >
> > Wifi is working again.
> > We got multiple reports from users haveing same issue:
> > https://disc/
> > ourse.coreelec.org%2Ft%2Famlo&data=3D05%7C02%7Csven.dembianny%40bshg.co=
m
> > %7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d648ee58410f4
> > %7C0%7C0%7C638913544288040178%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
> > OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
> > %3D%3D%7C0%7C%7C%7C&sdata=3Dm%2BtmZYRdI8bMJxhT2%2FU3j5XvwmBZfjqsnZ%2BfO=
K
> > gIeb0%3D&reserved=3D0
> > gic-no-
> > discussion%2F46663%2F2296&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C=
3
> > cce9ee05e2049040
> > 15108dddfec6794%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638912928
> > 619230523%7CUn
> > known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOi
> > JXaW4zMiIsIkFOIjoi
> > TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DEjK%2FrOlN1nhCNVmlmxzbpeY=
w
> > cyRt6tqLJt9VS0y
> > uJpc%3D&reserved=3D0
> > Then we reverted this commit and all is good again.
> >
> > Thank you very much!
> > Portisch
> >
> >
> >
> >
> > Am Mittwoch, 20. August 2025 um 13:33:40 MESZ hat Dembianny Sven (BSH
> > GDE-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:
> >
> >
> >
> >
> >
> > Hi Portisch,
> > >
> > > Hi,
> > >
> > > current connman is broken and can not connect to encrypted networks.
> > >
> > do you have more info about your setup?
> >
> > We can't reproduce the issue with 43455 chip.
> > Which chip do you use, is it WPA3 capable?
> >
> > What AKM is configured on your AP?
> > Which wpa_supplicant version?
> > Is SAE activated for wpa_supplicant?
> > >
> > > Revert of this commit do solve the issue.
> > >
> > > Error log:
> > > connmanctl> connect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> Error
> > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313
> > > connmanctl> 53
> > > connmanctl> 6_
> > > connmanctl> managed_psk: Input/output error disconnect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error
> > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313
> > > connmanctl> 53

> > > connmanctl> 6_
> > > connmanctl> managed_psk: Not connected
> > >
> > >
> > > With 1.44 there is no such error:
> > > connmanctl> disconnect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> Disconnected
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> connmanctl> connect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> Connected
>
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> >
> > >
> > > Thanks,
> > > Portisch
> > > Team CoreELEC
> >
> > >
> > Best regards, Sven

