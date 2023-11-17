Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27F37174
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EA06E730DC;
	Fri, 17 Nov 2023 14:12:40 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5548:e1d7:c5e5:db02] (unknown [IPv6:2601:647:5a00:15c1:5548:e1d7:c5e5:db02])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9EB2973108;
	Fri, 17 Nov 2023 14:12:40 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Request for Comment: Implementing Non-link-level Failure
 Monitoring / Failover
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <7D53DC6A-AD44-468D-85CD-373878CB938A@holtmann.org>
Date: Fri, 17 Nov 2023 11:12:37 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <93D46C50-3D20-4FD3-82FD-1D3A102B0D91@nuovations.com>
References: <1B47C370-F3D5-4F60-9753-46D39CAB6728@nuovations.com>
 <805B2C7C-9DB6-44C7-9B10-25ADB0E5B84F@nuovations.com>
 <7D53DC6A-AD44-468D-85CD-373878CB938A@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 8, 2023, at 6:47 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> After spending some time yesterday digging in on this, it seems like =
the =E2=80=98EnableOnlineToReadyTransition=E2=80=99 option should, in =
theory, do what=E2=80=99s desired. However, I can see that there is at =
least one immediate obstacle that also explains the default service =
=E2=80=9CReady=E2=80=9D / =E2=80=9COnline=E2=80=9D flapping:
>>=20
>>   1. ipv6.connman.net appears to be down.
>>=20
>> Regarding (1), if I run 'wget -S =
http://ipv6.connman.net/online/status.html -O -=E2=80=98, I see:
>>=20
>>   1. I see DNS resolution to 2001:8d8:8b4:c861:5826:fa5f:6690:0 and =
87.106.208.187.
>>   2. The connection to 2001:8d8:8b4:c861:5826:fa5f:6690:0 eventually =
times out.
>>   3. A connection to 87.106.208.187 succeeds thereafter which then =
returns a 404: Not found HTTP error.
>>=20
>> Is there a monitor process for ipv6.connman.net? If not, can it be =
restarted manually?
>=20
> that is not good. I will look into this.

Marcel,

Any updates on this?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

