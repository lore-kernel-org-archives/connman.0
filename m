Received: from sonic307-53.consmr.mail.ir2.yahoo.com (sonic307-53.consmr.mail.ir2.yahoo.com [87.248.110.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B932E92B4
	for <connman@lists.linux.dev>; Thu, 21 Aug 2025 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758847; cv=none; b=A+qcmxCzFtI1SWcpXrMkS+nEcvTAkmeC6p/CBU97gl5Q8oUIyxP+2xTb0VHGL4LW9f4H0jL6+3Qb5HqCa3F+xMFspWdQsspleCCejjvrgN6YLCodpcN87KdwchYLda7nj3qSEn/mRaN6RMwXehf+gzUlYi9zjadAcjp/OUxlXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758847; c=relaxed/simple;
	bh=O9wktqGysC32BIuwx3hXprkfhg8Roam1ld4TcUlrInU=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=l4r126YateIQWyAQ57vSBFVjYmjn84MyFH8t8925UcIBE23FAriVjVUj+UIgUpyn5MSpI7p0vp2zxAIQ9sOoGiFm8jP1eigUom/ugNdswGPCrOnJp3cRj5Fodo2E3xSqlpc1tUN0engilhF5py2AE1a6cD21ib2RlMoREPtLh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=BEtfmHsD; arc=none smtp.client-ip=87.248.110.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="BEtfmHsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1755758843; bh=O9wktqGysC32BIuwx3hXprkfhg8Roam1ld4TcUlrInU=; h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=BEtfmHsDlcghRBAukl255+H/ZcQPH3BDdGLYROZ2g5hdg1dLmyr/OB8513tLTsJNgROH0pRXUZIhUw2SOVxsXlZoStzYJ9wcQi9GTNR2J4SkaBLvfjvsCmtS+5C2alewpxvfRwFg+h1nB15C1j3gMDq3rYcY5XNR+i7nKnP+oGMcOAcJ85TkCE7pVbjww+fWSTZzSWJq1HcBeHrwy6LTuphnT+hGtMPjZwKeklkqOAH6GrH6Et8lBLwD6k9B8zCTYobYLAsuN03mS54e6kA/kJxa4eoCpK1ledzid+5LrMMiT7D5yqjaF2jM4u9+Nq/T7glzzgN7TskOx8JERWLj4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755758843; bh=pMGoxYJ7nXVVoTHvqEL671MmMOixCONyTruWFeX8grT=; h=X-Sonic-MF:X-Sonic-MF:Date:From:To:Subject:From:Subject; b=RKJw8Q0Nw92xT4a9/pfxr4UT0/q5yk44+uAt6K2ezXLY6pTjyjBmdWfemX3SPB75XGwcN0ULX/CuosQ0s5UutHWX/fksZhvE2/wU6PfZrywXTtDRze0xfP3o6zje8QGuSIYw9QG1jwLMSOiLNiaArOVVHSYK/o2HQXECMYB5tuJ4Tb24VD2e2dgCHe8o6adR+At24sRZn7XxxNSgJLI8CfVnOG5pXHU5b39WuHXdb+tYLh6p6rtqm/JE2Fq8/V4dxelUiASRsCMVFoRtua5vw5Mx66mj/V+wS0N8H43OKFMmhxRuP1u8+3U409zga49Ir/D6OxErj9YKVU5P94CLQQ==
X-YMail-OSG: 9PsxkkkVM1l5G66NnKkAdqj_BEXE4zdG0gJMFSlsO5d5TBKLgRqjbPmOxWQgk_q
 xfM7Apey.OQcjb8KOOrEdzEv17swm07k4mTEQhKa6bxM3AknSYJVrlBfooGqtCaO_lEbuqab4qez
 ZWQCfMTyyHkkRoVZBWNfLwQcAwejU._hr6WqxT2heC9cb1FJ3XekCTSPC58DHrKRy31kWsgqd7wT
 m.lbz7zUu_ecTPetxALfYa9szXSoQ12TVCqwniOBsKX7hu6hxf_N7O0ZpvfVCZKhPMD_lbyurEIN
 2DUmP808FGM8IoYxkLcj6.4YxS4174VpgeW4gnJUnrOe2223uXKh0JPPg7.kXY1pRHfD_MeGs6bO
 sMlaZHdYfVCAmCTrL0kbRqAPKQvdfrak5MRPBfLp6WdbkyBmqPSJgb_MbvEsvMln1qGiJ4TMI1a8
 veLBbLNW7sKKbW3v.S6VOcl.bFColyetTG2ddrQ3PHtKIm1ePKO5LsfoaCWwrQBqrVwfMBA61sTy
 mQb2o2ffVIi3eC0sYvG4HMhx1AcsUmdSQJRKm0qKUPRn1oMYmLLau7AKREbPWrwNa8pQl9SLOyg8
 T4bGOt3iaAgDjdt6Sd4lzujJy4z62Bmnejsno2H0Fg5qQfrwurRg6WMpIjWRAefigt76tMeUJwU0
 Srj2VNChsRTx5Vholg1qXiISI7pNXWTE.0nq5AZC0qIhgeBFUBLm.lXKz0keIXkCz6u6hGIFZM1S
 JVsPft529oCgp06DnkGf3MTuboKiD0ErxiKYpyahpNadk.EQRVoOSN0lEso.mLo4c3jI2e4nAOw6
 JvZ3JbOLGdXt8CLJPCIedA4sBDHIn_fYS.nSh7C2d2f709x.qemQUoIEaaeMIRW5RHoq5POK4kXB
 tFpnP.STnI1uOt.h_oG7_TwE_fNTV3ZuPopkKawaugiVOyq3fZzkGUocLMdA7SdnltzThR4vE5n0
 OZpR6gDBN4iPGZTwutPia15ocqElYMMBtRO7ClI4INp12Wjqn33Pf5vHVcTdSt3qxTn5pY6GSSEm
 kHgapN8cIukGXRWZcaMjQFFACaAuflF5GpivuHAV2WnFoqxPzBioO9mfSXcbyl5Zvg9q6RfesjXS
 XjXRzupwuPDPN3YAhekeOtnQinwJm2R7HrmrzQSHaNsEUfvhBaJYXM2gTU9wRtnUmPVhYxYTAibH
 qfmQE9Kyx9nenhZUhBw6vW3BsnrnCjMTZvuBN3JdBhv13.I.dH6ohAhVrqGZ68qU5w5CBwbwYGhA
 s4JPFP8fqXIbBAxzy.aQIWbH6xlSJsbASE7EEOq0wpNO48BP7KxPUyCRVDqwuHUhKkWyHfgr52wj
 GxUAHLPjNH_2bzfJm391OztFjdc6S6nfXVx33r5EOiLM3RLqv7AELYSan7bGi4Dy5NUrcv3b_0in
 DsfvJCb74yErqnaC7lC7TZ50BDhhzjiuV4fOEJri3GOpBw0F6axR5xvC_BEBjrhZ7poD4AcRoCG.
 SgLiZ4L3q9hEyKbkMjkgRJQk5fmUB8V1qdiGQKhVD_qGIAYLvfFDCA.mjkkPO5DXlvH_qJ7kr7uo
 DP3.5y8iDFGbo1epK7Bd1G28_qoS7HuV42X7V4kv0vAIakHmS1JKg4tETXpPfUPnpNbw2IaV1RLG
 xl0kJxKo5kw30egMb6Vnst1Y4n_fAr05HHFtFs1wme3y1iQ5IWMpsUO0rvxtVR7Xpr5ujeRGxmGv
 9qy.f_1nlnCXt6DqQB8U0xqAqW05PgoNXUiPvFSy2ZolCN2AcQAfY54t_1CjBy7bVsE2tygtio4a
 KK8woH33NEGKpQYd_6gr3touEzUwkBUq6wfyebAYu3Md5gcFotOUJEWfmzYsmaOm6ve5INit.rLM
 E3.TH6TdDKMfshPtQx1Gw_TMo_JJPKfIFcf9AEshEqnyqIXq5rpWQA1lJup8O4mtswLyqyVQFJ8_
 ewOr0rogu8R4VGdhnsKIN.xE8iBqbCUWvZITP56hiMBmCBEjD25u4MtKwwkVXHtXpiXxeAWzEMa0
 zk6scxBrytSKTpgFpjuNNm_jSI.OqAp3BYN0q1mtyRKOTEsb..z5S3DeG5RJgsagjQVGsJUWcNEo
 _IkitF9_zQFwVp6dZzKKxnZFZyCNY3z5JIsdFYCEty62cpSdSmnkah5X77LJXPdUI6qJlvitfJfo
 Vwf2XPPnpcAVCi2e.eFfuzc9akIZX5sZjX.gHbntWSx.M8uiw_XNEQATszjJtcBWVkPMFi2xb6Nr
 79Wd8oXIk9CY3vjE_aeSHyBPul2eaH8u97pjoFBg7B3zmJiY0QLKLpS8yXIgTK0u4yVSFsfDSQut
 tvof9vIWR4dsw6wJnQXNpeeBZTen3lutkfNOo0neLW7bP5Lp5VQ--
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: 7a6f9784-d362-4765-8e11-b4fb4a715895
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 21 Aug 2025 06:47:23 +0000
Received: by hermes--production-ir2-858bd4ff7b-w59v5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5f5f3183cd9cd22392c792eff48e9a88;
          Thu, 21 Aug 2025 06:27:03 +0000 (UTC)
X-YMail-OSG: u3RVUPQVM1m9jM4Ir7Cbju2BPIiMQZUe5zdq8eMq5oKEGgFOnHbpc5RWKrVBhTW
 CKfUMV4I4HeOjt3.3JDKoYh6r5XtBxgm0lPaOJ5NXTqIHdmq5QCDx.a9RTp.WB_uI4ilNlIxuq5_
 VoBIti_3loiFYLKxGlel7NHbp_pgoUgNKXOogOf6VcI7IWOYIigOtFcw_UUs0wHUtmNmW3Qa24W0
 DcJrfRXJ_q1KlL6OkxLN1SWYvgsd3nWRmHKsII.TC2csLik_pogeXSVRzauaHETqiTI4jMIlSAWu
 P1rnP8sgN8r52G8KemMOIAld6V5KReEE_EwF5aLIbPlOnGK6wzLjSG_cz6ADQcP_gPefNLaOdH6p
 qeJOqhRbzbK0fwnKW8jnLxZt4VZhuBfELqsTDQBCTNEslHlOgcSG97zWNLlrCXZUj8aPn.q688uI
 q9DLKBuNm9uCZ6UN_dp1eJ0mge4N9q8pxZTMh1GWtBN.3uAQJcRjaHGPzA9Sfbnyi42XZ11TM6xN
 AMb2PQliKw8xUqsf3fSvLlHCZiz9Kus6UqgNSSgoVXBCw5rh_8WC78p48urMERLvxqdVzvl107Ap
 rSWMm71vs6qtMQ9979to_hpIYci.aZl9nNB8jSeQ._N_NochlwuRkJRlqBYuc0ud9P8QyPssPfTM
 oN0lkB2cjVZAlUP_i2xpczGUwo4ZolHB9_QaxwLopxTWG0n0h_faDwoWKunFV8nsmserwR1RksbW
 FFo4tORM5j86W8Wws4bjnaBnL9U5LSHCeiJle3EAKlYmxtXAW9_EjLAayRpc5ADNr790_.G8BjDy
 RoQkneaGuRAaa5Pv.0_9WSb4IrQVNEjOyPW4OE4YTKOGldLWTvj0OjlQbcDsiGSBoqg7zxhMWnEq
 FFDusEHj8ZVqIKKjMCBXNON9yur1Q.CL3qhX1sAsHV4ujUhyD9J4j8L6Bb.ekKmUlJsC4HJgMcqB
 5DtSEawvmXu3w24fIPm2VlvrQFUNa5X8I3I.YKstt.eny41KRFX5j3Jju_FmteWp3zVI6G6yQJpf
 TABYiXOM2b32HJyN.frTQzqOpjjnOrhh.L8KteWVPeZ4p5G.iU0V3FnzG3de2QF9h4rkqtjFMbN8
 hicTCJ8PhvZAt6E9RufQXK7Gp05783nOYdgoi3qOiOK16zPOTTBjb5dTqQOik.8ONf271uxIhTZE
 0iKbvIfRc.HopQ1Ub3UWrl0JfD5JN1gUk3NvWBF4DNMoZy.2pe2RC2ZswyAUdwn8.TOvknFeMue6
 WHUJIo6W88Wcgl6MAWrADd3GhJWxSHfzwo.w7hLmwMDIFBsYpV8olzaMNgKIGFjliVFO34d_pfEb
 n.n_8vPv2afGWTYcLbcat7euD5llalnySohX6waYZrLfy12JRbWjCmQnezWWWk.WBCeg5Phz6mZw
 hFkgM0J21nL9FaLvTWzXKW9RGw0JAs931hCyqINlBjc27eQM7W3z587muUaqx6TeZ6414qJRv.Xn
 e4l5GL7yRQbsXdgC6KeKCDPs84LAFzqi0.oLuWtqhI1SDirLz8TRfyUO3MtiCREw6lvRcLL_KsO5
 NtzAjZ3lVbcLzLn9mQCvYGqyg0dz2niSzq4nvk.pN.XJvdxzwSx.cttIseAi.4SlNg2vxBeTd_mF
 yQHM5jfLRu8_ZkefbwvE7UlHurO3uDhdqKuyYA6tZhVL83qAybTY6MSatbW7toLZzs6nGJCbx8Pi
 XZ84.Nl283asTgEzL_eiqC1Kre9SeAHrsz5Gh3e_2Ku3VaqNop6G.0vsnQGfrwTxb0SUqp94X353
 Rgy95pWnsLCjveGBNsWytSUzcnsgXv1_ZWNhbPEoSRqEKsstS33YWvKhK7NK_AE71jq9ndYABqlP
 mVrW2kP7KcZ5kOnhpuT8GQXFepHAZ2gAlvQVQJ4lxhJoRy1FZt_HVwf4HjIVBEr04dcE6iTITTUF
 ZL7YtnqHJ_HeEmgHgA12TgAeh_GK7aQkiTXH2myX8E.LhehUlJBfu86kb_vTOu6f8Yiwi9tDhlwh
 nHIdJnDKnk4pIn4SpZ_T6V8KMOnh5S2nfLPltFbN.LydyGy5ZF6cJaI4RZtHYSui064qIwzUUbOx
 7Apees2DzCOyVBYmy3z9WFNG5.7SqdjQ9kjimHwnHyziKm7LhcMvgyIVw9IMB6BqRowvoLnBP.9j
 vYVAVHYO04EppMF5dlBF_jMd3IQJGZQSpvJKs7fduos3guKKOVjUMBcWiScTIX1hbCWsRttd_HiR
 WZQ3iCGmZun6mHC81HfckEx73NXh3ShXoxX05vQmYMNL6WuEd7cuDaORK.Z.rAys.t82f.DKElX9
 nJzcXICngUtHCmDUXVvuFUHM-
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: fa5a9fab-6210-44b2-aadb-898298083d4e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Thu, 21 Aug 2025 06:27:03 +0000
Date: Thu, 21 Aug 2025 06:26:58 +0000 (UTC)
From: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
Reply-To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>, 
	"Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Message-ID: <1972372971.2755960.1755757618469@mail.yahoo.com>
In-Reply-To: <HE1PR10MB1690B9444B6197D17AB086A9F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com> <1082538859.4574595.1754637525886@mail.yahoo.com> <211116062.4586180.1754639815460@mail.yahoo.com> <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM> <511456109.2450472.1755696051598@mail.yahoo.com> <HE1PR10MB1690B9444B6197D17AB086A9F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: AW: AW: v1.45, broken wifi connect
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.24338 YMailNovation

Thx,

indeed, this do solve the issue:
https://github.com/CoreELEC/CoreELEC/commit/a8f96d2c4a97bd2afdd49c5aac6d14c=
d6efb8494
Maybe connman should be include a switch if this option is enabled or not?

I tried also to replace wpa_supplicant by iwd like LibreELEC was doing in p=
ast.
But the results are like the Wifi networks are not visible at all anymore.
If visible connection is not possible.

So we will stay with wpa_supplicant.

Thanks for your help!
Ticket can then be closed now I think.

Portisch






Am Mittwoch, 20. August 2025 um 15:44:38 MESZ hat Dembianny Sven (BSH GDE-E=
DSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:=20





Hi Portisch,

maybe adding WPA3 support for wpa_supplicant can help us.
Can you give it a try and add

CONFIG_SAE=3Dy

in

https://github.com/CoreELEC/CoreELEC/blob/coreelec-22/packages/network/wpa_=
supplicant/config/makefile.config

Best regards, Sven

> -----Urspr=C3=BCngliche Nachricht-----
> Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> Gesendet: Mittwoch, 20. August 2025 15:21
> An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7) <sven.dembian=
ny@bshg.com>
> Betreff: Re: AW: v1.45, broken wifi connect
>
> Hi,
>
> server is OpenWRT with: SSID: CI-0030156, Encryption: mixed WPA2/WPA3 PSK=
, SAE (CCMP) Client
> Khadas VIM3: AP6398S
>
> Same behavior with X96 M300, RTL8822CS, vid: 0x024C, pid: 0xC822
>
> With commit included:
> --------------------------------------
> VIM3:~ # connmanctl
> connmanctl> services
> *AO Wired ethernet_0200001e1f01_cable
> *A CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed=
_psk: Not registered
> connmanctl> state
> State =3D online
> OfflineMode =3D False
> SessionMode =3D False
> connmanctl> disconnect
> connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed=
_psk: Not connected
> --------------------------------------
>
> With commit reverted:
> --------------------------------------
> VIM3:~ # connmanctl
> connmanctl> services
> *AO Wired ethernet_0200001e1f01_cable
> *AR CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed=
_psk: Already
> connected
> connmanctl> disconnect
> connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Disconnected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Connected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> state
> State =3D online
> OfflineMode =3D False
> SessionMode =3D False
> --------------------------------------
>
> Wifi is working again.
> We got multiple reports from users haveing same issue:
> https://discourse.coreelec.org/t/amlo
> gic-no-
> discussion%2F46663%2F2296&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C3c=
ce9ee05e2049040
> 15108dddfec6794%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638912928619=
230523%7CUn
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa=
W4zMiIsIkFOIjoi
> TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DEjK%2FrOlN1nhCNVmlmxzbpeYwc=
yRt6tqLJt9VS0y
> uJpc%3D&reserved=3D0
> Then we reverted this commit and all is good again.
>
> Thank you very much!
> Portisch
>
>
>
>
> Am Mittwoch, 20. August 2025 um 13:33:40 MESZ hat Dembianny Sven (BSH GDE=
-EDSD7)
> <sven.dembianny@bshg.com> Folgendes geschrieben:
>
>
>
>
>
> Hi Portisch,
> >
> > Hi,
> >
> > current connman is broken and can not connect to encrypted networks.
> >
> do you have more info about your setup?
>
> We can't reproduce the issue with 43455 chip.
> Which chip do you use, is it WPA3 capable?
>
> What AKM is configured on your AP?
> Which wpa_supplicant version?
> Is SAE activated for wpa_supplicant?
> >
> > Revert of this commit do solve the issue.
> >
> > Error log:
> > connmanctl> connect wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> Error
> > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d3030333031353
> > connmanctl> 6_
> > connmanctl> managed_psk: Input/output error disconnect
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error
> > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d3030333031353
> > connmanctl> 6_
> > connmanctl> managed_psk: Not connected
> >
> >
> > With 1.44 there is no such error:
> > connmanctl> disconnect
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> Disconnected
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> connmanctl> connect
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> Connected

> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
>
> >
> > Thanks,
> > Portisch
> > Team CoreELEC
>
> >
> Best regards, Sven

