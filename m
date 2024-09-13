Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD3BA38
	for <connman@lists.linux.dev>; Fri, 13 Sep 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255057; cv=none; b=cj50Y+CGhKfLeWgGiOp4f42L3zsrFShCjwsSCanUaMWHExHamYown+yH/URfG1p6M8JHpS4pbD+kHM8WB6+1GHiJm48j96806u+gGg/UqzJdkA6mrL7mz97JDnqtNz/ptcXDUVNEqb0XdJlzE7VuKIxQXIEKONVRG8X6YdYGJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255057; c=relaxed/simple;
	bh=CqxkvU+Z2DEErYzOtDqUly+vt6Xl/vGXzigGMkwQVOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXv/QEExbBS6Np3J1lmRpmVX5xNpxqgVLB3MvIYFpGiZKOtLgDnVJgEqnjKU6YbKOqCke7fYFV96L26aF6TyLpmfPO9mC/wpH8WW2bAPfLtM+IFBZNfJMi0RKGF+nn7HNZe7fPW65t3jtfVAK54R04xUHajat5xVuJrjKCXf/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b=sMi2b4YQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rtie@gmx.de header.b="sMi2b4YQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726255053; x=1726859853; i=rtie@gmx.de;
	bh=CqxkvU+Z2DEErYzOtDqUly+vt6Xl/vGXzigGMkwQVOo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sMi2b4YQbSlpB9nfL2KwTSc/VPAnseuiT/iQfl4hTR9eBIrXrbgP+MNKHKBIrEiS
	 0st/BKC3sRabZPx+lxpkR7oMasr8MfMs3RqMhvI+Fz+EIoAFG8em8PxlngsFc2S4A
	 uhNNWX3O9oGhwZtJbtViu6mvlOvteQLri3OZTcsvZr3WUEQMlPpDFm+IF2pDu56to
	 J2xnrqL82fTl30KLGvfA+AzV66K0DVCM6ply84/hmoGHLkbooVl5i4ZwXwsdx+zJz
	 zrZnSLrRj5XVcYc9vljJJ66eIdz1JaT7PLgs0QOn7h7X2a5Ad0Rhs/H3OQXJHo+ic
	 8vmCVzpi3O/aC79wRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.69.148] ([87.167.7.191]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1ruWUB06SI-014kQa; Fri, 13
 Sep 2024 21:17:33 +0200
Message-ID: <5f33ec28-0e8a-41a1-9884-391934135056@gmx.de>
Date: Fri, 13 Sep 2024 21:08:12 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fixes for memory leaks and corruptions
To: Marcel Holtmann <marcel@holtmann.org>
Cc: connman@lists.linux.dev
References: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
 <CB7562C0-CF73-48B2-ADB5-47EAA3F020EF@holtmann.org>
Content-Language: en-US
From: Robert Tiemann <rtie@gmx.de>
In-Reply-To: <CB7562C0-CF73-48B2-ADB5-47EAA3F020EF@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o0fAsmtV972MTej/F/KJnEp0CNP6xPcojNm9V7M7Mqtfqm/jLHi
 pz6uNThBngyamJRhk10h2C9M+0KZ63ht2XqltQycPC14/6kJ/JoBHdn0uFanWjdLkl2fvo8
 xsAINck/tik9s1BiI2PJNYg2KL1/s4RJJSbEmwybveNx2wcvRdoo8PDkhTSKQJ1M326RghI
 naDVGKbgugX6TJ/+oHatw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/pjmRrhfi1o=;/hagxQr3omekzMnlwgLD8gLFVfm
 DXn1VbbmAYZPPclLMio8HwlaFnyRtTkqs+3hjZDAbBpU6Jbg/XKvMaTOgPxvJPhjUteq7IaJ6
 ZFx6qgIDKT90k/h5cOoIPvLL+EwzeikvPvS5qEikokGiEDArpKz65V8QNE6grkZzZlQOW+iMb
 NKWwLThw6pyE5prFas5DIzUOEJZp3lLJw3igoEG90vkffZUls4IhZ7Sz2JpR9pEEjUI8Cq+Gn
 esGox7B4POoZKg36r5ibzfaAHEZt6M6BenNhVFoq5I+GhQ0HMk66BuHl1Je6NLSxElPaxxJV2
 CXm3SXzeYACwgDXAqS/22Ws0yYGPTb7Ss1Fm4Pe/l2DDEgfJtXEhs2XyS259yIYYj78OctP81
 g3pZ7HcFRxUWWOZi20nahCW/kAAhFMfEJt0LW9zGJwRPsh3gSWu8n0wMNUgskhOSaYo9rOD4S
 ENj7xLsyU3eOrkGS96O9DJ8BEbB76WAzVg2TcL+mHWtmSZrR608leoQ1ynFZtlo72KinPJgeb
 q2ry2twHjT7trpVHuiCIgOqdldFwpENBtsMJlmmKZqBSJWBPhdp/hxliz8eA3NAGtkk685dyg
 /ucaDaTv1P1VcDsvSwuL8aPh0/EFQK6DkrghaHyL62v8HRupSo/xIEIR1PsYnrCWoqSCnRipe
 O3EIZyC42yVGOIJkybq9qaydYmLWI6Cbr0CEf/lYkIihemOnMBrALXdlZ/Ct0wjnqmOBw9YrB
 f7fYSFeXbLXoc8nw92T9Eq5SHxuzHlu9wmvdubB+/cHdRywHTpMfm3gQv4b0eDtHlY+GcHsuo
 Q+sKnA8AUO5hwkj/mylM3J9A==

On 9/2/24 10:35 AM, Marcel Holtmann wrote:
> Hi Robert,
>
> can you respin the series against HEAD since it doesn=E2=80=99t apply cl=
eanly.

Hi!

Sorry for the late reply. Seems like these patches were already merged
back in April.

> Regards
>
> Marcel

Cheers,
Robert
