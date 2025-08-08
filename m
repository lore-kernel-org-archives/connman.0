Received: from sonic312-27.consmr.mail.ir2.yahoo.com (sonic312-27.consmr.mail.ir2.yahoo.com [77.238.178.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC223C8A4
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639821; cv=none; b=VqgKREjh51cSajJaZ7TyrVe27YeGUdko1YwS/7hnhr/JHAKQ5QMbbYltV6/P8Dw3d0aYIrdt2FJIKZJ38bzjmt3iRYpYPwmFSai8HAVV50iRAqIym9pDAbokUBWsVAooPFSezPT/4rrrqimnzWedAxARIGIBEuv3C20sOhMF8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639821; c=relaxed/simple;
	bh=a9IGV4CJINUaNoDrzPTLU+w9uT3hkAFdgQQg+ZCkjVU=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gKZLopvqJx+4KZZuWQUMx8icvQ5tfo+GXprPZETi/jiOTfXCBwgYjqBv0Jj5oAE/4aXUqPPdOB7O4z1Ti41xck//jB4Q6JN/AgOeNfDNvxs6DNAMXCRH0J4ZVTSzHy/1yd91pF5a921t1bvTG9wTxnxeEZaAhqDp8OQXvs9WuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=YyMh4qFN; arc=none smtp.client-ip=77.238.178.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="YyMh4qFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1754639817; bh=a9IGV4CJINUaNoDrzPTLU+w9uT3hkAFdgQQg+ZCkjVU=; h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=YyMh4qFNggGII+ZPBeTC/oQQg75CJ9pl8LKG2jb9JPsiTkF8BUphg7VHr5ajD6RKaymz5zmrGQ9YIWWOoZZw4SiC6tfOHLg6rFL87wOLQi96XiJZcmHqowNREOnLy0IrFMLKaJqfwbycsixS/h2PoDf9ukSoCySfIRkqRTx0GKNPd2qgtz7O7nAWgN5WcYy+nefYLEnqMVgg9NKMvQVlC1Nw+MOZHMKuriu6xVIbOU/tHB4+lyk7KLK40CpS+8/QobmemyBMgYhulil6muB3Ulfs+fP7N8Xfs8A+EbcI00+4MtjIgW7N2MDBXTNdukAFDia27Yne7f26NslET01Yjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754639817; bh=5EJKevYdjxOZR63be5n2v+hNQ5G0skTROkQg+rEsTpX=; h=X-Sonic-MF:X-Sonic-MF:Date:From:To:Subject:From:Subject; b=VXmJ2YMSHjGo44cRLkb0Axm43qxBLIOaAXBJ2Fb2l+smoQv4DYLZv3k3uEO/9Tltrs2R79lnDxVJH/G8HgZeLbCGXZopkUPjD6CTIYmWPAFnawT33dqTUn+50ymja2EL9Nq2URFoYmUWzxeo5EVTXP6aJMtNNfurpOgO1SsRmWQ7Kd5357DTrPR5Kl1IssS0YgK3z2XotagIerroYZFw6AJ6SvX51e7WIQ27Vl2SqcMp2nNQYYgtWOTesKXi6uUNdRgTWMevtG4UWR3cyLT00kqADbFtnK2f0rgD+gTNMvM5CVy5jTYB8Ywelop1vUi9sIGoZcj9ELsnkDxrfc42HA==
X-YMail-OSG: pnM8q_kVM1mJHUzp31G.BRn.itmkfmaoNy_6y3pJGxfjQTnXhf2DcszMug91JT0
 V.g58lfcN7MULtAqVkPwWa_YHgJRqLJNuubM_DkLvUAbFBqaRXPGaKQv7ueR7msPe45SSFrIJIuG
 PklPHiX9_7zm1vlNGOHAp0R9yYi4jHnwrboXEX2LwyEgRhTcDtBSPaEfO15AreB3U12zd4c.Qw8x
 vtS_NixGBRvwfKHr4afvi3Y9vKD8zlJ.u9HeXRgQyy6vQHJjLP8kEyUEd_2y.I.EUh2SZaNA74_l
 fu4CpubBWBlOHDS6gDV17JJWT93H6qenWLE3QOXVNYge..0dhNhoBVrYXmmZaldrdLce7CmEr66r
 yEYkb7DLzds.UV3BYEOlvhDcg0jOatTek3t2TmRkD3sP.uqowIotkUyVUEwlfN7vxelKavXBK4od
 3g3QVZqcxL4njE2E4NVIAAvRbb8gQIbiqYGn4MSQb0e4uhweOdssWY8mltxwdEQARiodfjfYqVx1
 Hev9nwBOvrSZwHNJdktX764WU8JWAd7XaiYDbTD5Men8ud1ig8R9TcOsF0yNR1m2_rEzt7si1NKe
 2EktSUFCrC8L8Rz6K0l1UC6g31dY0yxt8R5YZYDmKJI5gc44zQxgt2xLbK1p91nJTcqFtOOFGi.r
 TajO.XO_I6SR0c0zSGNN4i9Rv3hbRUa4iAgzD99pZqidDM6UTksn3xHGm_wYXAYZhLdLwtrRA_Nk
 f1wdExQ0Q.mHrVhqraLiTERTuOmod4zjiCr9stPDdUvW54DD.DrAEI.6lkT_AIzWKMbWo8E0SJgn
 gDPVfSwoX_J4u4gwHV2CMyVbXctj6Db0pyRJCJse4P8_aplGVzw.KHIvXUbntY_Yq7MP3lhxuNx5
 fBlNudiKpdmN71DpVhTpxmSSBREwcXzbSodPXLdINzTPV3wp6eokOp6mCBh6D94whERc8SY7b4zw
 FBU9fMXxguqT9aR_qX5PU9SLZliTrwcfoce4kiFhRzRm1.ArmgEkzzmH0_BUe1Gc1J2hKYICl7M9
 j7aym7tpBcFlMJ4ZwaC6p.l5uqKA08jaDgZcSCwlatjXr7rHIIj_bcoAxwvpmEwoQJq5HBOhmL7f
 jXxAnDnXVUXwwtrDV3qEME6njP3q.ZV.D097KdieDSVyS67Xu52erQ1_GV7z0eheihVtHcgbatwP
 0OuYowqi5RLMI5TLiR5ZFGBoDPc1iWt5QJq5STNmMfa8Z5ym_n3EurobZBWF.3nI30YRgJoRWggf
 N1tF_BOjxxk184XDpMEy.v4NlsNdokpChCwpR_1BuV6e4GN0yv5XLWJc.YJKr.bf9mrU5c1hly1U
 BEKSJE0zu6Vk.vfV5JKHPay5qyvpu0pzwCIqeNu3jXGGBScc_ge2wWqila6NKWmLrNJpy29m2wbM
 0KjyCVLQFzn.OAynYk6wWJ0lN45BKxIcsI3UhSyqsDDVWuiTYzyhZwI0aYMxlN1AzfwIgxA6I6H_
 UmpLi4voS.zz9rg1ePQ35OpANEgAumm1jcqhMGu2XWaTpWQ_ZogZdCAVMPpvld7ZtiO0JHQhcwPd
 eeBAlWeMQKYouloTk_PWFiS1qxhSF5mYMKjaOycRW2d2fTgNYvDmKi7aTMJrxz7FWC0nzUuej8mY
 8GzFSE2r0nnVK9SXM03Io.UMC59Pd1UbhH7LMZkS6GHxQbU5jYq1_X092ynzwCSC7b3yDYCHgulr
 WjLW59l8LNqOynqYu5W3dHiRTFPJgnta6hNfM4iwYccwuqbjx6chI7U9_Usib4l25hoqzZ1bHz58
 aq5r9lhWncty_N30EtPTPWIzklA8qj1.0e.Dua3h53SqIBVT4eyhcA7I6pBKPNxKjyKFUQpzL4yj
 WXHi6zrNfLKuLa6qiiQOHxs4IThbyhoaph1spVcriF3sDutgES08noYWf2kI31w.gRdKoHg9gsdB
 YVIi7jL0DTt9p.lwMxx4_vwhTs3RPFydfwt5OEvCgKJQJN8cnqQsZmgQgYrIwP.D1M70BTx4gzk6
 C4brQNUR5D8abGOR5mXzuCFidwrDEzKNBhRyD4QklLUpcOLDjLVSzWk_A7uiV32D3trN9O88o2P1
 0czd_0C10RQDfewOzo_ueQgGlwS3x5mFk1xTGWdoeKOuoLz0oKgc8w0Vc87e3JApmpGYTU3pj5Sr
 3E419kYEMLEqSMJ_mZjLv0OLhrQ9VYRSfiTrOidOECi3ErFCCmuX92DTZi_hGd3Gu3959vyHHBrR
 78cmPUet3t6ozJVopiPY7dxNyZFVlViu9q0Y51Eo.JMzSViwCtSyC194J_Pkl6l6WvUEgM18BSft
 66LOVPg83NmRvyi2KXOCoxWXMDoHyjmd_FUVKAy6b
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: c3222401-550a-4194-8aa3-1bff23dc70f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Fri, 8 Aug 2025 07:56:57 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9b6c11217916abe6bc652d2e6760cb45;
          Fri, 08 Aug 2025 07:56:56 +0000 (UTC)
X-YMail-OSG: 3LiDbD4VM1mmzde2gHYOT7rQux6UhVP9AANkswhYOmhY7b0ElBKWET3NXfkSCdU
 cjYOQZAtDVDiayIXdDgbw4QZwQ5b75nbrXradkbKqQCsCxZ5sVpsi1PLvufgR2FJ9kI_BTUnupPE
 lGimtIUaB7Gc7ojBJBOYiL9dImqt.TmhkMiCs8yI1oW4eHNub_2O7FTYxfdrFqWn.ELYgLVrPn.T
 NXvlxXilIVHB5Gb73AnkA_TT7Y.48d8FwAjKG0PQ4K3xAW75L3OWkHpC6GAG0TyxVhRhSNo4Ymz.
 uo4GnI.WW0QUEivUHBedxDKVqlwWhTw5CiPUEDlELuJV9beiGHeuQk7rMkapGXhQoWExY3_SL6N2
 JBOkeG86H5z_l743M9i1oSw6CdLsuNUwEnUnjp1DyMiDlVYSpJnlzjLlTrulLpYQqd6IAMU38_1c
 1ykNSMmcU9_IcAbXKCFovknIEkS7VuUYLORIQqmImlmuai8Xwqam6vjtvn_2wYjhD.5_EERq60Mr
 lDxEqyCw1uxa_YvtNAXn_HjlaVsvLB4yFy5Nyl9fUkg8D3Ycom57QUwkRAJic_5uKBkIoNDHAkYW
 Y3F_mospzKab.UTwvTQ7uxmYlFN9IKfZ2mn4vFZvJ22VMxesA_ud__NDJgStK1lrkvcqbDIJ7CUc
 W6iHglo8TbCSBUtbJCxqISGSOmffkeZL8fXyRto.zE3p4MTeFougJ5rYVgd6QZrHfYO3qhZrnMtZ
 0sxaAAvRmsJUBRg0qViOa9SNIfnpk5DoPp0ObmbN7onDJbq4fgA0yNDY6XKTrJDqjwXj1AHGlU1Z
 hKEI34uuDuInWbD7ZCeM65c.t7yCSBatx7osJo.4z5Lxrg4mXvqOk_.nY7BovLqI_tVFjZgC3Whi
 QOtWQh3sOACO91uDnVp0kOIzjs5GTJ.MZbuQqlWgUBIuxB9ZWlXze6MGGdBpy5qnqoR1zKY63Ttc
 rcMgi6PthTWLLK7jp7J3pCpA4Fr3yWvT0xhgoUjumm22OWHLAmHOY6KyTUr85g9r4RadXCRc.yEQ
 Rdg7wWJNHvLbDW_ULckDxyKOmL5O0AoExtxJ6k4GIyKUxseZNv1IXKuBVDdenn50TVGIrVXSzJ3K
 x5bLAeHdGK2TPNJHXalaFUR0zcMd6tWj31boFEBNfkvj_3mlWz52q6d.yD4p0_Vy4EuDXaVVjNSp
 xZ6JDNf5U57.DEI_tpw7HlBl.kEhYs_iXkUNE58Pp4ZRFckpo0UGfrqoVKeh8YriJKLiPeeErbMP
 2BAej.Kf0mnEnRZORUHGCUkY0uow0AMDV7QoWflc3Jsg7zIdUyl7I_7Itwde3J.khDDjnescwvKh
 7TXNU1qg2FwSZIg7AkFXIxVTAG.T6V2yXCl0QFyxRSdPFODv1aXpn7c4gSwI5li1425.e.KPh1Kf
 n6Ep.uho6NF5d6CpoQXV8Rm9nPeOUaFCIzU3I4GfeHa6O1qq_zzxAEOzNZdLk3Vy5vgTmEYTsEPi
 t5f7xUY20ZclcMwqWgXM651ALs.kY0zkZlO8BWaaX55kw9i6wUxUHVIDYeNjfvRa3f.44Q3IrW6o
 TCca_5RjlaHCnkShpT13A20kOeYA7f8MgxtiVkkfuhqzsW2N6E.AJ3JtipCs7rKg4Yy5lHeeaift
 nV9zeW8peaQSyQrmd2D0ssLiHDGvLU8mT0Mh5gRpkfI0juD.74lWiXEosaCBSt.rDKfYLgYII8cb
 PrI7MfoZRiFLWeoWfR8Z70gQ3xv5ruz5ayqYUtXOmHX0HOYm0XsL_SQBEtkBeOfgqWXc52IN9Nmk
 38ReJgYuQFgPjFuLUKg4BA903eSf9QdDyOZJpsvfh0iSARR7n5v72lEqpSqy1OXPSJr6kpMuTmLY
 .AYrSS9WSj.LNLFpI8ukIFgwtv3vU4peXWb862KafhhEcUVzsE7otqbRLb8tK4O2yczoZT2gdn8x
 Frq0H1DabmIW8K0cVwxzTM93rwLqhJFRHRyyQQ6kztlWNfdQMwETy5XC_OzLzpqexy_4jIOuYWrL
 ynWt5jryMd18vJn94d.9jbhbOGg0aqeDWrCrRndfYOo6qC.tRXnu1K_vOsawICJH_nBvX8wUSaHu
 sq4oRKUyIAcLDcsG60oMney6uvrOb4r69AfNKMV_OTtm8ksf4fgVioirMlgjDzYaNuwPnAEoOCaE
 ZKLU7YM1LPqbgI4Jc5Y4tUCRXqE0VaUN3IaFdMIY4PRrU3xvyWs13h45cot.MQFUpd.ssrn1OA9Q
 S8mH.Wi4HrEt.DTguUNysXCeB0CU.cW1rkkkMkNppY99y3pb7fZsEQpXbVTZ_Pi68sByf_rLKjeI
 cXqkIJ2glyZOf
X-Sonic-MF: <hugo.portisch@yahoo.de>
X-Sonic-ID: 711aeeba-1f6d-46f4-8d74-1ea5835b30fb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Fri, 8 Aug 2025 07:56:56 +0000
Date: Fri, 8 Aug 2025 07:56:55 +0000 (UTC)
From: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
Reply-To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Message-ID: <211116062.4586180.1754639815460@mail.yahoo.com>
In-Reply-To: <1082538859.4574595.1754637525886@mail.yahoo.com>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com> <1082538859.4574595.1754637525886@mail.yahoo.com>
Subject: v1.45, broken wifi connect
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 YMailNovation

Hi,

current connman is broken and can not connect to encrypted networks.

The reason is the commit: https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=5e73b55e00b97e1867397258b72f0d6e5ad7d31d

Revert of this commit do solve the issue.

Error log:
connmanctl> connect wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error /net/connman/service/wifi_485c2cd4ca36_43492d30303330313536_managed_psk: Input/output error
connmanctl> disconnect wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error /net/connman/service/wifi_485c2cd4ca36_43492d30303330313536_managed_psk: Not connected


With 1.44 there is no such error:
connmanctl> disconnect wifi_485c2cd4ca36_43492d30303330313536_managed_psk Disconnected wifi_485c2cd4ca36_43492d30303330313536_managed_psk connmanctl> connect wifi_485c2cd4ca36_43492d30303330313536_managed_psk Connected wifi_485c2cd4ca36_43492d30303330313536_managed_psk

Thanks,
Portisch
Team CoreELEC

