Received: from sonic308-17.consmr.mail.ir2.yahoo.com (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58F237172
	for <connman@lists.linux.dev>; Wed, 20 Aug 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699102; cv=none; b=ixZU+IKQFUM3q9qcYVOmOsYphBUbm9q45vK+A2IHdLLCZyPyFLhXr423EHMIPZfC/QeGgqALB4qNWQ1yIhD/I5tyNt+jME781skVAOeOP08RwvlvRMfNQ6ZcmGglp7HLGgQ2Me+ZVGjx4V0k7LPXYipPp5D+sqG12P1X3NtNqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699102; c=relaxed/simple;
	bh=5hQePrGZY6+Yz/UYexxp8PraQ+RoB/HzNuPnYR9bmak=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sES37xsY68oLPwAxGySmz1ZsZDiQr6c5r8UpIfLFt8bEExlgSJeWKfilGT3WxMZ1rRWiKJybwa4oqBhwbV0k/uzd9w+35qMSvm3n6h/D3DvMuyZWrW37iC+6Ii6G9Z+01d9C6b/4QFaGcv/F+7aJibBTAebMkDs0sbVhI7nngGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=k9cMU/RZ; arc=none smtp.client-ip=77.238.178.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="k9cMU/RZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1755699098; bh=almoKNlOaFuBkFdNLCzxIaJ295rZDWF47gFDu2kjC/Q=; h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=k9cMU/RZl3KkkNAXbX98Kt+7miP1z30ZzJRmHLHtgNxgjj1dkJMm4coy2TXhPNMTyuRCB9hLDFh451k5ay8goe3oDa76dc1DfKoTKrptzSf9ppl0V7zhm0Np4sg29P1O4pzLTmrlguY3YDd1C57GMpZST59oXsxx9JLQddUHVdJTTvpbSHPIXmN8NY+fBKwn1LClezr2eZk9nCfYbufSLXZ7o9In/m/tbG9nNsAI/F2xYp8jN52pNY+N3tg33h7oTXdmQ+Vgz9Z+5Zbjjw9gm26EELodQzWSZhMCngdLQbYtJ8380A93+q9TnSSA6+kFhjaSz3ftVG4MmHcGJfSMxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755699098; bh=itTIg7qnVocFEma60kqQRh/fdCvsHu+N8CJbjKEy4lw=; h=X-Sonic-MF:X-Sonic-MF:Date:From:To:Subject:From:Subject; b=EQMOEuNYQWIGddzTlvFGtCsp7wepCamYxAzf0uz3fkM6rnBaFic1PQujU/DRRfeI47FOZXLL+gU+EC0FAAscFe4rgBlPhIxOAdk8z/KAHT+0f/CLHoJ1qKJRWqGpaCEgENxK9qKmc7P8Jw0inMTtvnWlhgT9DHwT15M/SpsoDdvpQVK4ArAluYGY+Y2qPmNI+v9COB6JRo20Apk34xe7bHSvaz2h8YSrCunneOQkd9Cmt3kJjwDgHnbA+mi6JeHYrEqXll/SRfzXnpsltzrPKzVJq3DYlx8Qy50ei1CXlndbBKfsXYF6IDL/FHRwYkSSDMYlO+c/AjG/T4Mh6YWvJw==
X-YMail-OSG: ysKj.U4VM1l94FF3NQskqcFc91RnmGY3bK8oYB1aLR_ZHrYMNimQXx2.uJkjDu3
 Y5bhiu4RfoXPAQQXTOAUkzBlv3p9pgiy08qeNx.BjAnGBF.vGJ6PIw0Z6n2IE04nsoU2XZ6iK2UY
 _ZnbD.xxGtdCgbQsdUlrohtAzfTrh8DvYm56y9Xw_a3HzHNr6FqJIm8fpJPg95Fi6Wsf_..l_KAv
 ZmpxlEiYt4hHfOa7052UmL64e2T3GARB1IQfQg8FYwCWZEC6tv9Xq79sd3CBkFAIH5xesDhiupEM
 DveC6Ln5esE_UNKk.EDWtndrZSr.NEpX7t1yCIdgtOtSBUyILKsLMykjjcuVYwOksEVDhYUhSZVA
 fDmnkrk4AoDEZ6gZDL7hCjEQUN5ASMKsdoWGAcexhFpJ_FWY9t77A5lxT0z84ZYxE2NCkow_xeJM
 Mxdqbreqkr3SXhuhO4cq7UNcpJS4tVevOI_LAGLpnLnMIRCBZAruSyav3K5QK7eEGO2pHf8MDmTY
 OivS21IFE7qNVKbL7uoIgG3MQywvO1.NHiVrdi89prwrMiR6jsvQbkZnVlImPRRe2gD37MX1hyiX
 BAS0t2vQgLjnitKGRgUqHKAJpbbBNsPiXbxTX5hqWBxP3nHqvle6hBEyrDy66NC_aKGy2QqN1KUk
 DMojqsh9NBZPkxTIeV4bZZgwq_KzRYoGYvsV0IKnFqBPbm7E1.BKsTy2oLevPrwk1xFz.Ps.ViBN
 DNB_8dJpFXx0TUQE.66gUuVQB8FM_MN_13uY7RrX9UJfKYprv.DfGmcptuk8ubp0l99jdSZcE.Xa
 O1WsmFg2zyBnh2g3kXOJzYVKJi9uqZ2lb3tGGwKiKdq_9RdWKXxVDCJYpynO_jSrGAcAajh0js2L
 s07gDFX3AUIo7A4JeVF7HUcZvYYD0R9GYn4XDYZq0_Qae7TAnAHp1YuLOrX9Dz0jubT6PpShLABK
 aGqo6Z35buOTbFbkUCwCBxsdkKdRXZB9O8Vv9ysIxdAj9AoB4q6Lh8PP1VxKCmyB9TC21ERBszPM
 tV6lEGKnVfJ3uJtQzHXtspIRIgG4rfyfg_jOus21beyl8RcRMO2mUBOG3hpb6_yTFIqGgEPJ22iF
 qN_KRZMNBrW7cuSt4qYVKuQHP8enqZmebmtYX1v3uJD.ittauFaXKLFvnqaUbvWQsgIsqrUgU8.5
 vjd0E4cIAWaqC1.kOhQG6UDIkU6sAWQpyK9qNMeW5Rcyaj3B_gV8C81dB5OxxWL37hytcJEUUb69
 SMhImYepM1yWbXcypxcbQZYYtAPpsu1mX93LvJ0hgf4W4518Kk4JF90CyIyYSEyh5MV.gzUDbYE2
 tNTvmGPdbM4frYMeW42ziXJ8WKKhDrx8ZQI.QDmRMOR7asv48cK7UMfO7ylG8lkSRFkYAT88tQgz
 p7TqHUViuDJ.NSKSn.iJLiuXXG4dFPIR.OZb0Evj8klGc6iId8cFheY61FfVAA43ADlRB7R4Vhk4
 3QxGx6RC_2gQ47AN7okKJL4QlJQV3TcNbxXdJzT9C4T5tRU1r5tHqh1In_tXu18H5SAsWKL84NGe
 qAAW.ZUIH4qhgyjoHrmpwQ839czVxrcKyqNZjaqfdt9E7P16Iq8A.ffp6UPdvrimUtF1tmOzi8X7
 Xjp23T1fScTzTXM4OQ7U3fB7dFeBQl4BXYmdl6JRnD.tRdsIhqAqE7A5zZQK9RwB3m5NS9OZhlCV
 62JxcMyk8bUg8h7fMM7lbTqfYWA9XkSrh7jS5X5PLvTYV7.wS6aYQ1Kew0nL4oxCdyGXxBozfC5e
 NhRItweJCjR1R6S41oN2t9khwTqV2xhl20lfU8RDp0pAg9X5zIwhN8EfSiP47kbKR4YQWBCeOVb8
 3EWD.NbH9pV5F8I9_1JNmmHNgcEsdUQs4YZZYZ1llvMRsP1zDv4xjm43FJSmsI.TZl7p5DKSs131
 s4JDBdq5r4tr3G_HPK_LAiHXt8sLx6IFG7REzD9Aoote_7RMBliKbNmYPwdsiJ9j_V2nvG26nj4D
 KVhZsLqTSjxLS6OxFDOQKH6N5XAk7kE4_i2m4oTaFn8pnCUyStmCQDFNDFIso91ivYNpnaQM3TCd
 58DTtVH3QpVIFt5ZHcg4QMqbkgxNAhBoaaFpcwNe6z3UIskjd5FIdOis1Of76m2VYZXCqfTn7lYT
 j4cNNIBz31AzxSYiPfWqBmGIkchuLVNrHQ_.KFZ6b_Cj.3eXmfev3Os7EimD20ttRogLYvaBEZlQ
 Aoj49YoyGvUEP5eIyVS5imAyeZCV48_Z.CSk9Zhb_X4FE6D5d0wzANCgSf52j_9jjqdrxrBruggV
 83C.3MTXlNgFhYbqtHAqjU1DHv2uUT1ueOjErIBxSXeM-
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: e30bf381-d5f7-4d47-843a-ca430c169a4c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 20 Aug 2025 14:11:38 +0000
Received: by hermes--production-ir2-858bd4ff7b-ljvkz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c0ccefe693e776823393bee0e587f783;
          Wed, 20 Aug 2025 13:20:55 +0000 (UTC)
X-YMail-OSG: THeBCasVM1n4obkoDknVnWuIB4QizEZw50gVXL1v6nU526KijkE9OyDgwd4omRh
 wy1HgOxtmcx346hqEVmujH7RgLMCcMp6WPiv2y2VqfeMgy7mW.LuVeiVI8M7HxV5n13tQs8jij7f
 8mUgdoViMzjN3bcHZijyWTSc6QOWyBCMk9DPWP8VoPZarzJjZ9QjgndeH1aOi18hfhUXiwwdiNtn
 jJffHN6RMjXVqT4WR.GJi3GVwvK9cnXg_G0l9UikUKkQoUAhMEZBOT0zEvqkue_MxmT6g_9dhOoI
 3PNhZjDcKMtRxjPiWeRcz3MZ_RCDV.KcQz3vDATyHgUKYgLufxCYmcpmV.xfre1iwgnrt2jcjd6O
 kB0771mgo5poeJvIdJOG2YkI5h0p03biyGzwtSJ9v06qD.whEF5p4aZPGDKWbz33avVMFtKzWB.L
 ByRiaIIrpDoOVOIasBmiSDvmUEp8zoO.0_kTS9oPYYlE.xT65pIt_GjacepgV00h3qzrfzU8YQ8r
 iedDWLjnOFTHND6cdaM1nS5sDjXlkY9.pDJX6INPpGx4EC9iQiELoslGobR43i3jf9McXYl1AMCF
 _IXy9PWrfxM6Ojm4EEho.FidJ8DU2syIAiePc0XxBHHEiccF9Kun4IpbojsavTL_rVq_OSsL4ces
 p2nrFuQvIfOJ0KAiJhM1._UjaoUct6V33IGB4OR8zC0g3hU37nMQlkFqhahzFGaszkJlWdeDkjwE
 Qfirv4ZXDGiCj8ODRe7QO1CZR6t0E2mGHfv1dFZCJbNT4cxs2g.KyAfLOhxIp9AdZG1kYbRyikNe
 6RC0sePGht_9qXb55LKb.9VhROQi4alNSPXCH62bjx5UcptTWvIzlQ_8wfC7Z9jXDZ7iuvojfo5k
 xbofzEq3RkfvFailJoQjKWMu.biWqXX5IwUjcLry0wLZHo7VLZ.AChcIhm1M4GYQ4eX1iEHvcJBR
 ToZ5g.82XaxC4pM3TyBkzyU8zW24eGDIwpgekFc0QTJM3VQ7jTdKvtOQVWaq1sgPL_RcA9nuoaVz
 g7hAtRmMtYmT.2Hn17loUgYV8EdrrN787OZfMt5cgrsFrDebi1.R7z2QI_jGhAlLhX1BI1dKdkLN
 uHt2lS5A7z4DkMAZrdWYpBg44ZjLAfFwdSjx0v._zB5jw7zL6QlbZYEYL_JzFeXuFydNDEI02OWX
 mP.FPA1kBIf_oLBJvdD8xAa6n0x.izfGa7P9VkvigldL86h0G3or4wgAP8kNmmsZILa5JgKr15H.
 PqnHE3_YonJ9ZGGjHgQQ.l7XsJgL4HPq9BonAp6rK..1.MjbwCF3YbDuQ0y8RTxPPWEXSorET_5j
 WBPQU7bfnkfZw_aXx8x_hZAP33xQKGNWJOdMSVQwD01WceRbz1I92esFEIujPL4j0U5L2U.OXuBU
 Bbwrn_RhSH5cpY.JhDGW8zTw.K5oeFjSwkiT_bQWXTMG4eDKZZk89qCf9KYEka6LIXrUQpHlqmgB
 zyLVFPClmCcJYTwQ1IWWbDNQHNcx0_kTeOLK46qPzQlLApby_7VpcnbzjQj6QXSuB6hR9dPDeFyG
 trU3wJZQVBkL9tUyjZRRPKEQ.1JAfWXajRAiQLbWqfbNcnpriVjtuwoxbNF7OtY7c4.hr2pzbIg5
 6QqpSn8ErLR71qFN.NJ3l6ltlascEqnuGy1iAwAZsBOmgFJJbzNMk215h3xhgYunRmD6msu6S8VQ
 NGhNjAoOs4T2EdblQrGQ0fMoxS85B9nlz9bS4tddO9Xn7tB_b7QgPQ6M7TXTqGvuDvy5PT5E0NmM
 h8naaxl3u5zybaMo5adTDQs7OwcyGOC3SgmXkJAlywaJyLZ8IBSrpn8g1x9wRNvavIbZwuGCqxyL
 JWyrjE8PL2F84e_SoXsJF7kyv6PSSR4HZvkfCVAft3XTlGLjuDQ_qPQkjKGYpF.udt00Q8PaXfYn
 TZ.j8rBizqk0jfWOdkYhSskHYdYO9t_yf5a2mV0R8AHvtnedPrBC0IXemDX1RSbIa5jdAwS.xJn5
 LH_YQoBDarAVgAUJrX0b8iJeUQxOzbJpsT3avGi1tqpWxpGPmGuXOBk0058JoAB_sgk5wKkHSw9A
 fNKMIzk21TtDldwFNh8J_HWx95cCj48IO86Zk1FWwBc2rrPZ.9qzschdYU7wHwAH9jgOvfisd6Ga
 uTqxj0sR0A5S4RtyLgaCpgjjtCo3QfTDtvLREFEo.3j3tyYDxY5.2OuCAcIcN6cwxu_ruC0eqDy8
 5q9ZSNfm0SIPrRw5vqobQtNBY7z1BvvonWotbQmTN79ln8hIsMcjxfJ7AmUgVLdmIy4b4c7PBDYc
 zmBUaY7v8xqTcxERgeNmw
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: d44b5e6d-de57-4db0-aba3-b2bd1d82f98d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 20 Aug 2025 13:20:55 +0000
Date: Wed, 20 Aug 2025 13:20:51 +0000 (UTC)
From: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
Reply-To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>, 
	"Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Message-ID: <511456109.2450472.1755696051598@mail.yahoo.com>
In-Reply-To: <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com> <1082538859.4574595.1754637525886@mail.yahoo.com> <211116062.4586180.1754639815460@mail.yahoo.com> <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: AW: v1.45, broken wifi connect
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24338 YMailNovation

Hi,

server is OpenWRT with: SSID: CI-0030156, Encryption: mixed WPA2/WPA3 PSK, SAE (CCMP)
Client Khadas VIM3: AP6398S

Same behavior with X96 M300, RTL8822CS, vid: 0x024C, pid: 0xC822

With commit included:
--------------------------------------
VIM3:~ # connmanctl
connmanctl> services
*AO Wired ethernet_0200001e1f01_cable
*A CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_psk: Not registered
connmanctl> state
State = online
OfflineMode = False
SessionMode = False
connmanctl> disconnect wifi_6c21a29b2882_43492d30303330313536_managed_psk
Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_psk: Not connected
--------------------------------------

With commit reverted:
--------------------------------------
VIM3:~ # connmanctl
connmanctl> services
*AO Wired ethernet_0200001e1f01_cable
*AR CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_psk: Already connected
connmanctl> disconnect wifi_6c21a29b2882_43492d30303330313536_managed_psk
Disconnected wifi_6c21a29b2882_43492d30303330313536_managed_psk
connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
Connected wifi_6c21a29b2882_43492d30303330313536_managed_psk
connmanctl> state
State = online
OfflineMode = False
SessionMode = False
--------------------------------------

Wifi is working again.
We got multiple reports from users haveing same issue: https://discourse.coreelec.org/t/amlogic-no-discussion/46663/2296
Then we reverted this commit and all is good again.

Thank you very much!
Portisch




Am Mittwoch, 20. August 2025 um 13:33:40 MESZ hat Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben: 





Hi Portisch,
> 
> Hi,
> 
> current connman is broken and can not connect to encrypted networks.
> 
do you have more info about your setup?

We can't reproduce the issue with 43455 chip.
Which chip do you use, is it WPA3 capable?

What AKM is configured on your AP?
Which wpa_supplicant version?
Is SAE activated for wpa_supplicant?
> 
> Revert of this commit do solve the issue.
> 
> Error log:
> connmanctl> connect wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> connmanctl> Error
> connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313536_
> connmanctl> managed_psk: Input/output error disconnect
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error
> connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313536_
> connmanctl> managed_psk: Not connected
> 
> 
> With 1.44 there is no such error:
> connmanctl> disconnect
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> connmanctl> Disconnected
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> connmanctl> connmanctl> connect
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Connected
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk

> 
> Thanks,
> Portisch
> Team CoreELEC

> 
Best regards, Sven

